module SimpleTypes where

import Datatypes
import TypeCheck (gettype)
import Data.List (delete, union, (\\), find)
import Data.Maybe (fromJust)
import Debug.Trace (trace)
import Lexer (alexScanTokens)
import Parser (parser)

free :: Term -> [VarName]
free Zero = []
free (Succ e) = free e
free (Iszero e) = free e
free TrueT = []
free FalseT = []
free (If e th el) = free e `union` free th `union` free el
free (Var v) = [v]
free (t1 `App` t2) = free t1 `union` free t2
free (Lam v _ b) = delete v $ free b
free (Let v t1 t2) = delete v $ (free t1 `union` free t2)

char2str = \c -> [c]

letters = ['a' .. 'z'] ++ ['A' .. 'Z']
digits = ['0' .. '9']

allvars :: [VarName]
allvars = map reverse $ map char2str letters ++ [x : c | c <- allvars, x <- letters ++ digits] -- TODO SHIT

freshvar :: [VarName] -> VarName
freshvar l = fromJust $ find (\x -> not $ x `elem` l) allvars

rename :: VarName -> VarName -> Term -> Term
rename _ _ t@Zero = t
rename v what t@(Succ t2) = Succ $ rename v what t2
rename v what t@(Iszero t2) = Iszero $ rename v what t2
rename _ _ t@FalseT = t
rename _ _ t@TrueT = t
rename v what t@(If e th el) = If (rename v what e) (rename v what th) (rename v what el)
rename v what t@(Var v2) = if v == v2 then Var what else t
rename v what t@(t1 `App` t2) = (rename v what t1) `App` (rename v what t2)
rename v what t@(Lam v2 tp b) = if v == v2 then t else Lam v2 tp $ rename v what b
rename v what t@(Let v2 t1 t2) = if v == v2 then t else Let v2 (rename v what t1) (rename v what t2)

subst :: VarName -> Term -> Term -> Term
subst _ _ t@Zero = t
subst v what t@(Succ t2) = Succ $ subst v what t2
subst v what t@(Iszero t2) = Iszero $ subst v what t2
subst _ _ t@FalseT = t
subst _ _ t@TrueT = t
subst v what t@(If e th el) = If (subst v what e) (subst v what th) (subst v what el)
subst v what t@(Var v2) = if v == v2 then what else t
subst v what t@(t1 `App` t2) = (subst v what t1) `App` (subst v what t2)
subst v what t@(Lam v2 tp b) | v == v2                            = t
                             | v /= v2 && v2 `notElem` (free what) = Lam v2 tp $ subst v what b 
                             | otherwise                           = let fv = freshvar (free b `union` free what)
                                                                     in Lam fv tp $ subst v what (rename v2 fv b)
subst v what t@(Let v2 t1 t2) | v == v2                             = t
                              | v /= v2 && v2 `notElem` (free what) = Let v2 (subst v what t1) (subst v what t2)
                              | otherwise                           = let fv = freshvar (v2 : free what `union` free t1 `union` free t2)
                                                                      in Let fv (subst v what (rename v2 fv t1)) (subst v what (rename v2 fv t2))

-- TODO abstract reduction strategy
evalaux :: Term -> (Bool, Term)
evalaux t@Zero = (False, t)
evalaux t@(Succ t2) = let (b, et2) = evalaux t2
                      in (b, Succ et2)
evalaux t@(Iszero Zero) = (True, TrueT)
evalaux t@(Iszero (Succ _)) = (True, FalseT)
evalaux t@(Iszero t2) = let (b, et2) = evalaux t2
                        in (b, Iszero et2)
evalaux t@TrueT = (False, t)
evalaux t@FalseT = (False, t)
evalaux t@(If TrueT th _) = (True, th)
evalaux t@(If FalseT _ el) = (True, el)
evalaux t@(If e th el) = let (b, et) = evalaux e -- shouldn't I return (True, If et th el)? Well-typed expression in if condition has to evaluate.
                         in (b, If et th el)
evalaux t@(Var _) = (False, t)
evalaux t@(Lam _ _ _) = (False, t)
evalaux t@(Let v t1 t2) = (True, subst v t1 t2)
evalaux ((Lam v _ b) `App` t2) = (True, subst v t2 b)
evalaux t@(t1 `App` t2) = let (b1, et1) = evalaux t1
                              (b2, et2) = evalaux t2
                          in if b1
                             then (True, et1 `App` t2)
                             else if b2
                                  then (True, t1 `App` et2)
                                  else (False, t)

eval :: Term -> Term
eval t = let (b, et) = evalaux t
         in if b then eval et else t

alala = do
  s <- getLine
  let t = parser $ alexScanTokens s
  putStr $ show t ++ " :: "
  case gettype [] t of
    Just tp -> do putStrLn $ show tp
                  let et = eval t
                  putStrLn $ show et ++ " :: " ++ (show $ fromJust $ gettype [] et)
    Nothing -> do putStrLn $ "type error"
                  alala

main :: IO ()
main = return ()

--main = print
--    do $ tintid
--    print $ gettype [] tintid
--    print $ tintidid
--    print $ gettype [] tintidid
--    print $ term1
--    print $ gettype [("x", Base MyInt)] term1
--    print $ termlet
--    print $ gettype [] termlet
--    print $ eterm1
--    print $ gettype [("x", Base MyInt)] eterm1
