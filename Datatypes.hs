module Datatypes where

import Data.List (intercalate)

type VarName = String

type TypeName = String

data BaseType = MyBool
              | MyInt
              deriving (Eq)

data Type = Base BaseType
          | Type :-> Type
          | TypeProd [Type]
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
          | Pred Term
          | Iszero Term
          | Fix Term
          | Tuple [Term]
          | UnpackTuple Int Term
          deriving (Eq, Show)

instance Show BaseType where
    show MyBool = "bool"
    show MyInt = "int"

-- TODO more cases
prettyShowType :: Type -> String
prettyShowType (Base t1) = show t1
prettyShowType (Base t1 :-> t2) = show t1 ++ " → " ++ prettyShowType t2
prettyShowType (t1 :-> t2) = "(" ++ prettyShowType t1 ++ ")" ++ " → " ++ prettyShowType t2
prettyShowType (TypeProd []) = "@empty"
prettyShowType (TypeProd [t]) = "@" ++ prettyShowType t
prettyShowType (TypeProd tl) = intercalate "*" $ map prettyShowType tl


-- TODO more cases
prettyShowTerm :: Term -> String
prettyShowTerm (Var v) = v
prettyShowTerm (Lam v _ t) = "λ" ++ v ++ "." ++ prettyShowTerm t
prettyShowTerm (t1@(Lam _ _ _ ) `App` t2) = "(" ++ prettyShowTerm t1 ++ ")" ++ " " ++ prettyShowTerm t2
prettyShowTerm (t1 `App` (Var v)) = prettyShowTerm t1 ++ " " ++ v
prettyShowTerm (t1 `App` t2) = prettyShowTerm t1 ++ " (" ++ prettyShowTerm t2 ++ ")"
prettyShowTerm (Let v t1 t2) = "let " ++ v ++ " = " ++ prettyShowTerm t1 ++ " in " ++ prettyShowTerm t2
prettyShowTerm TrueT = "true"
prettyShowTerm FalseT = "false"
prettyShowTerm (If t1 t2 t3) = "if" ++ " " ++ prettyShowTerm t1 ++ " " ++ "then" ++ " " ++ prettyShowTerm t2 ++ " " ++ "else" ++ " " ++ prettyShowTerm t3
prettyShowTerm Zero = "zero"
prettyShowTerm (Succ e) = "succ" ++ " " ++ prettyShowTerm e
prettyShowTerm (Pred e) = "pred" ++ " " ++ prettyShowTerm e
prettyShowTerm (Iszero e) = "iszero" ++ " " ++ prettyShowTerm e
prettyShowTerm (Fix e) = "fix" ++ " " ++ prettyShowTerm e
prettyShowTerm (Tuple el) = "<" ++ (intercalate ", " $ map prettyShowTerm el) ++ ">"
prettyShowTerm (UnpackTuple i e) = prettyShowTerm e ++ "#" ++ show i

