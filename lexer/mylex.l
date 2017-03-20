%{
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

%}

/* regular definitions */

id            		[a-zA-Z]+([a-zA-Z]|[0-9])*
badid				[0-9]+([a-zA-Z]|[0-9])*
ws            		(\t)+|(" ")+ 
newline       		[\n]
and					&&
assign				:=
declarations		(D|d)(E|e)(C|c)(L|l)(A|a)(R|r)(A|a)(T|t)(I|i)(O|o)(N|n)(S|s)
dot					\.
enddeclarations		(E|e)(N|n)(D|d)(D|d)(E|e)(C|c)(L|l)(A|a)(R|r)(A|a)(T|t)(I|i)(O|o)(N|n)(S|s)
equal				\=
gt					>
int					(I|i)(N|n)(T|t)
lbrac				\[
lparen				\(
method				(M|m)(E|e)(T|t)(H|h)(O|o)(D|d)
ne					!=
or					\|\|
program				(P|p)(R|r)(O|o)(G|g)(R|r)(A|a)(M|m)
rbrac				\]
rparen				\)
semi				;
val					(V|v)(A|a)(L|l)
while				(W|w)(H|h)(I|i)(L|l)(E|e)
class				(C|c)(L|l)(A|a)(S|s)(S|s)
comma				\,
divide				\/
else				(E|e)(L|l)(S|s)(E|e)
eq					\=\=
ge					>\=
iconst				([0-9]+(.)?[0-9]*)|((.)?[0-9]+)
if					(I|i)(F|f)
lbrace				\{
le					<=
lt					<
minus				-
not					!
plus				\+
rbrace				\}
return				(R|r)(E|e)(T|t)(U|u)(R|r)(N|n)
sconst				'(\\.|[^\\'])*'
times				\*
void				(V|v)(O|o)(I|i)(D|d)
eof					\Z
comment				("/*")((.)|[\n])*("*/")
commentbegin		("/*")
commentend			("*/")

%%
{comment}				{yycolumn += yyleng; parseComment();}
{commentbegin}			{yycolumn += yyleng; reportError("Unpaired Comment", yyline, yycolumn);}
{commentend}			{yycolumn += yyleng; reportError("Unpaired Comment", yyline, yycolumn);}
{newline}           	{yyline++; yycolumn = 0;}
{ws}					{yycolumn += yyleng;}
{program}				{yycolumn += yyleng; return (PROGRAMnum);}
{semi}					{yycolumn += yyleng; return (SEMInum);}
{class}					{yycolumn += yyleng; return (CLASSnum);}
{lbrace}				{yycolumn += yyleng; return (LBRACEnum);}
{method}				{yycolumn += yyleng; return (METHODnum);}
{void}					{yycolumn += yyleng; return (VOIDnum);}
{lparen}				{yycolumn += yyleng; return (LPARENnum);}
{rparen}				{yycolumn += yyleng; return (RPARENnum);}
{badid}					{yycolumn += yyleng; reportError("ID Name", yyline, yycolumn);}
{iconst}				{yycolumn += yyleng; yylval.intg = atoi(yytext); return(ICONSTnum);}
{dot}					{yycolumn += yyleng; return (DOTnum);}
{sconst}				{yycolumn += yyleng; return (SCONSTnum);}
{rbrace}				{yycolumn += yyleng; return (RBRACEnum);}
{if}					{yycolumn += yyleng; return (IFnum);}
{times}					{yycolumn += yyleng; return (TIMESnum);}
{plus}					{yycolumn += yyleng; return (PLUSnum);}
{not}					{yycolumn += yyleng; return (NOTnum);}
{minus}					{yycolumn += yyleng; return (MINUSnum);}
{lt}					{yycolumn += yyleng; return (LTnum);}
{le}					{yycolumn += yyleng; return (LEnum);}
{ge}					{yycolumn += yyleng; return (GEnum);}
{eq}					{yycolumn += yyleng; return (EQnum);}
{else}					{yycolumn += yyleng; return (ELSEnum);}
{divide}				{yycolumn += yyleng; return (DIVIDEnum);}
{comma}					{yycolumn += yyleng; return (COMMAnum);}
{while}					{yycolumn += yyleng; return (WHILEnum);}
{val}					{yycolumn += yyleng; return (VALnum);}
{rbrac}					{yycolumn += yyleng; return (RBRACnum);}
{or}					{yycolumn += yyleng; return (ORnum);}
{ne}					{yycolumn += yyleng; return (NEnum);}
{lbrac}					{yycolumn += yyleng; return (LBRACnum);}
{int}					{yycolumn += yyleng; return (INTnum);}
{gt}					{yycolumn += yyleng; return (GTnum);}
{equal}					{yycolumn += yyleng; return (EQUALnum);}
{enddeclarations}		{yycolumn += yyleng; return (ENDDECLARATIONSnum);}
{declarations}			{yycolumn += yyleng; return (DECLARATIONSnum);}
{assign}				{yycolumn += yyleng; return (ASSGNnum);}
{and}					{yycolumn += yyleng; return (ANDnum);}
{return}				{yycolumn += yyleng; return (RETURNnum);}
{id}			    	{yycolumn += yyleng; return (IDnum);}
{eof}					{yycolumn = 0; return (EOFnum);}
.						{yycolumn += yyleng; reportError("Syntax", yyline, yycolumn);}				


%%

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
