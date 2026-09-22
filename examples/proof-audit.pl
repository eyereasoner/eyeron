% Run with the proof facts another eyeron invocation produced:
% eyeron examples/proof/socrates.pl examples/proof-audit.pl
% Tests and the example generator supply that document automatically.

member(X, [X|_]).
member(X, [_|Rest]) :-
    member(X, Rest).

% Positive premises and completed collections both carry proof references.
parent_proof(Id, Parent) :-
    proof(Id, _, _, Premises),
    member(uses(Parent, _), Premises).

parent_proof(Id, Parent) :-
    proof(Id, _, _, Premises),
    member(collected(_, _, _, Parents, complete), Premises),
    member(Parent, Parents).

depends_on(Id, Parent) :-
    parent_proof(Id, Parent).
depends_on(Id, Ancestor) :-
    parent_proof(Id, Parent),
    depends_on(Parent, Ancestor).

% A source fact is a proof step that used a clause and needed no premises.
source_fact(Id, Fact) :-
    proof(Id, Fact, rule(_), []).
supporting_fact(Id, Fact) :-
    source_fact(Id, Fact).
supporting_fact(Id, Fact) :-
    depends_on(Id, Ancestor),
    source_fact(Ancestor, Fact).

support(Query, Fact) :-
    why(Query, _, Proof),
    supporting_fact(Proof, Fact).

applied(Proof, Name, Value) :-
    substitution(Proof, Bindings),
    member(Name = Value, Bindings).

query_dependency(Query, Ancestor) :-
    why(Query, _, Root),
    depends_on(Root, Ancestor).

answer_rule_proof(Query, Proof) :-
    why(Query, _, Root),
    proof(Root, _, query, Premises),
    member(uses(Proof, _), Premises).

answer_applied(Query, Proof, Name, Value) :-
    answer_rule_proof(Query, Proof),
    applied(Proof, Name, Value).

?- query_dependency(1, Ancestor).
?- support(1, Fact).
?- answer_applied(1, Proof, Name, Value).
