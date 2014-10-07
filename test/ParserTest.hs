module Main where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit

import Cofunctor.Lexer (alexScanTokens)
import Cofunctor.Parser (parser, Ex(..))
import Cofunctor.Datatypes

runTest :: String -> Ex Term
runTest s = parser $ alexScanTokens s

s1 = "x"
t1 = Ok $ Var "x"

s2 = "x1 x2"
t2 = Ok $ Var "x1" `App` Var "x2"

s3 = "\\x::Int->Int.x"
t3 = Ok $ Lam "x" (Base MyInt :-> Base MyInt) (Var "x")

s4 = "let x = y5 z6 in a5"
t4 = Ok $ Let "x" (Var "y5" `App` Var "z6") (Var "a5")

s5 = "x let x = z in let y = w in q"
t5 = Ok $ Var "x" `App` Let "x" (Var "z") (Let "y" (Var "w") (Var "q"))

s6 = "let x = z in let y = w in q x"
t6 = Ok $ Let "x" (Var "z") (Let "y" (Var "w") (Var "q" `App` Var "x"))

s7 = "\\x :: Int -> (Int -> Bool) -> Int.x"
t7 = Ok $ Lam "x" (Base MyInt :-> ((Base MyInt :-> Base MyBool) :-> Base MyInt)) (Var "x")

s8 = "(\\x :: Int. succ (succ x)) (succ (succ zero))"
t8 = Ok $ App (Lam "x" (Base MyInt) (Succ (Succ (Var "x")))) (Succ (Succ Zero))

s9 = "\\x :: int. zero"
t9 = Fail ""

s10 = "\\x :: sadlald. zero"
t10 = Fail ""

s11 = "let type MaybeInt = Int + Int in zero"
t11 = Ok $ LetType "MaybeInt" (TypeSum [Base MyInt, Base MyInt]) Zero

s12 = "let type MaybeInt = Int + Int * Bool + Bool -> Bool in zero"
t12 = Ok $ (LetType "MaybeInt" (TypeSum [Base MyInt, TypeProd [Base MyInt, Base MyBool], Base MyBool :-> Base MyBool]) Zero)

s13 = "let type MaybeInt = Int -> Int * Bool -> Bool * Int -> Bool in zero"
t13 = Ok $ (LetType "MaybeInt" (Base MyInt :-> (TypeProd [Base MyInt, Base MyBool] :-> (TypeProd [Base MyBool, Base MyInt] :-> Base MyBool))) Zero)

s14 = "let \
\ type Integer = Int + Int; \
\ adds = \\x::Integer.\\ \ 
\    case x { \
\        pos : true; \
\        neg : false \
\    } \
\ in adds (inj zero as Integer@1)"
t14 = Ok $ LetType "Integer" (TypeSum [Base MyInt,Base MyInt]) (Let "adds" (Lam "x" (TypeVar "Integer") (Case (Var "x") [("pos",TrueT),("neg",FalseT)])) (App (Var "adds") (Inject 1 Zero (TypeVar "Integer"))))

tests = [
         (s1, t1),
         (s2, t2),
         (s3, t3),
         (s4, t4),
         (s5, t5),
         (s6, t6),
         (s7, t7),
         (s8, t8),
         (s9, t9),
         (s10, t10),
         (s11, t11),
         (s12, t12),
         (s13, t13)
        ]

-- modifed Eq for Ex, treats all Fails as equal
exeq :: (Eq a) => Ex a -> Ex a -> Bool
exeq (Ok x) (Ok y) = x == y
exeq (Ok _) (Fail _) = False
exeq (Fail _) (Ok _) = False
exeq (Fail _) (Fail _) = True

testss = map (\(s, t) -> (runTest s `exeq` t) @?= True) tests

main = defaultMain $ map (testCase "") testss