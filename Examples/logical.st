let

not = \x::Bool.if x then false else true;
and = \x::Bool.\y::Bool.if x then if y then true else false else false;
or = \x::Bool.\y::Bool.if x then true else if y then true else false;
implies = \x::Bool.\y::Bool.if x then y else true;
equiv = \x::Bool.\y::Bool.if x then y else (not y)

in and (or true false) (equiv (implies true false) false)