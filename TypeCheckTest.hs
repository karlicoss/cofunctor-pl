module TypeCheckTest where

import Datatypes
import TypeCheck (gettype, typecheck)

dummy = Lam "f" (Base MyInt) (Var "f")

i1 = (Fix $ Lam "f" (Base MyBool :-> Base MyBool) $ Lam "x" (Base MyBool) TrueT, [])
o1 = Just (Base MyBool :-> Base MyBool)

i2 = (Let "aaa" (Fix $ Lam "f" (Base MyBool :-> Base MyBool) $ Lam "x" (Base MyBool) TrueT) (Var "aaa"), [])
o2 = Just (Base MyBool :-> Base MyBool)

i3 = (Let "a" (Tuple []) (UnpackTuple 0 (Var "a")), [])
o3 = Nothing

i4 = ((UnpackTuple 1 $ Tuple [dummy, dummy, dummy, dummy]), [])
o4 = Just $ Base MyInt :-> Base MyInt

testsgettype = [
                  (i1, o1),
                  (i2, o2),
                  (i3, o3),
                  (i4, o4)
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