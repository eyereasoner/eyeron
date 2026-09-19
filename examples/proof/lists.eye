# Eyelang result format 2
query(1, [call(append(?v0, ?v1, [a, b]))], [binding("left", ?v0), binding("right", ?v1)]).
result(1, complete, 3).
answer(1, [binding("left", []), binding("right", [a, b])]).
why(1, [binding("left", []), binding("right", [a, b])], 2).
answer(1, [binding("left", [a]), binding("right", [b])]).
why(1, [binding("left", [a]), binding("right", [b])], 6).
answer(1, [binding("left", [a, b]), binding("right", [])]).
why(1, [binding("left", [a, b]), binding("right", [])], 9).
query(2, [call(member(?v0, [a, b, a]))], [binding("x", ?v0)]).
result(2, complete, 2).
answer(2, [binding("x", a)]).
why(2, [binding("x", a)], 11).
answer(2, [binding("x", b)]).
why(2, [binding("x", b)], 15).
clause(1, append([], var("ys"), var("ys")), []).
clause(2, append([var("x") | var("xs")], var("ys"), [var("x") | var("zs")]), [call(append(var("xs"), var("ys"), var("zs")))]).
clause(3, member(var("x"), [var("x") | anonymous(1)]), []).
clause(4, member(var("x"), [anonymous(1) | var("xs")]), [call(member(var("x"), var("xs")))]).
substitution(1, [binding("ys", [a, b])]).
proof(1, append([], [a, b], [a, b]), rule(1), []).
substitution(2, [binding("left", []), binding("right", [a, b])]).
proof(2, solution([[], [a, b]]), query, [uses(1, append([], [a, b], [a, b]))]).
substitution(3, [binding("ys", [b])]).
proof(3, append([], [b], [b]), rule(1), []).
substitution(4, [binding("x", a), binding("xs", []), binding("ys", [b]), binding("zs", [b])]).
proof(4, append([a], [b], [a, b]), rule(2), [uses(3, append([], [b], [b]))]).
substitution(5, [binding("ys", [])]).
proof(5, append([], [], []), rule(1), []).
substitution(6, [binding("left", [a]), binding("right", [b])]).
proof(6, solution([[a], [b]]), query, [uses(4, append([a], [b], [a, b]))]).
substitution(7, [binding("x", b), binding("xs", []), binding("ys", []), binding("zs", [])]).
proof(7, append([b], [], [b]), rule(2), [uses(5, append([], [], []))]).
substitution(8, [binding("x", a), binding("xs", [b]), binding("ys", []), binding("zs", [b])]).
proof(8, append([a, b], [], [a, b]), rule(2), [uses(7, append([b], [], [b]))]).
substitution(9, [binding("left", [a, b]), binding("right", [])]).
proof(9, solution([[a, b], []]), query, [uses(8, append([a, b], [], [a, b]))]).
substitution(10, [binding("x", a)]).
proof(10, member(a, [a, b, a]), rule(3), []).
substitution(11, [binding("x", a)]).
proof(11, solution([a]), query, [uses(10, member(a, [a, b, a]))]).
substitution(12, [binding("x", b)]).
proof(12, member(b, [b, a]), rule(3), []).
substitution(13, [binding("x", b), binding("xs", [b, a])]).
proof(13, member(b, [a, b, a]), rule(4), [uses(12, member(b, [b, a]))]).
substitution(14, [binding("x", a)]).
proof(14, member(a, [a]), rule(3), []).
substitution(15, [binding("x", b)]).
proof(15, solution([b]), query, [uses(13, member(b, [a, b, a]))]).
substitution(16, [binding("x", a), binding("xs", [a])]).
proof(16, member(a, [b, a]), rule(4), [uses(14, member(a, [a]))]).
