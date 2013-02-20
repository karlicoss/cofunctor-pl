{
module Lexer where
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]


tokens :-

  $white+                           ;
  let                               { \s -> TokenLet }
  in                                { \s -> TokenIn  }
  int                               { \s -> TokenTypeInt }
  bool                              { \s -> TokenTypeBool }
  if                                { \s -> TokenIf }
  then                              { \s -> TokenThen }
  else                              { \s -> TokenElse }
  true                              { \s -> TokenTrue }
  false                             { \s -> TokenFalse }
  zero                              { \s -> TokenZero }
  succ                              { \s -> TokenSucc }
  pred                              { \s -> TokenPred }
  iszero                            { \s -> TokenIszero }
  fix                               { \s -> TokenFix }
  $digit+                           { \s -> TokenInteger (read s :: Int) }
  \*                                { \s -> TokenAsterisk }
  \=                                { \s -> TokenAssignment }
  \\                                { \s -> TokenLambda }
  \<                                { \s -> TokenLT }
  \>                                { \s -> TokenGT }
  \@                                { \s -> TokenAt }
  \#                                { \s -> TokenSharp }   
  \.                                { \s -> TokenDot }
  \,                                { \s -> TokenComma }
  \(                                { \s -> TokenOBracket }
  \)                                { \s -> TokenCBracket }
  \:\:                              { \s -> TokenDoubleColon }
  \;                                { \s -> TokenSemiColon }
  \-\>                              { \s -> TokenArrow }
  $alpha [$alpha $digit \_ \']*     { \s -> TokenVar s} 

{

data Token = TokenLet
           | TokenIn
           | TokenTypeInt
           | TokenTypeBool
           | TokenIf
           | TokenThen
           | TokenElse
           | TokenTrue
           | TokenFalse
           | TokenZero
           | TokenSucc
           | TokenPred
           | TokenIszero
           | TokenFix
           | TokenInteger Int
           | TokenAsterisk
           | TokenAssignment
           | TokenLambda
           | TokenAt
           | TokenSharp
           | TokenLT
           | TokenGT
           | TokenComma
           | TokenDot
           | TokenOBracket
           | TokenCBracket
           | TokenDoubleColon
           | TokenSemiColon
           | TokenArrow
           | TokenVar String
           deriving (Show)

--main = do
--    s <- getContents
--    print $ alexScanTokens s
}