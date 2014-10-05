{
module Lexer where
}

%wrapper "basic"

$digit = [0-9]
$lower = [a-z]
$upper = [A-Z]
$alpha = [a-zA-Z0-9\_]


tokens :-

  $white+                           ;
  let                               { \s -> TokenLet }
  in                                { \s -> TokenIn  }
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
  type                              { \s -> TokenType }
  case                              { \s -> TokenCase }
  inj                               { \s -> TokenInj }
  as                                { \s -> TokenAs }
  $digit+                           { \s -> TokenInteger (read s :: Int) }
  \(\*                              { \s -> TokenOABracket }
  \*\)                              { \s -> TokenCABracket }
  \(\+                              { \s -> TokenOPBracket }
  \+\)                              { \s -> TokenCPBracket }
  \(                                { \s -> TokenOBracket }
  \)                                { \s -> TokenCBracket }
  \{                                { \s -> TokenOCBracket }
  \}                                { \s -> TokenCCBracket }
  \+                                { \s -> TokenPlus }
  \*                                { \s -> TokenAsterisk }
  \=                                { \s -> TokenAssignment }
  \\                                { \s -> TokenLambda }
  \<                                { \s -> TokenLT }
  \>                                { \s -> TokenGT }
  \$                                { \s -> TokenDollar }
  \@                                { \s -> TokenAt }
  \#                                { \s -> TokenSharp }   
  \.                                { \s -> TokenDot }
  \,                                { \s -> TokenComma }
  \:\:                              { \s -> TokenDoubleColon }
  \:                                { \s -> TokenColon }
  \;                                { \s -> TokenSemiColon }
  \-\>                              { \s -> TokenArrow }
  $upper [$alpha \']*               { \s -> TokenTypeVar s} 
  $lower [$alpha \']*               { \s -> TokenVar s} 


{

data Token = TokenLet
           | TokenIn
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
           | TokenType
           | TokenCase
           | TokenInj
           | TokenAs
           | TokenInteger Int
           | TokenOABracket
           | TokenCABracket
           | TokenOPBracket
           | TokenCPBracket
           | TokenOBracket
           | TokenCBracket
           | TokenOCBracket
           | TokenCCBracket
           | TokenPlus
           | TokenAsterisk
           | TokenAssignment
           | TokenLambda
           | TokenDollar
           | TokenAt
           | TokenSharp
           | TokenLT
           | TokenGT
           | TokenComma
           | TokenDot
           | TokenDoubleColon
           | TokenColon
           | TokenSemiColon
           | TokenArrow
           | TokenVar String
           | TokenTypeVar String
           deriving (Show)

--main = do
--    s <- getContents
--    print $ alexScanTokens s
}
