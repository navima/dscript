grammar DSDecl;

VOID: 'void';
BOOL: 'bool';
FLOAT: 'float';
INT: 'int';
STRING: 'string' | 'str';
ENUM: 'enum';
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;
SEMI: ';';
WS: [ \t\r\n]+ -> skip;
COMMENT: '#' ~[\r\n]*;
OPEN_BRACKET: '(';
CLOSE_BRACKET: ')';
COMMA: ',';
EQ: '=';
COLON: ':';

body: namespace*;
namespace: name COLON (var_decl|func_decl|enum_decl|comment)*;

var_decl: type name SEMI?;
func_decl: type name OPEN_BRACKET (parameter (COMMA parameter)*)? CLOSE_BRACKET SEMI? | name OPEN_BRACKET (parameter (COMMA parameter)*)? CLOSE_BRACKET SEMI;
enum_decl: ENUM name EQ IDENTIFIER+ SEMI?;
comment: COMMENT;

parameter: type name;
type: VOID | BOOL | FLOAT | INT | STRING | IDENTIFIER | type OPEN_BRACKET (parameter (COMMA parameter)*)? CLOSE_BRACKET;
name: IDENTIFIER;
// TODO ADD IMPORTS TO NAMESPACES, SO THAT THEY CAN IMPORT FROM OTHER NAMESPACES, REDUCING CODE DUPLICATION