module Datatypes where

type VarName = String

type TypeName = String

data BaseType = MyBool
              | MyInt
              deriving (Eq)

data Type = Base BaseType
          | Type :-> Type
          deriving (Eq, Show)

data Term = Var VarName
          | Lam VarName Type Term
          | App Term Term
          | Let VarName Term Term -- let Var = Term in Term
          | TrueT
          | FalseT
          | If Term Term Term -- if Term then Term else Term
          | Zero
          | Succ Term
          | Iszero Term
          deriving (Eq, Show)

instance Show BaseType where
    show MyBool = "B"
    show MyInt = "I"

--instance Show Type where
--    show (Base t1) = show t1
--    show (Base t1 :-> t2) = show t1 ++ " → " ++ show t2
--    show (t1 :-> t2) = "(" ++ show t1 ++ ")" ++ " → " ++ show t2

-- TODO more cases
prettyShow :: Term -> String
prettyShow (Var v) = v
prettyShow (Lam v _ t) = "λ" ++ v ++ "." ++ prettyShow t
prettyShow (t1@(Lam _ _ _ ) `App` t2) = "(" ++ prettyShow t1 ++ ")" ++ " " ++ prettyShow t2
prettyShow (t1 `App` (Var v)) = prettyShow t1 ++ " " ++ v
prettyShow (t1 `App` t2) = prettyShow t1 ++ " (" ++ prettyShow t2 ++ ")"
prettyShow (Let v t1 t2) = "let " ++ v ++ " = " ++ prettyShow t1 ++ " in " ++ prettyShow t2