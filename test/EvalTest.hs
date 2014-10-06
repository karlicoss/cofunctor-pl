module Main where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit

import Datatypes
import SimpleTypes (eval, rename)
import TypeCheck (typecheck)

genid :: Type -> Term
genid t = Lam "x" t (Var "x")

tintid = genid (Base MyInt)
tintidid = genid ((Base MyInt) :-> (Base MyInt))

tand x y = ((Lam "x" (Base MyBool) $ Lam "y" (Base MyBool) $ If (Var "x") (If (Var "y") TrueT FalseT) FalseT) `App` x) `App` y
tor x y = ((Lam "x" (Base MyBool) $ Lam "y" (Base MyBool) $ If (Var "x") TrueT (If (Var "y") TrueT FalseT)) `App` x) `App` y
tnot x = If x FalseT TrueT

gencases :: [(Term, Term)] -> Term -> Term
gencases [] el = el
gencases ((c, t): xs) el = If c t $ gencases xs el


eqcase00 = Iszero (Var "x") `tand` Iszero (Var "y")
eqcase01 = Iszero (Var "x") `tand` (tnot $ Iszero (Var "y"))
eqcase10 = (tnot $ Iszero (Var "x")) `tand` (Iszero (Var "y"))
--eqcase11
eqcase00b = TrueT
eqcase01b = FalseT
eqcase10b = FalseT
eqcase11b = (Var "f" `App` (Pred $ Var "x")) `App` (Pred $ Var "y")

teq x y = ((Fix $ Lam "f" (Base MyInt :-> (Base MyInt :-> Base MyBool)) $ Lam "x" (Base MyInt) $ Lam "y" (Base MyInt) $ gencases [(eqcase00, eqcase00b), (eqcase01, eqcase01b), (eqcase10, eqcase10b)] eqcase11b) `App` x) `App` y

tadd x y = ((Fix $ Lam "f" (Base MyInt :-> (Base MyInt :-> Base MyInt)) $ Lam "x" (Base MyInt) $ Lam "y" (Base MyInt) $ If (Iszero (Var "y")) (Var "x") (Succ $ ((Var "f") `App` (Var "x")) `App` (Pred $ Var "y"))) `App` x) `App` y

tmul x y = ((Fix $ Lam "f" (Base MyInt :-> (Base MyInt :-> Base MyInt)) $ Lam "x" (Base MyInt) $ Lam "y" (Base MyInt) $ If (Iszero (Var "y")) Zero ((Var "x") `tadd` (((Var "f") `App` (Var "x")) `App` (Pred $ Var "y")))) `App` x) `App` y

tfac x = (Fix $ Lam "f" (Base MyInt :-> Base MyInt) $ Lam "x" (Base MyInt) $ If (Iszero (Var "x")) (Succ Zero) ((Var "x") `tmul` ((Var "f") `App` (Pred $ Var "x")))) `App` x

makenumber :: Int -> Term
makenumber 0 = Zero
makenumber n = Succ $ makenumber (n - 1)

i1 = If TrueT FalseT TrueT
o1 = FalseT

i2 = If (If FalseT TrueT FalseT) FalseT TrueT
o2 = TrueT

i3 = tintid
o3 = tintid

i4 = (tintidid `App` tintid) `App` (Succ Zero)
o4 = Succ Zero

i5 = tand FalseT FalseT
o5 = FalseT

i6 = tand FalseT TrueT
o6 = FalseT

i7 = tand TrueT FalseT
o7 = FalseT

i8 = tand TrueT TrueT
o8 = TrueT

i9 = tor (Iszero $ Succ Zero) (Iszero Zero)
o9 = TrueT

i10 = App (Lam "x" (Base MyInt) (Succ (Succ (Var "x")))) (Succ (Succ Zero))
o10 = Succ $ Succ $ Succ $ Succ $ Zero

i11 = Lam "x" (Base MyInt) (Pred $ Var "x") `App` (Succ $ Succ $ Zero)
o11 = Succ Zero

i12 = Zero `teq` Zero
o12 = TrueT

i13 = Succ Zero `teq` Zero
o13 = FalseT

i14 = makenumber 5 `teq` makenumber 5
o14 = TrueT

i15 = makenumber 10 `teq` makenumber 13
o15 = FalseT

i16 = makenumber 11 `tadd` makenumber 12
o16 = makenumber 23

i17 = makenumber 3 `tmul` makenumber 4
o17 = makenumber 12

i18 = tfac $ makenumber 3
o18 = makenumber 6

i19 = LetType "Integer" (TypeSum [Base MyInt,Base MyInt]) (Let "adds" (Lam "x" (TypeVar "Integer") (Case (Var "x") [("pos",TrueT),("neg",FalseT)])) (App (Var "adds") (Inject 1 Zero (TypeVar "Integer"))))
o19 = FalseT

i20 = LetType "Integer" (TypeSum [Base MyInt]) (Let "mi" (Inject 0 Zero (TypeVar "Integer")) (Var "mi"))
o20 = Inject 0 Zero (TypeSum [Base MyInt] ) -- !!! Problem with comparing typevar types and non-typevar

tests = [
             (i1, o1),
             (i2, o2),
             (i3, o3),
             (i4, o4),
             (i5, o5),
             (i6, o6),
             (i7, o7),
             (i8, o8),
             (i9, o9),
             (i10, o10),
             (i11, o11),
             (i12, o12),
             (i13, o13),
             (i14, o14),
             (i15, o15),
             (i16, o16),
             (i17, o17),
             (i18, o18),
             (i19, o19),
             (i20, o20)
            ]


testeval = map (\(s, t) -> eval s @?= t) tests

--testtype = \(i, (s, t)) -> do putStr $ show i ++ " " -- well, later types will be erased, so this code will be moved somewhere
--                              case typecheck s of
--                                Nothing -> do putStrLn $ "ERROR"
--                                              putStrLn $ "Test case did not typecheck"
--                                Just tp -> let res = eval s
--                                           in case typecheck res of
--                                                  Nothing -> do putStrLn $ "ERROR"
--                                                                putStrLn $ "Got: no type"
--                                                                putStrLn $ "Expected: " ++ show tp
--                                                  Just tp2 -> if tp == tp2
--                                                              then putStrLn $ "OK"
--                                                              else do putStrLn $ "ERROR"
--                                                                      putStrLn $ "Got: " ++ show tp2
--                                                                      putStrLn $ "Expected: " ++ show tp


main = defaultMain $ map (testCase "") testeval

--TODO TEST TYPE PRESERVATION

--test = do
--    putStrLn $ "Testing evaluation"
--    mapM_ testeval (zip [1..] testseval)
--    putStrLn $ "Testing type preservation"
--    mapM_ testtype (zip [1..] testseval)
