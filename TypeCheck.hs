module TypeCheck where

import Datatypes
import Data.List (delete)

type Context = [(VarName, Type)]

replins :: Context -> (VarName, Type) -> Context
replins c (v, t) = case lookup v c of
                       Just t2 -> (v, t) : delete (v, t2) c
                       Nothing -> (v, t) : c

gettype :: Context -> Term -> Maybe Type
gettype c (Fix t) = do (l :-> r) <- gettype c t
                       if l == r
                       then return l
                       else fail "sdfsdf"
gettype _ Zero = Just $ Base MyInt
gettype c (Succ e) = do ety <- gettype c e
                        if ety == Base MyInt
                        then return $ Base MyInt
                        else fail "int expected"
gettype c (Pred e) = do ety <- gettype c e
                        if ety == Base MyInt
                        then return $ Base MyInt
                        else fail "int expected"                        
gettype c (Iszero e) = do ety <- gettype c e
                          if ety == Base MyInt
                          then return $ Base MyBool
                          else fail "int expected"                         
gettype _ TrueT = Just $ Base MyBool
gettype _ FalseT = Just $ Base MyBool
gettype c (If e th el) = do ety <- gettype c e
                            if ety == Base MyBool
                            then do thty <- gettype c th
                                    elty <- gettype c el
                                    if thty == elty
                                    then return thty
                                    else fail "then/else clause type mismatch"
                            else fail "if condition type is not boolean"
gettype c t@(Var v) = lookup v c
gettype c t@(Lam vn ty b) = do bty <- gettype (replins c (vn, ty)) b
                               return (ty :-> bty)
gettype c t@(t1 `App` t2) = do (l :-> r) <- gettype c t1
                               t2ty <- gettype c t2
                               if l == t2ty
                                   then return r
                                   else fail "application type mismatch"
gettype c t@(Let v t1 t2) = do vt <- gettype c t1
                               t2ty <- gettype (replins c (v, vt)) t2
                               return t2ty

typecheck = gettype []