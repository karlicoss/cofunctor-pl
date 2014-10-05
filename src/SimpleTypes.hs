module SimpleTypes where

import Datatypes
import TypeCheck (gettype, typecheck)
import Data.List (delete, union, (\\), find)
import Data.Maybe (fromJust)
import Debug.Trace (trace)
import Lexer (alexScanTokens)
import Parser (parser, Ex(..))

free :: Term -> [VarName]
free (UnpackTuple i t) = free t
free (Tuple tl) = foldl union [] $ map free tl
free (Fix e) = free e
free Zero = []
free (Succ e) = free e
free (Pred e) = free e
free (Iszero e) = free e
free TrueT = []
free FalseT = []
free (If e th el) = free e `union` free th `union` free el
free (Var v) = [v]
free (t1 `App` t2) = free t1 `union` free t2
free (Lam v _ b) = delete v $ free b
free (Let v t1 t2) = delete v $ (free t1 `union` free t2)
free (LetType v tp term) = free term
free (Inject i term tp) = free term
free (Case term cl) = free term `union` (foldl union [] $ (map (\(x, y) -> delete x $ free y) cl)) 

char2str = \c -> [c]

letters = ['a' .. 'z'] ++ ['A' .. 'Z']
digits = ['0' .. '9']

allvars :: [VarName]
allvars = map reverse $ map char2str letters ++ [x : c | c <- allvars, x <- letters ++ digits] -- TODO SHIT

freshvar :: [VarName] -> VarName
freshvar l = fromJust $ find (\x -> not $ x `elem` l) allvars

rename :: VarName -> VarName -> Term -> Term
rename v what t@(UnpackTuple i t2) = UnpackTuple i $ rename v what t2
rename v what t@(Tuple el) = Tuple $ map (rename v what) el
rename v what t@(Fix e) = Fix $ rename v what e
rename _ _ t@Zero = t
rename v what t@(Succ t2) = Succ $ rename v what t2
rename v what t@(Pred t2) = Pred $ rename v what t2
rename v what t@(Iszero t2) = Iszero $ rename v what t2
rename _ _ t@FalseT = t
rename _ _ t@TrueT = t
rename v what t@(If e th el) = If (rename v what e) (rename v what th) (rename v what el)
rename v what t@(Var v2) = if v == v2 then Var what else t
rename v what t@(t1 `App` t2) = (rename v what t1) `App` (rename v what t2)
rename v what t@(Lam v2 tp b) = if v == v2 then t else Lam v2 tp $ rename v what b
rename v what t@(Let v2 t1 t2) = if v == v2 then t else Let v2 (rename v what t1) (rename v what t2)
rename v what t@(LetType v2 tp term) = LetType v2 tp $ rename v what term
rename v what t@(Inject i term tp) = Inject i (rename v what term) tp
rename v what t@(Case term cl) = Case (rename v what term) $ map (\(x, y) -> (x, if x == v then y else rename v what y)) cl

subst :: VarName -> Term -> Term -> Term
subst v what t@(UnpackTuple i t2) = UnpackTuple i $ subst v what t2
subst v what t@(Tuple el) = Tuple $ map (subst v what) el
subst v what t@(Fix t2) = Fix $ subst v what t2
subst _ _ t@Zero = t
subst v what t@(Succ t2) = Succ $ subst v what t2
subst v what t@(Pred t2) = Pred $ subst v what t2
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
subst v what t@(LetType v2 tp term) = LetType v2 tp $ subst v what term
subst v what t@(Inject i term tp) = Inject i (subst v what term) tp
subst v what t@(Case term cl) = Case (subst v what term) $ map helper cl where
  helper (x, y) | v == x                            = (x, y)
                | v /= x && x `notElem` (free what) = (x, subst v what y)
                | otherwise                         = let fv = freshvar (x : free what `union` free y)
                                                      in (fv, subst v what $ rename x fv y)

-- TODO abstract reduction strategy
evalaux :: Term -> (Bool, Term)
evalaux t@(UnpackTuple i (Tuple tl)) = (True, tl !! i)
evalaux t@(UnpackTuple i t2) = let (b, et2) = evalaux t2
                               in (b, UnpackTuple i et2)
evalaux t@(Tuple tl) = let n = length tl
                           el = map evalaux tl
                           notel = takeWhile (not . fst) el
                           ln = length notel
                       in if ln == n
                            then (False, t)
                            else let ev = snd $ el !! ln
                                 in (True, Tuple $ take ln tl ++ [ev] ++ drop (ln + 1) tl)  
evalaux t@(Fix t2) = (True, t2 `App` (Fix t2))
evalaux t@Zero = (False, t)
evalaux t@(Succ t2) = let (b, et2) = evalaux t2
                      in (b, Succ et2)
evalaux t@(Pred Zero) = (True, Zero)
evalaux r@(Pred (Succ t2)) = (True, t2)
evalaux t@(Pred t2) = let (b, et2) = evalaux t2
                      in (b, Pred et2)
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
evalaux t@(LetType v tp term) = let (b, eterm) = evalaux term
                                in (b, LetType v tp eterm) -- TODO i should definitely erase types
evalaux t@(Inject i term tp) = let (b, eterm) = evalaux term
                               in (b, Inject i eterm tp)
evalaux t@(Case (Inject i term tp) cl) = (True, subst (fst $ cl !! i) term (snd $ cl !! i))
evalaux t@(Case term cl) = let (b, eterm) = evalaux term
                           in (b, Case eterm cl)

eval :: Term -> Term
eval t = let (b, et) = evalaux t
         in if b then eval et else t

alala = do
  s <- getContents
  case parser $ alexScanTokens s of
    Ok t -> do --putStrLn $ "DEBUG: " ++ show t 
               putStr $ prettyShowTerm t ++ " :: "
               case typecheck t of
                 Just tp -> do putStrLn $ prettyShowType tp
                               let et = eval t
                               --putStrLn $ "DEBUG: " ++ (show $ typecheck et)
                               --putStr $ show et
                               putStr $ prettyShowTerm et
                               putStrLn $ " :: " ++ (prettyShowType $ fromJust $ typecheck et)
                 Nothing -> putStrLn $ "type error"
    Fail s -> putStr $ "Parse error: " ++ s

main :: IO ()
main = alala

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
