% Prolog result format 4
query(1, seen(_0), ['Someone' = _0]).
result(1, complete, 1).
answer(1, ['Someone' = _0]).
why(1, ['Someone' = _0], [seen(_0)]).

clause(1, knows(alice, bob), true).
clause(2, seen(var('Someone')), knows(alice, bob)).

step(seen(_0), rule(2), ['Someone' = _0], [knows(alice, bob)]).
step(knows(alice, bob), fact(1), [], []).
