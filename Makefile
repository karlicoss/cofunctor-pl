all : parser

parser : Parser.y lexer
	happy --info Parser.y

lexer : Lexer.x
	alex Lexer.x

clean:
	rm -f Lexer.hs Parser.hs Parser.info