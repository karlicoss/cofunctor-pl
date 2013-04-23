let
add = fix
    (
    \add::Int -> Int -> Int.
    \x::Int.\y::Int.
        if (iszero x) then y
        else succ (add (pred x) y)
    )

in add 5 6
