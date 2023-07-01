parser grammar DscriptParser;
options {
	tokenVocab = DscriptLexer;
}

body: text*;
substitution: OPEN expression CLOSE_CURLY_BRACKET;
expression:
	literal
	| IDENTIFIER
	| OPEN_BRACKET expression CLOSE_BRACKET
	| expression BINARY_OPERATOR expression
	| UNARY_OPERATOR expression
	| expression TERNARY_OPERATOR expression COLON expression
	| substitution;
literal: INTEGER | FLOAT | STRING;
text: TEXT (substitution TEXT?)*;