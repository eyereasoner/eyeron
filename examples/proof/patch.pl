% Prolog result format 3
query(1, patched(_0, _1, _2), ['S' = _0, 'P' = _1, 'O' = _2]).
result(1, complete, 5).
answer(1, ['S' = alice, 'P' = age, 'O' = 31]).
why(1, ['S' = alice, 'P' = age, 'O' = 31], 20).
answer(1, ['S' = alice, 'P' = status, 'O' = activeStatus]).
why(1, ['S' = alice, 'P' = status, 'O' = activeStatus], 21).
answer(1, ['S' = alice, 'P' = verified, 'O' = true]).
why(1, ['S' = alice, 'P' = verified, 'O' = true], 22).
answer(1, ['S' = alice, 'P' = type, 'O' = person]).
why(1, ['S' = alice, 'P' = type, 'O' = person], 25).
answer(1, ['S' = bob, 'P' = type, 'O' = person]).
why(1, ['S' = bob, 'P' = type, 'O' = person], 26).
clause(1, source(alice, type, person), true).
clause(2, source(alice, age, 30), true).
clause(3, source(alice, status, oldStatus), true).
clause(4, source(alice, email, "alice@example.org"), true).
clause(5, source(bob, type, person), true).
clause(6, delete_(alice, age, 30), true).
clause(7, delete_(alice, status, oldStatus), true).
clause(8, delete_(alice, email, "alice@example.org"), true).
clause(9, insert_(alice, age, 31), true).
clause(10, insert_(alice, status, activeStatus), true).
clause(11, insert_(alice, verified, true), true).
clause(12, kept(var('S'), var('P'), var('O')), (source(var('S'), var('P'), var('O')), \+delete_(var('S'), var('P'), var('O')))).
clause(13, patched(var('S'), var('P'), var('O')), kept(var('S'), var('P'), var('O'))).
clause(14, patched(var('S'), var('P'), var('O')), insert_(var('S'), var('P'), var('O'))).
substitution(1, []).
proof(1, insert_(alice, age, 31), rule(9), []).
substitution(2, []).
proof(2, insert_(alice, status, activeStatus), rule(10), []).
substitution(3, []).
proof(3, insert_(alice, verified, true), rule(11), []).
substitution(4, []).
proof(4, source(alice, type, person), rule(1), []).
substitution(5, []).
proof(5, source(alice, age, 30), rule(2), []).
substitution(6, []).
proof(6, source(alice, status, oldStatus), rule(3), []).
substitution(7, []).
proof(7, source(alice, email, "alice@example.org"), rule(4), []).
substitution(8, []).
proof(8, source(bob, type, person), rule(5), []).
substitution(9, ['S' = alice, 'P' = age, 'O' = 31]).
proof(9, patched(alice, age, 31), rule(14), [uses(1, insert_(alice, age, 31))]).
substitution(10, ['S' = alice, 'P' = status, 'O' = activeStatus]).
proof(10, patched(alice, status, activeStatus), rule(14), [uses(2, insert_(alice, status, activeStatus))]).
substitution(11, ['S' = alice, 'P' = verified, 'O' = true]).
proof(11, patched(alice, verified, true), rule(14), [uses(3, insert_(alice, verified, true))]).
substitution(12, ['S' = alice, 'P' = type, 'O' = person]).
proof(12, kept(alice, type, person), rule(12), [uses(4, source(alice, type, person)), absent(delete_(alice, type, person), complete)]).
substitution(13, []).
proof(13, delete_(alice, age, 30), rule(6), []).
substitution(14, []).
proof(14, solution([]), query, [uses(13, delete_(alice, age, 30))]).
substitution(15, []).
proof(15, delete_(alice, status, oldStatus), rule(7), []).
substitution(16, []).
proof(16, solution([]), query, [uses(15, delete_(alice, status, oldStatus))]).
substitution(17, []).
proof(17, delete_(alice, email, "alice@example.org"), rule(8), []).
substitution(18, []).
proof(18, solution([]), query, [uses(17, delete_(alice, email, "alice@example.org"))]).
substitution(19, ['S' = bob, 'P' = type, 'O' = person]).
proof(19, kept(bob, type, person), rule(12), [uses(8, source(bob, type, person)), absent(delete_(bob, type, person), complete)]).
substitution(20, ['S' = alice, 'P' = age, 'O' = 31]).
proof(20, solution([alice, age, 31]), query, [uses(9, patched(alice, age, 31))]).
substitution(21, ['S' = alice, 'P' = status, 'O' = activeStatus]).
proof(21, solution([alice, status, activeStatus]), query, [uses(10, patched(alice, status, activeStatus))]).
substitution(22, ['S' = alice, 'P' = verified, 'O' = true]).
proof(22, solution([alice, verified, true]), query, [uses(11, patched(alice, verified, true))]).
substitution(23, ['S' = alice, 'P' = type, 'O' = person]).
proof(23, patched(alice, type, person), rule(13), [uses(12, kept(alice, type, person))]).
substitution(24, ['S' = bob, 'P' = type, 'O' = person]).
proof(24, patched(bob, type, person), rule(13), [uses(19, kept(bob, type, person))]).
substitution(25, ['S' = alice, 'P' = type, 'O' = person]).
proof(25, solution([alice, type, person]), query, [uses(23, patched(alice, type, person))]).
substitution(26, ['S' = bob, 'P' = type, 'O' = person]).
proof(26, solution([bob, type, person]), query, [uses(24, patched(bob, type, person))]).
