# Eyelang example: graph-term-emulation.
graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])).
graph_term(g2, graph([triple(alice, likes, tea)])).
about_graph(note1, g1).
contains(?graph, ?statement) if graph_term(?graph, graph([?statement | ?rest])).
contains(?graph, ?statement) if graph_term(?graph, graph([?first | ?rest])), member(?statement, ?rest).
member(?x, [?x | ?tail]). member(?x, [?head | ?tail]) if member(?x, ?tail).
social(?graph) if contains(?graph, triple(?s, knows, ?o)).
mentions(?graph, ?subject) if contains(?graph, triple(?subject, ?predicate, ?object)).
mentions(?graph, ?object) if contains(?graph, triple(?subject, ?predicate, ?object)).
ask social(?graph).
ask mentions(?graph, ?resource).
