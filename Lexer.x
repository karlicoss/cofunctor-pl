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
  \=                                { \s -> TokenAssignment }
  \\                                { \s -> TokenLambda }
  \.                                { \s -> TokenDot }
  \(                                { \s -> TokenOBracket }
  \)                                { \s -> TokenCBracket }
  \:\:                              { \s -> TokenDoubleColon }
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
           | TokenAssignment
           | TokenLambda
           | TokenDot
           | TokenOBracket
           | TokenCBracket
           | TokenDoubleColon
           | TokenArrow
           | TokenVar String
           deriving (Show)

--main = do
--    s <- getContents
--    print $ alexScanTokens s
}