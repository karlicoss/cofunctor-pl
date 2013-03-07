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

add = fix
    (
    \add::Int -> Int -> Int.
    \x::Int.\y::Int.
        if (iszero x) then y
        else succ (add (pred x) y)
    )

in add n2 n1