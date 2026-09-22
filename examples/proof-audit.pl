% Run with the proof facts another eyeron invocation produced:
% eyeron examples/proof/socrates.pl examples/proof-audit.pl
% Tests and the example generator supply that document automatically.
%
% A proof document records one `step(Conclusion, By, Bindings, Uses)` fact
% per justified conclusion, and `why(Query, Bindings, Goals)` linking an
% answer to the goals it proved. Because a step names what it used by
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

support(Query, Fact) :-
    why(Query, _, Goals),
    member(Goal, Goals),
    supporting_fact(Goal, Fact).

applied(Conclusion, Name, Value) :-
    step(Conclusion, rule(_), Bindings, _),
    member(Name = Value, Bindings).

query_dependency(Query, Ancestor) :-
    why(Query, _, Goals),
    member(Goal, Goals),
    depends_on(Goal, Ancestor).

answer_applied(Query, Conclusion, Name, Value) :-
    why(Query, _, Goals),
    member(Conclusion, Goals),
    applied(Conclusion, Name, Value).

?- query_dependency(1, Ancestor).
?- support(1, Fact).
?- answer_applied(1, Conclusion, Name, Value).
