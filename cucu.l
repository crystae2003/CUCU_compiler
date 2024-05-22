%{
    // Definition section
    #include"y.tab.h"
%}

%%
"if"                    {fprintf(yyout, "Conditional Statement: IF\n"); return IF;}
"return"                {fprintf(yyout, "Control Statement: return \n");return RETURN;}
"int"                   {fprintf(yyout, "Data Type : INT\n"); yylval.str = strdup(yytext);return INT;}
"char *"                {fprintf(yyout, "Data Type : Char pointer\n"); yylval.str = strdup(yytext);return CHAR;}
"else"                  {fprintf(yyout, "Conditional Statement: ELSE\n"); return ELSE;}
"while"                 {fprintf(yyout, "Loop : while loop\n"); return WHILE;}
[a-zA-Z][0-9A-Za-z_]*   {fprintf(yyout, "Identifier : %s\n", yytext); yylval.str = strdup(yytext); return ID;}
[0-9]+                  {fprintf(yyout, "Constant: %d\n", yylval.number = atoi(yytext)); return CONST;}
[\{]                    {fprintf(yyout, "Left curly braces: { \n"); return OPENCURLY;}
[\}]                    {fprintf(yyout, "Right curly braces: }\n"); return CLOSECURLY;}
[\(]                    {fprintf(yyout, "Left parenthesis: ( \n"); return OPENPAREN;}
[\)]                    {fprintf(yyout, "Right parenthesis: )\n"); return CLOSEPAREN;}
","                     {fprintf(yyout, "Comma : ,\n"); return COM;}
"*"                     {fprintf(yyout, "Operator : *\n"); return MULT;}
"/"                     {fprintf(yyout, "Operator : /\n"); return DIV;}
"+"                     {fprintf(yyout, "Operator : +\n"); return ADD;}
"-"                     {fprintf(yyout, "Operator : -\n"); return SUB;}
">"                     {fprintf(yyout, "Operator : greater than\n"); return GREATERTHAN;}
"<"                     {fprintf(yyout, "Operator : less than\n"); return LESSTHAN;}
"<="                    {fprintf(yyout, "Operator : less than or equal to\n"); return LESSOREQ;}
">="                    {fprintf(yyout, "Operator : greater than or equal to\n"); return GREATEROREQ;}
"&"                     {fprintf(yyout, "Operator : BITWISE AND\n"); return AND;}
"|"                     {fprintf(yyout, "Operator : BITWISE OR\n"); return OR;}
"="                     {fprintf(yyout, "Assignment : =\n"); return ASSIGNMENT;}
"!="                    {fprintf(yyout, "Relational Operator : !=\n"); return NOTEQ;}
"=="                    {fprintf(yyout, "Relational Operator : ==\n"); return EQ;}
";"                     {fprintf(yyout, "SEMICOLON : ;\n");return SEMICOLON;}
[\[]                    {fprintf(yyout, "Left Square bracket: [\n"); return SQOPEN;}
[\]]                    {fprintf(yyout, "Right Square bracket: ]\n"); return SQCLOSE;}
"/*"(\**[^\*\/])*"*/"   {fprintf(yyout, "COMMENT\n");}
[ |\t|\n]               
%%

int yywrap(){
    return 1;
}
