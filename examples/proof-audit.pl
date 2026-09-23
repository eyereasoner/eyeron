% Run with the proof facts another eyeron invocation produced:
% eyeron examples/proof/socrates.pl examples/proof-audit.pl
% Tests and the example generator supply that document automatically.
%
% A proof document states what it concluded and then why: its plain facts
% are the claims, and one `step(Conclusion, By, Bindings, Uses)` fact
% explains each justified conclusion. Because a step names what it used by
% those uses' own conclusions, rather than by an id to be joined back, the
% dependency relation is a direct read -- the same shape the N3 and SRL
% companions walk through `pe:uses`.

member(X, [X|_]).
member(X, [_|Rest]) :-
    member(X, Rest).

depends_on(Conclusion, Used) :-
    step(Conclusion, _, _, Uses),
    member(Used, Uses).
depends_on(Conclusion, Ancestor) :-
    depends_on(Conclusion, Used),
    depends_on(Used, Ancestor).

% A step justified by `fact(N)` was simply given; one justified by
% `rule(N)` is something the engine derived.
source_fact(Fact) :-
    step(Fact, fact(_), _, _).

supporting_fact(Conclusion, Conclusion) :-
    source_fact(Conclusion).
supporting_fact(Conclusion, Fact) :-
    depends_on(Conclusion, Fact),
    source_fact(Fact).

% The proof's root is the conclusion the engine derived, which is the one
% step justified by a rule rather than given -- the same reading the N3
% companion makes of `pe:rule`.
root(Conclusion) :-
    step(Conclusion, rule(_), _, _).

applied(Conclusion, Name, Value) :-
    step(Conclusion, rule(_), Bindings, _),
    member(Name = Value, Bindings).

query_dependency(Ancestor) :-
    root(Root),
    depends_on(Root, Ancestor).

support(Fact) :-
    root(Root),
    supporting_fact(Root, Fact).

answer_applied(Conclusion, Name, Value) :-
    root(Conclusion),
    applied(Conclusion, Name, Value).

?- query_dependency(Ancestor).
?- support(Fact).
?- answer_applied(Conclusion, Name, Value).
