parser grammar DscriptParser;
options {
	tokenVocab = DscriptLexer;
}

body: text* statement*;
text: TEXT (substitution TEXT?)*;
substitution: OPEN_EXPR expression CLOSE_CURLY_BRACKET;
statement: (OPEN_STATEMENT | OPEN_STATEMENT2) statement_identifier expression*;
expression:
	literal
	| variable
	| OPEN_BRACKET expression CLOSE_BRACKET
	| expression BINARY_OPERATOR expression
	| UNARY_OPERATOR expression
	| expression TERNARY_OPERATOR expression COLON expression;
statement_identifier: IDENTIFIER;
variable: IDENTIFIER;
literal: INTEGER | FLOAT | STRING | BOOLEAN;
