## Running the interpreter
The main interpreter function is in the `SimpleTypes.hs` file. You can run your program "program.st" invoking the "runhaskell SimpleTypes.hs < program.st" command. Apparently, the parser is dumb at the moment and does not display parse errors in a convenient way. If you get parse error, most likely you have not placed ";" in the end of a let binding in a let list or have placed a redundand ";" before the "in" keyword.

If you get typecheck error, most likely it is "unknown identifier error", that is you have used variable which is not in the scope.

## Let expressions

The program is basically a big let expression. Something in Haskell like:

    :::haskell
    a = succ zero
    b = zero
    c = mul a b
    print c

should be explicitly written as

    :::haskell
    let a = succ zero in
    let b = zero in
    let c = mul a b in
    print c

Note: this program will not actually typecheck since `print` and `mul` are unknown identifiers.

You can use a list of let bindings in a single let expression:

    :::haskell
    let a = succ zero;
        b = zero;
        c = mul one zero
    in print c

Notice that unlike Haskell, you have to place semicolon after each let binding which does not precede the 'in' keyword. (Haskell has a *very* complicated parser to let you avoid semicolons and curly braces everywhere). `let`-expressions scope as much to the right as they can, so `let a = b in let c = d in e` is `let a = b in (let c = d in e)`.

## Datatypes
Base datatypes are `Int` and `Bool`. For `Int`s we have keywords `zero` (`Int`), `succ` (`Int -> Int`), `pred` (`Int -> Int`), `iszero` (`Int -> Bool`). `pred zero` yields `zero`. Actually, I should have named this datatype `Nat`.

For `Bool`s we have keywords `true` (`Bool`), `false` (`Bool`) and `if`-expression (has type `Bool -> T -> T -> T` for each `T` in some sense). Actually, these are enough for a big class of programs. `if`-expression scopes as much to the right as it can. So, `if a then b else if c then d else e` is actually  `if a then b else (if c then d else e)`.


## Function application
As you might have already guessed, `f a b` means "apply arguments `a` and `b` to the `f`". Of course, the parser uses the standard convention that application associates to the left, so `f a b` is `(f a) b`.

## Defining functions
The only functions you can define are lambda expressions. Actually, Haskell has `only` lambda-expressions for functions, the code

    :::haskell
    fun a b c = someexpression

desugars into

    :::haskell
    fun = \a -> \b -> \c -> someexpression

in our syntax it would be

    :::haskell
    let fun = \a::TypeA.\b::TypeB.\c::TypeC.someexpression

Lambda binds as much to right as it can, that is, `\x::Int.a b c \y::Int.y x if a then x else y` is `\x::Int.(a b c \y::Int.(y x if a then x else y))`. Also note you have to explicitly specify the type of the abstraction variable. Apparently, I haven't implemented type inference yet. 

## Example: logical connectives
Let's code something:

    :::haskell
    let

    not = \x::Bool.if x then false else true;
    and = \x::Bool.\y::Bool.if x then if y then true else false else false;
    or = \x::Bool.\y::Bool.if x then true else if y then true else false;
    implies = \x::Bool.\y::Bool.if x then y else true;
    equiv = \x::Bool.\y::Bool.if x then y else (not y)

    in and (or true false) (equiv (implies true false) false)

So, we defined some simple logical connectives and can evaluate complex boolean expressions. Apparently, there is not infix notation at the moment. You can find the code in the `Examples\logical.st` file. 

## Recursion
Okay, so far, all our programs have always terminated. Actually, to prove it formally we need to define the evaluation strategy, but I hope it is somewhat intiutive. The main reasons for our programs to terminate, are:

1. Our programming language has types. Untyped lambda calculus does not have such a termination property (formally, it's called *the normalization property*). It is impossible to give a type for `\x.x x`.
2. We forbid explicit self-reference. That is, we are unable to write something like `let f = f in g`. 

Apparently, programming language's ability to write a program which never halts (`while (true) {}` in C, for example) is esssential for Turing completeness. So, we have two ways of gaining it:

1. Get rid of types. However, programming without types reduces code readability and makes debugging extremely complex (ask python guys, AFAIK, a vast amount of their unit tests are type assertions).
2. Permit explicit self-reference. This might lead to some problems of course, for example `let f = f in f` will never evaluate, however, still better than untyped programming.

What's the language primitive to support self-reference? It is the fixed point operator. Fixed point operator is a function (in some sense, it has type `(a -> a) -> a`), which takes some function `f :: a -> a` and returns its least fixed point, which is such a value `v` that `f v = v`. It cannot be defined in terms of our current language, in Haskell it is in some sense built-in and you can define it as:

    :::haskell
    fix :: (a -> a) -> a
    fix f = f (fix f)

Again: we are able to define a fixed point combinator in Haskell only because it is already Turing complete.

You might wonder: is this function ever gonna terminate since `fix f = f (fix f) = f (f (fix f)) = ...`, and you are right, it won't. Or you might wonder what should `fix id` (where `id` has type `Nat -> Nat`) return, since all `Nat`'s are its fixpoints. But what are we gonna do is to find the least fixed point of `functions from functions to functions` (that is, the type variable `a` will actually be of type `b -> c`). Then you can interpret `f :: (b -> c) -> (b -> c)` as "`f` is a function which takes some approximation `fa :: (b -> c)` and returns a better approximation". In such sense, the least fixed point of a function is its maximum approximation, that is, the function which for any argument returns the correct value. And thanks to the lazy evaluation, we are not gonna evaluate all the sequence `f, f (fix f), f (f (fix f)), f (f (f (fix f))), ...`, when we define `g = fix f` and then evaluate `g a`, we will only evaluate the sequence of approximations until we find the approximation which covers `a`. The best way to understand all this is an example. Suppose we are using the Peano arithmetics in Haskell and want to write a function which adds two numbers. Well, pretty straightforward:

    :::haskell
    add :: Nat -> Nat -> Nat
    add = \x -> \y -> if (iszero x) then y else succ (add (pred x) y)

If we have defined `iszero`, `succ` and `pred`, this is a correct program (unsugared, you would have used datatype constructors and pattern matching in real Haskell programming). However, we use `add` in the body of the `add` itself, which is forbidden in our language. What should we do? Fix translation! Haskell code after fix translating would be:

    :::haskell
    add :: Nat -> Nat -> Nat
    add = fix (\adda -> \x -> \y -> if (iszero x) then y else succ (adda (pred x) y))

where `adda` is the "add approximation" function. Note that now the usage of `adda` is allowed in our programming language since it is just a variable bound by a lambda abstraction. What happens if we apply `add` to, say, 2 and 1 (meaning `succ succ zero` and `succ zero` correspondingly)? Let "..." be the shorthand for `(\adda -> \x -> \y -> if (iszero x) then y else succ ((adda) (pred x) y))`, then the sequence of beta-reductions is:

    add 2 1
    => (fix ...) 2 1
    => ... (fix ...) 2 1
    => if (iszero 2) then 1 else succ ((fix ...) (pred 2) 1)
    => if false then 1 else succ ((fix ...) (pred 2) 1)
    => succ ((fix ...) (pred 2) 1)
    => succ ((fix ...) 1 1)
    => succ (... (fix ...) 1 1)
    => succ (if (iszero 1) then 1 else succ ((fix ...) (pred 1) 1))
    => succ (if false then 1 else succ ((fix ...) (pred 1) 1))
    => succ (succ ((fix ...) (pred 1) 1))
    => succ (succ ((fix ...) 0 1))
    => succ (succ (... (fix ...) 0 1))
    => succ (succ (if (iszero 0) then 1 else succ ((fix ...) (pred 0) 1)))
    => succ (succ (if true then 1 else succ ((fix ...) (pred 0) 1)))
    => succ (succ 1), which is actually succ (succ (succ zero)) = 3, as expected!

So, basically, what is the algorithm of transforming some self-referential function `f :: A -> B`, `f = fbody` into fix-point notation? Just rewrite the `f` definition as `f = fix (\f :: (A -> B). fbody)`. Note that we haven't changed the function body, but we enclosed in into a lambda abstraction and now `f` in `fbody` refers to the bound variable `f`, so type checker will not complain. Try to run the `Examples/add.st` program and ensure the result is `succ succ succ zero`!

As I already noticed, we are able to write non-terminating programs now:

    ::haskell
    let f = fix (\f :: Int. f) in f

This piece of code is in the `Examples/whiletrue.st` file. If you run it, it does typecheck and has type `Int` but its evaluation will never stop. What's worth, we can't write a program (as a part of the compiler for example) which will determine if the program in the given source file will ever terminate. For a simple proof, google the "Halting undecidability problem". Welcome to the Turing complete world!

## Type synonims
TODO

## Product types
TODO

## Sum types
TODO