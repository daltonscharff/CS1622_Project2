%{ /* definition */
#include "proj2.h"
#include <stdio.h>

	tree tree_type;
%}

%token <intg> ANDnum ASSGNnum DECLARATIONSnum DOTnum ENDDECLARATIONSnum EQUALnum
%token <intg> GTnum IDnum INTnum LBRACnum LPARENnum METHODnum NEnum ORnum PROGRAMnum
%token <intg> RBRACnum RPARENnum SEMInum VALnum WHILEnum CLASSnum COMMAnum DIVIDEnum ELSEnum
%token <intg> EQnum GEnum ICONSTnum IFnum LBRACEnum LEnum LTnum MINUSnum NOTnum PLUSnum
%token <intg> RBRACEnum RETURNnum SCONSTnum TIMESnum VOIDnum

%type <tptr> Program ClassDecl ClassBody Decls FieldDecl VariableInitializer
%type <tptr> ArrayInitializer ArrayCreationExpression MethodDecl FormalParameterList Block Type
%type <tptr> StatementList Statement AssignmentStatement MethodCallStatement ReturnStatement 
%type <tptr> IfStatement WhileStatement Expression SimpleExpression Term Factor UnsignedConstant
%type <tptr> Variable ClassDecl_recursive ClassBody_Decls ClassBody_MethodDecl
%type <tptr> Decls_recursive VariableDeclID VariableDeclID_recursive
%type <tptr> ArrayCreationExpression_recursive FormalParameterList_recursive Type_rec
%type <tptr> StatementList_recursive IfStatement MethodCallStatement_recursive SimpleExpression_recursive
%type <tptr> Term_recursive Variable_recursive Variable_expression FieldDecl_recursive
%type <tptr> ArrayInitializer_recursive 



%% /* yacc specification */

Program 							:	PROGRAMnum IDnum SEMInum ClassDecl_recursive
										{
											$$ = MakeTree(ProgramOp, $4, MakeLeaf(IDNode, $2));
											printtree($$, 0);
										};

ClassDecl_recursive					:	ClassDecl
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
											/*$$ = MakeTree(BodyOp, $2, $3);*/
											if ($3 == NullExp()) { /* this is blester's code*/
												$$ = $2;
											}
											else {
												$$ = MkLeftC($2, $3);
											}
										};

ClassBody_Decls						:	/* Epsilon */
										{

											$$ = NullExp();

										}
									|	Decls
										{
											$$ = $1;
										};

ClassBody_MethodDecl				:	/* Epsilon */
										{
											$$ = NullExp();
										}
									|	MethodDecl /*difference blester had methoddecl_z1 and another nonterminal called methoddecl*/
										{
											$$ = $1;
										}
									|	ClassBody_MethodDecl MethodDecl // I think this is causing the shift reduce conflict
										{
											$$ = MakeTree(BodyOp, $1, $2); 
										};

Decls 								:	/* Epsilon */
										{
											$$ = NullExp();
										}

									|	DECLARATIONSnum Decls_recursive ENDDECLARATIONSnum
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
											$$ = $2; //what to do with type
										};

FieldDecl_recursive					:	SEMInum
										{
											$$ = NullExp();
										}
									|	VariableDeclID EQUALnum VariableInitializer COMMAnum FieldDecl_recursive
										{
/**/
										}
									|	VariableDeclID EQUALnum VariableInitializer SEMInum
										{
/**/
										}
									|	VariableDeclID COMMAnum FieldDecl_recursive
										{
											$$ = MakeTree(DeclOp, $1, $3);
										}
									|	VariableDeclID SEMInum
										{
											$$ = $1;
										};

VariableDeclID						:	IDnum
										{
											$$ = MakeLeaf(IDNode, $1);
										}
									|	IDnum LBRACnum RBRACnum VariableDeclID_recursive
										{
											$$ = MakeLeaf(IDNode, $1); 
										};

VariableDeclID_recursive			:	/* Epsilon */
										{
											$$ = NullExp();
										}
									|	LBRACnum RBRACnum VariableDeclID_recursive
										{
											$$ = $$;
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
											$$ = MakeTree(ArrayTypeOp, $2, tree_type);
										};

ArrayInitializer_recursive			:	VariableInitializer
										{
											$$ = MakeTree(CommaOp, NullExp(), $1);
										};
									|	ArrayInitializer_recursive COMMAnum VariableInitializer
										{
											$$ = MakeTree(CommaOp, $1, $3);
										};

ArrayCreationExpression				:	INTnum ArrayCreationExpression_recursive
										{
											$$ = MakeTree(ArrayTypeOp, $2, MakeLeaf(NUMNode, $1));
										};

ArrayCreationExpression_recursive	:	LBRACnum Expression RBRACnum
										{
											$$ = $2;
										}
									|	LBRACnum Expression RBRACnum ArrayCreationExpression_recursive
										{
											$$ = MakeTree(BoundOp, $4, $2);
										};

MethodDecl 							:	METHODnum Type IDnum LPARENnum FormalParameterList RPARENnum Block
										{
											tree head = MakeTree(HeadOp, MakeLeaf(IDNode, $3), $5);
											$$ = MakeTree(MethodOp, head, $7);
										}
									|	METHODnum VOIDnum IDnum LPARENnum FormalParameterList RPARENnum Block
										{
											tree_type = NullExp();
											tree head = MakeTree(HeadOp, MakeLeaf(IDNode, $3), $5);
											$$ = MakeTree(MethodOp, head, $7);
										};

FormalParameterList					:	/* Epsilon */
										{
											$$ = MakeTree(SpecOp, NullExp(), tree_type);
										}
									|	VALnum INTnum  FormalParameterList_recursive
										{
	                                        $$ = $3;
										};


FormalParameterList_recursive		:	/* Epsilon */
										{
											$$ = NullExp();
										};
									|	SEMInum FormalParameterList
										{
											$$ = $2;
										};

Block								:	Decls StatementList
										{
											$$ = MakeTree(BodyOp, $1, $2);
										};

Type								:	
										IDnum Type_rec
										{
											$$ = tree_type = MakeTree(TypeIdOp, MakeLeaf(IDNode, $1), $2);
										}
									|	INTnum Type_rec
										{
											$$ = tree_type = MakeTree(TypeIdOp, MakeLeaf(NUMNode, $1), $2);
										}
									|	IDnum Type_rec DOTnum Type
										{
											tree temp = MakeTree(TypeIdOp, MakeLeaf(IDNode, $1), $2);
											tree temp2 = MakeTree(FieldOp, $4, NullExp());
											$$ = tree_type = MkRightC(temp,temp2);
										}
									|	INTnum Type_rec DOTnum Type
										{
											tree temp = MakeTree(TypeIdOp, MakeLeaf(NUMNode, $1), $2);
											tree temp2 = MakeTree(FieldOp, $4, NullExp());
											$$ = tree_type = MkRightC(temp,temp2);
										};

Type_rec							:	/* Epsilon */
										{
											$$ = tree_type = NullExp();
										}
									|	LBRACnum RBRACnum
										{
											$$ = tree_type = MakeTree(IndexOp, NullExp(), NullExp());
										}
									|	Type_rec LBRACnum RBRACnum
									{
										$$ = tree_type = MakeTree(IndexOp, NullExp(), $1);
									};

StatementList						:	LBRACEnum StatementList_recursive RBRACEnum
										{
											$$ = $2;
										};

StatementList_recursive				:	/* Episilon */
										{
											$$ = NullExp();
										}
									|	Statement
										{
											$$ = MakeTree(StmtOp, NullExp(), $1);
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
											tree temp = MakeTree(CommaOp, $2, $3);
											$$ = MakeTree(IfElseOp, NullExp(), temp); // not sure about this one
										}
									|	IFnum Expression StatementList ELSEnum IfStatement
										{
											tree temp = MakeTree(CommaOp, $2, $3);
											$$ = MakeTree(IfElseOp, NullExp(), temp);
										}
									|	IFnum Expression StatementList ELSEnum StatementList
										{
											tree temp = MakeTree(CommaOp, $2, $3);
											tree temp2 = MakeTree(IfElseOp, NullExp(), temp);
											$$ = MakeTree(IfElseOp, temp2, $5);
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

Variable 							:	IDnum Variable_recursive 
										{
											$$ = MakeTree(VarOp,MakeLeaf(IDNode, $1), $2);
										};

Variable_recursive 					:	/* Epsilon */
										{
											$$ = NullExp();
										}
									|	LBRACnum Variable_expression RBRACnum Variable_recursive
										{
											$$ = MakeTree(IndexOp, $4, $2); 
										}
									|	DOTnum IDnum Variable_recursive
										{
											$$ = MakeTree(FieldOp, MakeLeaf(IDNode, $2), $3);
										};

Variable_expression					:	Expression
										{
											$$ = $1;
										}
									|	Variable_expression COMMAnum Expression
										{
											$$ = MakeTree(IndexOp, $1, MakeTree(IndexOp, $3, NullExp()));
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

#include "lex.yy.c"