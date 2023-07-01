lexer grammar DscriptLexer;
BODY: SUBSTITUTION | TEXT (SUBSTITUTION TEXT?)*;
SUBSTITUTION: '{' -> pushMode(dsExpression);
TEXT: ~[{}#]+;

mode dsExpression;
NUMBER: [0-9]+;
OPERATOR: BINARY_OPERATOR | UNARY_OPERATOR | TERNARY_OPERATOR;
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
INTEGER: '0' | [1-9][0-9]*;
FLOAT: [0-9]* '.' [0-9]+;
STRING: '"' (~["\n\r] | '\\' .)* '"';
BINARY_OPERATOR:
	'+'
	| '-'
	| '*'
	| '/'
	| '%'
	| '=='
	| '!='
	| '<'
	| '>'
	| '<='
	| '>='
	| '&&'
	| '||'
	| '!';
UNARY_OPERATOR: '-' | '!';
TERNARY_OPERATOR: '?';
WS: [ \t\r\n]+ -> skip;
OPEN_BRACKET: '(';
CLOSE_BRACKET: ')';
OPEN_SQUARE_BRACKET: '[';
CLOSE_SQUARE_BRACKET: ']';
OPEN_CURLY_BRACKET: '{';
CLOSE_CURLY_BRACKET: '}' -> popMode;
COLON: ':';