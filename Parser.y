{
module Parser (parser, Ex(..)) where

import Lexer
import Datatypes
import Debug.Trace (trace)
}

%monad { Ex } { thenEx } { returnEx }
%name parser
%tokentype { Token }
%error { parseError }

%token
    "let"     { TokenLet }
    "in"      { TokenIn }
    "if"      { TokenIf }
    "then"    { TokenThen }
    "else"    { TokenElse }
    "true"    { TokenTrue }
    "false"   { TokenFalse }
    "zero"    { TokenZero }
    "succ"    { TokenSucc }
    "pred"    { TokenPred }
    "iszero"  { TokenIszero }
    "fix"     { TokenFix }
    "type"    { TokenType }
    "case"    { TokenCase }
    "inj"     { TokenInj }
    "as"      { TokenAs }
    "integer" { TokenInteger $$ }
    "(*"      { TokenOABracket }
    "*)"      { TokenCABracket }
    "(+"      { TokenOPBracket }
    "+)"      { TokenCPBracket }
    "("       { TokenOBracket }
    ")"       { TokenCBracket }
    "{"       { TokenOCBracket }
    "}"       { TokenCCBracket }
    "+"       { TokenPlus }
    "*"       { TokenAsterisk }
    "="       { TokenAssignment }
    "\\"      { TokenLambda }
    "@"       { TokenAt }
    "#"       { TokenSharp }
    "<"       { TokenLT }
    ">"       { TokenGT }
    "."       { TokenDot }
    ","       { TokenComma }
    "::"      { TokenDoubleColon }
    ":"       { TokenColon }
    ";"       { TokenSemiColon }
    "->"      { TokenArrow }
    "var"     { TokenVar $$ }
    "typevar" { TokenTypeVar $$ }

%nonassoc "fix"
%nonassoc "succ" "pred" "iszero"
%left "#"

%%

Term :: { Term }
Term : AppTerm { $1  }
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
      | Tuple { Tuple $1 }
      | ATerm "#" "integer" { UnpackTuple $3 $1 }
      | Case { $1 }
      | SumInjection { $1 }

Lam :: { Term }
Lam : "\\" "var" "::" Type "." Term { Lam $2 $4 $6 }

Let :: { Term }
Let : "let" LetList "in" Term { makeLet $2 $4 }

LetList :: { [Either (VarName, Term) (TypeName, Type)] }
LetList : "var" "=" Term { [Left ($1, $3)] }
        | "type" "typevar" "=" Type { [Right ($2, $4)] }
        | "var" "=" Term ";" LetList { Left ($1, $3) : $5 }
        | "type" "typevar" "=" Type ";" LetList { Right ($2, $4) : $6 }

Tuple :: { [Term] }
Tuple : "<" ">" { [] }
      | "<" TupleTermList ">" { $2 } 

TupleTermList :: { [Term] }
TupleTermList : Term { [$1] }
              | Term "," TupleTermList { $1 : $3 }


IfThenElse :: { Term }
IfThenElse : "if" Term "then" Term "else" Term { If $2 $4 $6 }

SumInjection :: { Term }
SumInjection : "inj" Term "as" Type "@" "integer" { Inject $6 $2 $4 }

Case :: { Term }
Case : "case" Term "{" CaseList "}" { Case $2 $4 }

CaseList :: { [(VarName, Term)] }
CaseList : "var" ":" Term { [($1, $3)] }
         | "var" ":" Term ";" CaseList { ($1, $3) : $5 }

Type :: { Type } 
Type : TypeSum { $1 }

TypeSum :: { Type }
TypeSum : TypeSumList { if length $1 == 1 then head $1 else TypeSum $1 }
        | "(+" "+)" { TypeSum [] }
        | "(+" Type "+)" { TypeSum [$2] }

TypeSumList :: { [Type] }
TypeSumList : TypeArrow { [$1] }
            | TypeArrow "+" TypeSumList { $1 : $3 }

TypeArrow :: { Type }
TypeArrow : TypeProd { $1 }
          | TypeProd "->" TypeArrow { $1 :-> $3 }

TypeProd :: { Type }
TypeProd : TypeProdList { if length $1 == 1 then head $1 else TypeProd $1 }
         | "(*" "*)" { TypeProd [] }
         | "(*" Type "*)" { TypeProd [$2] }

TypeProdList :: { [Type] }
TypeProdList : AType { [$1] }
             | AType "*" TypeProdList { $1 : $3 }

AType :: { Type }
AType : "(" Type ")" { $2 }
      | "typevar" { makeType $1 }

{

data Ex a = Ok a
          | Fail String
          deriving (Show, Eq)

thenEx :: Ex a -> (a -> Ex b) -> Ex b
m `thenEx` k = case m of
                   Ok a -> k a
                   Fail s -> Fail s

returnEx :: a -> Ex a
returnEx a = Ok a

failEx :: String -> Ex a
failEx s = Fail s

catchEx :: Ex a -> (String -> Ex a) -> Ex a
catchEx m k = case m of
                  Ok a -> Ok a
                  Fail s -> k s

-- checks if type name is a base type, returns the appropriate type
makeType :: TypeName -> Type
makeType "Int" = Base MyInt
makeType "Bool" = Base MyBool
makeType v = TypeVar v

makeLet :: [Either (VarName, Term) (TypeName, Type)] -> Term -> Term
makeLet [Left (x, y)] z = Let x y z
makeLet [Right (x, y)] z = LetType x y z
makeLet (Left (x, y) : ls) z = Let x y $ makeLet ls z
makeLet (Right (x, y): ls) z = LetType x y $ makeLet ls z

parseError :: [Token] -> Ex a
parseError tokens = failEx $ "Parse error" ++ show tokens


main' = do
    s <- getContents
    let tokens = alexScanTokens s
    print $ tokens
    let parseTree = parser tokens
    print $ parseTree

main = main'

}