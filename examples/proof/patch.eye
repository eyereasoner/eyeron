# Eyelang result format 2
query(1, [call(patched(?v0, ?v1, ?v2))], [binding("s", ?v0), binding("p", ?v1), binding("o", ?v2)]).
result(1, complete, 5).
answer(1, [binding("s", alice), binding("p", age), binding("o", 31)]).
why(1, [binding("s", alice), binding("p", age), binding("o", 31)], 20).
answer(1, [binding("s", alice), binding("p", status), binding("o", activeStatus)]).
why(1, [binding("s", alice), binding("p", status), binding("o", activeStatus)], 21).
answer(1, [binding("s", alice), binding("p", verified), binding("o", true)]).
why(1, [binding("s", alice), binding("p", verified), binding("o", true)], 22).
answer(1, [binding("s", alice), binding("p", type), binding("o", person)]).
why(1, [binding("s", alice), binding("p", type), binding("o", person)], 25).
answer(1, [binding("s", bob), binding("p", type), binding("o", person)]).
why(1, [binding("s", bob), binding("p", type), binding("o", person)], 26).
clause(1, source(alice, type, person), []).
clause(2, source(alice, age, 30), []).
clause(3, source(alice, status, oldStatus), []).
clause(4, source(alice, email, "alice@example.org"), []).
clause(5, source(bob, type, person), []).
clause(6, delete_(alice, age, 30), []).
clause(7, delete_(alice, status, oldStatus), []).
clause(8, delete_(alice, email, "alice@example.org"), []).
clause(9, insert_(alice, age, 31), []).
clause(10, insert_(alice, status, activeStatus), []).
clause(11, insert_(alice, verified, true), []).
clause(12, kept(var("s"), var("p"), var("o")), [call(source(var("s"), var("p"), var("o"))), absent(delete_(var("s"), var("p"), var("o")))]).
clause(13, patched(var("s"), var("p"), var("o")), [call(kept(var("s"), var("p"), var("o")))]).
clause(14, patched(var("s"), var("p"), var("o")), [call(insert_(var("s"), var("p"), var("o")))]).
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
substitution(9, [binding("s", alice), binding("p", age), binding("o", 31)]).
proof(9, patched(alice, age, 31), rule(14), [uses(1, insert_(alice, age, 31))]).
substitution(10, [binding("s", alice), binding("p", status), binding("o", activeStatus)]).
proof(10, patched(alice, status, activeStatus), rule(14), [uses(2, insert_(alice, status, activeStatus))]).
substitution(11, [binding("s", alice), binding("p", verified), binding("o", true)]).
proof(11, patched(alice, verified, true), rule(14), [uses(3, insert_(alice, verified, true))]).
substitution(12, [binding("s", alice), binding("p", type), binding("o", person)]).
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
substitution(19, [binding("s", bob), binding("p", type), binding("o", person)]).
proof(19, kept(bob, type, person), rule(12), [uses(8, source(bob, type, person)), absent(delete_(bob, type, person), complete)]).
substitution(20, [binding("s", alice), binding("p", age), binding("o", 31)]).
proof(20, solution([alice, age, 31]), query, [uses(9, patched(alice, age, 31))]).
substitution(21, [binding("s", alice), binding("p", status), binding("o", activeStatus)]).
proof(21, solution([alice, status, activeStatus]), query, [uses(10, patched(alice, status, activeStatus))]).
substitution(22, [binding("s", alice), binding("p", verified), binding("o", true)]).
proof(22, solution([alice, verified, true]), query, [uses(11, patched(alice, verified, true))]).
substitution(23, [binding("s", alice), binding("p", type), binding("o", person)]).
proof(23, patched(alice, type, person), rule(13), [uses(12, kept(alice, type, person))]).
substitution(24, [binding("s", bob), binding("p", type), binding("o", person)]).
proof(24, patched(bob, type, person), rule(13), [uses(19, kept(bob, type, person))]).
substitution(25, [binding("s", alice), binding("p", type), binding("o", person)]).
proof(25, solution([alice, type, person]), query, [uses(23, patched(alice, type, person))]).
substitution(26, [binding("s", bob), binding("p", type), binding("o", person)]).
proof(26, solution([bob, type, person]), query, [uses(24, patched(bob, type, person))]).
