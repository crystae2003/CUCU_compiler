# CUCU_compiler

There are 13 files in this folder : a.out, cucu.l, cucu.y, lex.yy.c, Lexer1.txt, Lexer2.txt, Parser1.txt, Parser2.txt, Sample1.cu, Sample2.cu, y.tab.h, y.tab.c, README.txt

The Following Instructions Should Be Followed While Running The Program :
    A. Open the terminal in the directory 2022CSB1128 and Enter the following commands to run the program :
        1. lex cucu.l
        2. yacc -d cucu.y
        3. gcc lex.yy.c y.tab.c
        4. ./a.out

cucu.l

    A. I've tokenized all the variable names, keywords, special characters and numbers (comments also).
    B. It will give the output inside the lexer.txt file and print every token name in it.

cucu.y

    A. This program contains the BNF grammar rules for the compiler.
    B. This will give the output inside the parser.txt file and print the parsing of code.
    C. If there would be any error in syntax then an error message Syntax Error is printed in the terminal and code returns from there.


Sample1.cu

    A. This file contains the code which has correct synatx.
    B. You can add your correct syntax code here and the program would parse it.
    C. Comment the line 130 and uncomment the line 129 to run the program on this file.

Lexer1.txt And Lexer2.txt

    A. These files contain the output obtained by the cucu.l file, which are all the tokens in the code.
    B. The files Lexer1.txt and Lexer2.txt have outputs for Sample1.cu and Sample2.cu respectively.
    C. The file the user will generate will be Lexer.txt.

Parser1.txt and Parser2.txt

    A. These files store the output obtained by the cucu.y file, which is parsed by the cucu.y file and printed the steps and different types of statements in it.
    B. The files Parser1.txt and Parser2.txt have outputs for Sample1.cu and Sample2.cu respectively.
    C. The file the user will generate will be Parser.txt.

ALL loops , functions will be printed in Parser.txt post detection of all its grammar.
Also the expressions are evaluated postfix.
