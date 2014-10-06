module Main where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit

import Datatypes
import SimpleTypes (eval, rename)
import TypeCheck (typecheck)


ri1 = (Var "x", "x", "alala")
ro1 = (Var "alala")

ri2 = (Var "x", "y", "sdfsf")
ro2 = (Var "x")

ri3 = ((Lam "x" (Base MyInt) ((Var "y") `App` (Lam "y" (Base MyInt) (Var "y" `App` Var "x")))) `App` (Var "z"), "x", "q")
ro3 = (Lam "x" (Base MyInt) ((Var "y") `App` (Lam "y" (Base MyInt) (Var "y" `App` Var "x")))) `App` (Var "z")

ri4 = ((Lam "x" (Base MyInt) ((Var "y") `App` (Lam "y" (Base MyInt) (Var "y" `App` Var "x")))) `App` (Var "z"), "z", "q")
ro4 = (Lam "x" (Base MyInt) ((Var "y") `App` (Lam "y" (Base MyInt) (Var "y" `App` Var "x")))) `App` (Var "q")

ri5 = ((Lam "x" (Base MyInt) ((Var "y") `App` (Lam "y" (Base MyInt) (Var "y" `App` Var "x")))) `App` (Var "z"), "y", "q")
ro5 = (Lam "x" (Base MyInt) ((Var "q") `App` (Lam "y" (Base MyInt) (Var "y" `App` Var "x")))) `App` (Var "z")

-- TODO insert tests for substitution and beta-reduction

tests = [
       (ri1, ro1),
       (ri2, ro2),
       (ri3, ro3),
       (ri4, ro4),
       (ri5, ro5)
      ]



testcases = map (\((s, from, to), t) -> (rename from to s) @?= t) tests

main = defaultMain $ map (testCase "") testcases