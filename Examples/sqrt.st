let 

n0 = zero;
n1 = succ n0;
n2 = succ n1;
n3 = succ n2;
n4 = succ n3;
n5 = succ n4;
n6 = succ n5;
n7 = succ n6;
n8 = succ n7;
n9 = succ n8;

and = \x::Bool.\y::Bool.if x then if y then true else false else false;
or = \x::Bool.\y::Bool.if x then true else if y then true else false;
not = \x::Bool.if x then false else true;


eq = fix
    (
    \eq::Int -> Int -> Bool.
    \x::Int.\y::Int.
        if and (iszero x) (iszero y) then true
        else if or (iszero x) (iszero y) then false
        else eq (pred x) (pred y)
    );

gt = fix
    (
    \gt::Int -> Int -> Bool.
    \x::Int.\y::Int.
        if (iszero x) then false
        else if (iszero y) then true
        else gt (pred x) (pred y)
    );

lt = \x::Int.\y::Int.not (or (eq x y) (gt x y));

add = fix
    (
    \add::Int -> Int -> Int.
    \x::Int.\y::Int.
        if (iszero x) then y
        else succ (add (pred x) y)
    );

mul = fix
    (
    \mul::Int -> Int -> Int.
    \x::Int.\y::Int.
        if (iszero x) then n0
        else add y (mul (pred x) y)
    );

type Unit = (* *);
unit = < >;

type MInt = Int + Unit;
justMInt = \x::Int.inj x as MInt@0;
nothingMInt = inj unit as MInt@1;

sqrtaux = fix
    (
    \sqrtaux::Int->Int->MInt.
    \s::Int.\x::Int.
    let sq = mul x x in 
        if eq sq s then justMInt x
        else if gt sq s then nothingMInt
        else sqrtaux s (succ x)
    );

sqrt = \s::Int.sqrtaux s zero

in sqrt n9