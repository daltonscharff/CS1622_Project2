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
%type <tptr> Decls_recursive VariableDeclID VariableDeclID_recursive FieldDeclId	
%type <tptr> ArrayCreationExpression_recursive FormalParameterList_recursive Type_rec
%type <tptr> StatementList_recursive MethodCallStatement_recursive SimpleExpression_recursive
%type <tptr> Term_recursive Variable_recursive Variable_expression FieldDecl_recursive
%type <tptr> ArrayInitializer_recursive FormalParameter FormalParameter_recursive 



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


ClassBody							:	LBRACEnum Decls ClassBody_MethodDecl RBRACEnum
										{
											/*$$ = MakeTree(BodyOp, $2, $3);*/
											if ($3 == NullExp()) { /* this is blester's code*/
												$$ = $2;
											}
											else {
												$$ = MkLeftC($2, $3);
											}
										};


ClassBody_MethodDecl				:	MethodDecl /*difference blester had methoddecl_z1 and another nonterminal called methoddecl*/
										{
											if($1 == NullExp())
											{
												$$ = NullExp();
											} else {
											$$ = MakeTree(BodyOp, NullExp(), $1);
											}
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

Decls_recursive						:	/* Epsilon */
										{
											$$ = NullExp();
										}
									|	Epsilon
										{
											$$ = MakeTree(BodyOp, NullExp(), NullExp());
										}
									|	FieldDecl
										{
											$$ = MakeTree(BodyOp, NullExp(), $1);
										}
									|	Decls_recursive FieldDecl
										{
											$$ = MakeTree(BodyOp, $1, $2);
										};

FieldDecl 							: 	Type FieldDecl_recursive
										{
											$$ = $2; 
										};

FieldDecl_recursive					:	FieldDeclId
										{
											$$ = MakeTree(DeclOp, NullExp(), $1);
										}
									|	FieldDecl_recursive COMMAnum FieldDeclId
										{
											$$ = MakeTree(DeclOp, $1, $3);
										};

FieldDeclId							:	VariableDeclID
										{
											tree temp = MakeTree(CommaOp, tree_type, NullExp());
											$$ = MakeTree(CommaOp, $1, temp);
										}
									|	VariableDeclID EQUALnum VariableInitializer
										{
											tree temp = MakeTree(CommaOp, tree_type, $3);
											$$ = MakeTree(CommaOp, $1, temp);
										};
VariableDeclID						:	IDnum
										{
											$$ = MakeLeaf(IDNode, $1);
										}
									|	IDnum VariableDeclID_recursive
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
										}
									|	LBRACnum RBRACnum
										{
											$$ = $$;
										};


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

ArrayInitializer_recursive			:	Expression
										{
											$$ = MakeTree(CommaOp, NullExp(), $1);
										};
									|	ArrayInitializer_recursive COMMAnum Expression
										{
											$$ = MakeTree(CommaOp, $1, $3);
										};

ArrayCreationExpression				:	INTnum ArrayCreationExpression_recursive
										{
											$$ = MakeTree(ArrayTypeOp, $2, MakeLeaf(INTEGERTNode, $1));
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
									|	METHODnum VOIDnum {tree_type = NullExp();}IDnum LPARENnum FormalParameterList RPARENnum Block
										{
											tree head = MakeTree(HeadOp, MakeLeaf(IDNode, $4), $6);
											$$ = MakeTree(MethodOp, head, $8);
										};

FormalParameterList					:	/* Epsilon */
										{
											$$ = MakeTree(SpecOp, NullExp(), tree_type);
										}
									| FormalParameterList_recursive
										{
											$$ = MakeTree(SpecOp, $1, tree_type);
										};


FormalParameterList_recursive		:	FormalParameter
										{
											$$ = $1;
										}
									| FormalParameter SEMInum FormalParameterList_recursive
										{
											$$ = MkRightC($3, $1);
										};
FormalParameter						:	VALnum INTnum  FormalParameterList_recursive
										{
	                                        $$ = $3;
										} 
									|   INTnum FormalParameter_recursive
										{
											$$ = $2;
										};
										
FormalParameter_recursive			:	IDnum
										{
											tree temp = MakeTree(CommaOp, MakeLeaf(IDNode, $1), MakeLeaf(INTEGERTNode, 0));
											$$ = MakeTree(RArgTypeOp, temp, NullExp()); /* github code */
										}
									|	IDnum COMMAnum FormalParameter_recursive
										{
											tree temp = MakeTree(CommaOp, MakeLeaf(IDNode, $1), MakeLeaf(INTEGERTNode, 0));
											tree fp = MakeTree(RArgTypeOp, temp, NullExp());
											$$ = MkRightC($3, fp);
										};

Block								:	Decls StatementList
										{
											$$ = MakeTree(BodyOp, $1, $2);
										}
									|	StatementList
										{
											$$ = MakeTree(BodyOp, NullExp(), $1);
										};

Type								:	
										IDnum Type_rec
										{
											$$ = tree_type = MakeTree(TypeIdOp, MakeLeaf(IDNode, $1), $2);
										}
									|	INTnum Type_rec
										{
											$$ = tree_type = MakeTree(TypeIdOp, MakeLeaf(INTEGERTNode, $1), $2);
										}
									|	IDnum Type_rec DOTnum Type
										{
											tree temp = MakeTree(TypeIdOp, MakeLeaf(IDNode, $1), $2);
											tree temp2 = MakeTree(SelectOp, $4, NullExp());
											$$ = tree_type = MkRightC(temp,temp2);
										}
									|	INTnum Type_rec DOTnum Type
										{
											tree temp = MakeTree(TypeIdOp, MakeLeaf(INTEGERTNode, $1), $2);
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
											MakeTree(IndexOp, NullExp(), $1);
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
											if ($3 == NullExp()) {
												$$ = $1;
											} else { 
												$$ = MakeTree(StmtOp, $1, $3);
											}
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
									|	Expression COMMAnum MethodCallStatement_recursive
										{
											$$ = MakeTree(CommaOp, $1, $3);
										};

ReturnStatement						:	RETURNnum Expression
										{
											$$ = MakeTree(ReturnOp, $2, NullExp());
										}
									|	RETURNnum
										{
											$$ = MakeTree(ReturnOp, NullExp(), NullExp());
										};

IfStatement							:	IFnum Expression StatementList
										{
											tree temp = MakeTree(CommaOp, $2, $3);
											$$ = MakeTree(IfElseOp, NullExp(), temp); 
										}
							/*		|	IFnum Expression StatementList ELSEnum IfStatement
										{
											tree temp = MakeTree(CommaOp, $2, $3);
											$$ = MakeTree(IfElseOp, NullExp(), temp);
										} */
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
											if ($2 == NullExp()) {
												$$ = $1;
											} else {
												$$ = MkLeftC($1, $2);
											}
										}
									|	PLUSnum Term SimpleExpression_recursive
										{
											if ($3 == NullExp()) {
												$$ = $2;
											} else {
												$$ = MkLeftC($2, $3);
											}
										}
									|	MINUSnum Term SimpleExpression_recursive
										{
											tree neg = MakeTree(UnaryNegOp, $2, NullExp()); /* github code */
											if ($3 == NullExp()) {
												$$ = neg;
											} else {
												$$ = MkLeftC(neg, $3);
											}
										};

SimpleExpression_recursive			:	/* Epsilon */
										{
											$$ = NullExp();
										}
									|	PLUSnum Term SimpleExpression_recursive
										{
											//$$ = MakeTree(AddOp, $3, $2);
											if($2 == NullExp())
											{
												$$ = MakeTree(AddOp, NullExp(), $2);
											} else {
											tree temp = MakeTree(AddOp, NullExp(), $2);
											$$ = MkLeftC(temp, $3);
											}
										}
									|	MINUSnum Term SimpleExpression_recursive
										{
											//$$ = MakeTree(SubOp, $3, $2);
											if($2 == NullExp())
											{
												$$ = MakeTree(SubOp, NullExp(), $2);
											} else {
											tree temp = MakeTree(SubOp, NullExp(), $2);
											$$ = MkLeftC(temp, $3);
											}
										}
									|	ORnum Term SimpleExpression_recursive
										{
										//	$$ = MakeTree(OrOp, $3, $2);
											if($2 == NullExp())
											{
												$$ = MakeTree(OrOp, NullExp(), $2);
											} else {
											tree temp = MakeTree(OrOp, NullExp(), $2);
											$$ = MkLeftC(temp, $3);
											}
										};

Term								:	Factor Term_recursive
										{
										//	$$ = MkLeftC($1, $2); /* github code */
											if ($2 == NullExp()) {
												$$ = $1;
											} else {
												$$ = MkLeftC($1, $2);
											}
										};

Term_recursive						:	/* Epsilon */
										{
											$$ = NullExp();
										}
									|	TIMESnum Factor Term_recursive
										{
											//$$ = MakeTree(MultOp, $3, $2);
											if($2 == NullExp())
											{
												$$ = MakeTree(MultOp, NullExp(), $2);
											} else {
											tree temp = MakeTree(MultOp, NullExp(), $2);
											$$ = MkLeftC(temp, $3);
											}
										}
									|	DIVIDEnum Factor Term_recursive
										{
											//$$ = MakeTree(DivOp, $3, $2);
											if($2 == NullExp())
											{
												$$ = MakeTree(DivOp, NullExp(), $2);
											} else {
											tree temp = MakeTree(DivOp, NullExp(), $2);
											$$ = MkLeftC(temp, $3);
											}
										}
									|	ANDnum Factor Term_recursive
										{
											//$$ = MakeTree(AndOp, $3, $2);
											if($2 == NullExp())
											{
												$$ = MakeTree(AndOp, NullExp(), $2);
											} else {
											tree temp = MakeTree(AndOp, NullExp(), $2);
											$$ = MkLeftC(temp, $3);
											}
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
											$$ = MakeTree(SelectOp, $2, $4); 
										}
									|	DOTnum IDnum Variable_recursive
										{
											tree temp = MakeTree(FieldOp, MakeLeaf(IDNode, $2), NullExp());
											$$ = MakeTree(SelectOp, temp, $3);
										};

Variable_expression					:	Expression
										{
											$$ = MakeTree(IndexOp, $1, NullExp());
										}
									|	Expression COMMAnum Variable_expression
										{
											$$ = MakeTree(IndexOp, $1, $3);;
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