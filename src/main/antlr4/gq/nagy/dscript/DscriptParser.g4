parser grammar DscriptParser;
options {
	tokenVocab = DscriptLexer;
}

body: text* statement*;
text: TEXT (substitution TEXT?)*;
substitution: OPEN_EXPR expression CLOSE_CURLY_BRACKET;
statement: (OPEN_STATEMENT | OPEN_STATEMENT2) statement_identifier (expression COMMA?)*;
expression: //TODO move `as string` etc to expression
	literal
	| variable
	| OPEN_BRACKET expression CLOSE_BRACKET
	| expression binary_operator expression
	| unary_operator expression
	| expression TERNARY_OPERATOR expression COLON expression;
binary_operator: BINARY_OPERATOR | MINUS;
unary_operator: MINUS | EXCL;
statement_identifier: IDENTIFIER;
variable: IDENTIFIER;
literal: INTEGER | FLOAT | STRING (AS IDENTIFIER)? | BOOLEAN;
