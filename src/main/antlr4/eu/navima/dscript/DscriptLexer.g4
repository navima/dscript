lexer grammar DscriptLexer;

OPEN_EXPR: '{' -> pushMode(ds);
OPEN_STATEMENT: '#' -> pushMode(ds);
TEXT: (~('{' | '#') | '\\#' | '\\{')+;

mode ds;
AS: 'as';
BOOLEAN: 'true'|'false';
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
INTEGER: '0' | [1-9][0-9]*;
FLOAT: [0-9]* '.' [0-9]+;
STRING: '"' (~["\n\r] | '\\' .)* '"';
MINUS: '-';
EXCL: '!';
COMMA: ',';
BINARY_OPERATOR:
	'+'
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
	| '||';
TERNARY_OPERATOR: '?';
WS: [ \t\r\n]+ -> skip;
OPEN_BRACKET: '(';
CLOSE_BRACKET: ')';
OPEN_SQUARE_BRACKET: '[';
CLOSE_SQUARE_BRACKET: ']';
OPEN_CURLY_BRACKET: '{';
CLOSE_CURLY_BRACKET: '}' -> popMode;
COLON: ':';
OPEN_STATEMENT2: '#';
// TODO ability to have additional text after statement