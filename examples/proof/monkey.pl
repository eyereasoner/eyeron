% Prolog result format 3
query(1, animal(_0), ['X' = _0]).
result(1, complete, 1).
answer(1, ['X' = bobos_kind]).
why(1, ['X' = bobos_kind], 3).
query(2, test, []).
result(2, complete, 1).
answer(2, []).
why(2, [], 8).
clause(2, monkey(bobos_kind), true).
clause(3, animal(var('X')), monkey(var('X'))).
clause(4, test, (monkey(var('X')), animal(var('X')))).
substitution(1, []).
proof(1, monkey(bobos_kind), rule(2), []).
substitution(2, ['X' = bobos_kind]).
proof(2, animal(bobos_kind), rule(3), [uses(1, monkey(bobos_kind))]).
substitution(3, ['X' = bobos_kind]).
proof(3, solution([bobos_kind]), query, [uses(2, animal(bobos_kind))]).
substitution(4, []).
proof(4, monkey(bobos_kind), rule(2), []).
substitution(5, []).
proof(5, monkey(bobos_kind), rule(2), []).
substitution(6, ['X' = bobos_kind]).
proof(6, animal(bobos_kind), rule(3), [uses(5, monkey(bobos_kind))]).
substitution(7, ['X' = bobos_kind]).
proof(7, test, rule(4), [uses(4, monkey(bobos_kind)), uses(6, animal(bobos_kind))]).
substitution(8, []).
proof(8, solution([]), query, [uses(7, test)]).
