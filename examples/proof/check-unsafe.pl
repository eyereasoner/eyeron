% Prolog result format 3
query(1, seen(_0), ['Someone' = _0]).
result(1, complete, 1).
answer(1, ['Someone' = _0]).
why(1, ['Someone' = _0], 3).
clause(1, knows(alice, bob), true).
clause(2, seen(var('Someone')), knows(alice, bob)).
substitution(1, []).
proof(1, knows(alice, bob), rule(1), []).
substitution(2, ['Someone' = _0]).
proof(2, seen(_0), rule(2), [uses(1, knows(alice, bob))]).
substitution(3, ['Someone' = _0]).
proof(3, solution([_0]), query, [uses(2, seen(_0))]).
