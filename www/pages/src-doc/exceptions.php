<div class="container py-2 px-0"><h4 id="throw_exception/1"><a href="/fasill/documentation/exceptions#throw_exception/1">throw_exception/1</a></h4><?php echo show_template("throw_exception(+Exception)"); ?><p><?php echo show_description("This predicate throws the exception +Exception."); ?></p></div>
<div class="container py-2 px-0"><h4 id="instantiation_error/2"><a href="/fasill/documentation/exceptions#instantiation_error/2">instantiation_error/2</a></h4><?php echo show_template("instantiation_error(+Indicator, ?Error)"); ?><p><?php echo show_description("This predicate succeeds when ?Error is the instantiation error produced by the predicate +Indicator. This error is produced when an argument or one of its components is a variable, and an instantiated argument or component is required."); ?></p></div>
<div class="container py-2 px-0"><h4 id="type_error/4"><a href="/fasill/documentation/exceptions#type_error/4">type_error/4</a></h4><?php echo show_template("type_error(+Type, +Term, +Indicator, ?Error)"); ?><p><?php echo show_description("This predicate succeeds when ?Error is the type error produced by the type +Type of the term +Term in the predicate +Indicator. This error is produced when the type of an argument or of one of its components is incorrect, but not a variable."); ?></p></div>
<div class="container py-2 px-0"><h4 id="evaluation_error/3"><a href="/fasill/documentation/exceptions#evaluation_error/3">evaluation_error/3</a></h4><?php echo show_template("evaluation_error(+Cause, +Indicator, ?Error)"); ?><p><?php echo show_description("This predicate succeeds when ?Error is the evaluation error produced by the cause +Cause in the predicate +Indicator. This error is produced when the operands of an evaluable functor has an exceptional value."); ?></p></div>
<div class="container py-2 px-0"><h4 id="existence_error/4"><a href="/fasill/documentation/exceptions#existence_error/4">existence_error/4</a></h4><?php echo show_template("existence_error(+Cause, +Term, +Indicator, ?Error)"); ?><p><?php echo show_description("This predicate succeeds when ?Error is the existence error produced by the term +Term in the predicate +Indicator. This error is produced when the object on which an operation is to be performed does not exist."); ?></p></div>