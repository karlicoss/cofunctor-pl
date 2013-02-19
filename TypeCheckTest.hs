module TypeCheckTest where

import Datatypes
import TypeCheck (gettype, typecheck)

i1 = (Fix $ Lam "f" (Base MyBool :-> Base MyBool) $ Lam "x" (Base MyBool) TrueT, [])
o1 = Just (Base MyBool :-> Base MyBool)

i2 = (Let "aaa" (Fix $ Lam "f" (Base MyBool :-> Base MyBool) $ Lam "x" (Base MyBool) TrueT) (Var "aaa"), [])
o2 = Just (Base MyBool :-> Base MyBool)

testsgettype = [
                  (i1, o1),
                  (i2, o2)
               ]

testgettype = \(i, ((s, c), t)) -> let res = gettype c s
                                   in if res == t
                                      then putStrLn $ show i ++ " " ++ "OK"
                                      else do putStrLn $ show i ++ " " ++ "ERROR"
                                              putStrLn $ "Got: " ++ show res
                                              putStrLn $ "Expected: " ++ show t

test = do
    putStrLn $ "Testing gettype"
    mapM_ testgettype (zip [1..] testsgettype)


main = test