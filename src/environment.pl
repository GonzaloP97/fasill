:- module(environment, [
    set_max_inferences/1,
    to_prolog/2,
    from_prolog/2,
    fasill_atom/1,
    fasill_float/1,
    fasill_integer/1,
    fasill_number/1,
    fasill_term/1,
    fasill_var/1,
    program_clause/2,
    program_rule_id/2,
    program_consult/1,
    lattice_tnorm/1,
    lattice_tconorm/1,
    lattice_call_bot/1,
    lattice_call_top/1,
    lattice_call_member/1,
    lattice_call_connective/3,
    lattice_consult/1,
    similarity_tnorm/1,
    similarity_between/4,
    similarity_consult/1
]).

:- use_module(parser).

:- dynamic(
    fasill_rule/3,
    fasill_lattice_tnorm/1,
    '~'/1,
    '~'/2
).



% ENVIRONMENT

% fasill_max_inferences/1
% fasill_max_inferences(?Limit)
%
% This predicate succeeds when ?Limit is the
% current limit of inferences that can be performed
% when a goal is executed.
:- dynamic(fasill_max_inferences/1).
fasill_max_inferences(false).

% set_max_inferences/1
% set_max_inferences(+Limit)
%
% This predicate succeeds, and chages the current
% limit of inferences that can be performed when
% a goal is executed.
set_max_inferences(Limit) :-
    retractall(fasill_max_inferences(Limit)),
    asserta(fasill_max_inferences(Limit)).



% OBJECT MANIPULATION

% to_prolog/2
% to_prolog(+FASILL, ?Prolog)
%
% This predicate takes the FASILL object +FASILL
% and returns the object ?Prolog in Prolog notation.
to_prolog([], []) :- !.
to_prolog([X|Xs], [Y|Ys]) :-
    !, to_prolog(X,Y),
    to_prolog(Xs,Ys).
to_prolog(num(X), X) :- !.
to_prolog(var(_), _).
to_prolog(term(X,Xs), Term) :-
    atom(X),
    !, to_prolog(Xs, Ys),
    Term =.. [X|Ys].

% from_prolog/2
% from_prolog(+Prolog, ?FASILL)
%
% This predicate takes the Prolog object +Prolog
% and returns the object ?FASILL in FASILL notation.
from_prolog([], term([], [])) :- !.
from_prolog([X|Xs], term('.', [Y,Ys])) :-
    !, from_prolog(X,Y),
    from_prolog(Xs,Ys).
from_prolog(X, num(X)) :- number(X), !.
from_prolog(X, term(X, [])) :- atom(X), !.
from_prolog(X, term(H,Args)) :-
    compound(X), !,
    X =.. [H|T],
    maplist(from_prolog, T, Args).

% fasill_number/1
% fasill_number(+Term)
%
% This predicate succeeds when +Term is a FASILL number.
fasill_number(num(_)).

% fasill_integer/1
% fasill_integer(+Term)
%
% This predicate succeeds when +Term is a FASILL integer.
fasill_integer(num(X)) :- integer(X).

% fasill_float/1
% fasill_float(+Term)
%
% This predicate succeeds when +Term is a FASILL float.
fasill_float(num(X)) :- float(X).

% fasill_atom/1
% fasill_atom(+Term)
%
% This predicate succeeds when +Term is a FASILL atom.
fasill_atom(term(_,[])).

% fasill_term/1
% fasill_term(+Term)
%
% This predicate succeeds when +Term is a FASILL term.
fasill_term(term(_,_)).

% fasill_var/1
% fasill_var(+Term)
%
% This predicate succeeds when +Term is a FASILL variable.
fasill_var(var(_)).



% RULES MANIPULATION

% program_clause/2
% program_clause(?Indicator, ?Rule)
%
%
program_clause(Name/Arity, rule(term(Name, Arity, Args), Body, Info)) :-
    fasill_rule(term(Name, Arity, Args), Body, Info).

% program_rule_id/2
% program_rule_id(+Rule, ?Id)
%
% This predicate succeeds when ?Id is the identifier
% of the rule +Rule.
program_rule_id(rule(_,_,Info), Id) :- member(id(Id), Info).

% program_consult/1
% program_consult(+Path)
%
% This predicate loads the FASILL program from
% the file +Path into the environment. This
% predicate cleans the previous rules.
program_consult(Path) :-
    retractall(rule(_,_,_)),
    file_consult(Path, Rules),
    (member(Rule, Rules), assertz(Rule), fail ; true).

% program_query/1
% program_consult(+Path)
%
% This predicate loads the FASILL program from
% the file +Path into the environment. This
% predicate cleans the previous rules.
program_consult(Path) :-
    retractall(rule(_,_,_)),
    file_consult(Path, Rules),
    (member(Rule, Rules), assertz(Rule), fail ; true).



% LATTICES

% lattice_tnorm/1
% lattice_tnorm(?Tnorm)
%
% This predicate succeeds when ?Tnorm is the
% current t-norm asserted in the environment.
lattice_tnorm(Tnorm) :- tnorm(Tnorm).

% lattice_tconorm/1
% lattice_tconorm(?Tconorm)
%
% This predicate succeeds when ?Tconorm is the
% current t-conorm asserted in the environment.
lattice_tconorm(Tconorm) :- tconorm(Tconorm).

% lattice_call_bot/1
% lattice_call_bot(-Bot)
%
% This predicate succeeds when -Bot is the
% bottom member of the lattice loaded into
% the environment.
lattice_call_bot(Bot) :-
    bot(Prolog),
    from_prolog(Prolog, Bot).

% lattice_call_top/1
% lattice_call_top(-Bot)
%
% This predicate succeeds when -Bot is the
% bottom member of the lattice loaded into
% the environment.
lattice_call_top(Top) :-
    top(Prolog),
    from_prolog(Prolog, Top).

% lattice_call_member/1
% lattice_call_member(+Memeber)
%
% This predicate succeeds when +Member is a member
% of the lattice loaded into the environment.
lattice_call_member(Member) :-
    to_prolog(Member, Prolog),
    member(Prolog).

% lattice_call_connective/3
% lattice_call_connective(+Name, +Arguments, ?Result)
%
% This predicate succeeds when ?Result is the result
% of evaluate the connective ?Name with the arguments
% +Arguments of the lattice loaded into the environment.
lattice_call_connective('&', Args, Result) :- !,
    (lattice_tnorm(Tnorm) ;
    current_predicate(Tnorm/3),
    sub_atom(Tnorm, 0, 4, _, and_)), !,
    lattice_call_connective(Tnorm, Args, Result).
lattice_call_connective('|', Args, Result) :- !,
    (lattice_tnorm(Tconorm) ;
    current_predicate(Tconorm/3),
    sub_atom(Tconorm, 0, 3, _, or_)), !,
    lattice_call_connective(Tconorm, Args, Result).
lattice_call_connective(Name, Args, Result) :-
    maplist(to_prolog, Args, Args_),
    append(Args_, [Prolog], ArgsCall),
    Call =.. [Name|ArgsCall],
    call(environment:Call),
    from_prolog(Prolog, Result).

% lattice_consult/1
% lattice_consult(+Path)
%
% This predicate loads the lattice of the file +Path into
% the environment. This predicate cleans the previous lattice.
lattice_consult(Path) :-
    consult(Path).



% SIMILARITY RELATIONS

% ~/1
% ~(+Assignment)
%
% This predicate succeeds when +Assignment is a valid 
% assignment of a t-norm. A valid assignment is of the 
% form ~tnorm = Atom, where Atom is an atom. This predicate
% asserts Atom in the current environment as the current
% t-norm for similarities. This predicate retracts the
% current t-norm, if exists.
:- op(750, fx, ~).
:- multifile('~'/1).

% ~/2
% ~(+SimilarityEquation)
%
% This predicate succeeds when +SimilarityEquation is a
% valid similarity equation and asserts it in the current
% environment. A valid similarity equation is of the form
% AtomA/Length ~ AtomB/Length = TD, where AtomA and AtomB
% are atoms and Length is a non-negative integer. Note that
% this equation is parsed with the default table operator
% as '~'('/'(AtomA,Length), '='('/'(AtomB,Length),TD)).
:- op(800, xfx, ~).
:- multifile('~'/2).

% similarity_tnorm/1
% similarity_tnorm(?Tnorm)
%
% This predicate succeeds when ?Tnorm is the current
% t-norm asserted in the environment.
similarity_tnorm(Tnorm) :- ~(tnorm=Tnorm).

% similarity_between/4
% similarity_between(?AtomA, ?AtomB, ?Length, ?TD)
%
% This predicate succeeds when ?AtomA/?Length is similar
% to ?AtomB/?Length with truth degree ?TD, using the current
% similarity relation in the environment.
similarity_between(AtomA, AtomB, Length, TD) :-
    environment:'~'(AtomA/Length, '='(AtomB/Length, Prolog)),
    from_prolog(Prolog, TD).
similarity_between(AtomA, AtomB, 0, TD) :-
    environment:'~'(AtomA, '='(AtomB, Prolog)),
    from_prolog(Prolog, TD).

% similarity_consult/1
% similarity_consult(+Path)
%
% This predicate loads the similarities equations of the
% file +Path into the environment. This predicate cleans
% the previous similarity relations.
similarity_consult(Path) :-
    retractall(~(_, _)),
    retractall(~(_)),
    consult(Path).