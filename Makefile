all : interpreter

interpreter: lexer parser Datatypes.hs TypeCheck.hs SimpleTypes.hs Main.hs
	ghc --make Main.hs -o SimpleTypes

test: parser lexer Datatypes.hs TypeCheck.hs EvalTest.hs ParserTest.hs Test.hs TypeCheckTest.hs
	ghc --make Test.hs

parser : Parser.y lexer Datatypes.hs
	happy --info Parser.y

lexer : Lexer.x
	alex Lexer.x

clean:
	rm -f Lexer.hs Parser.hs Parser.info
	rm -f *.o
	rm -f *.hi
