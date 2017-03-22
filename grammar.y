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
											$$ = MakeTree(BodyOp, $2, $3);
										};

ClassBody_Decls						:	/* Epsilon */
										{

											$$ = NullExp();

										}
									|	Decls
										{

										};

ClassBody_MethodDecl				:	/* Epsilon */
										{
											$$ = NullExp();
										}
									|	MethodDecl
										{
											$$ = $1;
										}
									|	ClassBody_recursive MethodDecl
										{
											$$ = MakeTree(BodyOp, $1, $2); // I think this could be wrong
										};

Decls 								:	DECLARATIONSnum Decls_recursive ENDDECLARATIONSnum
										{
											$$ = $2;
										};

Decls_recursive						:	FieldDecl
										{
											$$ = $1;
										}
									|	Decls_recursive FieldDecl
										{
											$$ = MakeTree(BodyOp, $1, $2);
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
											$$ = MakeLeaf(IDNode, $1); // not sure what to do with the
											//recursion
										};

VariableDeclID_recursive			:	/* Epsilon */
										{
											$$ = NullExp();
										}
									|	LBRACnum RBRACnum VariableDeclID_recursive
										{

										};

//May be too simple, could be wrong;
VariableInitializer					:	Expression
										{
											$$ = $1;
										}
									|	ArrayInitializer
										{
											$$ = $1;
										}
									|	ArrayCreationExpression
										{
											$$ = $1;
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
											$$ = $2;
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
											$$ = NullExp();
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
											$$ = NullExp();
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
											$$ = NullExp();
										}
									|	LBRACnum RBRACnum Type_brackets
										{

										}
									|	LBRACnum RBRACnum DOTnum Type 
										{

										};

StatementList						:	LBRACEnum StatementList_recursive RBRACEnum
										{
											$$ = $2;
										};

StatementList_recursive				:	Statement
										{
											$$ = $1;
										};
									|	StatementList_recursive SEMInum Statement
										{
											$$ = MakeTree(StmtOp, $1, $3);
										};

Statement 							:	/* Epsilon */
										{
											$$ = NullExp();
										}
									|	AssignmentStatement
										{
											$$ = $1;
										}
									|	MethodCallStatement
										{
											$$ = $1;
										}
									|	ReturnStatement
										{
											$$ = $1;
										}
									|	IfStatement
										{
											$$ = $1;
										}
									|	WhileStatement
										{
											$$ = $1;
										};

AssignmentStatement					:	Variable ASSGNnum Expression
										{

				

											tree temp = MakeTree(AssignOp, NullExp(), $1);
											$$ = MakeTree(AssignOp, temp, $3);

										};

MethodCallStatement					:	Variable LPARENnum MethodCallStatement_recursive RPARENnum
										{
											$$ = MakeTree(RoutineCallOp, $1, $3);
										};

MethodCallStatement_recursive		:	/* Epsilon */
										{
											$$ = NullExp();
										}
									|	Expression
										{
											$$ = MakeTree(CommaOp, $1, NullExp());
										}
									|	MethodCallStatement COMMAnum Expression
										{
										

											$$ = MakeTree(CommaOp, $1, $3);

										};

ReturnStatement						:	RETURNnum Expression
										{
											$$ = MakeTree(ReturnOp, $2, NullExp());
										};

IfStatement							:	IFnum Expression StatementList
										{
											$$ = MakeTree(IfElseOp, $2, $3); // not sure about this one
										}
									|	IFnum Expression StatementList ELSEnum IfStatement
										{
											
										}
									|	IFnum Expression StatementList ELSEnum StatementList
										{

										};

WhileStatement						:	WHILEnum Expression StatementList
										{
											$$ = MakeTree(LoopOp,$2,$3);
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
											$$ = MkLeftC($1, $2);
										}
									|	PLUSnum Term SimpleExpression_recursive
										{
											$$ = MakeTree(AddOp, $3, $2);
										}
									|	MINUSnum Term SimpleExpression_recursive
										{
											$$ = MakeTree(SubOp, $3, $2);
										};

SimpleExpression_recursive			:	/* Epsilon */
										{
											$$ = NullExp();
										}
									|	PLUSnum Term SimpleExpression_recursive
										{
											$$ = MakeTree(AddOp, $3, $2);
										}
									|	MINUSnum Term SimpleExpression_recursive
										{
											$$ = MakeTree(SubOp, $3, $2);
										}
									|	ORnum Term SimpleExpression_recursive
										{
											$$ = MakeTree(OrOp, $3, $2);
										};

Term								:	Factor Term_recursive
										{
											$$ = MkLeftC($1, $2);
										};

Term_recursive						:	/* Epsilon */
										{
											$$ = NullExp();
										}
									|	TIMESnum Factor Term_recursive
										{
											$$ = MakeTree(MultOp, $3, $2);
										}
									|	DIVIDEnum Factor Term_recursive
										{
											$$ = MakeTree(DivOp, $3, $2);
										}
									|	ANDnum Factor Term_recursive
										{
											$$ = MakeTree(AndOp, $3, $2);
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
//I think this is correct
Variable 							:	IDnum Variable_recursive 
										{
											$$ = MakeTree(VarOp,MakeLeaf(IDNode, $1), $2);
										};
//I think this is correct
Variable_recursive 					:	/* Epsilon */
										{
											$$ = NullExp();
										}
									|	LBRACnum Variable_expression RBRACnum Variable_recursive
										{
											$$ = MakeTree(IndexOp, $2, $4);
										}
									|	DOTnum IDnum Variable_recursive
										{
											$$ = MakeTree(FieldOp, $2, $3);
										};

//guess
Variable_expression					:	Expression
										{
											$$ = $1;
										}
									|	Variable_expression COMMAnum Expression
										{
											// I do not get this one
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
