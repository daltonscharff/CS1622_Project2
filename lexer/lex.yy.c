#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
# define U(x) x
# define NLSTATE yyprevious=YYNEWLINE
# define BEGIN yybgin = yysvec + 1 +
# define INITIAL 0
# define YYLERR yysvec
# define YYSTATE (yyestate-yysvec-1)
# define YYOPTIM 1
# ifndef YYLMAX 
# define YYLMAX BUFSIZ
# endif 
#ifndef __cplusplus
# define output(c) (void)putc(c,yyout)
#else
# define lex_output(c) (void)putc(c,yyout)
#endif

#if defined(__cplusplus) || defined(__STDC__)

#if defined(__cplusplus) && defined(__EXTERN_C__)
extern "C" {
#endif
	int yyback(int *, int);
	int yyinput(void);
	int yylook(void);
	void yyoutput(int);
	int yyracc(int);
	int yyreject(void);
	void yyunput(int);
	int yylex(void);
#ifdef YYLEX_E
	void yywoutput(wchar_t);
	wchar_t yywinput(void);
#endif
#ifndef yyless
	int yyless(int);
#endif
#ifndef yywrap
	int yywrap(void);
#endif
#ifdef LEXDEBUG
	void allprint(char);
	void sprint(char *);
#endif
#if defined(__cplusplus) && defined(__EXTERN_C__)
}
#endif

#ifdef __cplusplus
extern "C" {
#endif
	void exit(int);
#ifdef __cplusplus
}
#endif

#endif
# define unput(c) {yytchar= (c);if(yytchar=='\n')yylineno--;*yysptr++=yytchar;}
# define yymore() (yymorfg=1)
#ifndef __cplusplus
# define input() (((yytchar=yysptr>yysbuf?U(*--yysptr):getc(yyin))==10?(yylineno++,yytchar):yytchar)==EOF?0:yytchar)
#else
# define lex_input() (((yytchar=yysptr>yysbuf?U(*--yysptr):getc(yyin))==10?(yylineno++,yytchar):yytchar)==EOF?0:yytchar)
#endif
#define ECHO fprintf(yyout, "%s",yytext)
# define REJECT { nstr = yyreject(); goto yyfussy;}
int yyleng;
#define YYISARRAY
char yytext[YYLMAX];
int yymorfg;
extern char *yysptr, yysbuf[];
int yytchar;
FILE *yyin = {stdin}, *yyout = {stdout};
extern int yylineno;
struct yysvf { 
	struct yywork *yystoff;
	struct yysvf *yyother;
	int *yystops;};
struct yysvf *yyestate;
extern struct yysvf yysvec[], *yybgin;
#include <stdlib.h>
#include "token.h"

#define LIMIT1 500

extern int yycolumn, yylength, yyline, yylval;

char* getToken(int);
void reportError(char*, int, int);
int symbolTableInsert(char*, int);
char* replaceEscapeChars(char*);
void parseComment();

char symbolTable[LIMIT1];
int symbolTableValidator[LIMIT1];	/* Beginning of symbol(1)	*/
int symbolTableType[LIMIT1]; 		/* IDnum(0) or SCONSTnum(1)	*/
int symbolTablePointer;


# line 23 "mylex.l"
/* regular definitions */
# define YYNEWLINE 10
yylex(){
int nstr; extern int yyprevious;
#ifdef __cplusplus
/* to avoid CC and lint complaining yyfussy not being used ...*/
static int __lex_hack = 0;
if (__lex_hack) goto yyfussy;
#endif
while((nstr = yylook()) >= 0)
yyfussy: switch(nstr){
case 0:
if(yywrap()) return(0); break;
case 1:

# line 72 "mylex.l"
			{yycolumn += yyleng; parseComment();}
break;
case 2:

# line 73 "mylex.l"
		{yycolumn += yyleng; reportError("Unpaired Comment", yyline, yycolumn);}
break;
case 3:

# line 74 "mylex.l"
		{yycolumn += yyleng; reportError("Unpaired Comment", yyline, yycolumn);}
break;
case 4:

# line 75 "mylex.l"
          	{yyline++; yycolumn = 0;}
break;
case 5:

# line 76 "mylex.l"
				{yycolumn += yyleng;}
break;
case 6:

# line 77 "mylex.l"
			{yycolumn += yyleng; return (PROGRAMnum);}
break;
case 7:

# line 78 "mylex.l"
				{yycolumn += yyleng; return (SEMInum);}
break;
case 8:

# line 79 "mylex.l"
				{yycolumn += yyleng; return (CLASSnum);}
break;
case 9:

# line 80 "mylex.l"
			{yycolumn += yyleng; return (LBRACEnum);}
break;
case 10:

# line 81 "mylex.l"
			{yycolumn += yyleng; return (METHODnum);}
break;
case 11:

# line 82 "mylex.l"
				{yycolumn += yyleng; return (VOIDnum);}
break;
case 12:

# line 83 "mylex.l"
			{yycolumn += yyleng; return (LPARENnum);}
break;
case 13:

# line 84 "mylex.l"
			{yycolumn += yyleng; return (RPARENnum);}
break;
case 14:

# line 85 "mylex.l"
				{yycolumn += yyleng; reportError("ID Name", yyline, yycolumn);}
break;
case 15:

# line 86 "mylex.l"
			{yycolumn += yyleng; return (ICONSTnum);}
break;
case 16:

# line 87 "mylex.l"
				{yycolumn += yyleng; return (DOTnum);}
break;
case 17:

# line 88 "mylex.l"
			{yycolumn += yyleng; return (SCONSTnum);}
break;
case 18:

# line 89 "mylex.l"
			{yycolumn += yyleng; return (RBRACEnum);}
break;
case 19:

# line 90 "mylex.l"
				{yycolumn += yyleng; return (IFnum);}
break;
case 20:

# line 91 "mylex.l"
				{yycolumn += yyleng; return (TIMESnum);}
break;
case 21:

# line 92 "mylex.l"
				{yycolumn += yyleng; return (PLUSnum);}
break;
case 22:

# line 93 "mylex.l"
				{yycolumn += yyleng; return (NOTnum);}
break;
case 23:

# line 94 "mylex.l"
				{yycolumn += yyleng; return (MINUSnum);}
break;
case 24:

# line 95 "mylex.l"
				{yycolumn += yyleng; return (LTnum);}
break;
case 25:

# line 96 "mylex.l"
				{yycolumn += yyleng; return (LEnum);}
break;
case 26:

# line 97 "mylex.l"
				{yycolumn += yyleng; return (GEnum);}
break;
case 27:

# line 98 "mylex.l"
				{yycolumn += yyleng; return (EQnum);}
break;
case 28:

# line 99 "mylex.l"
				{yycolumn += yyleng; return (ELSEnum);}
break;
case 29:

# line 100 "mylex.l"
			{yycolumn += yyleng; return (DIVIDEnum);}
break;
case 30:

# line 101 "mylex.l"
				{yycolumn += yyleng; return (COMMAnum);}
break;
case 31:

# line 102 "mylex.l"
				{yycolumn += yyleng; return (WHILEnum);}
break;
case 32:

# line 103 "mylex.l"
				{yycolumn += yyleng; return (VALnum);}
break;
case 33:

# line 104 "mylex.l"
				{yycolumn += yyleng; return (RBRACnum);}
break;
case 34:

# line 105 "mylex.l"
				{yycolumn += yyleng; return (ORnum);}
break;
case 35:

# line 106 "mylex.l"
				{yycolumn += yyleng; return (NEnum);}
break;
case 36:

# line 107 "mylex.l"
				{yycolumn += yyleng; return (LBRACnum);}
break;
case 37:

# line 108 "mylex.l"
				{yycolumn += yyleng; return (INTnum);}
break;
case 38:

# line 109 "mylex.l"
				{yycolumn += yyleng; return (GTnum);}
break;
case 39:

# line 110 "mylex.l"
				{yycolumn += yyleng; return (EQUALnum);}
break;
case 40:

# line 111 "mylex.l"
	{yycolumn += yyleng; return (ENDDECLARATIONSnum);}
break;
case 41:

# line 112 "mylex.l"
		{yycolumn += yyleng; return (DECLARATIONSnum);}
break;
case 42:

# line 113 "mylex.l"
			{yycolumn += yyleng; return (ASSGNnum);}
break;
case 43:

# line 114 "mylex.l"
				{yycolumn += yyleng; return (ANDnum);}
break;
case 44:

# line 115 "mylex.l"
			{yycolumn += yyleng; return (RETURNnum);}
break;
case 45:

# line 116 "mylex.l"
		    	{yycolumn += yyleng; return (IDnum);}
break;
case 46:

# line 117 "mylex.l"
				{yycolumn = 0; return (EOFnum);}
break;
case 47:

# line 118 "mylex.l"
					{yycolumn += yyleng; reportError("Syntax", yyline, yycolumn);}
break;
case -1:
break;
default:
(void)fprintf(yyout,"bad switch yylook %d",nstr);
} return(0); }
/* end of yylex */

# line 122 "mylex.l"

int yyline = 0;
int yycolumn = 0;

char* getToken(int lexReturn){
	FILE* file = fopen("token.h", "r");
	char garbage[16];
	char token[32];
	int tokenNum;
	char* tokenName = malloc(32*sizeof(char));
	while(fscanf(file, "%s", garbage) != EOF){
		fscanf(file, "%s", token);
		fscanf(file, "%d", &tokenNum);
		if(tokenNum == lexReturn){
			strncpy(tokenName, token, sizeof(token));
			break;
		}
	}
	fclose(file);
	return tokenName;

}

void reportError(char* error, int yyline, int yycolumn){
	printf("%s Error: line %d, column %d\n", error, yyline, yycolumn);
	return;
}

void parseComment(){
	char* bComment = "/*";
	char* eComment = "*/";
	int i = strlen(yytext);
	yytext[i-1] = '\0';
	yytext[i-2] = '\0';
	strcpy(yytext, &(yytext[2]));

	i = 0;
	while(strstr(&(yytext[i]), bComment) || strstr(&(yytext[i]), eComment)){
		if((yytext[i] == '/' && yytext[i+1] == '*') || (yytext[i] == '*' && yytext[i+1] == '/')){
			reportError("Nested Comment", yyline, yycolumn - (strlen(yytext) - i));
		}
		i++;
	}
}

char* replaceEscapeChars(char* str){
	int i = 0;
	int z = 0;
	char buffer[LIMIT1];

	char* newline = "\n";
	char* tab = "\t";
	char* quote = "\'";

	while((int)strstr(&(str[i]), newline)){
		i = (int)strstr(&(str[i]), newline) - (int)str + 1;
		strcpy(buffer, str);
		strtok(str, newline);

		str[i-1] = '\\';
		str[i] = 'n';
		i++;
		strcpy(&(str[i]), &(buffer[i-1]));
		i++;
	}

	while((int)strstr(&(str[i]), tab)){
		i = (int)strstr(&(str[i]), tab) - (int)str + 1;
		strcpy(buffer, str);
		strtok(str, tab);

		str[i-1] = '\\';
		str[i] = 't';
		i++;
		strcpy(&(str[i]), &(buffer[i-1]));
		i++;
	}

	return str;
}

int symbolTableInsert(char* str, int lexReturn){
	int i = 0;

	while(str[i]){
		str[i] = tolower(str[i]);
		i++;
	}

	i = 0;
	while(strstr(&(symbolTable[i]), str) != NULL){
		i = (int)strstr(&(symbolTable[i]), str) - (int)symbolTable;
		if(symbolTableValidator[i] == 1){
			if((symbolTableType[i] == 0 && lexReturn == 264) || (symbolTableType[i] == 1 && lexReturn == 293)){
				return i;
			}
		}
		i++;
	}
	if(symbolTablePointer + strlen(str) + 1 < LIMIT1){
		str = replaceEscapeChars(str);
		strcpy(&(symbolTable[symbolTablePointer]), str);
		symbolTableValidator[symbolTablePointer] = 1;
		if(lexReturn == 264){
			symbolTableType[symbolTablePointer] = 0;
		}else{
			symbolTableType[symbolTablePointer] = 1;
		}

		symbolTablePointer += strlen(str);
		strcpy(&(symbolTable[symbolTablePointer]), " ");
		symbolTablePointer++;
		return symbolTablePointer - strlen(str) - 1;
	}else{
		printf("Data Overflow Error: symbol table larger than limit");
		return -1;
	}
}

int main(){
	int lexReturn;
	int arrayLocation;
	char* tokenName;
	symbolTablePointer = 0;

	printf("\nLine \tColumn(last char of the token) \tToken \t\t\tIndex_in_String_table\n");

	do{
		lexReturn = yylex();
		tokenName = getToken(lexReturn);
		if(strcmp(tokenName, "EOFnum") == 0){
			printf(" \t \t\t\t\t%s \t\t\n\n", tokenName);
		}else if(lexReturn == 264 || lexReturn == 293){
			if(lexReturn == 293){
				yytext[strlen(yytext)-1] = '\0';
				strcpy(yytext, yytext+1);
			}
			arrayLocation = symbolTableInsert(yytext, lexReturn);
			printf("%d \t%d \t\t\t\t%s    \t\t%d\n", yyline, yycolumn, tokenName, arrayLocation);
		}else{
			printf("%d \t%d \t\t\t\t%s\n", yyline, yycolumn, tokenName);
		}

	}while(lexReturn != 0);

	printf("String Table: %s\n", symbolTable);
}


/* TODO:
Comment Errors?
*/

int yyvstop[] = {
0,

47,
0, 

5,
47,
0, 

4,
0, 

5,
47,
0, 

22,
47,
0, 

47,
0, 

47,
0, 

12,
47,
0, 

13,
47,
0, 

20,
47,
0, 

21,
47,
0, 

30,
47,
0, 

23,
47,
0, 

16,
47,
0, 

29,
47,
0, 

14,
15,
47,
0, 

47,
0, 

7,
47,
0, 

24,
47,
0, 

39,
47,
0, 

38,
47,
0, 

45,
47,
0, 

45,
47,
0, 

45,
47,
0, 

45,
47,
0, 

45,
47,
0, 

45,
47,
0, 

45,
47,
0, 

45,
47,
0, 

45,
47,
0, 

45,
47,
0, 

45,
46,
47,
0, 

36,
47,
0, 

33,
47,
0, 

9,
47,
0, 

47,
0, 

18,
47,
0, 

15,
0, 

5,
0, 

5,
0, 

35,
0, 

43,
0, 

17,
0, 

15,
0, 

3,
0, 

2,
0, 

15,
0, 

14,
15,
0, 

14,
15,
0, 

42,
0, 

25,
0, 

27,
0, 

26,
0, 

15,
45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

19,
45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

34,
0, 

14,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

37,
45,
0, 

45,
0, 

45,
0, 

45,
0, 

32,
45,
0, 

45,
0, 

45,
0, 

1,
0, 

45,
0, 

45,
0, 

28,
45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

11,
45,
0, 

45,
0, 

8,
45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

31,
45,
0, 

45,
0, 

45,
0, 

10,
45,
0, 

45,
0, 

44,
45,
0, 

45,
0, 

45,
0, 

6,
45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

45,
0, 

41,
45,
0, 

45,
0, 

45,
0, 

45,
0, 

40,
45,
0, 
0};
# define YYTYPE unsigned char
struct yywork { YYTYPE verify, advance; } yycrank[] = {
0,0,	0,0,	1,3,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	1,4,	1,5,	
4,41,	41,41,	52,0,	0,0,	
0,0,	0,0,	9,45,	0,0,	
18,51,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	9,45,	
0,0,	18,0,	0,0,	0,0,	
0,0,	1,6,	1,7,	6,42,	
42,42,	0,0,	0,0,	1,8,	
1,9,	1,10,	1,11,	1,12,	
1,13,	1,14,	1,15,	1,16,	
1,17,	1,18,	8,44,	12,49,	
17,50,	45,45,	73,74,	88,74,	
9,46,	0,0,	18,51,	1,19,	
1,20,	1,21,	1,22,	1,23,	
7,43,	9,47,	1,24,	18,52,	
1,25,	1,26,	1,27,	19,54,	
21,55,	22,56,	1,28,	23,57,	
26,61,	0,0,	1,29,	25,60,	
29,66,	1,30,	9,45,	1,31,	
18,53,	30,67,	31,68,	1,32,	
1,33,	0,0,	0,0,	1,34,	
1,35,	1,3,	1,36,	47,48,	
33,71,	45,48,	2,4,	74,74,	
1,25,	1,26,	1,27,	0,0,	
74,88,	0,0,	1,28,	0,0,	
26,61,	9,48,	1,29,	25,60,	
29,66,	1,30,	0,0,	1,31,	
0,0,	30,67,	31,68,	1,32,	
1,33,	2,6,	2,7,	0,0,	
1,37,	1,38,	1,39,	2,8,	
33,71,	2,10,	2,11,	2,12,	
2,13,	2,14,	2,15,	2,16,	
2,17,	3,40,	3,40,	3,40,	
3,40,	3,40,	3,40,	3,40,	
3,40,	3,40,	3,40,	2,19,	
2,20,	2,21,	2,22,	2,23,	
27,62,	28,64,	27,63,	38,72,	
2,25,	2,26,	2,27,	32,69,	
0,0,	28,65,	2,28,	0,0,	
0,0,	0,0,	2,29,	0,0,	
0,0,	2,30,	0,0,	2,31,	
0,0,	32,70,	0,0,	2,32,	
2,33,	0,0,	0,0,	2,34,	
2,35,	2,3,	2,36,	0,0,	
27,62,	28,64,	27,63,	0,0,	
2,25,	2,26,	2,27,	32,69,	
0,0,	28,65,	2,28,	0,0,	
0,0,	0,0,	2,29,	0,0,	
0,0,	2,30,	0,0,	2,31,	
0,0,	32,70,	0,0,	2,32,	
2,33,	0,0,	0,0,	0,0,	
2,37,	2,38,	2,39,	24,58,	
24,58,	24,58,	24,58,	24,58,	
24,58,	24,58,	24,58,	24,58,	
24,58,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
24,59,	24,59,	24,59,	24,59,	
24,59,	24,59,	24,59,	24,59,	
24,59,	24,59,	24,59,	24,59,	
24,59,	24,59,	24,59,	24,59,	
24,59,	24,59,	24,59,	24,59,	
24,59,	24,59,	24,59,	24,59,	
24,59,	24,59,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
24,59,	24,59,	24,59,	24,59,	
24,59,	24,59,	24,59,	24,59,	
24,59,	24,59,	24,59,	24,59,	
24,59,	24,59,	24,59,	24,59,	
24,59,	24,59,	24,59,	24,59,	
24,59,	24,59,	24,59,	24,59,	
24,59,	24,59,	48,45,	50,73,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	48,0,	
50,73,	51,51,	51,51,	51,51,	
51,51,	51,51,	51,51,	51,51,	
51,51,	51,51,	51,51,	59,76,	
59,76,	59,76,	59,76,	59,76,	
59,76,	59,76,	59,76,	59,76,	
59,76,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
48,45,	50,73,	0,0,	0,0,	
50,74,	0,0,	0,0,	0,0,	
0,0,	48,45,	50,73,	53,53,	
53,53,	53,53,	53,53,	53,53,	
53,53,	53,53,	53,53,	53,53,	
53,53,	0,0,	0,0,	0,0,	
0,0,	0,0,	48,45,	50,73,	
53,75,	53,75,	53,75,	53,75,	
53,75,	53,75,	53,75,	53,75,	
53,75,	53,75,	53,75,	53,75,	
53,75,	53,75,	53,75,	53,75,	
53,75,	53,75,	53,75,	53,75,	
53,75,	53,75,	53,75,	53,75,	
53,75,	53,75,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
53,75,	53,75,	53,75,	53,75,	
53,75,	53,75,	53,75,	53,75,	
53,75,	53,75,	53,75,	53,75,	
53,75,	53,75,	53,75,	53,75,	
53,75,	53,75,	53,75,	53,75,	
53,75,	53,75,	53,75,	53,75,	
53,75,	53,75,	58,76,	58,76,	
58,76,	58,76,	58,76,	58,76,	
58,76,	58,76,	58,76,	58,76,	
58,76,	58,76,	58,76,	58,76,	
58,76,	58,76,	58,76,	58,76,	
58,76,	58,76,	58,76,	58,76,	
58,76,	58,76,	58,76,	58,76,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	58,76,	58,76,	
58,76,	58,76,	58,76,	58,76,	
58,76,	58,76,	58,76,	58,76,	
58,76,	58,76,	58,76,	58,76,	
58,76,	58,76,	58,76,	58,76,	
58,76,	58,76,	58,76,	58,76,	
58,76,	58,76,	58,76,	58,76,	
60,76,	60,76,	60,76,	60,76,	
60,76,	60,76,	60,76,	60,76,	
60,76,	60,76,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	60,77,	61,76,	61,76,	
61,76,	61,76,	61,76,	61,76,	
61,76,	61,76,	61,76,	61,76,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	61,78,	62,76,	62,76,	
62,76,	62,76,	62,76,	62,76,	
62,76,	62,76,	62,76,	62,76,	
0,0,	60,77,	63,76,	63,76,	
63,76,	63,76,	63,76,	63,76,	
63,76,	63,76,	63,76,	63,76,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	61,78,	63,80,	0,0,	
0,0,	62,79,	64,76,	64,76,	
64,76,	64,76,	64,76,	64,76,	
64,76,	64,76,	64,76,	64,76,	
65,76,	65,76,	65,76,	65,76,	
65,76,	65,76,	65,76,	65,76,	
65,76,	65,76,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	63,80,	0,0,	
0,0,	62,79,	66,76,	66,76,	
66,76,	66,76,	66,76,	66,76,	
66,76,	66,76,	66,76,	66,76,	
0,0,	0,0,	0,0,	0,0,	
65,81,	0,0,	67,76,	67,76,	
67,76,	67,76,	67,76,	67,76,	
67,76,	67,76,	67,76,	67,76,	
68,76,	68,76,	68,76,	68,76,	
68,76,	68,76,	68,76,	68,76,	
68,76,	68,76,	66,82,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
65,81,	67,83,	69,76,	69,76,	
69,76,	69,76,	69,76,	69,76,	
69,76,	69,76,	69,76,	69,76,	
0,0,	0,0,	0,0,	0,0,	
68,84,	0,0,	0,0,	0,0,	
0,0,	0,0,	66,82,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	69,85,	0,0,	
0,0,	67,83,	70,76,	70,76,	
70,76,	70,76,	70,76,	70,76,	
70,76,	70,76,	70,76,	70,76,	
0,0,	0,0,	0,0,	0,0,	
68,84,	71,76,	71,76,	71,76,	
71,76,	71,76,	71,76,	71,76,	
71,76,	71,76,	71,76,	70,86,	
0,0,	0,0,	69,85,	75,75,	
75,75,	75,75,	75,75,	75,75,	
75,75,	75,75,	75,75,	75,75,	
75,75,	0,0,	71,87,	78,76,	
78,76,	78,76,	78,76,	78,76,	
78,76,	78,76,	78,76,	78,76,	
78,76,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	70,86,	
76,76,	76,76,	76,76,	76,76,	
76,76,	76,76,	76,76,	76,76,	
76,76,	76,76,	0,0,	78,90,	
0,0,	0,0,	71,87,	0,0,	
0,0,	76,76,	76,76,	76,76,	
76,76,	76,76,	76,76,	76,76,	
76,76,	76,76,	76,76,	76,76,	
76,76,	76,76,	76,76,	76,76,	
76,76,	76,76,	76,76,	76,76,	
76,76,	76,76,	76,76,	76,76,	
76,76,	76,76,	76,76,	78,90,	
0,0,	0,0,	0,0,	0,0,	
0,0,	76,76,	76,76,	76,76,	
76,76,	76,76,	76,76,	76,76,	
76,76,	76,76,	76,76,	76,76,	
76,76,	76,76,	76,76,	76,76,	
76,76,	76,76,	76,76,	76,76,	
76,76,	76,76,	76,76,	76,76,	
76,76,	76,76,	76,76,	77,76,	
77,76,	77,76,	77,76,	77,76,	
77,76,	77,76,	77,76,	77,76,	
77,76,	79,76,	79,76,	79,76,	
79,76,	79,76,	79,76,	79,76,	
79,76,	79,76,	79,76,	80,76,	
80,76,	80,76,	80,76,	80,76,	
80,76,	80,76,	80,76,	80,76,	
80,76,	0,0,	79,91,	0,0,	
0,0,	0,0,	77,89,	0,0,	
0,0,	0,0,	0,0,	80,92,	
81,76,	81,76,	81,76,	81,76,	
81,76,	81,76,	81,76,	81,76,	
81,76,	81,76,	82,76,	82,76,	
82,76,	82,76,	82,76,	82,76,	
82,76,	82,76,	82,76,	82,76,	
0,0,	0,0,	79,91,	0,0,	
0,0,	0,0,	77,89,	0,0,	
0,0,	0,0,	0,0,	80,92,	
0,0,	0,0,	82,93,	83,76,	
83,76,	83,76,	83,76,	83,76,	
83,76,	83,76,	83,76,	83,76,	
83,76,	84,76,	84,76,	84,76,	
84,76,	84,76,	84,76,	84,76,	
84,76,	84,76,	84,76,	0,0,	
0,0,	0,0,	83,94,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	82,93,	85,76,	
85,76,	85,76,	85,76,	85,76,	
85,76,	85,76,	85,76,	85,76,	
85,76,	0,0,	0,0,	0,0,	
0,0,	0,0,	84,95,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	83,94,	86,76,	
86,76,	86,76,	86,76,	86,76,	
86,76,	86,76,	86,76,	86,76,	
86,76,	87,76,	87,76,	87,76,	
87,76,	87,76,	87,76,	87,76,	
87,76,	87,76,	87,76,	86,96,	
0,0,	0,0,	84,95,	89,76,	
89,76,	89,76,	89,76,	89,76,	
89,76,	89,76,	89,76,	89,76,	
89,76,	0,0,	0,0,	0,0,	
0,0,	87,97,	90,76,	90,76,	
90,76,	90,76,	90,76,	90,76,	
90,76,	90,76,	90,76,	90,76,	
0,0,	0,0,	0,0,	86,96,	
0,0,	0,0,	0,0,	90,99,	
0,0,	0,0,	89,98,	91,76,	
91,76,	91,76,	91,76,	91,76,	
91,76,	91,76,	91,76,	91,76,	
91,76,	87,97,	92,76,	92,76,	
92,76,	92,76,	92,76,	92,76,	
92,76,	92,76,	92,76,	92,76,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	90,99,	
0,0,	0,0,	89,98,	92,100,	
0,0,	93,76,	93,76,	93,76,	
93,76,	93,76,	93,76,	93,76,	
93,76,	93,76,	93,76,	94,76,	
94,76,	94,76,	94,76,	94,76,	
94,76,	94,76,	94,76,	94,76,	
94,76,	95,76,	95,76,	95,76,	
95,76,	95,76,	95,76,	95,76,	
95,76,	95,76,	95,76,	92,100,	
93,101,	96,76,	96,76,	96,76,	
96,76,	96,76,	96,76,	96,76,	
96,76,	96,76,	96,76,	0,0,	
0,0,	94,102,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	95,103,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
93,101,	97,76,	97,76,	97,76,	
97,76,	97,76,	97,76,	97,76,	
97,76,	97,76,	97,76,	0,0,	
0,0,	94,102,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	97,104,	95,103,	
98,76,	98,76,	98,76,	98,76,	
98,76,	98,76,	98,76,	98,76,	
98,76,	98,76,	99,76,	99,76,	
99,76,	99,76,	99,76,	99,76,	
99,76,	99,76,	99,76,	99,76,	
100,76,	100,76,	100,76,	100,76,	
100,76,	100,76,	100,76,	100,76,	
100,76,	100,76,	97,104,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	100,106,	
0,0,	0,0,	0,0,	0,0,	
99,105,	101,76,	101,76,	101,76,	
101,76,	101,76,	101,76,	101,76,	
101,76,	101,76,	101,76,	102,76,	
102,76,	102,76,	102,76,	102,76,	
102,76,	102,76,	102,76,	102,76,	
102,76,	101,107,	0,0,	0,0,	
0,0,	0,0,	0,0,	100,106,	
102,108,	0,0,	0,0,	0,0,	
99,105,	103,76,	103,76,	103,76,	
103,76,	103,76,	103,76,	103,76,	
103,76,	103,76,	103,76,	104,76,	
104,76,	104,76,	104,76,	104,76,	
104,76,	104,76,	104,76,	104,76,	
104,76,	101,107,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
102,108,	0,0,	0,0,	103,109,	
105,76,	105,76,	105,76,	105,76,	
105,76,	105,76,	105,76,	105,76,	
105,76,	105,76,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	105,110,	106,76,	106,76,	
106,76,	106,76,	106,76,	106,76,	
106,76,	106,76,	106,76,	106,76,	
0,0,	0,0,	0,0,	103,109,	
107,76,	107,76,	107,76,	107,76,	
107,76,	107,76,	107,76,	107,76,	
107,76,	107,76,	0,0,	0,0,	
0,0,	0,0,	106,111,	0,0,	
0,0,	105,110,	108,76,	108,76,	
108,76,	108,76,	108,76,	108,76,	
108,76,	108,76,	108,76,	108,76,	
109,76,	109,76,	109,76,	109,76,	
109,76,	109,76,	109,76,	109,76,	
109,76,	109,76,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	106,111,	108,112,	
110,76,	110,76,	110,76,	110,76,	
110,76,	110,76,	110,76,	110,76,	
110,76,	110,76,	111,76,	111,76,	
111,76,	111,76,	111,76,	111,76,	
111,76,	111,76,	111,76,	111,76,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	111,114,	
0,0,	0,0,	0,0,	108,112,	
0,0,	0,0,	0,0,	0,0,	
110,113,	112,76,	112,76,	112,76,	
112,76,	112,76,	112,76,	112,76,	
112,76,	112,76,	112,76,	113,76,	
113,76,	113,76,	113,76,	113,76,	
113,76,	113,76,	113,76,	113,76,	
113,76,	0,0,	0,0,	111,114,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
110,113,	0,0,	0,0,	0,0,	
113,115,	114,76,	114,76,	114,76,	
114,76,	114,76,	114,76,	114,76,	
114,76,	114,76,	114,76,	115,76,	
115,76,	115,76,	115,76,	115,76,	
115,76,	115,76,	115,76,	115,76,	
115,76,	116,76,	116,76,	116,76,	
116,76,	116,76,	116,76,	116,76,	
116,76,	116,76,	116,76,	0,0,	
113,115,	0,0,	0,0,	114,116,	
0,0,	0,0,	116,118,	0,0,	
0,0,	0,0,	115,117,	117,76,	
117,76,	117,76,	117,76,	117,76,	
117,76,	117,76,	117,76,	117,76,	
117,76,	118,76,	118,76,	118,76,	
118,76,	118,76,	118,76,	118,76,	
118,76,	118,76,	118,76,	0,0,	
0,0,	0,0,	0,0,	114,116,	
0,0,	0,0,	116,118,	0,0,	
0,0,	117,119,	115,117,	119,76,	
119,76,	119,76,	119,76,	119,76,	
119,76,	119,76,	119,76,	119,76,	
119,76,	0,0,	0,0,	0,0,	
0,0,	118,120,	120,76,	120,76,	
120,76,	120,76,	120,76,	120,76,	
120,76,	120,76,	120,76,	120,76,	
0,0,	0,0,	0,0,	0,0,	
0,0,	117,119,	0,0,	0,0,	
0,0,	0,0,	119,121,	0,0,	
0,0,	0,0,	0,0,	120,122,	
0,0,	0,0,	0,0,	0,0,	
0,0,	118,120,	121,76,	121,76,	
121,76,	121,76,	121,76,	121,76,	
121,76,	121,76,	121,76,	121,76,	
122,76,	122,76,	122,76,	122,76,	
122,76,	122,76,	122,76,	122,76,	
122,76,	122,76,	119,121,	0,0,	
0,0,	0,0,	0,0,	120,122,	
123,76,	123,76,	123,76,	123,76,	
123,76,	123,76,	123,76,	123,76,	
123,76,	123,76,	0,0,	0,0,	
0,0,	0,0,	0,0,	122,123,	
124,76,	124,76,	124,76,	124,76,	
124,76,	124,76,	124,76,	124,76,	
124,76,	124,76,	0,0,	0,0,	
0,0,	0,0,	123,124,	125,76,	
125,76,	125,76,	125,76,	125,76,	
125,76,	125,76,	125,76,	125,76,	
125,76,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	122,123,	
0,0,	0,0,	0,0,	124,125,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	123,124,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	124,125,	
0,0};
struct yysvf yysvec[] = {
0,	0,	0,
yycrank+-1,	0,		0,	
yycrank+-89,	yysvec+1,	0,	
yycrank+89,	0,		yyvstop+1,
yycrank+3,	yysvec+3,	yyvstop+3,
yycrank+0,	0,		yyvstop+6,
yycrank+3,	yysvec+3,	yyvstop+8,
yycrank+3,	yysvec+3,	yyvstop+11,
yycrank+12,	yysvec+3,	yyvstop+14,
yycrank+-17,	0,		yyvstop+16,
yycrank+0,	yysvec+3,	yyvstop+18,
yycrank+0,	yysvec+3,	yyvstop+21,
yycrank+4,	yysvec+3,	yyvstop+24,
yycrank+0,	yysvec+3,	yyvstop+27,
yycrank+0,	yysvec+3,	yyvstop+30,
yycrank+0,	yysvec+3,	yyvstop+33,
yycrank+0,	yysvec+3,	yyvstop+36,
yycrank+10,	yysvec+3,	yyvstop+39,
yycrank+-19,	0,		yyvstop+42,
yycrank+10,	yysvec+3,	yyvstop+46,
yycrank+0,	yysvec+3,	yyvstop+48,
yycrank+11,	yysvec+3,	yyvstop+51,
yycrank+12,	yysvec+3,	yyvstop+54,
yycrank+14,	yysvec+3,	yyvstop+57,
yycrank+167,	0,		yyvstop+60,
yycrank+3,	yysvec+24,	yyvstop+63,
yycrank+7,	yysvec+24,	yyvstop+66,
yycrank+76,	yysvec+24,	yyvstop+69,
yycrank+83,	yysvec+24,	yyvstop+72,
yycrank+11,	yysvec+24,	yyvstop+75,
yycrank+3,	yysvec+24,	yyvstop+78,
yycrank+17,	yysvec+24,	yyvstop+81,
yycrank+94,	yysvec+24,	yyvstop+84,
yycrank+24,	yysvec+24,	yyvstop+87,
yycrank+0,	yysvec+24,	yyvstop+90,
yycrank+0,	yysvec+3,	yyvstop+94,
yycrank+0,	yysvec+3,	yyvstop+97,
yycrank+0,	yysvec+3,	yyvstop+100,
yycrank+31,	yysvec+3,	yyvstop+103,
yycrank+0,	yysvec+3,	yyvstop+105,
yycrank+0,	yysvec+3,	yyvstop+108,
yycrank+4,	0,		yyvstop+110,
yycrank+4,	0,		yyvstop+112,
yycrank+0,	0,		yyvstop+114,
yycrank+0,	0,		yyvstop+116,
yycrank+-5,	yysvec+9,	0,	
yycrank+0,	0,		yyvstop+118,
yycrank+-3,	yysvec+9,	yyvstop+120,
yycrank+-289,	0,		0,	
yycrank+0,	0,		yyvstop+122,
yycrank+-290,	0,		yyvstop+124,
yycrank+253,	0,		yyvstop+126,
yycrank+-4,	yysvec+18,	yyvstop+128,
yycrank+291,	0,		yyvstop+131,
yycrank+0,	0,		yyvstop+134,
yycrank+0,	0,		yyvstop+136,
yycrank+0,	0,		yyvstop+138,
yycrank+0,	0,		yyvstop+140,
yycrank+349,	yysvec+24,	yyvstop+142,
yycrank+263,	yysvec+24,	yyvstop+145,
yycrank+424,	yysvec+24,	yyvstop+147,
yycrank+442,	yysvec+24,	yyvstop+149,
yycrank+462,	yysvec+24,	yyvstop+151,
yycrank+474,	yysvec+24,	yyvstop+153,
yycrank+498,	yysvec+24,	yyvstop+155,
yycrank+508,	yysvec+24,	yyvstop+158,
yycrank+530,	yysvec+24,	yyvstop+160,
yycrank+546,	yysvec+24,	yyvstop+162,
yycrank+556,	yysvec+24,	yyvstop+164,
yycrank+578,	yysvec+24,	yyvstop+166,
yycrank+610,	yysvec+24,	yyvstop+168,
yycrank+625,	yysvec+24,	yyvstop+170,
yycrank+0,	0,		yyvstop+172,
yycrank+-12,	yysvec+50,	0,	
yycrank+-57,	yysvec+50,	0,	
yycrank+639,	yysvec+53,	yyvstop+174,
yycrank+668,	0,		yyvstop+176,
yycrank+743,	yysvec+24,	yyvstop+178,
yycrank+651,	yysvec+24,	yyvstop+180,
yycrank+753,	yysvec+24,	yyvstop+182,
yycrank+763,	yysvec+24,	yyvstop+184,
yycrank+784,	yysvec+24,	yyvstop+186,
yycrank+794,	yysvec+24,	yyvstop+189,
yycrank+819,	yysvec+24,	yyvstop+191,
yycrank+829,	yysvec+24,	yyvstop+193,
yycrank+851,	yysvec+24,	yyvstop+195,
yycrank+875,	yysvec+24,	yyvstop+198,
yycrank+885,	yysvec+24,	yyvstop+200,
yycrank+-13,	yysvec+50,	yyvstop+202,
yycrank+899,	yysvec+24,	yyvstop+204,
yycrank+914,	yysvec+24,	yyvstop+206,
yycrank+935,	yysvec+24,	yyvstop+208,
yycrank+946,	yysvec+24,	yyvstop+211,
yycrank+969,	yysvec+24,	yyvstop+213,
yycrank+979,	yysvec+24,	yyvstop+215,
yycrank+989,	yysvec+24,	yyvstop+217,
yycrank+1001,	yysvec+24,	yyvstop+219,
yycrank+1033,	yysvec+24,	yyvstop+222,
yycrank+1056,	yysvec+24,	yyvstop+224,
yycrank+1066,	yysvec+24,	yyvstop+227,
yycrank+1076,	yysvec+24,	yyvstop+229,
yycrank+1101,	yysvec+24,	yyvstop+231,
yycrank+1111,	yysvec+24,	yyvstop+233,
yycrank+1133,	yysvec+24,	yyvstop+235,
yycrank+1143,	yysvec+24,	yyvstop+237,
yycrank+1164,	yysvec+24,	yyvstop+240,
yycrank+1182,	yysvec+24,	yyvstop+242,
yycrank+1196,	yysvec+24,	yyvstop+244,
yycrank+1214,	yysvec+24,	yyvstop+247,
yycrank+1224,	yysvec+24,	yyvstop+249,
yycrank+1244,	yysvec+24,	yyvstop+252,
yycrank+1254,	yysvec+24,	yyvstop+254,
yycrank+1281,	yysvec+24,	yyvstop+256,
yycrank+1291,	yysvec+24,	yyvstop+259,
yycrank+1317,	yysvec+24,	yyvstop+261,
yycrank+1327,	yysvec+24,	yyvstop+263,
yycrank+1337,	yysvec+24,	yyvstop+265,
yycrank+1359,	yysvec+24,	yyvstop+267,
yycrank+1369,	yysvec+24,	yyvstop+269,
yycrank+1391,	yysvec+24,	yyvstop+271,
yycrank+1406,	yysvec+24,	yyvstop+273,
yycrank+1438,	yysvec+24,	yyvstop+275,
yycrank+1448,	yysvec+24,	yyvstop+278,
yycrank+1464,	yysvec+24,	yyvstop+280,
yycrank+1480,	yysvec+24,	yyvstop+282,
yycrank+1495,	yysvec+24,	yyvstop+284,
0,	0,	0};
struct yywork *yytop = yycrank+1595;
struct yysvf *yybgin = yysvec+1;
char yymatch[] = {
  0,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,  10,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,  39, 
  1,   1,   1,   1,   1,   1,   1,   1, 
 48,  48,  48,  48,  48,  48,  48,  48, 
 48,  48,   1,   1,   1,   1,   1,   1, 
  1,  65,  65,  65,  65,  65,  65,  65, 
 65,  65,  65,  65,  65,  65,  65,  65, 
 65,  65,  65,  65,  65,  65,  65,  65, 
 65,  65,  65,   1,  39,   1,   1,   1, 
  1,  65,  65,  65,  65,  65,  65,  65, 
 65,  65,  65,  65,  65,  65,  65,  65, 
 65,  65,  65,  65,  65,  65,  65,  65, 
 65,  65,  65,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
0};
char yyextra[] = {
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0};
/*	Copyright (c) 1989 AT&T	*/
/*	  All Rights Reserved  	*/

/*	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T	*/
/*	The copyright notice above does not evidence any   	*/
/*	actual or intended publication of such source code.	*/

#pragma ident	"@(#)ncform	6.12	97/12/08 SMI"

int yylineno =1;
# define YYU(x) x
# define NLSTATE yyprevious=YYNEWLINE
struct yysvf *yylstate [YYLMAX], **yylsp, **yyolsp;
char yysbuf[YYLMAX];
char *yysptr = yysbuf;
int *yyfnd;
extern struct yysvf *yyestate;
int yyprevious = YYNEWLINE;
#if defined(__cplusplus) || defined(__STDC__)
int yylook(void)
#else
yylook()
#endif
{
	register struct yysvf *yystate, **lsp;
	register struct yywork *yyt;
	struct yysvf *yyz;
	int yych, yyfirst;
	struct yywork *yyr;
# ifdef LEXDEBUG
	int debug;
# endif
	char *yylastch;
	/* start off machines */
# ifdef LEXDEBUG
	debug = 0;
# endif
	yyfirst=1;
	if (!yymorfg)
		yylastch = yytext;
	else {
		yymorfg=0;
		yylastch = yytext+yyleng;
		}
	for(;;){
		lsp = yylstate;
		yyestate = yystate = yybgin;
		if (yyprevious==YYNEWLINE) yystate++;
		for (;;){
# ifdef LEXDEBUG
			if(debug)fprintf(yyout,"state %d\n",yystate-yysvec-1);
# endif
			yyt = yystate->yystoff;
			if(yyt == yycrank && !yyfirst){  /* may not be any transitions */
				yyz = yystate->yyother;
				if(yyz == 0)break;
				if(yyz->yystoff == yycrank)break;
				}
#ifndef __cplusplus
			*yylastch++ = yych = input();
#else
			*yylastch++ = yych = lex_input();
#endif
#ifdef YYISARRAY
			if(yylastch > &yytext[YYLMAX]) {
				fprintf(yyout,"Input string too long, limit %d\n",YYLMAX);
				exit(1);
			}
#else
			if (yylastch >= &yytext[ yytextsz ]) {
				int	x = yylastch - yytext;

				yytextsz += YYTEXTSZINC;
				if (yytext == yy_tbuf) {
				    yytext = (char *) malloc(yytextsz);
				    memcpy(yytext, yy_tbuf, sizeof (yy_tbuf));
				}
				else
				    yytext = (char *) realloc(yytext, yytextsz);
				if (!yytext) {
				    fprintf(yyout,
					"Cannot realloc yytext\n");
				    exit(1);
				}
				yylastch = yytext + x;
			}
#endif
			yyfirst=0;
		tryagain:
# ifdef LEXDEBUG
			if(debug){
				fprintf(yyout,"char ");
				allprint(yych);
				putchar('\n');
				}
# endif
			yyr = yyt;
			if ( (uintptr_t)yyt > (uintptr_t)yycrank){
				yyt = yyr + yych;
				if (yyt <= yytop && yyt->verify+yysvec == yystate){
					if(yyt->advance+yysvec == YYLERR)	/* error transitions */
						{unput(*--yylastch);break;}
					*lsp++ = yystate = yyt->advance+yysvec;
					if(lsp > &yylstate[YYLMAX]) {
						fprintf(yyout,"Input string too long, limit %d\n",YYLMAX);
						exit(1);
					}
					goto contin;
					}
				}
# ifdef YYOPTIM
			else if((uintptr_t)yyt < (uintptr_t)yycrank) {	/* r < yycrank */
				yyt = yyr = yycrank+(yycrank-yyt);
# ifdef LEXDEBUG
				if(debug)fprintf(yyout,"compressed state\n");
# endif
				yyt = yyt + yych;
				if(yyt <= yytop && yyt->verify+yysvec == yystate){
					if(yyt->advance+yysvec == YYLERR)	/* error transitions */
						{unput(*--yylastch);break;}
					*lsp++ = yystate = yyt->advance+yysvec;
					if(lsp > &yylstate[YYLMAX]) {
						fprintf(yyout,"Input string too long, limit %d\n",YYLMAX);
						exit(1);
					}
					goto contin;
					}
				yyt = yyr + YYU(yymatch[yych]);
# ifdef LEXDEBUG
				if(debug){
					fprintf(yyout,"try fall back character ");
					allprint(YYU(yymatch[yych]));
					putchar('\n');
					}
# endif
				if(yyt <= yytop && yyt->verify+yysvec == yystate){
					if(yyt->advance+yysvec == YYLERR)	/* error transition */
						{unput(*--yylastch);break;}
					*lsp++ = yystate = yyt->advance+yysvec;
					if(lsp > &yylstate[YYLMAX]) {
						fprintf(yyout,"Input string too long, limit %d\n",YYLMAX);
						exit(1);
					}
					goto contin;
					}
				}
			if ((yystate = yystate->yyother) && (yyt= yystate->yystoff) != yycrank){
# ifdef LEXDEBUG
				if(debug)fprintf(yyout,"fall back to state %d\n",yystate-yysvec-1);
# endif
				goto tryagain;
				}
# endif
			else
				{unput(*--yylastch);break;}
		contin:
# ifdef LEXDEBUG
			if(debug){
				fprintf(yyout,"state %d char ",yystate-yysvec-1);
				allprint(yych);
				putchar('\n');
				}
# endif
			;
			}
# ifdef LEXDEBUG
		if(debug){
			fprintf(yyout,"stopped at %d with ",*(lsp-1)-yysvec-1);
			allprint(yych);
			putchar('\n');
			}
# endif
		while (lsp-- > yylstate){
			*yylastch-- = 0;
			if (*lsp != 0 && (yyfnd= (*lsp)->yystops) && *yyfnd > 0){
				yyolsp = lsp;
				if(yyextra[*yyfnd]){		/* must backup */
					while(yyback((*lsp)->yystops,-*yyfnd) != 1 && lsp > yylstate){
						lsp--;
						unput(*yylastch--);
						}
					}
				yyprevious = YYU(*yylastch);
				yylsp = lsp;
				yyleng = yylastch-yytext+1;
				yytext[yyleng] = 0;
# ifdef LEXDEBUG
				if(debug){
					fprintf(yyout,"\nmatch ");
					sprint(yytext);
					fprintf(yyout," action %d\n",*yyfnd);
					}
# endif
				return(*yyfnd++);
				}
			unput(*yylastch);
			}
		if (yytext[0] == 0  /* && feof(yyin) */)
			{
			yysptr=yysbuf;
			return(0);
			}
#ifndef __cplusplus
		yyprevious = yytext[0] = input();
		if (yyprevious>0)
			output(yyprevious);
#else
		yyprevious = yytext[0] = lex_input();
		if (yyprevious>0)
			lex_output(yyprevious);
#endif
		yylastch=yytext;
# ifdef LEXDEBUG
		if(debug)putchar('\n');
# endif
		}
	}
#if defined(__cplusplus) || defined(__STDC__)
int yyback(int *p, int m)
#else
yyback(p, m)
	int *p;
#endif
{
	if (p==0) return(0);
	while (*p) {
		if (*p++ == m)
			return(1);
	}
	return(0);
}
	/* the following are only used in the lex library */
#if defined(__cplusplus) || defined(__STDC__)
int yyinput(void)
#else
yyinput()
#endif
{
#ifndef __cplusplus
	return(input());
#else
	return(lex_input());
#endif
	}
#if defined(__cplusplus) || defined(__STDC__)
void yyoutput(int c)
#else
yyoutput(c)
  int c; 
#endif
{
#ifndef __cplusplus
	output(c);
#else
	lex_output(c);
#endif
	}
#if defined(__cplusplus) || defined(__STDC__)
void yyunput(int c)
#else
yyunput(c)
   int c; 
#endif
{
	unput(c);
	}
