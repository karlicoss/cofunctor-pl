module Main where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit

import Cofunctor.Datatypes
import Cofunctor.TypeCheck (gettype, typecheck)

dummy = Lam "f" (Base MyInt) (Var "f")

i1 = (Fix $ Lam "f" (Base MyBool :-> Base MyBool) $ Lam "x" (Base MyBool) TrueT, [], [])
o1 = Just (Base MyBool :-> Base MyBool)

i2 = (Let "aaa" (Fix $ Lam "f" (Base MyBool :-> Base MyBool) $ Lam "x" (Base MyBool) TrueT) (Var "aaa"), [], [])
o2 = Just (Base MyBool :-> Base MyBool)

i3 = (Let "a" (Tuple []) (UnpackTuple 0 (Var "a")), [], [])
o3 = Nothing

i4 = ((UnpackTuple 1 $ Tuple [dummy, dummy, dummy, dummy]), [], [])
o4 = Just $ Base MyInt :-> Base MyInt

i5 = (LetType "x" (TypeVar "A") Zero, [], [])
o5 = Nothing

i6 = (LetType "Fint" (Base MyInt :-> Base MyInt) (Let "fac" (Fix (Lam "fac" (TypeVar "Fint") (Lam "x" (Base MyInt) Zero))) (App (Var "fac") Zero)), [], [])
o6 = Just $ Base MyInt

i7 = (LetType "A" (Base MyInt) (Let "ida" (Lam "x" (TypeVar "A") (Var "x")) (App (Var "ida") Zero)), [], [])
o7 = Just $ Base MyInt

testsgettype = [
                  (i1, o1),
                  (i2, o2),
                  (i3, o3),
                  (i4, o4),
                  (i5, o5),
                  (i6, o6),
                  (i7, o7)
               ]


tests = map (\((s, c, tc), t) -> (gettype c tc s) @?= t) testsgettype

main = defaultMain $ map (testCase "") tests