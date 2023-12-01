start: program;

program  : functiondef* expression;

functiondef:  DEF ID LPAR (ID (',' ID)*)*  RPAR LCBR expression RCBR;
function_ref: ID;

@expression:
	  parexpression
	| conditional
	| functioncall
	| mulexpr
	| addexpr
	| number 
	| variable
	| function_ref
	| list
	;

parexpression:
  LPAR expression RPAR;

conditional:
	IF LPAR logicalexpression RPAR LCBR expression RCBR ELSE LCBR expression RCBR;

functioncall:
	ID LPAR (expression (',' expression)*)* RPAR;

mulexpr:
	expression (MUL | DIV | MOD) expression;

addexpr:
	expression (ADD | SUB) expression;

variable:
	ID;

list:
    '\'' LPAR list_content RPAR;

list_content:
    expression (' ' expression)*
    | /* empty */;

      

logicalexpression:
	expression (LT | GT | LEQ | GEQ | EQ | NEQ) expression
	| TRUE
	| FALSE
	;
/**
 * Lexer rules
 *
 * Here we define the tokens identified by the lexer.
 */

// Comments
OPEN_COMMENT :  '/\*';
CLOSE_COMMENT :  '\*/';
COMMENT : OPEN_COMMENT '.*?' CLOSE_COMMENT (%ignore);

// Arithmetic operations
ADD  :  '\+';
SUB  :  '-';
MUL  :  '\*';
DIV  :  '/';
MOD  :  '%';

// Boolean operations
LT  :  '<';
GT  :  '>';
LEQ :  '<=';
GEQ :  '>=';
EQ  :  '==';
NEQ  : '!=';

LPAR : '\(';
RPAR : '\)';
LCBR : '{';
RCBR : '}';

// Integers and identifiers
number: '[0-9]+';
ID: '[a-z]+'
	(%unless
		DEF: 'def';
		IF    : 'if';
		ELSE  : 'else';
		TRUE  : 'true';
		FALSE : 'false';		
		NULL  : 'null';
	);

// Ignore white space, tab and new lines.
WS: '[ \t\r\n]+' (%ignore);		
