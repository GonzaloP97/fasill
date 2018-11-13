<div class="container py-2 px-0"><h4 id="wmgu/3"><a href="/fasill/documentation/src/semantics#wmgu/3">wmgu/3</a></h4><?php echo show_template("wmgu(+ExpressionA, +ExpressionB, ?State)"); ?><p><?php echo show_description("This predicate returns the weak most general unifier (wmgu) ?State of the expressions +ExpressionA and +ExpressionB."); ?></p></div>
<div class="container py-2 px-0"><h4 id="mgu/3"><a href="/fasill/documentation/src/semantics#mgu/3">mgu/3</a></h4><?php echo show_template("mgu(+ExpressionA, +ExpressionB, ?MGU)"); ?><p><?php echo show_description("This predicate returns the most general unifier (mgu) ?MGU of the expressions +ExpressionA and +ExpressionB."); ?></p></div>
<div class="container py-2 px-0"><h4 id="is_fuzzy_computed_answer/1"><a href="/fasill/documentation/src/semantics#is_fuzzy_computed_answer/1">is_fuzzy_computed_answer/1</a></h4><?php echo show_template("is_fuzzy_computed_answer(+Expression)"); ?><p><?php echo show_description("This predicate succeeds when +Expression is a (symbolic) fuzzy computed answer."); ?></p></div>
<div class="container py-2 px-0"><h4 id="select_atom/4"><a href="/fasill/documentation/src/semantics#select_atom/4">select_atom/4</a></h4><?php echo show_template("select_atom(+Expression, ?ExprVar, ?Var, ?Atom)"); ?><p><?php echo show_description("This predicate selects an atom ?Atom from the expression +Expression, where ?ExprVar is the expression +Expression with the variable ?Var instead of the atom ?Atom."); ?></p></div>
<div class="container py-2 px-0"><h4 id="select_expression/4"><a href="/fasill/documentation/src/semantics#select_expression/4">select_expression/4</a></h4><?php echo show_template("select_expression(+Expression, ?ExprVar, ?Var, ?Atom)"); ?><p><?php echo show_description("This predicate selects an interpretable expression ?Atom from the expression +Expression, where ?ExprVar is the expression +Expression with the variable ?Var instead of the atom ?Atom."); ?></p></div>
<div class="container py-2 px-0"><h4 id="interpretable/1"><a href="/fasill/documentation/src/semantics#interpretable/1">interpretable/1</a></h4><?php echo show_template("interpretable(+Expression)"); ?><p><?php echo show_description("This predicate succeeds when the expression +Expression can be interpreted (i.e., there is no atoms in the expression)."); ?></p></div>
<div class="container py-2 px-0"><h4 id="query/2"><a href="/fasill/documentation/src/semantics#query/2">query/2</a></h4><?php echo show_template("query(+Goal, ?Answer)"); ?><p><?php echo show_description("This predicate succeeds when ?Answer is a fuzzy computed answer (fca) for the goal +Goal. A fca is a term of the form state(TD, Substitution), where TD is the truth degree."); ?></p></div>
<div class="container py-2 px-0"><h4 id="get_variables/2"><a href="/fasill/documentation/src/semantics#get_variables/2">get_variables/2</a></h4><?php echo show_template("get_variables(+Term, ?Variables)"); ?><p><?php echo show_description("This predicate succeeds when ?Variables is the initial substitution for the term +Term, where each variable in +Term is replaced by itself (X/X)."); ?></p></div>
<div class="container py-2 px-0"><h4 id="derivation/4"><a href="/fasill/documentation/src/semantics#derivation/4">derivation/4</a></h4><?php echo show_template("derivation(+From, +State1, ?State2, ?Info)"); ?><p><?php echo show_description("This predicate performs a complete derivation from an initial state ?State1 to the final state ?State2, using the program +Program. ?Info is a list containing the information of each step."); ?></p></div>
<div class="container py-2 px-0"><h4 id="inference/4"><a href="/fasill/documentation/src/semantics#inference/4">inference/4</a></h4><?php echo show_template("inference(+From, +State1, ?State2, ?Info)"); ?><p><?php echo show_description("This predicate performs an inference step from the initial state +State1 to the final step ?State2. ?Info is an atom containg information about the rule used in the derivation."); ?></p></div>
<div class="container py-2 px-0"><h4 id="admissible_step/4"><a href="/fasill/documentation/src/semantics#admissible_step/4">admissible_step/4</a></h4><?php echo show_template("admissible_step(+From, +State1, ?State2, ?Info)"); ?><p><?php echo show_description("This predicate performs an admissible step from the state +State1 to the state ?State2. ?Info is an atom containg information about the rule used in the derivation."); ?></p></div>
<div class="container py-2 px-0"><h4 id="success_step/4"><a href="/fasill/documentation/src/semantics#success_step/4">success_step/4</a></h4><?php echo show_template("success_step(+From, +State1, ?State2, ?Info)"); ?><p><?php echo show_description("This predicate performs a successful admissible step from the state +State1 to the state ?State2. ?Info is an atom containg information about the rule used in the derivation."); ?></p></div>
<div class="container py-2 px-0"><h4 id="failure_step/3"><a href="/fasill/documentation/src/semantics#failure_step/3">failure_step/3</a></h4><?php echo show_template("failure_step(+State1, ?State2, ?Info)"); ?><p><?php echo show_description("This predicate performs an unsuccessful admissible step from the state +State1 to the state ?State2. ?Info is an atom containg information about the failure."); ?></p></div>
<div class="container py-2 px-0"><h4 id="interpretive_step/4"><a href="/fasill/documentation/src/semantics#interpretive_step/4">interpretive_step/4</a></h4><?php echo show_template("interpretive_step(+From, +State1, ?State2, ?Info)"); ?><p><?php echo show_description("This predicate performs an interpretive step from the state +State1 to the state ?State2 ?Info is an atom containg information about the derivation. This steps only can be performed when there is no atoms to perform admissible steps."); ?></p></div>
<div class="container py-2 px-0"><h4 id="interpret/2"><a href="/fasill/documentation/src/semantics#interpret/2">interpret/2</a></h4><?php echo show_template("interpret(+Expression, ?Result)"); ?><p><?php echo show_description("This predicate interprets the expression +Expression in the expression. ?Result is the resulting expression."); ?></p></div>
<div class="container py-2 px-0"><h4 id="rename/2"><a href="/fasill/documentation/src/semantics#rename/2">rename/2</a></h4><?php echo show_template("rename(+Expression, ?Renamed)"); ?><p><?php echo show_description("This predicate renames the expression +Expression, replacing the variables of the expression by fresh variables. ?Renamed is the expression +Expression with fresh variables."); ?></p></div>
<div class="container py-2 px-0"><h4 id="compose/3"><a href="/fasill/documentation/src/semantics#compose/3">compose/3</a></h4><?php echo show_template("compose(+Substitution1, +Substitution2, ?SubstitutionOut)"); ?><p><?php echo show_description("This predicate composes both substitutions, +Substitution1 and +Substitution2 in ?SubstitutionOut."); ?></p></div>
<div class="container py-2 px-0"><h4 id="apply/3"><a href="/fasill/documentation/src/semantics#apply/3">apply/3</a></h4><?php echo show_template("apply(+ExpressionIn, +Substitution, ?ExpressionOut)"); ?><p><?php echo show_description("This predicate applies the substitution +Substitution to the expression +ExpressionIn. ?ExpressionOut is the resulting expression."); ?></p></div>
<div class="container py-2 px-0"><h4 id="arithmetic_evaluation/3"><a href="/fasill/documentation/src/semantics#arithmetic_evaluation/3">arithmetic_evaluation/3</a></h4><?php echo show_template("arithmetic_evaluation(+Indicator, +Expression, ?Result)"); ?><p><?php echo show_description("This predicate succeeds when ?Result is the result of evaluating the expression +Expression. This predicate throws an arithmetical exception if there is any problem."); ?></p></div>
<div class="container py-2 px-0"><h4 id="arithmetic_comparison/3"><a href="/fasill/documentation/src/semantics#arithmetic_comparison/3">arithmetic_comparison/3</a></h4><?php echo show_template("arithmetic_comparison(+Op, +Expression1, +Expression2)"); ?><p><?php echo show_description("This predicate succeeds when expressions +Expression1 and +Expression2, evaluated as much as possible, fulfill the ordering relation +Op."); ?></p></div>
<div class="container py-2 px-0"><h4 id="arithmetic_type/2"><a href="/fasill/documentation/src/semantics#arithmetic_type/2">arithmetic_type/2</a></h4><?php echo show_template("arithmetic_type(+Number, ?Type)"); ?><p><?php echo show_description("This predicate succeeds when +Number has the type ?Type (integer or float)."); ?></p></div>
<div class="container py-2 px-0"><h4 id="arithmetic_op/2"><a href="/fasill/documentation/src/semantics#arithmetic_op/2">arithmetic_op/2</a></h4><?php echo show_template("arithmetic_op(+Operator, +Arguments, +Types, ?Result)"); ?><p><?php echo show_description("This predicate succeeds when ?Result is the result of evaluating the operator +Operator with the arguments +Arguments with types +Types."); ?></p></div>
<div class="container py-2 px-0"><h4 id="current_fresh_variable_id/1"><a href="/fasill/documentation/src/semantics#current_fresh_variable_id/1">current_fresh_variable_id/1</a></h4><?php echo show_template("current_fresh_variable_id(?Identifier)"); ?><p><?php echo show_description("This predicate stores the current identifier ?Identifier to be used in a fresh variable."); ?></p></div>
<div class="container py-2 px-0"><h4 id="auto_fresh_variable_id/1"><a href="/fasill/documentation/src/semantics#auto_fresh_variable_id/1">auto_fresh_variable_id/1</a></h4><?php echo show_template("auto_fresh_variable_id(?Identifier)"); ?><p><?php echo show_description("This predicate updates the current variable identifier  ?Identifier and returns it."); ?></p></div>
<div class="container py-2 px-0"><h4 id="reset_fresh_variable_id/0"><a href="/fasill/documentation/src/semantics#reset_fresh_variable_id/0">reset_fresh_variable_id/0</a></h4><?php echo show_template("reset_fresh_variable_id"); ?><p><?php echo show_description("This predicate resets the current ?Identifier identifier to the first."); ?></p></div>