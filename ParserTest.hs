module ParserTest where

import Lexer (alexScanTokens)
import Parser (parser, Ex(..))
import Datatypes

runTest :: String -> Ex Term
runTest s = parser $ alexScanTokens s

s1 = "x"
t1 = Ok $ Var "x"

s2 = "x1 x2"
t2 = Ok $ Var "x1" `App` Var "x2"

s3 = "\\x::int->int.x"
t3 = Ok $ Lam "x" (Base MyInt :-> Base MyInt) (Var "x")

s4 = "let x = y5 z6 in A5"
t4 = Ok $ Let "x" (Var "y5" `App` Var "z6") (Var "A5")

s5 = "x let x = z in let y = w in q"
t5 = Ok $ Var "x" `App` Let "x" (Var "z") (Let "y" (Var "w") (Var "q"))

s6 = "let x = z in let y = w in q x"
t6 = Ok $ Let "x" (Var "z") (Let "y" (Var "w") (Var "q" `App` Var "x"))

s7 = "\\x :: int -> (int -> bool) -> int.x"
t7 = Ok $ Lam "x" (Base MyInt :-> ((Base MyInt :-> Base MyBool) :-> Base MyInt)) (Var "x")

s8 = "(\\x :: int. succ (succ x)) (succ (succ zero))"
t8 = Ok $ App (Lam "x" (Base MyInt) (Succ (Succ (Var "x")))) (Succ (Succ Zero))

tests = [
         (s1, t1),
         (s2, t2),
         (s3, t3),
         (s4, t4),
         (s5, t5),
         (s6, t6),
         (s7, t7),
         (s8, t8)
        ]

test = do
    let tst = \(i, (s, t)) -> let res = runTest s
                              in if res == t
                                 then putStrLn $ show i ++ " " ++ "OK"
                                 else do putStrLn $ show i ++ " " ++ "ERROR"
                                         putStrLn $ "Got: " ++ show res
                                         putStrLn $ "Expected: " ++ show t
    mapM_ tst (zip [1..] tests)

main = test
