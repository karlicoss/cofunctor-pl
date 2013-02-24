module TypeCheck where

import Datatypes
import Data.List (delete)
import Data.Maybe (isJust)
import Debug.Trace (trace)

type Context = [(VarName, Type)]

type TypeContext = [(TypeName, Type)]

replins :: Context -> (VarName, Type) -> Context
replins c (v, t) = case lookup v c of
                       Just t2 -> (v, t) : delete (v, t2) c
                       Nothing -> (v, t) : c

arecompatible :: TypeContext -> Type -> Type -> Bool
arecompatible _ (Base t1) (Base t2) = t1 == t2
arecompatible _ (Base _) (_ :-> _) = False
arecompatible _ (Base _) (TypeProd _) = False
arecompatible tc t1@(_ :-> _) t2@(Base _) = arecompatible tc t2 t1 -- symmetry                                              
arecompatible tc (t1 :-> t2) (t3 :-> t4) = arecompatible tc t1 t3 && arecompatible tc t1 t3
arecompatible tc (_ :-> _) (TypeProd _) = False
arecompatible tc t1@(TypeProd _) t2@(Base _) = arecompatible tc t2 t1 -- symmmetry
arecompatible tc t1@(TypeProd _) t2@(_ :-> _) = arecompatible tc t2 t1 -- symmetry
arecompatible tc (TypeProd tl1) (TypeProd tl2) = (length tl1 == length tl2) && (and $ map (\(x, y) -> arecompatible tc x y) $ zip tl1 tl2)
arecompatible _ (TypeVar tv) (TypeVar tv2) = True -- TODO not sure about this
arecompatible tc (TypeVar tv) t = case lookup tv tc of
                                      Just t2 -> arecompatible tc t2 t
                                      Nothing -> False
arecompatible tc t1 t2@(TypeVar _) = arecompatible tc t2 t1 -- symmetry

-- "evaluates" the type until it is not a type variable
getbase :: TypeContext -> Type -> Maybe Type
getbase tc (TypeVar tv) = do t2 <- lookup tv tc
                             getbase tc t2
getbase tc t            = Just t

-- checks that the type has no undefined type variables
checktype :: TypeContext -> Type -> Bool
checktype tc t@(Base _) = True
checktype tc t@(x :-> y) = checktype tc x && checktype tc y
checktype tc t@(TypeProd tl) = and $ map (checktype tc) tl
checktype tc t@(TypeVar tv) = isJust $ lookup tv tc

-- continues execution if its arguent is true, otherwise fails
contif :: (Monad m) => Bool -> m ()
contif True = return ()
contif False = fail "False"

gettype :: Context -> TypeContext -> Term -> Maybe Type
gettype c tc (LetType tn tp term) = do contif $ checktype tc tp                                       
                                       gettype c (replins tc (tn, tp)) term -- TODO use another replins or make it more abstract
gettype c tc (UnpackTuple i t) = do tp <- gettype c tc t
                                    (TypeProd tl) <- getbase tc tp
                                    if i < length tl
                                       then return $ tl !! i
                                       else fail "Tuple out of range"                          
gettype c tc (Tuple l) = do tl <- mapM (gettype c tc) l
                            return $ TypeProd tl
gettype c tc (Fix t) = do tp <- gettype c tc t
                          (l :-> r) <- getbase tc tp
                          if arecompatible tc l r
                             then return l
                             else fail "sdfsdf"
gettype _ tc Zero = Just $ Base MyInt
gettype c tc (Succ e) = do ety <- gettype c tc e
                           if arecompatible tc ety (Base MyInt)
                              then return $ Base MyInt
                              else fail "int expected"
gettype c tc (Pred e) = do ety <- gettype c tc e
                           if arecompatible tc ety (Base MyInt)
                              then return $ Base MyInt
                              else fail "int expected"                        
gettype c tc (Iszero e) = do ety <- gettype c tc e
                             if arecompatible tc ety (Base MyInt)
                                then return $ Base MyBool
                                else fail "int expected"                         
gettype _ tc TrueT = Just $ Base MyBool
gettype _ tc FalseT = Just $ Base MyBool
gettype c tc (If e th el) = do ety <- gettype c tc e
                               if arecompatible tc ety (Base MyBool)
                                  then do thty <- gettype c tc th
                                          elty <- gettype c tc el
                                          if arecompatible tc thty elty
                                             then return thty
                                             else fail "then/else clause type mismatch"
                                  else fail "if condition type is not boolean"
gettype c tc t@(Var v) = lookup v c
gettype c tc t@(Lam vn ty b) = do contif $ checktype tc ty
                                  bty <- gettype (replins c (vn, ty)) tc b
                                  return (ty :-> bty)
gettype c tc t@(t1 `App` t2) = do tp1 <- gettype c tc t1
                                  tp2 <- gettype c tc t2
                                  (l :-> r) <- getbase tc tp1
                                  if arecompatible tc l tp2
                                     then return r
                                     else fail "application type mismatch"
gettype c tc t@(Let v t1 t2) = do vt <- gettype c tc t1
                                  t2ty <- gettype (replins c (v, vt)) tc t2
                                  return t2ty

typecheck = gettype [] []