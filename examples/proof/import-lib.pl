% Prolog result format 3
query(1, ancestor(iris, _0), ['Descendant' = _0]).
result(1, complete, 2).
answer(1, ['Descendant' = jules]).
why(1, ['Descendant' = jules], 3).
answer(1, ['Descendant' = kai]).
why(1, ['Descendant' = kai], 7).
clause(1, parent(iris, jules), true).
clause(2, parent(jules, kai), true).
clause(3, ancestor(var('X'), var('Y')), parent(var('X'), var('Y'))).
clause(4, ancestor(var('X'), var('Z')), (parent(var('X'), var('Y')), ancestor(var('Y'), var('Z')))).
substitution(1, []).
proof(1, parent(iris, jules), rule(1), []).
substitution(2, ['X' = iris, 'Y' = jules]).
proof(2, ancestor(iris, jules), rule(3), [uses(1, parent(iris, jules))]).
substitution(3, ['Descendant' = jules]).
proof(3, solution([jules]), query, [uses(2, ancestor(iris, jules))]).
substitution(4, []).
proof(4, parent(jules, kai), rule(2), []).
substitution(5, ['X' = jules, 'Y' = kai]).
proof(5, ancestor(jules, kai), rule(3), [uses(4, parent(jules, kai))]).
substitution(6, ['X' = iris, 'Z' = kai, 'Y' = jules]).
proof(6, ancestor(iris, kai), rule(4), [uses(1, parent(iris, jules)), uses(5, ancestor(jules, kai))]).
substitution(7, ['Descendant' = kai]).
proof(7, solution([kai]), query, [uses(6, ancestor(iris, kai))]).
