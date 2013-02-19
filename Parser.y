{
module Parser (parser) where

import Lexer
import Datatypes
}

%name parser
%tokentype { Token }
%error { parseError }

%token
    "let"    { TokenLet }
    "in"     { TokenIn }
    "int"    { TokenTypeInt }
    "bool"   { TokenTypeBool }
    "if"     { TokenIf }
    "then"   { TokenThen }
    "else"   { TokenElse }
    "true"   { TokenTrue }
    "false"  { TokenFalse }
    "zero"   { TokenZero }
    "succ"   { TokenSucc }
    "pred"   { TokenPred }
    "iszero" { TokenIszero }
    "fix"    { TokenFix }
    "="      { TokenAssignment }
    "\\"     { TokenLambda }
    "."      { TokenDot }
    "("      { TokenOBracket }
    ")"      { TokenCBracket }
    "::"     { TokenDoubleColon }
    ";"      { TokenSemiColon }
    "->"     { TokenArrow }
    "var"    { TokenVar $$ }

%right "->"

%%

Term :: { Term }
Term : AppTerm { $1 }
     --| 

AppTerm :: { Term }
AppTerm : AppTerm1 { foldl App (head $1) (tail $1) } -- application is left associative

AppTerm1 :: { [ Term ] }
AppTerm1 : ATerm { [$1] }
         | ATerm AppTerm1 { $1 : $2 }
         | Lam { [$1] } -- is it supposed to be like that?
         | Let { [$1] }
         | IfThenElse { [$1] }

ATerm :: { Term }
ATerm : "(" Term ")" { $2 }
      | "var" { Var $1 }
      | "true" { TrueT }
      | "false" { FalseT }
      | "zero" { Zero }
      | "succ" ATerm { Succ $2 }
      | "pred" ATerm { Pred $2 }
      | "iszero" ATerm { Iszero $2 }
      | "fix" ATerm { Fix $2 }

Lam :: { Term }
Lam : "\\" "var" "::" Type "." Term { Lam $2 $4 $6 }

Let :: { Term }
Let : "let" LetList "in" Term { makeLet $2 $4 }

LetList :: { [(VarName, Term)] }
LetList : "var" "=" Term { [($1, $3)] }
LetList : "var" "=" Term ";" LetList { ($1, $3) : $5 }


IfThenElse :: { Term }
IfThenElse : "if" Term "then" Term "else" Term { If $2 $4 $6 }

Type :: { Type } 
Type : "int" { Base MyInt }
     | "bool" { Base MyBool }
     | "(" Type ")" { $2 }
     | Type "->" Type { $1 :-> $3 }

{
    
makeLet :: [(VarName, Term)] -> Term -> Term
makeLet [(x, y)] z = Let x y z
makeLet ((x, y) : ls) z = Let x y $ makeLet ls z

parseError :: [Token] -> a
parseError tokens = error ("Parse error" ++ show tokens)


main' = do
    s <- getContents
    let parseTree = parser $ alexScanTokens s
    print $ parseTree

main = main'

}