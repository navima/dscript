parser grammar DscriptParser;
options {
	tokenVocab = DscriptLexer;
}

body: text* statement*;
substitution: OPEN_EXPR expression CLOSE_CURLY_BRACKET;
statement: (OPEN_STATEMENT | OPEN_STATEMENT2) IDENTIFIER expression*;
expression:
	literal
	| IDENTIFIER
	| OPEN_BRACKET expression CLOSE_BRACKET
	| expression BINARY_OPERATOR expression
	| UNARY_OPERATOR expression
	| expression TERNARY_OPERATOR expression COLON expression;
literal: INTEGER | FLOAT | STRING;
text: TEXT (substitution TEXT?)*;
