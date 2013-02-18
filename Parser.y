{
module Parser where

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
     --| 

AppTerm :: { Term }
AppTerm : AppTerm1 { foldl App (head $1) (tail $1) } -- application is left associative

AppTerm1 :: { [ Term ] }
AppTerm1 : ATerm { [$1] }
         | ATerm AppTerm1 { $1 : $2 }
         | Lam { [$1] } -- is it supposed to be like that?
         | Let { [$1] }

ATerm :: { Term }
ATerm : "(" Term ")" { $2 }
      | "var" { Var $1 }

Lam :: { Term }
Lam : "\\" "var" "::" Type "." Term { Lam $2 $4 $6 }

Let :: { Term }
Let : "let" "var" "=" Term "in" Term { Let $2 $4 $6 }

Type :: { Type } 
Type : "int" { Base MyInt }
     | "bool" { Base MyBool }
     | "(" Type ")" { $2 }
     | Type "->" Type { $1 :-> $3 }

{
    
parseError :: [Token] -> a
parseError tokens = error ("Parse error" ++ show tokens)


--main = do
--    s <- getContents
--    let parseTree = parser $ alexScanTokens s
--    print $ parseTree

}