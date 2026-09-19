# Eyelang result format 2
query(1, [call(counter([1, 1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 0], ?v0))], [binding("states", ?v0)]).
result(1, complete, 1).
answer(1, [binding("states", [[0, 0, 1], [0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]])]).
why(1, [binding("states", [[0, 0, 1], [0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]])], 44).
query(2, [call(gcc(0, [1, 0, 1], ?v0))], [binding("state", ?v0)]).
result(2, complete, 1).
answer(2, [binding("state", [1, 0, 1])]).
why(2, [binding("state", [1, 0, 1])], 59).
clause(1, and_gate(0, 0, 0), []).
clause(2, and_gate(0, 1, 0), []).
clause(3, and_gate(1, 0, 0), []).
clause(4, and_gate(1, 1, 1), []).
clause(5, or_gate(0, 0, 0), []).
clause(6, or_gate(0, 1, 1), []).
clause(7, or_gate(1, 0, 1), []).
clause(9, inv(0, 1), []).
clause(10, inv(1, 0), []).
clause(11, dff(anonymous(1), 0, var("q"), var("q")), []).
clause(12, dff(var("d"), 1, anonymous(1), var("d")), []).
clause(13, neta(var("a"), var("b"), var("q")), [call(and_gate(var("a"), var("b"), var("t1"))), call(inv(var("a"), var("na"))), call(inv(var("b"), var("nb"))), call(and_gate(var("na"), var("nb"), var("t2"))), call(or_gate(var("t1"), var("t2"), var("q")))]).
clause(14, netb(var("a"), var("b"), var("c"), var("q1"), var("q2")), [call(and_gate(var("a"), var("c"), var("t1"))), call(inv(var("c"), var("nc"))), call(and_gate(var("b"), var("nc"), var("t2"))), call(inv(var("a"), var("na"))), call(and_gate(var("na"), var("c"), var("t3"))), call(or_gate(var("t1"), var("t2"), var("q1"))), call(or_gate(var("t2"), var("t3"), var("q2")))]).
clause(15, gcc(var("clock"), [var("qa"), var("qb"), var("qc")], [var("za"), var("zb"), var("zc")]), [call(netb(var("qa"), var("qb"), var("qc"), var("d1"), var("d2"))), call(neta(var("qa"), var("qb"), var("d3"))), call(dff(var("d1"), var("clock"), var("qa"), var("za"))), call(dff(var("d2"), var("clock"), var("qb"), var("zb"))), call(dff(var("d3"), var("clock"), var("qc"), var("zc")))]).
clause(16, counter([], anonymous(1), []), []).
clause(17, counter([var("clock") | var("clocks")], var("state"), [var("next") | var("states")]), [call(gcc(var("clock"), var("state"), var("next"))), call(counter(var("clocks"), var("next"), var("states")))]).
substitution(1, []).
proof(1, and_gate(0, 0, 0), rule(1), []).
substitution(2, []).
proof(2, inv(0, 1), rule(9), []).
substitution(3, []).
proof(3, and_gate(0, 1, 0), rule(2), []).
substitution(4, []).
proof(4, and_gate(1, 0, 0), rule(3), []).
substitution(5, []).
proof(5, or_gate(0, 0, 0), rule(5), []).
substitution(6, [binding("a", 0), binding("b", 0), binding("c", 0), binding("q1", 0), binding("q2", 0), binding("t1", 0), binding("nc", 1), binding("t2", 0), binding("na", 1), binding("t3", 0)]).
proof(6, netb(0, 0, 0, 0, 0), rule(14), [uses(1, and_gate(0, 0, 0)), uses(2, inv(0, 1)), uses(3, and_gate(0, 1, 0)), uses(2, inv(0, 1)), uses(4, and_gate(1, 0, 0)), uses(5, or_gate(0, 0, 0)), uses(5, or_gate(0, 0, 0))]).
substitution(7, []).
proof(7, and_gate(1, 1, 1), rule(4), []).
substitution(8, []).
proof(8, or_gate(0, 1, 1), rule(6), []).
substitution(9, [binding("a", 0), binding("b", 0), binding("q", 1), binding("t1", 0), binding("na", 1), binding("nb", 1), binding("t2", 1)]).
proof(9, neta(0, 0, 1), rule(13), [uses(1, and_gate(0, 0, 0)), uses(2, inv(0, 1)), uses(2, inv(0, 1)), uses(7, and_gate(1, 1, 1)), uses(8, or_gate(0, 1, 1))]).
substitution(10, [binding("d", 0)]).
proof(10, dff(0, 1, 0, 0), rule(12), []).
substitution(11, [binding("d", 1)]).
proof(11, dff(1, 1, 0, 1), rule(12), []).
substitution(12, [binding("clock", 1), binding("qa", 0), binding("qb", 0), binding("qc", 0), binding("za", 0), binding("zb", 0), binding("zc", 1), binding("d1", 0), binding("d2", 0), binding("d3", 1)]).
proof(12, gcc(1, [0, 0, 0], [0, 0, 1]), rule(15), [uses(6, netb(0, 0, 0, 0, 0)), uses(9, neta(0, 0, 1)), uses(10, dff(0, 1, 0, 0)), uses(10, dff(0, 1, 0, 0)), uses(11, dff(1, 1, 0, 1))]).
substitution(13, []).
proof(13, inv(1, 0), rule(10), []).
substitution(14, [binding("a", 0), binding("b", 0), binding("c", 1), binding("q1", 0), binding("q2", 1), binding("t1", 0), binding("nc", 0), binding("t2", 0), binding("na", 1), binding("t3", 1)]).
proof(14, netb(0, 0, 1, 0, 1), rule(14), [uses(3, and_gate(0, 1, 0)), uses(13, inv(1, 0)), uses(1, and_gate(0, 0, 0)), uses(2, inv(0, 1)), uses(7, and_gate(1, 1, 1)), uses(5, or_gate(0, 0, 0)), uses(8, or_gate(0, 1, 1))]).
substitution(15, [binding("d", 1)]).
proof(15, dff(1, 1, 1, 1), rule(12), []).
substitution(16, [binding("clock", 1), binding("qa", 0), binding("qb", 0), binding("qc", 1), binding("za", 0), binding("zb", 1), binding("zc", 1), binding("d1", 0), binding("d2", 1), binding("d3", 1)]).
proof(16, gcc(1, [0, 0, 1], [0, 1, 1]), rule(15), [uses(14, netb(0, 0, 1, 0, 1)), uses(9, neta(0, 0, 1)), uses(10, dff(0, 1, 0, 0)), uses(11, dff(1, 1, 0, 1)), uses(15, dff(1, 1, 1, 1))]).
substitution(17, [binding("a", 0), binding("b", 1), binding("c", 1), binding("q1", 0), binding("q2", 1), binding("t1", 0), binding("nc", 0), binding("t2", 0), binding("na", 1), binding("t3", 1)]).
proof(17, netb(0, 1, 1, 0, 1), rule(14), [uses(3, and_gate(0, 1, 0)), uses(13, inv(1, 0)), uses(4, and_gate(1, 0, 0)), uses(2, inv(0, 1)), uses(7, and_gate(1, 1, 1)), uses(5, or_gate(0, 0, 0)), uses(8, or_gate(0, 1, 1))]).
substitution(18, [binding("a", 0), binding("b", 1), binding("q", 0), binding("t1", 0), binding("na", 1), binding("nb", 0), binding("t2", 0)]).
proof(18, neta(0, 1, 0), rule(13), [uses(3, and_gate(0, 1, 0)), uses(2, inv(0, 1)), uses(13, inv(1, 0)), uses(4, and_gate(1, 0, 0)), uses(5, or_gate(0, 0, 0))]).
substitution(19, [binding("d", 0)]).
proof(19, dff(0, 1, 1, 0), rule(12), []).
substitution(20, [binding("clock", 1), binding("qa", 0), binding("qb", 1), binding("qc", 1), binding("za", 0), binding("zb", 1), binding("zc", 0), binding("d1", 0), binding("d2", 1), binding("d3", 0)]).
proof(20, gcc(1, [0, 1, 1], [0, 1, 0]), rule(15), [uses(17, netb(0, 1, 1, 0, 1)), uses(18, neta(0, 1, 0)), uses(10, dff(0, 1, 0, 0)), uses(15, dff(1, 1, 1, 1)), uses(19, dff(0, 1, 1, 0))]).
substitution(21, []).
proof(21, or_gate(1, 0, 1), rule(7), []).
substitution(22, [binding("a", 0), binding("b", 1), binding("c", 0), binding("q1", 1), binding("q2", 1), binding("t1", 0), binding("nc", 1), binding("t2", 1), binding("na", 1), binding("t3", 0)]).
proof(22, netb(0, 1, 0, 1, 1), rule(14), [uses(1, and_gate(0, 0, 0)), uses(2, inv(0, 1)), uses(7, and_gate(1, 1, 1)), uses(2, inv(0, 1)), uses(4, and_gate(1, 0, 0)), uses(8, or_gate(0, 1, 1)), uses(21, or_gate(1, 0, 1))]).
substitution(23, [binding("clock", 1), binding("qa", 0), binding("qb", 1), binding("qc", 0), binding("za", 1), binding("zb", 1), binding("zc", 0), binding("d1", 1), binding("d2", 1), binding("d3", 0)]).
proof(23, gcc(1, [0, 1, 0], [1, 1, 0]), rule(15), [uses(22, netb(0, 1, 0, 1, 1)), uses(18, neta(0, 1, 0)), uses(11, dff(1, 1, 0, 1)), uses(15, dff(1, 1, 1, 1)), uses(10, dff(0, 1, 0, 0))]).
substitution(24, [binding("a", 1), binding("b", 1), binding("c", 0), binding("q1", 1), binding("q2", 1), binding("t1", 0), binding("nc", 1), binding("t2", 1), binding("na", 0), binding("t3", 0)]).
proof(24, netb(1, 1, 0, 1, 1), rule(14), [uses(4, and_gate(1, 0, 0)), uses(2, inv(0, 1)), uses(7, and_gate(1, 1, 1)), uses(13, inv(1, 0)), uses(1, and_gate(0, 0, 0)), uses(8, or_gate(0, 1, 1)), uses(21, or_gate(1, 0, 1))]).
substitution(25, [binding("a", 1), binding("b", 1), binding("q", 1), binding("t1", 1), binding("na", 0), binding("nb", 0), binding("t2", 0)]).
proof(25, neta(1, 1, 1), rule(13), [uses(7, and_gate(1, 1, 1)), uses(13, inv(1, 0)), uses(13, inv(1, 0)), uses(1, and_gate(0, 0, 0)), uses(21, or_gate(1, 0, 1))]).
substitution(26, [binding("clock", 1), binding("qa", 1), binding("qb", 1), binding("qc", 0), binding("za", 1), binding("zb", 1), binding("zc", 1), binding("d1", 1), binding("d2", 1), binding("d3", 1)]).
proof(26, gcc(1, [1, 1, 0], [1, 1, 1]), rule(15), [uses(24, netb(1, 1, 0, 1, 1)), uses(25, neta(1, 1, 1)), uses(15, dff(1, 1, 1, 1)), uses(15, dff(1, 1, 1, 1)), uses(11, dff(1, 1, 0, 1))]).
substitution(27, [binding("a", 1), binding("b", 1), binding("c", 1), binding("q1", 1), binding("q2", 0), binding("t1", 1), binding("nc", 0), binding("t2", 0), binding("na", 0), binding("t3", 0)]).
proof(27, netb(1, 1, 1, 1, 0), rule(14), [uses(7, and_gate(1, 1, 1)), uses(13, inv(1, 0)), uses(4, and_gate(1, 0, 0)), uses(13, inv(1, 0)), uses(3, and_gate(0, 1, 0)), uses(21, or_gate(1, 0, 1)), uses(5, or_gate(0, 0, 0))]).
substitution(28, [binding("clock", 1), binding("qa", 1), binding("qb", 1), binding("qc", 1), binding("za", 1), binding("zb", 0), binding("zc", 1), binding("d1", 1), binding("d2", 0), binding("d3", 1)]).
proof(28, gcc(1, [1, 1, 1], [1, 0, 1]), rule(15), [uses(27, netb(1, 1, 1, 1, 0)), uses(25, neta(1, 1, 1)), uses(15, dff(1, 1, 1, 1)), uses(19, dff(0, 1, 1, 0)), uses(15, dff(1, 1, 1, 1))]).
substitution(29, [binding("a", 1), binding("b", 0), binding("c", 1), binding("q1", 1), binding("q2", 0), binding("t1", 1), binding("nc", 0), binding("t2", 0), binding("na", 0), binding("t3", 0)]).
proof(29, netb(1, 0, 1, 1, 0), rule(14), [uses(7, and_gate(1, 1, 1)), uses(13, inv(1, 0)), uses(1, and_gate(0, 0, 0)), uses(13, inv(1, 0)), uses(3, and_gate(0, 1, 0)), uses(21, or_gate(1, 0, 1)), uses(5, or_gate(0, 0, 0))]).
substitution(30, [binding("a", 1), binding("b", 0), binding("q", 0), binding("t1", 0), binding("na", 0), binding("nb", 1), binding("t2", 0)]).
proof(30, neta(1, 0, 0), rule(13), [uses(4, and_gate(1, 0, 0)), uses(13, inv(1, 0)), uses(2, inv(0, 1)), uses(3, and_gate(0, 1, 0)), uses(5, or_gate(0, 0, 0))]).
substitution(31, [binding("clock", 1), binding("qa", 1), binding("qb", 0), binding("qc", 1), binding("za", 1), binding("zb", 0), binding("zc", 0), binding("d1", 1), binding("d2", 0), binding("d3", 0)]).
proof(31, gcc(1, [1, 0, 1], [1, 0, 0]), rule(15), [uses(29, netb(1, 0, 1, 1, 0)), uses(30, neta(1, 0, 0)), uses(15, dff(1, 1, 1, 1)), uses(10, dff(0, 1, 0, 0)), uses(19, dff(0, 1, 1, 0))]).
substitution(32, [binding("a", 1), binding("b", 0), binding("c", 0), binding("q1", 0), binding("q2", 0), binding("t1", 0), binding("nc", 1), binding("t2", 0), binding("na", 0), binding("t3", 0)]).
proof(32, netb(1, 0, 0, 0, 0), rule(14), [uses(4, and_gate(1, 0, 0)), uses(2, inv(0, 1)), uses(3, and_gate(0, 1, 0)), uses(13, inv(1, 0)), uses(1, and_gate(0, 0, 0)), uses(5, or_gate(0, 0, 0)), uses(5, or_gate(0, 0, 0))]).
substitution(33, [binding("clock", 1), binding("qa", 1), binding("qb", 0), binding("qc", 0), binding("za", 0), binding("zb", 0), binding("zc", 0), binding("d1", 0), binding("d2", 0), binding("d3", 0)]).
proof(33, gcc(1, [1, 0, 0], [0, 0, 0]), rule(15), [uses(32, netb(1, 0, 0, 0, 0)), uses(30, neta(1, 0, 0)), uses(19, dff(0, 1, 1, 0)), uses(10, dff(0, 1, 0, 0)), uses(10, dff(0, 1, 0, 0))]).
substitution(34, []).
proof(34, counter([], [0, 0, 1], []), rule(16), []).
substitution(35, [binding("clock", 1), binding("clocks", []), binding("state", [0, 0, 0]), binding("next", [0, 0, 1]), binding("states", [])]).
proof(35, counter([1], [0, 0, 0], [[0, 0, 1]]), rule(17), [uses(12, gcc(1, [0, 0, 0], [0, 0, 1])), uses(34, counter([], [0, 0, 1], []))]).
substitution(36, [binding("clock", 1), binding("clocks", [1]), binding("state", [1, 0, 0]), binding("next", [0, 0, 0]), binding("states", [[0, 0, 1]])]).
proof(36, counter([1, 1], [1, 0, 0], [[0, 0, 0], [0, 0, 1]]), rule(17), [uses(33, gcc(1, [1, 0, 0], [0, 0, 0])), uses(35, counter([1], [0, 0, 0], [[0, 0, 1]]))]).
substitution(37, [binding("clock", 1), binding("clocks", [1, 1]), binding("state", [1, 0, 1]), binding("next", [1, 0, 0]), binding("states", [[0, 0, 0], [0, 0, 1]])]).
proof(37, counter([1, 1, 1], [1, 0, 1], [[1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(31, gcc(1, [1, 0, 1], [1, 0, 0])), uses(36, counter([1, 1], [1, 0, 0], [[0, 0, 0], [0, 0, 1]]))]).
substitution(38, [binding("clock", 1), binding("clocks", [1, 1, 1]), binding("state", [1, 1, 1]), binding("next", [1, 0, 1]), binding("states", [[1, 0, 0], [0, 0, 0], [0, 0, 1]])]).
proof(38, counter([1, 1, 1, 1], [1, 1, 1], [[1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(28, gcc(1, [1, 1, 1], [1, 0, 1])), uses(37, counter([1, 1, 1], [1, 0, 1], [[1, 0, 0], [0, 0, 0], [0, 0, 1]]))]).
substitution(39, [binding("clock", 1), binding("clocks", [1, 1, 1, 1]), binding("state", [1, 1, 0]), binding("next", [1, 1, 1]), binding("states", [[1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]])]).
proof(39, counter([1, 1, 1, 1, 1], [1, 1, 0], [[1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(26, gcc(1, [1, 1, 0], [1, 1, 1])), uses(38, counter([1, 1, 1, 1], [1, 1, 1], [[1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]))]).
substitution(40, [binding("clock", 1), binding("clocks", [1, 1, 1, 1, 1]), binding("state", [0, 1, 0]), binding("next", [1, 1, 0]), binding("states", [[1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]])]).
proof(40, counter([1, 1, 1, 1, 1, 1], [0, 1, 0], [[1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(23, gcc(1, [0, 1, 0], [1, 1, 0])), uses(39, counter([1, 1, 1, 1, 1], [1, 1, 0], [[1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]))]).
substitution(41, [binding("clock", 1), binding("clocks", [1, 1, 1, 1, 1, 1]), binding("state", [0, 1, 1]), binding("next", [0, 1, 0]), binding("states", [[1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]])]).
proof(41, counter([1, 1, 1, 1, 1, 1, 1], [0, 1, 1], [[0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(20, gcc(1, [0, 1, 1], [0, 1, 0])), uses(40, counter([1, 1, 1, 1, 1, 1], [0, 1, 0], [[1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]))]).
substitution(42, [binding("clock", 1), binding("clocks", [1, 1, 1, 1, 1, 1, 1]), binding("state", [0, 0, 1]), binding("next", [0, 1, 1]), binding("states", [[0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]])]).
proof(42, counter([1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 1], [[0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(16, gcc(1, [0, 0, 1], [0, 1, 1])), uses(41, counter([1, 1, 1, 1, 1, 1, 1], [0, 1, 1], [[0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]))]).
substitution(43, [binding("clock", 1), binding("clocks", [1, 1, 1, 1, 1, 1, 1, 1]), binding("state", [0, 0, 0]), binding("next", [0, 0, 1]), binding("states", [[0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]])]).
proof(43, counter([1, 1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 0], [[0, 0, 1], [0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(12, gcc(1, [0, 0, 0], [0, 0, 1])), uses(42, counter([1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 1], [[0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]))]).
substitution(44, [binding("states", [[0, 0, 1], [0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]])]).
proof(44, solution([[[0, 0, 1], [0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]]), query, [uses(43, counter([1, 1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 0], [[0, 0, 1], [0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]))]).
substitution(45, []).
proof(45, and_gate(1, 1, 1), rule(4), []).
substitution(46, []).
proof(46, inv(1, 0), rule(10), []).
substitution(47, []).
proof(47, and_gate(0, 0, 0), rule(1), []).
substitution(48, []).
proof(48, and_gate(0, 1, 0), rule(2), []).
substitution(49, []).
proof(49, or_gate(1, 0, 1), rule(7), []).
substitution(50, []).
proof(50, or_gate(0, 0, 0), rule(5), []).
substitution(51, [binding("a", 1), binding("b", 0), binding("c", 1), binding("q1", 1), binding("q2", 0), binding("t1", 1), binding("nc", 0), binding("t2", 0), binding("na", 0), binding("t3", 0)]).
proof(51, netb(1, 0, 1, 1, 0), rule(14), [uses(45, and_gate(1, 1, 1)), uses(46, inv(1, 0)), uses(47, and_gate(0, 0, 0)), uses(46, inv(1, 0)), uses(48, and_gate(0, 1, 0)), uses(49, or_gate(1, 0, 1)), uses(50, or_gate(0, 0, 0))]).
substitution(52, []).
proof(52, and_gate(1, 0, 0), rule(3), []).
substitution(53, []).
proof(53, inv(0, 1), rule(9), []).
substitution(54, [binding("a", 1), binding("b", 0), binding("q", 0), binding("t1", 0), binding("na", 0), binding("nb", 1), binding("t2", 0)]).
proof(54, neta(1, 0, 0), rule(13), [uses(52, and_gate(1, 0, 0)), uses(46, inv(1, 0)), uses(53, inv(0, 1)), uses(48, and_gate(0, 1, 0)), uses(50, or_gate(0, 0, 0))]).
substitution(55, [binding("q", 1)]).
proof(55, dff(1, 0, 1, 1), rule(11), []).
substitution(56, [binding("q", 0)]).
proof(56, dff(0, 0, 0, 0), rule(11), []).
substitution(57, [binding("q", 1)]).
proof(57, dff(0, 0, 1, 1), rule(11), []).
substitution(58, [binding("clock", 0), binding("qa", 1), binding("qb", 0), binding("qc", 1), binding("za", 1), binding("zb", 0), binding("zc", 1), binding("d1", 1), binding("d2", 0), binding("d3", 0)]).
proof(58, gcc(0, [1, 0, 1], [1, 0, 1]), rule(15), [uses(51, netb(1, 0, 1, 1, 0)), uses(54, neta(1, 0, 0)), uses(55, dff(1, 0, 1, 1)), uses(56, dff(0, 0, 0, 0)), uses(57, dff(0, 0, 1, 1))]).
substitution(59, [binding("state", [1, 0, 1])]).
proof(59, solution([[1, 0, 1]]), query, [uses(58, gcc(0, [1, 0, 1], [1, 0, 1]))]).
