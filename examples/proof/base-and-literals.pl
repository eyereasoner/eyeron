% Prolog result format 3
query(1, adult(_0), ['Person' = _0]).
result(1, complete, 1).
answer(1, ['Person' = alice]).
why(1, ['Person' = alice], 3).
clause(1, person(alice, literal("Alice Smith", en), typed(22, integer)), true).
clause(3, adult(var('Person')), (person(var('Person'), literal(var('Name'), en), typed(var('Age'), integer)), var('Age') >= 18)).
substitution(1, []).
proof(1, person(alice, literal("Alice Smith", en), typed(22, integer)), rule(1), []).
substitution(2, ['Person' = alice, 'Name' = "Alice Smith", 'Age' = 22]).
proof(2, adult(alice), rule(3), [uses(1, person(alice, literal("Alice Smith", en), typed(22, integer))), builtin(22 >= 18)]).
substitution(3, ['Person' = alice]).
proof(3, solution([alice]), query, [uses(2, adult(alice))]).
