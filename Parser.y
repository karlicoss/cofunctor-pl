{
module Parser where

import Lexer
}

%name parser
%tokentype { Token }
%error { parseError }

%token
    "let"    { TokenLet }
    "in"     { TokenIn }
    "int"    { TokenTypeInt }
    "bool"   { TokenTypeBool }
    "="      { TokenAssignment }
    "\\"     { TokenLambda }
    "."      { TokenDot }
    "("      { TokenOBracket }
    ")"      { TokenCBracket }
    "::"     { TokenDoubleColon }
    "->"     { TokenArrow }
    "var"    { TokenVar $$ }

%right "->"

%%

Term :: { Term }
Term : AppTerm { $1 }
     | "let" "var" "=" Term "in" Term { Let $2 $4 $6 }
     | "\\" "var" "::" Type "." Term { Lam $2 $4 $6 }

AppTerm :: { Term }
AppTerm : AppTerm1 { foldl App (head $1) (tail $1) } -- left recursion elimination

AppTerm1 :: { [ Term ] }
AppTerm1 : ATerm { [$1] }
         | ATerm AppTerm1 { $1 : $2 }

ATerm :: { Term }
ATerm : "(" Term ")" { $2 }
      | "var" { Var $1 }

Type :: { Type } 
Type : "int" { Base MyInt }
     | "bool" { Base MyBool }
     | "(" Type ")" { $2 }
     | Type "->" Type { $1 :-> $3 }

{
    
parseError :: [Token] -> a
parseError tokens = error ("Parse error" ++ show tokens)

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

main = do
    s <- getContents
    let parseTree = parser $ alexScanTokens s
    print $ parseTree

}