% Prolog result format 3
query(1, test, []).
result(1, complete, 1).
answer(1, []).
why(1, [], 3).
clause(1, same_as(x, y), true).
clause(2, test, same_as(x, y)).
substitution(1, []).
proof(1, same_as(x, y), rule(1), []).
substitution(2, []).
proof(2, test, rule(2), [uses(1, same_as(x, y))]).
substitution(3, []).
proof(3, solution([]), query, [uses(2, test)]).
