grammar dscript;
body: text* directive*;
directive: '#' identifier (' ' expression)*;
expression:
	literal
	| identifier
	| '(' expression ')'
	| expression BINARY_OPERATOR expression
	| UNARY_OPERATOR expression
	| expression TERNARY_OPERATOR expression ':' expression
	| substitution;
literal: INTEGER | FLOAT | STRING;
substitution: '{' expression '}';
text: TEXT (substitution TEXT?)*;
identifier: IDENTIFIER;

IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
TEXT: ~[{}#]*;
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