% Prolog example: graph-term-emulation.
graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])).
graph_term(g2, graph([triple(alice, likes, tea)])).
about_graph(note1, g1).
contains(Graph, Statement) :-
    graph_term(Graph, graph([Statement|Rest])).
contains(Graph, Statement) :-
    graph_term(Graph, graph([First|Rest])),
    member(Statement, Rest).
member(X, [X|Tail]).
member(X, [Head|Tail]) :-
    member(X, Tail).
social(Graph) :-
    contains(Graph, triple(S, knows, O)).
mentions(Graph, Subject) :-
    contains(Graph, triple(Subject, Predicate, Object)).
mentions(Graph, Object) :-
    contains(Graph, triple(Subject, Predicate, Object)).
?- social(Graph).
?- mentions(Graph, Resource).
