% Prolog result format 3
query(1, counter([1, 1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 0], _0), ['States' = _0]).
result(1, complete, 1).
answer(1, ['States' = [[0, 0, 1], [0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]]).
why(1, ['States' = [[0, 0, 1], [0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]], 44).
query(2, gcc(0, [1, 0, 1], _0), ['State' = _0]).
result(2, complete, 1).
answer(2, ['State' = [1, 0, 1]]).
why(2, ['State' = [1, 0, 1]], 59).
clause(1, and_gate(0, 0, 0), true).
clause(2, and_gate(0, 1, 0), true).
clause(3, and_gate(1, 0, 0), true).
clause(4, and_gate(1, 1, 1), true).
clause(5, or_gate(0, 0, 0), true).
clause(6, or_gate(0, 1, 1), true).
clause(7, or_gate(1, 0, 1), true).
clause(9, inv(0, 1), true).
clause(10, inv(1, 0), true).
clause(11, dff(anonymous(1), 0, var('Q'), var('Q')), true).
clause(12, dff(var('D'), 1, anonymous(1), var('D')), true).
clause(13, neta(var('A'), var('B'), var('Q')), (and_gate(var('A'), var('B'), var('T1')), inv(var('A'), var('Na')), inv(var('B'), var('Nb')), and_gate(var('Na'), var('Nb'), var('T2')), or_gate(var('T1'), var('T2'), var('Q')))).
clause(14, netb(var('A'), var('B'), var('C'), var('Q1'), var('Q2')), (and_gate(var('A'), var('C'), var('T1')), inv(var('C'), var('Nc')), and_gate(var('B'), var('Nc'), var('T2')), inv(var('A'), var('Na')), and_gate(var('Na'), var('C'), var('T3')), or_gate(var('T1'), var('T2'), var('Q1')), or_gate(var('T2'), var('T3'), var('Q2')))).
clause(15, gcc(var('Clock'), [var('Qa'), var('Qb'), var('Qc')], [var('Za'), var('Zb'), var('Zc')]), (netb(var('Qa'), var('Qb'), var('Qc'), var('D1'), var('D2')), neta(var('Qa'), var('Qb'), var('D3')), dff(var('D1'), var('Clock'), var('Qa'), var('Za')), dff(var('D2'), var('Clock'), var('Qb'), var('Zb')), dff(var('D3'), var('Clock'), var('Qc'), var('Zc')))).
clause(16, counter([], anonymous(1), []), true).
clause(17, counter([var('Clock')|var('Clocks')], var('State'), [var('Next')|var('States')]), (gcc(var('Clock'), var('State'), var('Next')), counter(var('Clocks'), var('Next'), var('States')))).
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
substitution(6, ['A' = 0, 'B' = 0, 'C' = 0, 'Q1' = 0, 'Q2' = 0, 'T1' = 0, 'Nc' = 1, 'T2' = 0, 'Na' = 1, 'T3' = 0]).
proof(6, netb(0, 0, 0, 0, 0), rule(14), [uses(1, and_gate(0, 0, 0)), uses(2, inv(0, 1)), uses(3, and_gate(0, 1, 0)), uses(2, inv(0, 1)), uses(4, and_gate(1, 0, 0)), uses(5, or_gate(0, 0, 0)), uses(5, or_gate(0, 0, 0))]).
substitution(7, []).
proof(7, and_gate(1, 1, 1), rule(4), []).
substitution(8, []).
proof(8, or_gate(0, 1, 1), rule(6), []).
substitution(9, ['A' = 0, 'B' = 0, 'Q' = 1, 'T1' = 0, 'Na' = 1, 'Nb' = 1, 'T2' = 1]).
proof(9, neta(0, 0, 1), rule(13), [uses(1, and_gate(0, 0, 0)), uses(2, inv(0, 1)), uses(2, inv(0, 1)), uses(7, and_gate(1, 1, 1)), uses(8, or_gate(0, 1, 1))]).
substitution(10, ['D' = 0]).
proof(10, dff(0, 1, 0, 0), rule(12), []).
substitution(11, ['D' = 1]).
proof(11, dff(1, 1, 0, 1), rule(12), []).
substitution(12, ['Clock' = 1, 'Qa' = 0, 'Qb' = 0, 'Qc' = 0, 'Za' = 0, 'Zb' = 0, 'Zc' = 1, 'D1' = 0, 'D2' = 0, 'D3' = 1]).
proof(12, gcc(1, [0, 0, 0], [0, 0, 1]), rule(15), [uses(6, netb(0, 0, 0, 0, 0)), uses(9, neta(0, 0, 1)), uses(10, dff(0, 1, 0, 0)), uses(10, dff(0, 1, 0, 0)), uses(11, dff(1, 1, 0, 1))]).
substitution(13, []).
proof(13, inv(1, 0), rule(10), []).
substitution(14, ['A' = 0, 'B' = 0, 'C' = 1, 'Q1' = 0, 'Q2' = 1, 'T1' = 0, 'Nc' = 0, 'T2' = 0, 'Na' = 1, 'T3' = 1]).
proof(14, netb(0, 0, 1, 0, 1), rule(14), [uses(3, and_gate(0, 1, 0)), uses(13, inv(1, 0)), uses(1, and_gate(0, 0, 0)), uses(2, inv(0, 1)), uses(7, and_gate(1, 1, 1)), uses(5, or_gate(0, 0, 0)), uses(8, or_gate(0, 1, 1))]).
substitution(15, ['D' = 1]).
proof(15, dff(1, 1, 1, 1), rule(12), []).
substitution(16, ['Clock' = 1, 'Qa' = 0, 'Qb' = 0, 'Qc' = 1, 'Za' = 0, 'Zb' = 1, 'Zc' = 1, 'D1' = 0, 'D2' = 1, 'D3' = 1]).
proof(16, gcc(1, [0, 0, 1], [0, 1, 1]), rule(15), [uses(14, netb(0, 0, 1, 0, 1)), uses(9, neta(0, 0, 1)), uses(10, dff(0, 1, 0, 0)), uses(11, dff(1, 1, 0, 1)), uses(15, dff(1, 1, 1, 1))]).
substitution(17, ['A' = 0, 'B' = 1, 'C' = 1, 'Q1' = 0, 'Q2' = 1, 'T1' = 0, 'Nc' = 0, 'T2' = 0, 'Na' = 1, 'T3' = 1]).
proof(17, netb(0, 1, 1, 0, 1), rule(14), [uses(3, and_gate(0, 1, 0)), uses(13, inv(1, 0)), uses(4, and_gate(1, 0, 0)), uses(2, inv(0, 1)), uses(7, and_gate(1, 1, 1)), uses(5, or_gate(0, 0, 0)), uses(8, or_gate(0, 1, 1))]).
substitution(18, ['A' = 0, 'B' = 1, 'Q' = 0, 'T1' = 0, 'Na' = 1, 'Nb' = 0, 'T2' = 0]).
proof(18, neta(0, 1, 0), rule(13), [uses(3, and_gate(0, 1, 0)), uses(2, inv(0, 1)), uses(13, inv(1, 0)), uses(4, and_gate(1, 0, 0)), uses(5, or_gate(0, 0, 0))]).
substitution(19, ['D' = 0]).
proof(19, dff(0, 1, 1, 0), rule(12), []).
substitution(20, ['Clock' = 1, 'Qa' = 0, 'Qb' = 1, 'Qc' = 1, 'Za' = 0, 'Zb' = 1, 'Zc' = 0, 'D1' = 0, 'D2' = 1, 'D3' = 0]).
proof(20, gcc(1, [0, 1, 1], [0, 1, 0]), rule(15), [uses(17, netb(0, 1, 1, 0, 1)), uses(18, neta(0, 1, 0)), uses(10, dff(0, 1, 0, 0)), uses(15, dff(1, 1, 1, 1)), uses(19, dff(0, 1, 1, 0))]).
substitution(21, []).
proof(21, or_gate(1, 0, 1), rule(7), []).
substitution(22, ['A' = 0, 'B' = 1, 'C' = 0, 'Q1' = 1, 'Q2' = 1, 'T1' = 0, 'Nc' = 1, 'T2' = 1, 'Na' = 1, 'T3' = 0]).
proof(22, netb(0, 1, 0, 1, 1), rule(14), [uses(1, and_gate(0, 0, 0)), uses(2, inv(0, 1)), uses(7, and_gate(1, 1, 1)), uses(2, inv(0, 1)), uses(4, and_gate(1, 0, 0)), uses(8, or_gate(0, 1, 1)), uses(21, or_gate(1, 0, 1))]).
substitution(23, ['Clock' = 1, 'Qa' = 0, 'Qb' = 1, 'Qc' = 0, 'Za' = 1, 'Zb' = 1, 'Zc' = 0, 'D1' = 1, 'D2' = 1, 'D3' = 0]).
proof(23, gcc(1, [0, 1, 0], [1, 1, 0]), rule(15), [uses(22, netb(0, 1, 0, 1, 1)), uses(18, neta(0, 1, 0)), uses(11, dff(1, 1, 0, 1)), uses(15, dff(1, 1, 1, 1)), uses(10, dff(0, 1, 0, 0))]).
substitution(24, ['A' = 1, 'B' = 1, 'C' = 0, 'Q1' = 1, 'Q2' = 1, 'T1' = 0, 'Nc' = 1, 'T2' = 1, 'Na' = 0, 'T3' = 0]).
proof(24, netb(1, 1, 0, 1, 1), rule(14), [uses(4, and_gate(1, 0, 0)), uses(2, inv(0, 1)), uses(7, and_gate(1, 1, 1)), uses(13, inv(1, 0)), uses(1, and_gate(0, 0, 0)), uses(8, or_gate(0, 1, 1)), uses(21, or_gate(1, 0, 1))]).
substitution(25, ['A' = 1, 'B' = 1, 'Q' = 1, 'T1' = 1, 'Na' = 0, 'Nb' = 0, 'T2' = 0]).
proof(25, neta(1, 1, 1), rule(13), [uses(7, and_gate(1, 1, 1)), uses(13, inv(1, 0)), uses(13, inv(1, 0)), uses(1, and_gate(0, 0, 0)), uses(21, or_gate(1, 0, 1))]).
substitution(26, ['Clock' = 1, 'Qa' = 1, 'Qb' = 1, 'Qc' = 0, 'Za' = 1, 'Zb' = 1, 'Zc' = 1, 'D1' = 1, 'D2' = 1, 'D3' = 1]).
proof(26, gcc(1, [1, 1, 0], [1, 1, 1]), rule(15), [uses(24, netb(1, 1, 0, 1, 1)), uses(25, neta(1, 1, 1)), uses(15, dff(1, 1, 1, 1)), uses(15, dff(1, 1, 1, 1)), uses(11, dff(1, 1, 0, 1))]).
substitution(27, ['A' = 1, 'B' = 1, 'C' = 1, 'Q1' = 1, 'Q2' = 0, 'T1' = 1, 'Nc' = 0, 'T2' = 0, 'Na' = 0, 'T3' = 0]).
proof(27, netb(1, 1, 1, 1, 0), rule(14), [uses(7, and_gate(1, 1, 1)), uses(13, inv(1, 0)), uses(4, and_gate(1, 0, 0)), uses(13, inv(1, 0)), uses(3, and_gate(0, 1, 0)), uses(21, or_gate(1, 0, 1)), uses(5, or_gate(0, 0, 0))]).
substitution(28, ['Clock' = 1, 'Qa' = 1, 'Qb' = 1, 'Qc' = 1, 'Za' = 1, 'Zb' = 0, 'Zc' = 1, 'D1' = 1, 'D2' = 0, 'D3' = 1]).
proof(28, gcc(1, [1, 1, 1], [1, 0, 1]), rule(15), [uses(27, netb(1, 1, 1, 1, 0)), uses(25, neta(1, 1, 1)), uses(15, dff(1, 1, 1, 1)), uses(19, dff(0, 1, 1, 0)), uses(15, dff(1, 1, 1, 1))]).
substitution(29, ['A' = 1, 'B' = 0, 'C' = 1, 'Q1' = 1, 'Q2' = 0, 'T1' = 1, 'Nc' = 0, 'T2' = 0, 'Na' = 0, 'T3' = 0]).
proof(29, netb(1, 0, 1, 1, 0), rule(14), [uses(7, and_gate(1, 1, 1)), uses(13, inv(1, 0)), uses(1, and_gate(0, 0, 0)), uses(13, inv(1, 0)), uses(3, and_gate(0, 1, 0)), uses(21, or_gate(1, 0, 1)), uses(5, or_gate(0, 0, 0))]).
substitution(30, ['A' = 1, 'B' = 0, 'Q' = 0, 'T1' = 0, 'Na' = 0, 'Nb' = 1, 'T2' = 0]).
proof(30, neta(1, 0, 0), rule(13), [uses(4, and_gate(1, 0, 0)), uses(13, inv(1, 0)), uses(2, inv(0, 1)), uses(3, and_gate(0, 1, 0)), uses(5, or_gate(0, 0, 0))]).
substitution(31, ['Clock' = 1, 'Qa' = 1, 'Qb' = 0, 'Qc' = 1, 'Za' = 1, 'Zb' = 0, 'Zc' = 0, 'D1' = 1, 'D2' = 0, 'D3' = 0]).
proof(31, gcc(1, [1, 0, 1], [1, 0, 0]), rule(15), [uses(29, netb(1, 0, 1, 1, 0)), uses(30, neta(1, 0, 0)), uses(15, dff(1, 1, 1, 1)), uses(10, dff(0, 1, 0, 0)), uses(19, dff(0, 1, 1, 0))]).
substitution(32, ['A' = 1, 'B' = 0, 'C' = 0, 'Q1' = 0, 'Q2' = 0, 'T1' = 0, 'Nc' = 1, 'T2' = 0, 'Na' = 0, 'T3' = 0]).
proof(32, netb(1, 0, 0, 0, 0), rule(14), [uses(4, and_gate(1, 0, 0)), uses(2, inv(0, 1)), uses(3, and_gate(0, 1, 0)), uses(13, inv(1, 0)), uses(1, and_gate(0, 0, 0)), uses(5, or_gate(0, 0, 0)), uses(5, or_gate(0, 0, 0))]).
substitution(33, ['Clock' = 1, 'Qa' = 1, 'Qb' = 0, 'Qc' = 0, 'Za' = 0, 'Zb' = 0, 'Zc' = 0, 'D1' = 0, 'D2' = 0, 'D3' = 0]).
proof(33, gcc(1, [1, 0, 0], [0, 0, 0]), rule(15), [uses(32, netb(1, 0, 0, 0, 0)), uses(30, neta(1, 0, 0)), uses(19, dff(0, 1, 1, 0)), uses(10, dff(0, 1, 0, 0)), uses(10, dff(0, 1, 0, 0))]).
substitution(34, []).
proof(34, counter([], [0, 0, 1], []), rule(16), []).
substitution(35, ['Clock' = 1, 'Clocks' = [], 'State' = [0, 0, 0], 'Next' = [0, 0, 1], 'States' = []]).
proof(35, counter([1], [0, 0, 0], [[0, 0, 1]]), rule(17), [uses(12, gcc(1, [0, 0, 0], [0, 0, 1])), uses(34, counter([], [0, 0, 1], []))]).
substitution(36, ['Clock' = 1, 'Clocks' = [1], 'State' = [1, 0, 0], 'Next' = [0, 0, 0], 'States' = [[0, 0, 1]]]).
proof(36, counter([1, 1], [1, 0, 0], [[0, 0, 0], [0, 0, 1]]), rule(17), [uses(33, gcc(1, [1, 0, 0], [0, 0, 0])), uses(35, counter([1], [0, 0, 0], [[0, 0, 1]]))]).
substitution(37, ['Clock' = 1, 'Clocks' = [1, 1], 'State' = [1, 0, 1], 'Next' = [1, 0, 0], 'States' = [[0, 0, 0], [0, 0, 1]]]).
proof(37, counter([1, 1, 1], [1, 0, 1], [[1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(31, gcc(1, [1, 0, 1], [1, 0, 0])), uses(36, counter([1, 1], [1, 0, 0], [[0, 0, 0], [0, 0, 1]]))]).
substitution(38, ['Clock' = 1, 'Clocks' = [1, 1, 1], 'State' = [1, 1, 1], 'Next' = [1, 0, 1], 'States' = [[1, 0, 0], [0, 0, 0], [0, 0, 1]]]).
proof(38, counter([1, 1, 1, 1], [1, 1, 1], [[1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(28, gcc(1, [1, 1, 1], [1, 0, 1])), uses(37, counter([1, 1, 1], [1, 0, 1], [[1, 0, 0], [0, 0, 0], [0, 0, 1]]))]).
substitution(39, ['Clock' = 1, 'Clocks' = [1, 1, 1, 1], 'State' = [1, 1, 0], 'Next' = [1, 1, 1], 'States' = [[1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]]).
proof(39, counter([1, 1, 1, 1, 1], [1, 1, 0], [[1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(26, gcc(1, [1, 1, 0], [1, 1, 1])), uses(38, counter([1, 1, 1, 1], [1, 1, 1], [[1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]))]).
substitution(40, ['Clock' = 1, 'Clocks' = [1, 1, 1, 1, 1], 'State' = [0, 1, 0], 'Next' = [1, 1, 0], 'States' = [[1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]]).
proof(40, counter([1, 1, 1, 1, 1, 1], [0, 1, 0], [[1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(23, gcc(1, [0, 1, 0], [1, 1, 0])), uses(39, counter([1, 1, 1, 1, 1], [1, 1, 0], [[1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]))]).
substitution(41, ['Clock' = 1, 'Clocks' = [1, 1, 1, 1, 1, 1], 'State' = [0, 1, 1], 'Next' = [0, 1, 0], 'States' = [[1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]]).
proof(41, counter([1, 1, 1, 1, 1, 1, 1], [0, 1, 1], [[0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(20, gcc(1, [0, 1, 1], [0, 1, 0])), uses(40, counter([1, 1, 1, 1, 1, 1], [0, 1, 0], [[1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]))]).
substitution(42, ['Clock' = 1, 'Clocks' = [1, 1, 1, 1, 1, 1, 1], 'State' = [0, 0, 1], 'Next' = [0, 1, 1], 'States' = [[0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]]).
proof(42, counter([1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 1], [[0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(16, gcc(1, [0, 0, 1], [0, 1, 1])), uses(41, counter([1, 1, 1, 1, 1, 1, 1], [0, 1, 1], [[0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]))]).
substitution(43, ['Clock' = 1, 'Clocks' = [1, 1, 1, 1, 1, 1, 1, 1], 'State' = [0, 0, 0], 'Next' = [0, 0, 1], 'States' = [[0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]]).
proof(43, counter([1, 1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 0], [[0, 0, 1], [0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]), rule(17), [uses(12, gcc(1, [0, 0, 0], [0, 0, 1])), uses(42, counter([1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 1], [[0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]))]).
substitution(44, ['States' = [[0, 0, 1], [0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]]]).
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
substitution(51, ['A' = 1, 'B' = 0, 'C' = 1, 'Q1' = 1, 'Q2' = 0, 'T1' = 1, 'Nc' = 0, 'T2' = 0, 'Na' = 0, 'T3' = 0]).
proof(51, netb(1, 0, 1, 1, 0), rule(14), [uses(45, and_gate(1, 1, 1)), uses(46, inv(1, 0)), uses(47, and_gate(0, 0, 0)), uses(46, inv(1, 0)), uses(48, and_gate(0, 1, 0)), uses(49, or_gate(1, 0, 1)), uses(50, or_gate(0, 0, 0))]).
substitution(52, []).
proof(52, and_gate(1, 0, 0), rule(3), []).
substitution(53, []).
proof(53, inv(0, 1), rule(9), []).
substitution(54, ['A' = 1, 'B' = 0, 'Q' = 0, 'T1' = 0, 'Na' = 0, 'Nb' = 1, 'T2' = 0]).
proof(54, neta(1, 0, 0), rule(13), [uses(52, and_gate(1, 0, 0)), uses(46, inv(1, 0)), uses(53, inv(0, 1)), uses(48, and_gate(0, 1, 0)), uses(50, or_gate(0, 0, 0))]).
substitution(55, ['Q' = 1]).
proof(55, dff(1, 0, 1, 1), rule(11), []).
substitution(56, ['Q' = 0]).
proof(56, dff(0, 0, 0, 0), rule(11), []).
substitution(57, ['Q' = 1]).
proof(57, dff(0, 0, 1, 1), rule(11), []).
substitution(58, ['Clock' = 0, 'Qa' = 1, 'Qb' = 0, 'Qc' = 1, 'Za' = 1, 'Zb' = 0, 'Zc' = 1, 'D1' = 1, 'D2' = 0, 'D3' = 0]).
proof(58, gcc(0, [1, 0, 1], [1, 0, 1]), rule(15), [uses(51, netb(1, 0, 1, 1, 0)), uses(54, neta(1, 0, 0)), uses(55, dff(1, 0, 1, 1)), uses(56, dff(0, 0, 0, 0)), uses(57, dff(0, 0, 1, 1))]).
substitution(59, ['State' = [1, 0, 1]]).
proof(59, solution([[1, 0, 1]]), query, [uses(58, gcc(0, [1, 0, 1], [1, 0, 1]))]).
