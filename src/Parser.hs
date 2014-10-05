{-# OPTIONS_GHC -w #-}
module Parser (parser, Ex(..)) where

import Lexer
import Datatypes
import Debug.Trace (trace)
import Control.Applicative(Applicative(..))

-- parser produced by Happy Version 1.19.4

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 (Term)
	| HappyAbsSyn6 ([ Term ])
	| HappyAbsSyn10 ([Either (VarName, Term) (TypeName, Type)])
	| HappyAbsSyn11 ([Term])
	| HappyAbsSyn16 ([(VarName, Term)])
	| HappyAbsSyn17 (Type)
	| HappyAbsSyn19 ([Type])

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104 :: () => Int -> ({-HappyReduction (Ex) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Ex) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Ex) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Ex) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51 :: () => ({-HappyReduction (Ex) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Ex) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Ex) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Ex) HappyAbsSyn)

action_0 (24) = happyShift action_11
action_0 (26) = happyShift action_12
action_0 (29) = happyShift action_13
action_0 (30) = happyShift action_14
action_0 (31) = happyShift action_15
action_0 (32) = happyShift action_16
action_0 (33) = happyShift action_17
action_0 (34) = happyShift action_18
action_0 (35) = happyShift action_19
action_0 (37) = happyShift action_20
action_0 (38) = happyShift action_21
action_0 (40) = happyShift action_22
action_0 (45) = happyShift action_23
action_0 (52) = happyShift action_24
action_0 (55) = happyShift action_25
action_0 (63) = happyShift action_26
action_0 (4) = happyGoto action_27
action_0 (5) = happyGoto action_2
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (8) = happyGoto action_5
action_0 (9) = happyGoto action_6
action_0 (11) = happyGoto action_7
action_0 (13) = happyGoto action_8
action_0 (14) = happyGoto action_9
action_0 (15) = happyGoto action_10
action_0 _ = happyFail

action_1 (24) = happyShift action_11
action_1 (26) = happyShift action_12
action_1 (29) = happyShift action_13
action_1 (30) = happyShift action_14
action_1 (31) = happyShift action_15
action_1 (32) = happyShift action_16
action_1 (33) = happyShift action_17
action_1 (34) = happyShift action_18
action_1 (35) = happyShift action_19
action_1 (37) = happyShift action_20
action_1 (38) = happyShift action_21
action_1 (40) = happyShift action_22
action_1 (45) = happyShift action_23
action_1 (52) = happyShift action_24
action_1 (55) = happyShift action_25
action_1 (63) = happyShift action_26
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (8) = happyGoto action_5
action_1 (9) = happyGoto action_6
action_1 (11) = happyGoto action_7
action_1 (13) = happyGoto action_8
action_1 (14) = happyGoto action_9
action_1 (15) = happyGoto action_10
action_1 _ = happyFail

action_2 _ = happyReduce_1

action_3 _ = happyReduce_2

action_4 (24) = happyShift action_11
action_4 (26) = happyShift action_12
action_4 (29) = happyShift action_13
action_4 (30) = happyShift action_14
action_4 (31) = happyShift action_15
action_4 (32) = happyShift action_16
action_4 (33) = happyShift action_17
action_4 (34) = happyShift action_18
action_4 (35) = happyShift action_19
action_4 (37) = happyShift action_20
action_4 (38) = happyShift action_21
action_4 (40) = happyShift action_22
action_4 (45) = happyShift action_23
action_4 (52) = happyShift action_24
action_4 (54) = happyShift action_44
action_4 (55) = happyShift action_25
action_4 (63) = happyShift action_26
action_4 (6) = happyGoto action_43
action_4 (7) = happyGoto action_4
action_4 (8) = happyGoto action_5
action_4 (9) = happyGoto action_6
action_4 (11) = happyGoto action_7
action_4 (13) = happyGoto action_8
action_4 (14) = happyGoto action_9
action_4 (15) = happyGoto action_10
action_4 _ = happyReduce_3

action_5 _ = happyReduce_5

action_6 _ = happyReduce_6

action_7 _ = happyReduce_18

action_8 _ = happyReduce_7

action_9 _ = happyReduce_21

action_10 _ = happyReduce_20

action_11 (36) = happyShift action_41
action_11 (63) = happyShift action_42
action_11 (10) = happyGoto action_40
action_11 _ = happyFail

action_12 (24) = happyShift action_11
action_12 (26) = happyShift action_12
action_12 (29) = happyShift action_13
action_12 (30) = happyShift action_14
action_12 (31) = happyShift action_15
action_12 (32) = happyShift action_16
action_12 (33) = happyShift action_17
action_12 (34) = happyShift action_18
action_12 (35) = happyShift action_19
action_12 (37) = happyShift action_20
action_12 (38) = happyShift action_21
action_12 (40) = happyShift action_22
action_12 (45) = happyShift action_23
action_12 (52) = happyShift action_24
action_12 (55) = happyShift action_25
action_12 (63) = happyShift action_26
action_12 (4) = happyGoto action_39
action_12 (5) = happyGoto action_2
action_12 (6) = happyGoto action_3
action_12 (7) = happyGoto action_4
action_12 (8) = happyGoto action_5
action_12 (9) = happyGoto action_6
action_12 (11) = happyGoto action_7
action_12 (13) = happyGoto action_8
action_12 (14) = happyGoto action_9
action_12 (15) = happyGoto action_10
action_12 _ = happyFail

action_13 _ = happyReduce_10

action_14 _ = happyReduce_11

action_15 _ = happyReduce_13

action_16 (29) = happyShift action_13
action_16 (30) = happyShift action_14
action_16 (31) = happyShift action_15
action_16 (32) = happyShift action_16
action_16 (33) = happyShift action_17
action_16 (34) = happyShift action_18
action_16 (35) = happyShift action_19
action_16 (37) = happyShift action_20
action_16 (38) = happyShift action_21
action_16 (40) = happyShift action_22
action_16 (45) = happyShift action_23
action_16 (55) = happyShift action_25
action_16 (63) = happyShift action_26
action_16 (7) = happyGoto action_38
action_16 (11) = happyGoto action_7
action_16 (14) = happyGoto action_9
action_16 (15) = happyGoto action_10
action_16 _ = happyFail

action_17 (29) = happyShift action_13
action_17 (30) = happyShift action_14
action_17 (31) = happyShift action_15
action_17 (32) = happyShift action_16
action_17 (33) = happyShift action_17
action_17 (34) = happyShift action_18
action_17 (35) = happyShift action_19
action_17 (37) = happyShift action_20
action_17 (38) = happyShift action_21
action_17 (40) = happyShift action_22
action_17 (45) = happyShift action_23
action_17 (55) = happyShift action_25
action_17 (63) = happyShift action_26
action_17 (7) = happyGoto action_37
action_17 (11) = happyGoto action_7
action_17 (14) = happyGoto action_9
action_17 (15) = happyGoto action_10
action_17 _ = happyFail

action_18 (29) = happyShift action_13
action_18 (30) = happyShift action_14
action_18 (31) = happyShift action_15
action_18 (32) = happyShift action_16
action_18 (33) = happyShift action_17
action_18 (34) = happyShift action_18
action_18 (35) = happyShift action_19
action_18 (37) = happyShift action_20
action_18 (38) = happyShift action_21
action_18 (40) = happyShift action_22
action_18 (45) = happyShift action_23
action_18 (55) = happyShift action_25
action_18 (63) = happyShift action_26
action_18 (7) = happyGoto action_36
action_18 (11) = happyGoto action_7
action_18 (14) = happyGoto action_9
action_18 (15) = happyGoto action_10
action_18 _ = happyFail

action_19 (29) = happyShift action_13
action_19 (30) = happyShift action_14
action_19 (31) = happyShift action_15
action_19 (32) = happyShift action_16
action_19 (33) = happyShift action_17
action_19 (34) = happyShift action_18
action_19 (35) = happyShift action_19
action_19 (37) = happyShift action_20
action_19 (38) = happyShift action_21
action_19 (40) = happyShift action_22
action_19 (45) = happyShift action_23
action_19 (55) = happyShift action_25
action_19 (63) = happyShift action_26
action_19 (7) = happyGoto action_35
action_19 (11) = happyGoto action_7
action_19 (14) = happyGoto action_9
action_19 (15) = happyGoto action_10
action_19 _ = happyFail

action_20 (24) = happyShift action_11
action_20 (26) = happyShift action_12
action_20 (29) = happyShift action_13
action_20 (30) = happyShift action_14
action_20 (31) = happyShift action_15
action_20 (32) = happyShift action_16
action_20 (33) = happyShift action_17
action_20 (34) = happyShift action_18
action_20 (35) = happyShift action_19
action_20 (37) = happyShift action_20
action_20 (38) = happyShift action_21
action_20 (40) = happyShift action_22
action_20 (45) = happyShift action_23
action_20 (52) = happyShift action_24
action_20 (55) = happyShift action_25
action_20 (63) = happyShift action_26
action_20 (4) = happyGoto action_34
action_20 (5) = happyGoto action_2
action_20 (6) = happyGoto action_3
action_20 (7) = happyGoto action_4
action_20 (8) = happyGoto action_5
action_20 (9) = happyGoto action_6
action_20 (11) = happyGoto action_7
action_20 (13) = happyGoto action_8
action_20 (14) = happyGoto action_9
action_20 (15) = happyGoto action_10
action_20 _ = happyFail

action_21 (24) = happyShift action_11
action_21 (26) = happyShift action_12
action_21 (29) = happyShift action_13
action_21 (30) = happyShift action_14
action_21 (31) = happyShift action_15
action_21 (32) = happyShift action_16
action_21 (33) = happyShift action_17
action_21 (34) = happyShift action_18
action_21 (35) = happyShift action_19
action_21 (37) = happyShift action_20
action_21 (38) = happyShift action_21
action_21 (40) = happyShift action_22
action_21 (45) = happyShift action_23
action_21 (52) = happyShift action_24
action_21 (55) = happyShift action_25
action_21 (63) = happyShift action_26
action_21 (4) = happyGoto action_33
action_21 (5) = happyGoto action_2
action_21 (6) = happyGoto action_3
action_21 (7) = happyGoto action_4
action_21 (8) = happyGoto action_5
action_21 (9) = happyGoto action_6
action_21 (11) = happyGoto action_7
action_21 (13) = happyGoto action_8
action_21 (14) = happyGoto action_9
action_21 (15) = happyGoto action_10
action_21 _ = happyFail

action_22 _ = happyReduce_12

action_23 (24) = happyShift action_11
action_23 (26) = happyShift action_12
action_23 (29) = happyShift action_13
action_23 (30) = happyShift action_14
action_23 (31) = happyShift action_15
action_23 (32) = happyShift action_16
action_23 (33) = happyShift action_17
action_23 (34) = happyShift action_18
action_23 (35) = happyShift action_19
action_23 (37) = happyShift action_20
action_23 (38) = happyShift action_21
action_23 (40) = happyShift action_22
action_23 (45) = happyShift action_23
action_23 (52) = happyShift action_24
action_23 (55) = happyShift action_25
action_23 (63) = happyShift action_26
action_23 (4) = happyGoto action_32
action_23 (5) = happyGoto action_2
action_23 (6) = happyGoto action_3
action_23 (7) = happyGoto action_4
action_23 (8) = happyGoto action_5
action_23 (9) = happyGoto action_6
action_23 (11) = happyGoto action_7
action_23 (13) = happyGoto action_8
action_23 (14) = happyGoto action_9
action_23 (15) = happyGoto action_10
action_23 _ = happyFail

action_24 (63) = happyShift action_31
action_24 _ = happyFail

action_25 (24) = happyShift action_11
action_25 (26) = happyShift action_12
action_25 (29) = happyShift action_13
action_25 (30) = happyShift action_14
action_25 (31) = happyShift action_15
action_25 (32) = happyShift action_16
action_25 (33) = happyShift action_17
action_25 (34) = happyShift action_18
action_25 (35) = happyShift action_19
action_25 (37) = happyShift action_20
action_25 (38) = happyShift action_21
action_25 (40) = happyShift action_22
action_25 (45) = happyShift action_23
action_25 (52) = happyShift action_24
action_25 (55) = happyShift action_25
action_25 (56) = happyShift action_30
action_25 (63) = happyShift action_26
action_25 (4) = happyGoto action_28
action_25 (5) = happyGoto action_2
action_25 (6) = happyGoto action_3
action_25 (7) = happyGoto action_4
action_25 (8) = happyGoto action_5
action_25 (9) = happyGoto action_6
action_25 (11) = happyGoto action_7
action_25 (12) = happyGoto action_29
action_25 (13) = happyGoto action_8
action_25 (14) = happyGoto action_9
action_25 (15) = happyGoto action_10
action_25 _ = happyFail

action_26 _ = happyReduce_9

action_27 (65) = happyAccept
action_27 _ = happyFail

action_28 (58) = happyShift action_55
action_28 _ = happyReduce_30

action_29 (56) = happyShift action_54
action_29 _ = happyFail

action_30 _ = happyReduce_28

action_31 (59) = happyShift action_53
action_31 _ = happyFail

action_32 (46) = happyShift action_52
action_32 _ = happyFail

action_33 (39) = happyShift action_51
action_33 _ = happyFail

action_34 (47) = happyShift action_50
action_34 _ = happyFail

action_35 (54) = happyShift action_44
action_35 _ = happyReduce_17

action_36 (54) = happyShift action_44
action_36 _ = happyReduce_16

action_37 (54) = happyShift action_44
action_37 _ = happyReduce_15

action_38 (54) = happyShift action_44
action_38 _ = happyReduce_14

action_39 (27) = happyShift action_49
action_39 _ = happyFail

action_40 (25) = happyShift action_48
action_40 _ = happyFail

action_41 (64) = happyShift action_47
action_41 _ = happyFail

action_42 (51) = happyShift action_46
action_42 _ = happyFail

action_43 _ = happyReduce_4

action_44 (40) = happyShift action_45
action_44 _ = happyFail

action_45 _ = happyReduce_19

action_46 (24) = happyShift action_11
action_46 (26) = happyShift action_12
action_46 (29) = happyShift action_13
action_46 (30) = happyShift action_14
action_46 (31) = happyShift action_15
action_46 (32) = happyShift action_16
action_46 (33) = happyShift action_17
action_46 (34) = happyShift action_18
action_46 (35) = happyShift action_19
action_46 (37) = happyShift action_20
action_46 (38) = happyShift action_21
action_46 (40) = happyShift action_22
action_46 (45) = happyShift action_23
action_46 (52) = happyShift action_24
action_46 (55) = happyShift action_25
action_46 (63) = happyShift action_26
action_46 (4) = happyGoto action_74
action_46 (5) = happyGoto action_2
action_46 (6) = happyGoto action_3
action_46 (7) = happyGoto action_4
action_46 (8) = happyGoto action_5
action_46 (9) = happyGoto action_6
action_46 (11) = happyGoto action_7
action_46 (13) = happyGoto action_8
action_46 (14) = happyGoto action_9
action_46 (15) = happyGoto action_10
action_46 _ = happyFail

action_47 (51) = happyShift action_73
action_47 _ = happyFail

action_48 (24) = happyShift action_11
action_48 (26) = happyShift action_12
action_48 (29) = happyShift action_13
action_48 (30) = happyShift action_14
action_48 (31) = happyShift action_15
action_48 (32) = happyShift action_16
action_48 (33) = happyShift action_17
action_48 (34) = happyShift action_18
action_48 (35) = happyShift action_19
action_48 (37) = happyShift action_20
action_48 (38) = happyShift action_21
action_48 (40) = happyShift action_22
action_48 (45) = happyShift action_23
action_48 (52) = happyShift action_24
action_48 (55) = happyShift action_25
action_48 (63) = happyShift action_26
action_48 (4) = happyGoto action_72
action_48 (5) = happyGoto action_2
action_48 (6) = happyGoto action_3
action_48 (7) = happyGoto action_4
action_48 (8) = happyGoto action_5
action_48 (9) = happyGoto action_6
action_48 (11) = happyGoto action_7
action_48 (13) = happyGoto action_8
action_48 (14) = happyGoto action_9
action_48 (15) = happyGoto action_10
action_48 _ = happyFail

action_49 (24) = happyShift action_11
action_49 (26) = happyShift action_12
action_49 (29) = happyShift action_13
action_49 (30) = happyShift action_14
action_49 (31) = happyShift action_15
action_49 (32) = happyShift action_16
action_49 (33) = happyShift action_17
action_49 (34) = happyShift action_18
action_49 (35) = happyShift action_19
action_49 (37) = happyShift action_20
action_49 (38) = happyShift action_21
action_49 (40) = happyShift action_22
action_49 (45) = happyShift action_23
action_49 (52) = happyShift action_24
action_49 (55) = happyShift action_25
action_49 (63) = happyShift action_26
action_49 (4) = happyGoto action_71
action_49 (5) = happyGoto action_2
action_49 (6) = happyGoto action_3
action_49 (7) = happyGoto action_4
action_49 (8) = happyGoto action_5
action_49 (9) = happyGoto action_6
action_49 (11) = happyGoto action_7
action_49 (13) = happyGoto action_8
action_49 (14) = happyGoto action_9
action_49 (15) = happyGoto action_10
action_49 _ = happyFail

action_50 (63) = happyShift action_70
action_50 (16) = happyGoto action_69
action_50 _ = happyFail

action_51 (41) = happyShift action_64
action_51 (43) = happyShift action_65
action_51 (45) = happyShift action_66
action_51 (64) = happyShift action_67
action_51 (17) = happyGoto action_68
action_51 (18) = happyGoto action_58
action_51 (19) = happyGoto action_59
action_51 (20) = happyGoto action_60
action_51 (21) = happyGoto action_61
action_51 (22) = happyGoto action_62
action_51 (23) = happyGoto action_63
action_51 _ = happyFail

action_52 _ = happyReduce_8

action_53 (41) = happyShift action_64
action_53 (43) = happyShift action_65
action_53 (45) = happyShift action_66
action_53 (64) = happyShift action_67
action_53 (17) = happyGoto action_57
action_53 (18) = happyGoto action_58
action_53 (19) = happyGoto action_59
action_53 (20) = happyGoto action_60
action_53 (21) = happyGoto action_61
action_53 (22) = happyGoto action_62
action_53 (23) = happyGoto action_63
action_53 _ = happyFail

action_54 _ = happyReduce_29

action_55 (24) = happyShift action_11
action_55 (26) = happyShift action_12
action_55 (29) = happyShift action_13
action_55 (30) = happyShift action_14
action_55 (31) = happyShift action_15
action_55 (32) = happyShift action_16
action_55 (33) = happyShift action_17
action_55 (34) = happyShift action_18
action_55 (35) = happyShift action_19
action_55 (37) = happyShift action_20
action_55 (38) = happyShift action_21
action_55 (40) = happyShift action_22
action_55 (45) = happyShift action_23
action_55 (52) = happyShift action_24
action_55 (55) = happyShift action_25
action_55 (63) = happyShift action_26
action_55 (4) = happyGoto action_28
action_55 (5) = happyGoto action_2
action_55 (6) = happyGoto action_3
action_55 (7) = happyGoto action_4
action_55 (8) = happyGoto action_5
action_55 (9) = happyGoto action_6
action_55 (11) = happyGoto action_7
action_55 (12) = happyGoto action_56
action_55 (13) = happyGoto action_8
action_55 (14) = happyGoto action_9
action_55 (15) = happyGoto action_10
action_55 _ = happyFail

action_56 _ = happyReduce_31

action_57 (57) = happyShift action_89
action_57 _ = happyFail

action_58 _ = happyReduce_37

action_59 _ = happyReduce_38

action_60 (49) = happyShift action_88
action_60 _ = happyReduce_41

action_61 (62) = happyShift action_87
action_61 _ = happyReduce_43

action_62 _ = happyReduce_45

action_63 (50) = happyShift action_86
action_63 _ = happyReduce_48

action_64 (41) = happyShift action_64
action_64 (42) = happyShift action_85
action_64 (43) = happyShift action_65
action_64 (45) = happyShift action_66
action_64 (64) = happyShift action_67
action_64 (17) = happyGoto action_84
action_64 (18) = happyGoto action_58
action_64 (19) = happyGoto action_59
action_64 (20) = happyGoto action_60
action_64 (21) = happyGoto action_61
action_64 (22) = happyGoto action_62
action_64 (23) = happyGoto action_63
action_64 _ = happyFail

action_65 (41) = happyShift action_64
action_65 (43) = happyShift action_65
action_65 (44) = happyShift action_83
action_65 (45) = happyShift action_66
action_65 (64) = happyShift action_67
action_65 (17) = happyGoto action_82
action_65 (18) = happyGoto action_58
action_65 (19) = happyGoto action_59
action_65 (20) = happyGoto action_60
action_65 (21) = happyGoto action_61
action_65 (22) = happyGoto action_62
action_65 (23) = happyGoto action_63
action_65 _ = happyFail

action_66 (41) = happyShift action_64
action_66 (43) = happyShift action_65
action_66 (45) = happyShift action_66
action_66 (64) = happyShift action_67
action_66 (17) = happyGoto action_81
action_66 (18) = happyGoto action_58
action_66 (19) = happyGoto action_59
action_66 (20) = happyGoto action_60
action_66 (21) = happyGoto action_61
action_66 (22) = happyGoto action_62
action_66 (23) = happyGoto action_63
action_66 _ = happyFail

action_67 _ = happyReduce_51

action_68 (53) = happyShift action_80
action_68 _ = happyFail

action_69 (48) = happyShift action_79
action_69 _ = happyFail

action_70 (60) = happyShift action_78
action_70 _ = happyFail

action_71 (28) = happyShift action_77
action_71 _ = happyFail

action_72 _ = happyReduce_23

action_73 (41) = happyShift action_64
action_73 (43) = happyShift action_65
action_73 (45) = happyShift action_66
action_73 (64) = happyShift action_67
action_73 (17) = happyGoto action_76
action_73 (18) = happyGoto action_58
action_73 (19) = happyGoto action_59
action_73 (20) = happyGoto action_60
action_73 (21) = happyGoto action_61
action_73 (22) = happyGoto action_62
action_73 (23) = happyGoto action_63
action_73 _ = happyFail

action_74 (61) = happyShift action_75
action_74 _ = happyReduce_24

action_75 (36) = happyShift action_41
action_75 (63) = happyShift action_42
action_75 (10) = happyGoto action_101
action_75 _ = happyFail

action_76 (61) = happyShift action_100
action_76 _ = happyReduce_25

action_77 (24) = happyShift action_11
action_77 (26) = happyShift action_12
action_77 (29) = happyShift action_13
action_77 (30) = happyShift action_14
action_77 (31) = happyShift action_15
action_77 (32) = happyShift action_16
action_77 (33) = happyShift action_17
action_77 (34) = happyShift action_18
action_77 (35) = happyShift action_19
action_77 (37) = happyShift action_20
action_77 (38) = happyShift action_21
action_77 (40) = happyShift action_22
action_77 (45) = happyShift action_23
action_77 (52) = happyShift action_24
action_77 (55) = happyShift action_25
action_77 (63) = happyShift action_26
action_77 (4) = happyGoto action_99
action_77 (5) = happyGoto action_2
action_77 (6) = happyGoto action_3
action_77 (7) = happyGoto action_4
action_77 (8) = happyGoto action_5
action_77 (9) = happyGoto action_6
action_77 (11) = happyGoto action_7
action_77 (13) = happyGoto action_8
action_77 (14) = happyGoto action_9
action_77 (15) = happyGoto action_10
action_77 _ = happyFail

action_78 (24) = happyShift action_11
action_78 (26) = happyShift action_12
action_78 (29) = happyShift action_13
action_78 (30) = happyShift action_14
action_78 (31) = happyShift action_15
action_78 (32) = happyShift action_16
action_78 (33) = happyShift action_17
action_78 (34) = happyShift action_18
action_78 (35) = happyShift action_19
action_78 (37) = happyShift action_20
action_78 (38) = happyShift action_21
action_78 (40) = happyShift action_22
action_78 (45) = happyShift action_23
action_78 (52) = happyShift action_24
action_78 (55) = happyShift action_25
action_78 (63) = happyShift action_26
action_78 (4) = happyGoto action_98
action_78 (5) = happyGoto action_2
action_78 (6) = happyGoto action_3
action_78 (7) = happyGoto action_4
action_78 (8) = happyGoto action_5
action_78 (9) = happyGoto action_6
action_78 (11) = happyGoto action_7
action_78 (13) = happyGoto action_8
action_78 (14) = happyGoto action_9
action_78 (15) = happyGoto action_10
action_78 _ = happyFail

action_79 _ = happyReduce_34

action_80 (40) = happyShift action_97
action_80 _ = happyFail

action_81 (46) = happyShift action_96
action_81 _ = happyFail

action_82 (44) = happyShift action_95
action_82 _ = happyFail

action_83 _ = happyReduce_39

action_84 (42) = happyShift action_94
action_84 _ = happyFail

action_85 _ = happyReduce_46

action_86 (45) = happyShift action_66
action_86 (64) = happyShift action_67
action_86 (22) = happyGoto action_93
action_86 (23) = happyGoto action_63
action_86 _ = happyFail

action_87 (41) = happyShift action_64
action_87 (45) = happyShift action_66
action_87 (64) = happyShift action_67
action_87 (20) = happyGoto action_92
action_87 (21) = happyGoto action_61
action_87 (22) = happyGoto action_62
action_87 (23) = happyGoto action_63
action_87 _ = happyFail

action_88 (41) = happyShift action_64
action_88 (45) = happyShift action_66
action_88 (64) = happyShift action_67
action_88 (19) = happyGoto action_91
action_88 (20) = happyGoto action_60
action_88 (21) = happyGoto action_61
action_88 (22) = happyGoto action_62
action_88 (23) = happyGoto action_63
action_88 _ = happyFail

action_89 (24) = happyShift action_11
action_89 (26) = happyShift action_12
action_89 (29) = happyShift action_13
action_89 (30) = happyShift action_14
action_89 (31) = happyShift action_15
action_89 (32) = happyShift action_16
action_89 (33) = happyShift action_17
action_89 (34) = happyShift action_18
action_89 (35) = happyShift action_19
action_89 (37) = happyShift action_20
action_89 (38) = happyShift action_21
action_89 (40) = happyShift action_22
action_89 (45) = happyShift action_23
action_89 (52) = happyShift action_24
action_89 (55) = happyShift action_25
action_89 (63) = happyShift action_26
action_89 (4) = happyGoto action_90
action_89 (5) = happyGoto action_2
action_89 (6) = happyGoto action_3
action_89 (7) = happyGoto action_4
action_89 (8) = happyGoto action_5
action_89 (9) = happyGoto action_6
action_89 (11) = happyGoto action_7
action_89 (13) = happyGoto action_8
action_89 (14) = happyGoto action_9
action_89 (15) = happyGoto action_10
action_89 _ = happyFail

action_90 _ = happyReduce_22

action_91 _ = happyReduce_42

action_92 _ = happyReduce_44

action_93 _ = happyReduce_49

action_94 _ = happyReduce_47

action_95 _ = happyReduce_40

action_96 _ = happyReduce_50

action_97 _ = happyReduce_33

action_98 (61) = happyShift action_103
action_98 _ = happyReduce_35

action_99 _ = happyReduce_32

action_100 (36) = happyShift action_41
action_100 (63) = happyShift action_42
action_100 (10) = happyGoto action_102
action_100 _ = happyFail

action_101 _ = happyReduce_26

action_102 _ = happyReduce_27

action_103 (63) = happyShift action_70
action_103 (16) = happyGoto action_104
action_103 _ = happyFail

action_104 _ = happyReduce_36

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn4
		 (foldl App (head happy_var_1) (tail happy_var_1)
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  6 happyReduction_3
happyReduction_3 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_2  6 happyReduction_4
happyReduction_4 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1 : happy_var_2
	)
happyReduction_4 _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  6 happyReduction_5
happyReduction_5 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  6 happyReduction_6
happyReduction_6 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  6 happyReduction_7
happyReduction_7 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  7 happyReduction_8
happyReduction_8 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (happy_var_2
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  7 happyReduction_9
happyReduction_9 (HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn4
		 (Var happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  7 happyReduction_10
happyReduction_10 _
	 =  HappyAbsSyn4
		 (TrueT
	)

happyReduce_11 = happySpecReduce_1  7 happyReduction_11
happyReduction_11 _
	 =  HappyAbsSyn4
		 (FalseT
	)

happyReduce_12 = happySpecReduce_1  7 happyReduction_12
happyReduction_12 (HappyTerminal (TokenInteger happy_var_1))
	 =  HappyAbsSyn4
		 (makeInt happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  7 happyReduction_13
happyReduction_13 _
	 =  HappyAbsSyn4
		 (Zero
	)

happyReduce_14 = happySpecReduce_2  7 happyReduction_14
happyReduction_14 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Succ happy_var_2
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_2  7 happyReduction_15
happyReduction_15 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Pred happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2  7 happyReduction_16
happyReduction_16 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Iszero happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_2  7 happyReduction_17
happyReduction_17 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Fix happy_var_2
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  7 happyReduction_18
happyReduction_18 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn4
		 (Tuple happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  7 happyReduction_19
happyReduction_19 (HappyTerminal (TokenInteger happy_var_3))
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (UnpackTuple happy_var_3 happy_var_1
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  7 happyReduction_20
happyReduction_20 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  7 happyReduction_21
happyReduction_21 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happyReduce 6 8 happyReduction_22
happyReduction_22 ((HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Lam happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_23 = happyReduce 4 9 happyReduction_23
happyReduction_23 ((HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (makeLet happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_24 = happySpecReduce_3  10 happyReduction_24
happyReduction_24 (HappyAbsSyn4  happy_var_3)
	_
	(HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn10
		 ([Left (happy_var_1, happy_var_3)]
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happyReduce 4 10 happyReduction_25
happyReduction_25 ((HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenTypeVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 ([Right (happy_var_2, happy_var_4)]
	) `HappyStk` happyRest

happyReduce_26 = happyReduce 5 10 happyReduction_26
happyReduction_26 ((HappyAbsSyn10  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVar happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Left (happy_var_1, happy_var_3) : happy_var_5
	) `HappyStk` happyRest

happyReduce_27 = happyReduce 6 10 happyReduction_27
happyReduction_27 ((HappyAbsSyn10  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenTypeVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Right (happy_var_2, happy_var_4) : happy_var_6
	) `HappyStk` happyRest

happyReduce_28 = happySpecReduce_2  11 happyReduction_28
happyReduction_28 _
	_
	 =  HappyAbsSyn11
		 ([]
	)

happyReduce_29 = happySpecReduce_3  11 happyReduction_29
happyReduction_29 _
	(HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (happy_var_2
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  12 happyReduction_30
happyReduction_30 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn11
		 ([happy_var_1]
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  12 happyReduction_31
happyReduction_31 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1 : happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happyReduce 6 13 happyReduction_32
happyReduction_32 ((HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (If happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_33 = happyReduce 6 14 happyReduction_33
happyReduction_33 ((HappyTerminal (TokenInteger happy_var_6)) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Inject happy_var_6 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_34 = happyReduce 5 15 happyReduction_34
happyReduction_34 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Case happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_35 = happySpecReduce_3  16 happyReduction_35
happyReduction_35 (HappyAbsSyn4  happy_var_3)
	_
	(HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn16
		 ([(happy_var_1, happy_var_3)]
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happyReduce 5 16 happyReduction_36
happyReduction_36 ((HappyAbsSyn16  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVar happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 ((happy_var_1, happy_var_3) : happy_var_5
	) `HappyStk` happyRest

happyReduce_37 = happySpecReduce_1  17 happyReduction_37
happyReduction_37 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  18 happyReduction_38
happyReduction_38 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn17
		 (if length happy_var_1 == 1 then head happy_var_1 else TypeSum happy_var_1
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_2  18 happyReduction_39
happyReduction_39 _
	_
	 =  HappyAbsSyn17
		 (TypeSum []
	)

happyReduce_40 = happySpecReduce_3  18 happyReduction_40
happyReduction_40 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn17
		 (TypeSum [happy_var_2]
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  19 happyReduction_41
happyReduction_41 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn19
		 ([happy_var_1]
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  19 happyReduction_42
happyReduction_42 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 : happy_var_3
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  20 happyReduction_43
happyReduction_43 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  20 happyReduction_44
happyReduction_44 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 :-> happy_var_3
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  21 happyReduction_45
happyReduction_45 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn17
		 (if length happy_var_1 == 1 then head happy_var_1 else TypeProd happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_2  21 happyReduction_46
happyReduction_46 _
	_
	 =  HappyAbsSyn17
		 (TypeProd []
	)

happyReduce_47 = happySpecReduce_3  21 happyReduction_47
happyReduction_47 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn17
		 (TypeProd [happy_var_2]
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  22 happyReduction_48
happyReduction_48 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn19
		 ([happy_var_1]
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  22 happyReduction_49
happyReduction_49 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 : happy_var_3
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_3  23 happyReduction_50
happyReduction_50 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn17
		 (happy_var_2
	)
happyReduction_50 _ _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  23 happyReduction_51
happyReduction_51 (HappyTerminal (TokenTypeVar happy_var_1))
	 =  HappyAbsSyn17
		 (makeType happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 65 65 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenLet -> cont 24;
	TokenIn -> cont 25;
	TokenIf -> cont 26;
	TokenThen -> cont 27;
	TokenElse -> cont 28;
	TokenTrue -> cont 29;
	TokenFalse -> cont 30;
	TokenZero -> cont 31;
	TokenSucc -> cont 32;
	TokenPred -> cont 33;
	TokenIszero -> cont 34;
	TokenFix -> cont 35;
	TokenType -> cont 36;
	TokenCase -> cont 37;
	TokenInj -> cont 38;
	TokenAs -> cont 39;
	TokenInteger happy_dollar_dollar -> cont 40;
	TokenOABracket -> cont 41;
	TokenCABracket -> cont 42;
	TokenOPBracket -> cont 43;
	TokenCPBracket -> cont 44;
	TokenOBracket -> cont 45;
	TokenCBracket -> cont 46;
	TokenOCBracket -> cont 47;
	TokenCCBracket -> cont 48;
	TokenPlus -> cont 49;
	TokenAsterisk -> cont 50;
	TokenAssignment -> cont 51;
	TokenLambda -> cont 52;
	TokenAt -> cont 53;
	TokenSharp -> cont 54;
	TokenLT -> cont 55;
	TokenGT -> cont 56;
	TokenDot -> cont 57;
	TokenComma -> cont 58;
	TokenDoubleColon -> cont 59;
	TokenColon -> cont 60;
	TokenSemiColon -> cont 61;
	TokenArrow -> cont 62;
	TokenVar happy_dollar_dollar -> cont 63;
	TokenTypeVar happy_dollar_dollar -> cont 64;
	_ -> happyError' (tk:tks)
	}

happyError_ 65 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

happyThen :: () => Ex a -> (a -> Ex b) -> Ex b
happyThen = (thenEx)
happyReturn :: () => a -> Ex a
happyReturn = (returnEx)
happyThen1 m k tks = (thenEx) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Ex a
happyReturn1 = \a tks -> (returnEx) a
happyError' :: () => [(Token)] -> Ex a
happyError' = parseError

parser tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


data Ex a = Ok a
          | Fail String
          deriving (Show, Eq)

thenEx :: Ex a -> (a -> Ex b) -> Ex b
m `thenEx` k = case m of
                   Ok a -> k a
                   Fail s -> Fail s

returnEx :: a -> Ex a
returnEx a = Ok a

failEx :: String -> Ex a
failEx s = Fail s

catchEx :: Ex a -> (String -> Ex a) -> Ex a
catchEx m k = case m of
                  Ok a -> Ok a
                  Fail s -> k s

-- checks if type name is a base type, returns the appropriate type
makeType :: TypeName -> Type
makeType "Int" = Base MyInt
makeType "Bool" = Base MyBool
makeType v = TypeVar v

makeLet :: [Either (VarName, Term) (TypeName, Type)] -> Term -> Term
makeLet [Left (x, y)] z = Let x y z
makeLet [Right (x, y)] z = LetType x y z
makeLet (Left (x, y) : ls) z = Let x y $ makeLet ls z
makeLet (Right (x, y): ls) z = LetType x y $ makeLet ls z

makeInt :: Int -> Term
makeInt 0 = Zero
makeInt n = Succ (makeInt (n - 1))

parseError :: [Token] -> Ex a
parseError tokens = failEx $ "Parse error" ++ show tokens


main' = do
    s <- getContents
    let tokens = alexScanTokens s
    print $ tokens
    let parseTree = parser tokens
    print $ parseTree

main = main'
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<command-line>" #-}







# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4










































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates/GenericTemplate.hs" #-}

{-# LINE 46 "templates/GenericTemplate.hs" #-}








{-# LINE 67 "templates/GenericTemplate.hs" #-}

{-# LINE 77 "templates/GenericTemplate.hs" #-}

{-# LINE 86 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 155 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 256 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 322 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
