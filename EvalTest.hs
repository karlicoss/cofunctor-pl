module EvalTest where

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

testsrename = [
               (ri1, ro1),
               (ri2, ro2),
               (ri3, ro3),
               (ri4, ro4),
               (ri5, ro5)
              ]

genid :: Type -> Term
genid t = Lam "x" t (Var "x")

tintid = genid (Base MyInt)
tintidid = genid ((Base MyInt) :-> (Base MyInt))

tand = Lam "x" (Base MyBool) $ Lam "y" (Base MyBool) $ If (Var "x") (If (Var "y") TrueT FalseT) FalseT

i1 = If TrueT FalseT TrueT
o1 = FalseT

i2 = If (If FalseT TrueT FalseT) FalseT TrueT
o2 = TrueT

i3 = tintid
o3 = tintid

i4 = (tintidid `App` tintid) `App` (Var "x") -- TODO this test case did not typecheck, insert value instead of Var "x" later
o4 = Var "x"

i5 = (tand `App` FalseT) `App` FalseT
o5 = FalseT

i6 = (tand `App` FalseT) `App` TrueT
o6 = FalseT

i7 = (tand `App` TrueT) `App` FalseT
o7 = FalseT

i8 = (tand `App` TrueT) `App` TrueT
o8 = TrueT


testseval = [
             (i1, o1),
             (i2, o2),
             (i3, o3),
             (i4, o4),
             (i5, o5),
             (i6, o6),
             (i7, o7),
             (i8, o8)
            ]

testeval = \(i, (s, t)) -> let res = eval s
                           in if res == t
                              then putStrLn $ show i ++ " " ++ "OK"
                              else do putStrLn $ show i ++ " " ++ "ERROR"
                                      putStrLn $ "Got: " ++ show res
                                      putStrLn $ "Expected: " ++ show t

testtype = \(i, (s, t)) -> do putStr $ show i ++ " " -- well, later types will be erased, so this code will be moved somewhere
                              case typecheck s of
                                Nothing -> do putStrLn $ "ERROR"
                                              putStrLn $ "Test case did not typecheck"
                                Just tp -> let res = eval s
                                           in case typecheck res of
                                                  Nothing -> do putStrLn $ "ERROR"
                                                                putStrLn $ "Got: no type"
                                                                putStrLn $ "Expected: " ++ show tp
                                                  Just tp2 -> if tp == tp2
                                                              then putStrLn $ "OK"
                                                              else do putStrLn $ "ERROR"
                                                                      putStrLn $ "Got: " ++ show tp2
                                                                      putStrLn $ "Expected: " ++ show tp


testrename = \(i, ((s, from, to), t)) -> do putStr $ show i ++ " "
                                            let res = rename from to s
                                            if res == t
                                            then putStrLn $ "OK"
                                            else do putStrLn $ "ERROR"
                                                    putStrLn $ "Got: " ++ show res
                                                    putStrLn $ "Expected: " ++ show t

test = do
    putStrLn $ "Testing renaming"
    mapM_ testrename (zip [1..] testsrename)
    putStrLn $ "Testing evaluation"
    mapM_ testeval (zip [1..] testseval)
    putStrLn $ "Testing type preservation"
    mapM_ testtype (zip [1..] testseval)


main = test