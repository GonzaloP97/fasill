:- module(environment, [
    program_clause/2,
    program_rule_id/2,
    lattice_tnorm/1,
    lattice_call_bot/1,
    lattice_call_top/1,
    lattice_call_member/1,
    lattice_call_connective/3,
    lattice_consult/1,
    similarity_tnorm/1,
    similarity_between/4,
    similarity_consult/1
]).

:- dynamic(
    fasill_rule/3,
    fasill_lattice_tnorm/1,
    '~'/1,
    '~'/2
).



% OBJECTS CONVERSION

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



% LATTICES

% lattice_tnorm/1
% lattice_tnorm(?Tnorm)
%
% This predicate succeeds when ?Tnorm is the current
% t-norm asserted in the environment.
lattice_tnorm(Tnorm) :- tnorm(Tnorm).

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