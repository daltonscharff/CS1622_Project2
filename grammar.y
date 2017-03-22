%{ /* definition */
#include "proj2.h"
#include <stdio.h>
%}

%token <intg> ANDnum ASSGNnum DECLARATIONSnum DOTnum ENDDECLARATIONSnum EQUALnum
%token <intg> GTnum IDnum INTnum LBRACnum LPARENnum METHODnum NEnum ORnum PROGRAMnum
%token <intg> RBRACnum RPARENnum SEMInum VALnum WHILEnum CLASSnum COMMAnum DIVIDEnum ELSEnum
%token <intg> EQnum GEnum ICONSTnum IFnum LBRACEnum LEnum LTnum MINUSnum NOTnum PLUSnum
%token <intg> RBRACEnum RETURNnum SCONSTnum TIMESnum VOIDnum

%type <tptr> Program ClassDecl ClassBody Decls FieldDecl VariableDeclld VariableInitializer
%type <tptr> ArrayInitializer ArrayCreationExpression MethodDecl FormalParameterList Block Type
%type <tptr> StatementList Statement AssignmentStatement MethodCallStatement ReturnStatement 
%type <tptr> IfStatementd WhileStatement Expression SimpleExpression Term Factor UnsignedConstant
%type <tptr> Variable

%% /* yacc specification */

Program 							:	PROGRAMnum IDnum SEMInum Program_recursive
										{
											$$ = MakeTree(ProgramOp, $4, MakeLeaf(IDNode, $2));
											printtree($$, 0);
										};
										
Program_recursive					:	ClassDecl
										{
											$$ = MakeTree(ClassOp, NullExp(), $1);
										}
									|	ClassDecl_recursive ClassDecl
										{
											$$ = MakeTree(ClassOp, $1, $2);
										};

ClassDecl							:	CLASSnum IDnum ClassBody
										{
											$$ = MakeTree(ClassDefOp, $3, MakeLeaf(IDNode, $2));
										};

ClassBody							:	LBRACEnum ClassBody_Decls ClassBody_MethodDecl RBRACEnum
										{

										};

ClassBody_Decls						:	/* Epsilon */
										{

										}
									|	Decls
										{

										};

ClassBody_MethodDecl				:	/* Epsilon */
										{

										}
									|	MethodDecl
										{

										}
									|	ClassBody_recursive MethodDecl
										{

										};

Decls 								:	DECLARATIONSnum Decls_recursive ENDDECLARATIONSnum
										{

										};

Decls_recursive						:	FieldDecl
										{

										}
									|	Decls_recursive FieldDecl
										{

										};

FieldDecl 							: 	Type FieldDecl_recursive
										{

										};

FieldDecl_recursive					:	SEMInum
										{

										}
									|	VariableDeclID EQUALnum VariableInitializer COMMAnum FieldDecl_recursive
										{

										}
									|	VariableDeclID EQUALnum VariableInitializer SEMInum
										{

										}
									|	VariableDeclID COMMAnum FieldDecl_recursive
										{

										}
									|	VariableDeclID SEMInum
										{

										};

VariableDeclID						:	IDnum
										{
											$$ = MakeLeaf(IDNode, $1);
										}
									|	IDnum LBRACnum RBRACnum VariableDeclID_recursive
										{

										};

VariableDeclID_recursive			:	/* Epsilon */
										{

										}
									|	LBRACnum RBRACnum VariableDeclID_recursive
										{

										};

VariableInitializer					:	Expression
										{

										}
									|	ArrayInitializer
										{

										}
									|	ArrayCreationExpression
										{

										};

ArrayInitializer					: 	LBRACEnum ArrayInitializer_recursive RBRACEnum
										{

										};

ArrayInitializer_recursive			:	VariableInitializer
										{

										};
									|	VariableInitializer_rec COMMAnum VariableInitializer
										{

										};

ArrayCreationExpression				:	INTnum ArrayCreationExpression_recursive
										{

										};

ArrayCreationExpression_recursive	:	LBRACnum Expression RBRACnum
										{

										}
									|	LBRACnum Expression RBRACnum ArrayCreationExpression_recursive
										{

										};

MethodDecl 							:	METHODnum Type IDnum LPARENnum FormalParameterList RPARENnum Block
										{

										}
									|	METHODnum VOIDnum IDnum LPARENnum FormalParameterList RPARENnum Block
										{

										};

FormalParameterList					:	/* Epsilon */
										{

										}
									|	VALnum INTnum FormalParameterList_IDnum FormalParameterList_recursive
										{

										}

FormalParameterList_IDnum			:	IDnum
										{

										}
									|	FormalParameterList_IDnum COMMAnum IDnum
										{

										};

FormalParameterList_recursive		:	/* Epsilon */
										{

										};
									|	SEMInum FormalParameterList
										{

										};

Block								:	Decls StatementList
										{
											$$ = MakeTree(BodyOp, $1, $2);
										};

Type								:	IDnum Type_brackets
										{

										}
									|	INTnum Type_brackets
										{

										};

Type_brackets						:	/* Epsilon */
										{

										}
									|	LBRACnum RBRACnum Type_brackets
										{

										}
									|	LBRACnum RBRACnum DOTnum Type 
										{

										};

StatementList						:	LBRACEnum StatementList_recursive RBRACEnum
										{

										};

StatementList_recursive				:	Statement
										{

										};
									|	StatementList_recursive SEMInum Statement
										{

										};

Statement 							:	/* Epsilon */
										{

										}
									|	AssignmentStatement
										{

										}
									|	MethodCallStatement
										{
											
										}
									|	ReturnStatement
										{
											
										}
									|	IfStatement
										{
											
										}
									|	WhileStatement
										{
											
										};

AssignmentStatement					:	Variable ASSGNnum Expression
										{

										};

MethodCallStatement					:	Varaible LPARENnum MethodCallStatement_recursive RPARENnum
										{

										};

MethodCallStatement_recursive		:	/* Epsilon */
										{

										}
									|	Expression
										{

										}
									|	MethodCallStatement COMMAnum Expression
										{

										};

ReturnStatement						:	RETURNnum Expression
										{
											$$ = MakeTree(ReturnOp, $2, NullExp());
										};

IfStatement							:	IFnum Expression StatementList
										{

										}
									|	IFnum Expression StatementList ELSEnum IfStatement
										{

										}
									|	IFnum Expression StatementList ELSEnum StatementList
										{

										};

WhileStatement						:	WHILEnum Expression StatementList
										{

										};

Expression 							:	SimpleExpression
										{
											$$ = $1;
										}
									|	SimpleExpression LTnum SimpleExpression
										{
											$$ = MakeTree(LTOp, $1, $3);
										}
									|	SimpleExpression LEnum SimpleExpression
										{
											$$ = MakeTree(LEOp, $1, $3);
										}
									|	SimpleExpression EQnum SimpleExpression
										{
											$$ = MakeTree(EQOp, $1, $3);
										}
									|	SimpleExpression NEnum SimpleExpression
										{
											$$ = MakeTree(NEOp, $1, $3);
										}
									|	SimpleExpression GEnum SimpleExpression
										{
											$$ = MakeTree(GEOp, $1, $3);
										}
									|	SimpleExpression GTnum SimpleExpression
										{
											$$ = MakeTree(GTOp, $1, $3);
										};

SimpleExpression					:	Term SimpleExpression_recursive
										{

										}
									|	PLUSnum Term SimpleExpression_recursive
										{

										}
									|	MINUSnum Term SimpleExpression_recursive
										{

										};

SimpleExpression_recursive			:	/* Epsilon */
										{

										}
									|	PLUSnum Term SimpleExpression_recursive
										{

										}
									|	MINUSnum Term SimpleExpression_recursive
										{

										}
									|	ORnum Term SimpleExpression_recursive
										{

										};

Term								:	Factor Term_recursive
										{

										};

Term_recursive						:	/* Epsilon */
										{

										}
									|	TIMESnum Factor Term_recursive
										{

										}
									|	DIVIDEnum Factor Term_recursive
										{
											
										}
									|	ANDnum Factor Term_recursive
										{
											
										};

Factor								:	UnsignedConstant
										{
											$$ = $1;
										}
									|	Variable 
										{
											$$ = $1;
										}
									|	MethodCallStatement 
										{
											$$ = $1;
										}
									|	LPARENnum Expression RPARENnum
										{
											$$ = $2;
										}
									|	NOTnum Factor
										{
											$$ = MakeTree(NotOp, $2, NullExp());
										};

UnsignedConstant					:	ICONSTnum
										{
											$$ = MakeLeaf(NUMNode, $1);
										}
									|	SCONSTnum
										{
											$$ = MakeLeaf(STRINGNode, $1);
										};

Variable 							:	IDnum Variable_recursive 
										{

										};

Variable_recursive 					:	/* Epsilon */
										{

										}
									|	LBRACnum Variable_expression RBRACnum Variable_recursive
										{

										}
									|	DOTnum IDnum Variable_recursive
										{

										};

Variable_expression					:	Expression
										{

										}
									|	Variable_expression COMMAnum Expression
										{

										};

%% /* C code */

int yycolumn, yyline;
FILE* treelst;

main(){
	treelst = stdout;
	yyparse();
}

yyerror(char* str){
	printf("yyerror: %s at line %d\n", str, yyline);
}

#include "lexer/lex.yy.c"
