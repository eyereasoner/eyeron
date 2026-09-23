ancestor(iris, jules).
ancestor(iris, kai).

clause(1, parent(iris, jules), true).
clause(2, parent(jules, kai), true).
clause(3, ancestor(var('X'), var('Y')), parent(var('X'), var('Y'))).
clause(4,
       ancestor(var('X'), var('Z')),
       (parent(var('X'), var('Y')), ancestor(var('Y'), var('Z')))).

step(ancestor(iris, jules), rule(3), ['X' = iris, 'Y' = jules], [parent(iris, jules)]).
step(parent(iris, jules), fact(1), [], []).
step(ancestor(iris, kai),
     rule(4),
     ['X' = iris, 'Z' = kai, 'Y' = jules],
     [parent(iris, jules), ancestor(jules, kai)]).
step(ancestor(jules, kai), rule(3), ['X' = jules, 'Y' = kai], [parent(jules, kai)]).
step(parent(jules, kai), fact(2), [], []).
