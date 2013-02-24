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

type FInt = Int -> Int;

fac = fix
    (
    \fac::FInt.
    \x::Int.
        if (iszero x) then n1
        else mul x (fac (pred x))
    );

type IntP = Int * Int;

alala = \x :: IntP.zero;

mulpar = fix
    (
    \mulpar::IntP -> Int.
    \a :: IntP.
        if iszero a#0 then n0
        else add a#1 (mulpar <pred a#0, a#1>)
    )

in fac n4