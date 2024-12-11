grammar MyLang;


program      : statement+ ;
statement    : variableDeclaration
              | printStatement
              | whileStatement
              | ifElseStatement
              | PASS;
variableDeclaration : LET ID '=' expression;
printStatement      : PRINT expression;

whileStatement : WHILE '(' condition ')' '{' {statement} '}' ;
ifElseStatement 
    : IF '(' condition ')' '{' (statement)* '}'
      ( ELIF '(' condition ')' '{' (statement)* '}' )*
      ( ELSE '{' (statement)* '}' )? ;
switchStatement 
    : SWITCH '(' expression ')' '{' 
        ( CASE LITERAL (statement)+ )* 
        ( DEFAULT (statement)+ )? 
      '}' END_SWITCH;


comment : '//' STRING* ;
multilineComment : '///' STRING* '///';
iterable            : array
                    | object
                    | ID ;
array               : '[' expression (',' expression)* ']' ;
object : '{' (pair (',' pair)*)? '}' ;
pair  : STRING ':' expression ;
condition           : expression COMPARISON_OP expression
                    | BOOLEAN ;
expression          : INT
                    | ID
                    | STRING
                    | array
                    | object
                    | '(' expression OPERATOR expression ')'
                    | expression '?' expression ':' expression ;


WHILE   : 'while';
LET     : 'let' ;
ELIF    : 'else if';
PRINT   : 'print' ;
RETURN  : 'return' ;
IF      : 'if' ;
ELSE    : 'else' ;
SWITCH  : 'switch' ;
CASE    : 'case' ;
DEFAULT : 'default' ;
END_SWITCH : 'end switch' ;
PASS       : 'pass' ;

OPERATOR            : '+' 
                    | '-' 
                    | '*' 
                    | '/' 
                    | '%' ;
COMPARISON_OP  : '>' 
                    | '<' 
                    | '==' 
                    | '!=' 
                    | '>=' 
                    | '<=' ;
BOOLEAN             : 'true' | 'false' ;
INT       : DIGIT+ ;
STRING : '"' ( ~['\\] | '\\' . )* '"' ;

LETTER    : 'a' .. 'z' | 'A' .. 'Z' | '_';  
DIGIT     : '0' .. '9'; 
ID        : LETTER (LETTER | DIGIT)* ;  
LITERAL : INT
        | STRING
        | BOOLEAN ;
WS: [ \t\r\n]+ -> skip;
NEWLINE : '\r'? '\n' ;
