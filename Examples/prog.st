let 

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


in zero