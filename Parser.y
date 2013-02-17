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

--main = do
--    s <- getContents
--    let parseTree = parser $ alexScanTokens s
--    print $ parseTree

}