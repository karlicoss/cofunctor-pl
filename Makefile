all : interpreter

interpreter: Parser.hs Lexer.hs Datatypes.hs TypeCheck.hs SimpleTypes.hs Main.hs
	ghc --make Main.hs -o SimpleTypes

test: Parser.hs Lexer.hs Datatypes.hs TypeCheck.hs EvalTest.hs ParserTest.hs Test.hs TypeCheckTest.hs
	ghc --make Test.hs

Parser.hs : Parser.y Lexer.hs Datatypes.hs
	happy --info Parser.y

Lexer.hs : Lexer.x
	alex Lexer.x

clean:
	rm -f Lexer.hs Parser.hs Parser.info
	rm -f *.o
	rm -f *.hi
