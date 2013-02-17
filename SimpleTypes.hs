import Data.List (delete)

type VarName = String

type TypeName = String

data BaseType = MyBool
              | MyInt
              deriving (Eq)

data Type = Base BaseType
          | Type :-> Type
          deriving (Eq)

data Term = Var VarName
          | Lam VarName Type Term
          | App Term Term
          | Let VarName Term Term -- let Var = Term in Term
          deriving (Eq)

type Context = [(VarName, Type)]

instance Show BaseType where
    show MyBool = "B"
    show MyInt = "I"

instance Show Type where
    show (Base t1) = show t1
    show (Base t1 :-> t2) = show t1 ++ " → " ++ show t2
    show (t1 :-> t2) = "(" ++ show t1 ++ ")" ++ " → " ++ show t2

instance Show Term where
    show (Var v) = v
    show (Lam v _ t) = "λ" ++ v ++ "." ++ show t
    show (t1@(Lam _ _ _ ) `App` t2) = "(" ++ show t1 ++ ")" ++ " " ++ show t2
    show (t1 `App` (Var v)) = show t1 ++ " " ++ v
    show (t1 `App` t2) = show t1 ++ "(" ++ show t2 ++ ")"
    show (Let v t1 t2) = "let " ++ v ++ " = " ++ show t1 ++ " in " ++ show t2

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

genid :: Type -> Term
genid t = Lam "x" t (Var "x")

tintid = genid (Base MyInt)

tintidid = genid ((Base MyInt) :-> (Base MyInt))

term1 = (tintidid `App` tintid) `App` (Var "x")

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

