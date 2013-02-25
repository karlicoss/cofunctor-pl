module Datatypes where

import Data.List (intercalate)

type VarName = String

type TypeName = String

data BaseType = MyBool
              | MyInt
              deriving (Eq, Show)

data Type = Base BaseType
          | Type :-> Type
          | TypeProd [Type]
          | TypeSum [Type]
          | TypeVar TypeName
          deriving (Eq, Show)
-- |  TypeSyn TypeName Type -- TODO what if we somehow define type int = blahblahblah?

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
          | Inject Int Term Type -- inj_Int Term as Type
          | Case Term [(VarName, Term)] -- case t of bind1 -> expr1, bind2 -> expr2, ... bindn -> exprn;
          | LetType TypeName Type Term
          deriving (Eq, Show)


-- TODO more cases
prettyShowType :: Type -> String
prettyShowType (Base t1) = show t1
prettyShowType (Base t1 :-> t2) = show t1 ++ " → " ++ prettyShowType t2
prettyShowType (t1 :-> t2) = "(" ++ prettyShowType t1 ++ ")" ++ " → " ++ prettyShowType t2
prettyShowType (TypeProd []) = "(* *)"
prettyShowType (TypeProd [t]) = "(* " ++ prettyShowType t ++ " *)"
prettyShowType (TypeProd tl) = intercalate "*" $ map prettyShowType tl
prettyShowType (TypeVar tv) = tv
prettyShowType (TypeSum []) = "(+ +)"
prettyShowType (TypeSum [t]) = "(+ " ++ prettyShowType t ++ " +)"
prettyShowType (TypeSum tl) = "(" ++ (intercalate "+" $ map prettyShowType tl) ++ ")" -- TODO more cases to avoid redundant parenthesis


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
prettyShowTerm (LetType v tp term) = "let type " ++ v ++ " = " ++ prettyShowType tp ++ " in " ++ prettyShowTerm term
prettyShowTerm t@(Case term cl) = show t -- TODO
prettyShowTerm t@(Inject i term tp) = show t -- TODO