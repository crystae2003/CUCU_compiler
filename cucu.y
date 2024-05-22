%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    int yylex();
    FILE* parser;
    extern FILE* yyin;
    extern FILE* yyout;
    extern void yyerror(char* str);
%}

/*defining all tokens*/
%token LESSTHAN
%token GREATERTHAN
%token LESSOREQ
%token GREATEROREQ
%token EQ
%token NOTEQ
%token SEMICOLON 
%token OPENCURLY 
%token CLOSECURLY 
%token OPENPAREN 
%token CLOSEPAREN 
%token SQOPEN
%token SQCLOSE
%token COM 
%token ASSIGNMENT 
%token IF 
%token ELSE 
%token WHILE 
%token RETURN
%token ADD MULT DIV SUB AND OR

/*assigning precedence and associativity*/
%left ADD SUB
%left MULT DIV
%left OPENPAREN CLOSEPAREN SQOPEN SQCLOSE

%union{
    int number;
    char* str;
}
%token <str> ID
%token <str> INT
%token <str> CHAR
%token <number> CONST

%%
BEGIN : DECLARATION BEGIN {fprintf(parser, "\n");};
        | FUNDEC BEGIN  {fprintf(parser, "\n");};
        | FUNCHEAD BEGIN {fprintf(parser, "\n");};
        |
        ;
        
DECLARATION :  INT ID SEMICOLON {fprintf(parser,"Data Type:INT , Identifier : %s n",  $2);}
        |  CHAR ID SEMICOLON {fprintf(parser,"Data Type:char * , Identifier : %s \n",  $2);}
        |  CHAR ID ASSIGNMENT EXPRSN SEMICOLON {fprintf(parser, "char %s assignment statement\n",$2);};
        |  INT ID ASSIGNMENT EXPRSN SEMICOLON {fprintf(parser, "int %s assignment statement\n",$2);};


STMNTS : STMNT STMNTS
            | STMNT
			;

STMNT   : INT ID SEMICOLON {fprintf(parser, "Data Type: INT, Identifier:%s , semicolon: \n", $2);};
            | CHAR ID SEMICOLON {fprintf(parser, "Data Type: char*, identifier:%s , semicolon: \n", $2);};
            | INT ID ASSIGNMENT EXPRSN SEMICOLON {fprintf(parser, "int assign statement\n");};
            | CHAR ID ASSIGNMENT EXPRSN SEMICOLON {fprintf(parser, "char assign statement\n");};
            | STMNT STRING STMNT SEMICOLON {fprintf(parser, "char array element \n");};
            | STRING ASSIGNMENT EXPRSN SEMICOLON {fprintf(parser, "char array element assign \n");};
            | ID ASSIGNMENT EXPRSN SEMICOLON {fprintf(parser, "assignment of %s variable to expression \n",$1);};
            | ID ASSIGNMENT ID SEMICOLON {fprintf(parser, "%s assignment of variable to %s\n",$1,$3);};
            | EXPRSN BOOL EXPRSN {fprintf(parser, "comparison\n");};
            | WHILE OPENPAREN BOOL CLOSEPAREN OPENCURLY STMNTS CLOSECURLY {fprintf(parser, "while loop\n\n");};
            | RETURN EXPRSN SEMICOLON {fprintf(parser, "return statement\n\n");};
            | IFELSE {fprintf(parser, "if else conditional statement\n\n");};
			

EXPRSN 
            : EXPRSN AND EXPRSN {fprintf(parser, "bitiwise & \n");};
            | EXPRSN OR EXPRSN {fprintf(parser, "bitiwise OR \n");};
            | EXPRSN ADD EXPRSN {fprintf(parser, "addition :+\n");};
            | EXPRSN SUB EXPRSN {fprintf(parser, "subtraction :-\n");};
            | EXPRSN MULT EXPRSN {fprintf(parser, "multiplication :*\n");};
            | EXPRSN DIV EXPRSN {fprintf(parser, "division :/\n");};
            | OPENPAREN EXPRSN CLOSEPAREN{fprintf(parser, "expression\n");};
            | ID {fprintf(parser, "identifier : %s\n", $1);};
            | STRING {fprintf(parser, "string/array element identifier \n");};
            | CONST {fprintf(parser, "constant :%d\n",$1);};
			

IFELSE      : IF OPENPAREN BOOL CLOSEPAREN OPENCURLY STMNTS CLOSECURLY ELSE OPENCURLY STMNTS CLOSECURLY {fprintf(parser, "if else statements end \n\n");};
            | IF OPENPAREN BOOL CLOSEPAREN OPENCURLY STMNTS CLOSECURLY {fprintf(parser, "if statement end \n\n");}
            ;
			

FUNCHEAD    : INT ID OPENPAREN ARGS CLOSEPAREN SEMICOLON {fprintf(parser, "int function:%s function declared\n\n",$2);};
            | CHAR ID OPENPAREN ARGS CLOSEPAREN SEMICOLON {fprintf(parser, "char function:%s function declared\n\n",$2);}
            ;
			

FUNDEC      : INT ID OPENPAREN ARGS CLOSEPAREN FUNCBODY {fprintf(parser, "int function ends: Function name:%s\n\n",$2);};
            | CHAR ID OPENPAREN ARGS CLOSEPAREN FUNCBODY {fprintf(parser, "char function ends: Function name:%s\n\n",$2);};
			

FUNCBODY    : OPENCURLY STMNTS CLOSECURLY {fprintf(parser, "Function Body ends \n\n");};
			

ARGS   : INT ID COM ARGS {fprintf(parser, "Arguments: %s\n\n",$2);};
            | CHAR ID COM ARGS {fprintf(parser, "Arguments: %s\n\n",$2);};
            | 
            | CHAR STRING {fprintf(parser, "string element Argument\n");};
            | CHAR ID {fprintf(parser,"Arguments : %s\n", $2);}
            | INT ID {fprintf(parser,"Arguments : %s\n", $2);}
			;

STRING      : ID SQOPEN EXPRSN SQCLOSE {fprintf(parser, "array/string element \n");};
            

BOOL        : BOOL LESSTHAN BOOL                {fprintf(parser,"Relational Operator : < \n");}
            | BOOL LESSOREQ BOOL              {fprintf(parser,"Relational Operator : <= \n");}
            | BOOL GREATERTHAN BOOL               {fprintf(parser,"Relational Operator : > \n");}
            | BOOL GREATEROREQ BOOL             {fprintf(parser,"Relational Operator : >= \n");}
            | BOOL EQ BOOL                  {fprintf(parser,"Relational Operator : == \n");}
            | BOOL NOTEQ BOOL               {fprintf(parser,"Relational Operator : != \n");}
            | EXPRSN
;
%%

int main(){
	parser = fopen("Parser.txt", "w");
	yyin = fopen("Sample1.cu", "r");
    //yyin = fopen("Sample2.cu", "r");
	yyout = fopen("Lexer.txt", "w");
	yyparse();
	return 0;
}
void yyerror(char *str)
{
    printf("Syntax Error\n");
	
}
