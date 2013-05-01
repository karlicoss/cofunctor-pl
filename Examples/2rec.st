let f = fix (
	\f :: Int -> Int.
	\x :: Int.
	let f2 = \x :: Int. if (iszero x) then 0 else succ (f (pred x))
	in if (iszero x) then 0 else succ succ (f2 (pred x))
) in f 3