import Datatypes
import Data.List (delete, union, (\\), find)
import Data.Maybe (fromJust)
import Debug.Trace (trace)

type Context = [(VarName, Type)]

replins :: Context -> (VarName, Type) -> Context
replins c (v, t) = case lookup v c of
                       Just t2 -> (v, t) : delete (v, t2) c
                       Nothing -> (v, t) : c

gettype :: Context -> Term -> Maybe Type
gettype c t@(Var v) = lookup v c
gettype c t@(Lam vn ty b) = do bty <- gettype (replins c (vn, ty)) b
                               return (ty :-> bty)
gettype c t@(t1 `App` t2) = do (l :-> r) <- gettype c t1
                               t2ty <- gettype c t2
                               if l == t2ty
                                   then return r
                                   else fail "application type mismatch"
gettype c t@(Let v t1 t2) = do vt <- gettype c t1
                               t2ty <- gettype (replins c (v, vt)) t2
                               return t2ty

free :: Term -> [VarName]
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
rename v what t@(Var v2) = if v == v2 then Var what else t
rename v what t@(t1 `App` t2) = (rename v what t1) `App` (rename v what t2)
rename v what t@(Lam v2 tp b) = if v == v2 then t else Lam v2 tp $ rename v what b
rename v what t@(Let v2 t1 t2) = if v == v2 then t else Let v2 (rename v what t1) (rename v what t2)

subst :: VarName -> Term -> Term -> Term
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

evalaux :: Term -> (Bool, Term)
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

genid :: Type -> Term
genid t = Lam "x" t (Var "x")

tintid = genid (Base MyInt)

tintidid = genid ((Base MyInt) :-> (Base MyInt))

term1 = (tintidid `App` tintid) `App` (Var "x")

eterm1 = eval term1

termlet = Let "x" tintid (tintidid `App` (Var "x"))

main = do
    print $ tintid
    print $ gettype [] tintid
    print $ tintidid
    print $ gettype [] tintidid
    print $ term1
    print $ gettype [("x", Base MyInt)] term1
    print $ termlet
    print $ gettype [] termlet
    print $ eterm1
    print $ gettype [("x", Base MyInt)] eterm1
