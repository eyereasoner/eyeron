% Prolog result format 3
query(1, query_dependency(1, _0), ['Ancestor' = _0]).
result(1, complete, 3).
answer(1, ['Ancestor' = 5]).
why(1, ['Ancestor' = 5], 7).
answer(1, ['Ancestor' = 1]).
why(1, ['Ancestor' = 1], 18).
answer(1, ['Ancestor' = 3]).
why(1, ['Ancestor' = 3], 22).
query(2, support(1, _0), ['Fact' = _0]).
result(2, complete, 2).
answer(2, ['Fact' = instance_of(socrates, human)]).
why(2, ['Fact' = instance_of(socrates, human)], 47).
answer(2, ['Fact' = subclass_of(human, mortal)]).
why(2, ['Fact' = subclass_of(human, mortal)], 50).
query(3, answer_applied(1, _0, _1, _2), ['Proof' = _0, 'Name' = _1, 'Value' = _2]).
result(3, complete, 3).
answer(3, ['Proof' = 5, 'Name' = 'Individual', 'Value' = socrates]).
why(3, ['Proof' = 5, 'Name' = 'Individual', 'Value' = socrates], 62).
answer(3, ['Proof' = 5, 'Name' = 'Superclass', 'Value' = mortal]).
why(3, ['Proof' = 5, 'Name' = 'Superclass', 'Value' = mortal], 67).
answer(3, ['Proof' = 5, 'Name' = 'Class', 'Value' = human]).
why(3, ['Proof' = 5, 'Name' = 'Class', 'Value' = human], 70).
clause(4, why(1, [], 6), true).
clause(9, proof(1, instance_of(socrates, human), rule(1), []), true).
clause(13, proof(3, subclass_of(human, mortal), rule(2), []), true).
clause(16, substitution(5, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]), true).
clause(17, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), true).
clause(19, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))]), true).
clause(20, member(var('X'), [var('X')|anonymous(1)]), true).
clause(21, member(var('X'), [anonymous(1)|var('Rest')]), member(var('X'), var('Rest'))).
clause(22, parent_proof(var('Id'), var('Parent')), (proof(var('Id'), anonymous(1), anonymous(2), var('Premises')), member(uses(var('Parent'), anonymous(3)), var('Premises')))).
clause(24, depends_on(var('Id'), var('Parent')), parent_proof(var('Id'), var('Parent'))).
clause(25, depends_on(var('Id'), var('Ancestor')), (parent_proof(var('Id'), var('Parent')), depends_on(var('Parent'), var('Ancestor')))).
clause(26, source_fact(var('Id'), var('Fact')), proof(var('Id'), var('Fact'), rule(anonymous(1)), [])).
clause(28, supporting_fact(var('Id'), var('Fact')), (depends_on(var('Id'), var('Ancestor')), source_fact(var('Ancestor'), var('Fact')))).
clause(29, support(var('Query'), var('Fact')), (why(var('Query'), anonymous(1), var('Proof')), supporting_fact(var('Proof'), var('Fact')))).
clause(30, applied(var('Proof'), var('Name'), var('Value')), (substitution(var('Proof'), var('Bindings')), member(var('Name') = var('Value'), var('Bindings')))).
clause(31, query_dependency(var('Query'), var('Ancestor')), (why(var('Query'), anonymous(1), var('Root')), depends_on(var('Root'), var('Ancestor')))).
clause(32, answer_rule_proof(var('Query'), var('Proof')), (why(var('Query'), anonymous(1), var('Root')), proof(var('Root'), anonymous(2), query, var('Premises')), member(uses(var('Proof'), anonymous(3)), var('Premises')))).
clause(33, answer_applied(var('Query'), var('Proof'), var('Name'), var('Value')), (answer_rule_proof(var('Query'), var('Proof')), applied(var('Proof'), var('Name'), var('Value')))).
substitution(1, []).
proof(1, why(1, [], 6), rule(4), []).
substitution(2, []).
proof(2, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))]), rule(19), []).
substitution(3, ['X' = uses(5, instance_of(socrates, mortal))]).
proof(3, member(uses(5, instance_of(socrates, mortal)), [uses(5, instance_of(socrates, mortal))]), rule(20), []).
substitution(4, ['Id' = 6, 'Parent' = 5, 'Premises' = [uses(5, instance_of(socrates, mortal))]]).
proof(4, parent_proof(6, 5), rule(22), [uses(2, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))])), uses(3, member(uses(5, instance_of(socrates, mortal)), [uses(5, instance_of(socrates, mortal))]))]).
substitution(5, ['Id' = 6, 'Parent' = 5]).
proof(5, depends_on(6, 5), rule(24), [uses(4, parent_proof(6, 5))]).
substitution(6, ['Query' = 1, 'Ancestor' = 5, 'Root' = 6]).
proof(6, query_dependency(1, 5), rule(31), [uses(1, why(1, [], 6)), uses(5, depends_on(6, 5))]).
substitution(7, ['Ancestor' = 5]).
proof(7, solution([5]), query, [uses(6, query_dependency(1, 5))]).
substitution(8, []).
proof(8, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), rule(17), []).
substitution(9, ['X' = uses(1, instance_of(socrates, human))]).
proof(9, member(uses(1, instance_of(socrates, human)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), rule(20), []).
substitution(10, ['Id' = 5, 'Parent' = 1, 'Premises' = [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]]).
proof(10, parent_proof(5, 1), rule(22), [uses(8, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))])), uses(9, member(uses(1, instance_of(socrates, human)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]))]).
substitution(11, ['X' = uses(3, subclass_of(human, mortal))]).
proof(11, member(uses(3, subclass_of(human, mortal)), [uses(3, subclass_of(human, mortal))]), rule(20), []).
substitution(12, ['Id' = 5, 'Parent' = 1]).
proof(12, depends_on(5, 1), rule(24), [uses(10, parent_proof(5, 1))]).
substitution(13, ['X' = uses(3, subclass_of(human, mortal)), 'Rest' = [uses(3, subclass_of(human, mortal))]]).
proof(13, member(uses(3, subclass_of(human, mortal)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), rule(21), [uses(11, member(uses(3, subclass_of(human, mortal)), [uses(3, subclass_of(human, mortal))]))]).
substitution(14, ['Id' = 6, 'Ancestor' = 1, 'Parent' = 5]).
proof(14, depends_on(6, 1), rule(25), [uses(4, parent_proof(6, 5)), uses(12, depends_on(5, 1))]).
substitution(15, ['Id' = 5, 'Parent' = 3, 'Premises' = [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]]).
proof(15, parent_proof(5, 3), rule(22), [uses(8, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))])), uses(13, member(uses(3, subclass_of(human, mortal)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]))]).
substitution(16, ['Query' = 1, 'Ancestor' = 1, 'Root' = 6]).
proof(16, query_dependency(1, 1), rule(31), [uses(1, why(1, [], 6)), uses(14, depends_on(6, 1))]).
substitution(17, ['Id' = 5, 'Parent' = 3]).
proof(17, depends_on(5, 3), rule(24), [uses(15, parent_proof(5, 3))]).
substitution(18, ['Ancestor' = 1]).
proof(18, solution([1]), query, [uses(16, query_dependency(1, 1))]).
substitution(19, []).
proof(19, proof(1, instance_of(socrates, human), rule(1), []), rule(9), []).
substitution(20, ['Id' = 6, 'Ancestor' = 3, 'Parent' = 5]).
proof(20, depends_on(6, 3), rule(25), [uses(4, parent_proof(6, 5)), uses(17, depends_on(5, 3))]).
substitution(21, ['Query' = 1, 'Ancestor' = 3, 'Root' = 6]).
proof(21, query_dependency(1, 3), rule(31), [uses(1, why(1, [], 6)), uses(20, depends_on(6, 3))]).
substitution(22, ['Ancestor' = 3]).
proof(22, solution([3]), query, [uses(21, query_dependency(1, 3))]).
substitution(23, []).
proof(23, proof(3, subclass_of(human, mortal), rule(2), []), rule(13), []).
substitution(24, []).
proof(24, why(1, [], 6), rule(4), []).
substitution(25, []).
proof(25, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))]), rule(19), []).
substitution(26, ['X' = uses(5, instance_of(socrates, mortal))]).
proof(26, member(uses(5, instance_of(socrates, mortal)), [uses(5, instance_of(socrates, mortal))]), rule(20), []).
substitution(27, ['Id' = 6, 'Parent' = 5, 'Premises' = [uses(5, instance_of(socrates, mortal))]]).
proof(27, parent_proof(6, 5), rule(22), [uses(25, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))])), uses(26, member(uses(5, instance_of(socrates, mortal)), [uses(5, instance_of(socrates, mortal))]))]).
substitution(28, ['Id' = 6, 'Parent' = 5]).
proof(28, depends_on(6, 5), rule(24), [uses(27, parent_proof(6, 5))]).
substitution(29, []).
proof(29, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), rule(17), []).
substitution(30, ['X' = uses(1, instance_of(socrates, human))]).
proof(30, member(uses(1, instance_of(socrates, human)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), rule(20), []).
substitution(31, ['Id' = 5, 'Parent' = 1, 'Premises' = [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]]).
proof(31, parent_proof(5, 1), rule(22), [uses(29, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))])), uses(30, member(uses(1, instance_of(socrates, human)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]))]).
substitution(32, ['X' = uses(3, subclass_of(human, mortal))]).
proof(32, member(uses(3, subclass_of(human, mortal)), [uses(3, subclass_of(human, mortal))]), rule(20), []).
substitution(33, ['Id' = 5, 'Parent' = 1]).
proof(33, depends_on(5, 1), rule(24), [uses(31, parent_proof(5, 1))]).
substitution(34, ['X' = uses(3, subclass_of(human, mortal)), 'Rest' = [uses(3, subclass_of(human, mortal))]]).
proof(34, member(uses(3, subclass_of(human, mortal)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), rule(21), [uses(32, member(uses(3, subclass_of(human, mortal)), [uses(3, subclass_of(human, mortal))]))]).
substitution(35, ['Id' = 6, 'Ancestor' = 1, 'Parent' = 5]).
proof(35, depends_on(6, 1), rule(25), [uses(27, parent_proof(6, 5)), uses(33, depends_on(5, 1))]).
substitution(36, ['Id' = 5, 'Parent' = 3, 'Premises' = [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]]).
proof(36, parent_proof(5, 3), rule(22), [uses(29, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))])), uses(34, member(uses(3, subclass_of(human, mortal)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]))]).
substitution(37, ['Id' = 5, 'Parent' = 3]).
proof(37, depends_on(5, 3), rule(24), [uses(36, parent_proof(5, 3))]).
substitution(38, []).
proof(38, proof(1, instance_of(socrates, human), rule(1), []), rule(9), []).
substitution(39, ['Id' = 6, 'Ancestor' = 3, 'Parent' = 5]).
proof(39, depends_on(6, 3), rule(25), [uses(27, parent_proof(6, 5)), uses(37, depends_on(5, 3))]).
substitution(40, []).
proof(40, proof(1, instance_of(socrates, human), rule(1), []), rule(9), []).
substitution(41, ['Id' = 1, 'Fact' = instance_of(socrates, human)]).
proof(41, source_fact(1, instance_of(socrates, human)), rule(26), [uses(40, proof(1, instance_of(socrates, human), rule(1), []))]).
substitution(42, []).
proof(42, proof(3, subclass_of(human, mortal), rule(2), []), rule(13), []).
substitution(43, ['Id' = 6, 'Fact' = instance_of(socrates, human), 'Ancestor' = 1]).
proof(43, supporting_fact(6, instance_of(socrates, human)), rule(28), [uses(35, depends_on(6, 1)), uses(41, source_fact(1, instance_of(socrates, human)))]).
substitution(44, []).
proof(44, proof(3, subclass_of(human, mortal), rule(2), []), rule(13), []).
substitution(45, ['Query' = 1, 'Fact' = instance_of(socrates, human), 'Proof' = 6]).
proof(45, support(1, instance_of(socrates, human)), rule(29), [uses(24, why(1, [], 6)), uses(43, supporting_fact(6, instance_of(socrates, human)))]).
substitution(46, ['Id' = 3, 'Fact' = subclass_of(human, mortal)]).
proof(46, source_fact(3, subclass_of(human, mortal)), rule(26), [uses(44, proof(3, subclass_of(human, mortal), rule(2), []))]).
substitution(47, ['Fact' = instance_of(socrates, human)]).
proof(47, solution([instance_of(socrates, human)]), query, [uses(45, support(1, instance_of(socrates, human)))]).
substitution(48, ['Id' = 6, 'Fact' = subclass_of(human, mortal), 'Ancestor' = 3]).
proof(48, supporting_fact(6, subclass_of(human, mortal)), rule(28), [uses(39, depends_on(6, 3)), uses(46, source_fact(3, subclass_of(human, mortal)))]).
substitution(49, ['Query' = 1, 'Fact' = subclass_of(human, mortal), 'Proof' = 6]).
proof(49, support(1, subclass_of(human, mortal)), rule(29), [uses(24, why(1, [], 6)), uses(48, supporting_fact(6, subclass_of(human, mortal)))]).
substitution(50, ['Fact' = subclass_of(human, mortal)]).
proof(50, solution([subclass_of(human, mortal)]), query, [uses(49, support(1, subclass_of(human, mortal)))]).
substitution(51, []).
proof(51, why(1, [], 6), rule(4), []).
substitution(52, []).
proof(52, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))]), rule(19), []).
substitution(53, ['X' = uses(5, instance_of(socrates, mortal))]).
proof(53, member(uses(5, instance_of(socrates, mortal)), [uses(5, instance_of(socrates, mortal))]), rule(20), []).
substitution(54, ['Query' = 1, 'Proof' = 5, 'Root' = 6, 'Premises' = [uses(5, instance_of(socrates, mortal))]]).
proof(54, answer_rule_proof(1, 5), rule(32), [uses(51, why(1, [], 6)), uses(52, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))])), uses(53, member(uses(5, instance_of(socrates, mortal)), [uses(5, instance_of(socrates, mortal))]))]).
substitution(55, []).
proof(55, substitution(5, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]), rule(16), []).
substitution(56, ['X' = ('Individual' = socrates)]).
proof(56, member('Individual' = socrates, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]), rule(20), []).
substitution(57, ['Proof' = 5, 'Name' = 'Individual', 'Value' = socrates, 'Bindings' = ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]]).
proof(57, applied(5, 'Individual', socrates), rule(30), [uses(55, substitution(5, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human])), uses(56, member('Individual' = socrates, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]))]).
substitution(58, ['X' = ('Superclass' = mortal)]).
proof(58, member('Superclass' = mortal, ['Superclass' = mortal, 'Class' = human]), rule(20), []).
substitution(59, ['Query' = 1, 'Proof' = 5, 'Name' = 'Individual', 'Value' = socrates]).
proof(59, answer_applied(1, 5, 'Individual', socrates), rule(33), [uses(54, answer_rule_proof(1, 5)), uses(57, applied(5, 'Individual', socrates))]).
substitution(60, ['X' = ('Superclass' = mortal), 'Rest' = ['Superclass' = mortal, 'Class' = human]]).
proof(60, member('Superclass' = mortal, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]), rule(21), [uses(58, member('Superclass' = mortal, ['Superclass' = mortal, 'Class' = human]))]).
substitution(61, ['X' = ('Class' = human)]).
proof(61, member('Class' = human, ['Class' = human]), rule(20), []).
substitution(62, ['Proof' = 5, 'Name' = 'Individual', 'Value' = socrates]).
proof(62, solution([5, 'Individual', socrates]), query, [uses(59, answer_applied(1, 5, 'Individual', socrates))]).
substitution(63, ['Proof' = 5, 'Name' = 'Superclass', 'Value' = mortal, 'Bindings' = ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]]).
proof(63, applied(5, 'Superclass', mortal), rule(30), [uses(55, substitution(5, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human])), uses(60, member('Superclass' = mortal, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]))]).
substitution(64, ['X' = ('Class' = human), 'Rest' = ['Class' = human]]).
proof(64, member('Class' = human, ['Superclass' = mortal, 'Class' = human]), rule(21), [uses(61, member('Class' = human, ['Class' = human]))]).
substitution(65, ['Query' = 1, 'Proof' = 5, 'Name' = 'Superclass', 'Value' = mortal]).
proof(65, answer_applied(1, 5, 'Superclass', mortal), rule(33), [uses(54, answer_rule_proof(1, 5)), uses(63, applied(5, 'Superclass', mortal))]).
substitution(66, ['X' = ('Class' = human), 'Rest' = ['Superclass' = mortal, 'Class' = human]]).
proof(66, member('Class' = human, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]), rule(21), [uses(64, member('Class' = human, ['Superclass' = mortal, 'Class' = human]))]).
substitution(67, ['Proof' = 5, 'Name' = 'Superclass', 'Value' = mortal]).
proof(67, solution([5, 'Superclass', mortal]), query, [uses(65, answer_applied(1, 5, 'Superclass', mortal))]).
substitution(68, ['Proof' = 5, 'Name' = 'Class', 'Value' = human, 'Bindings' = ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]]).
proof(68, applied(5, 'Class', human), rule(30), [uses(55, substitution(5, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human])), uses(66, member('Class' = human, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]))]).
substitution(69, ['Query' = 1, 'Proof' = 5, 'Name' = 'Class', 'Value' = human]).
proof(69, answer_applied(1, 5, 'Class', human), rule(33), [uses(54, answer_rule_proof(1, 5)), uses(68, applied(5, 'Class', human))]).
substitution(70, ['Proof' = 5, 'Name' = 'Class', 'Value' = human]).
proof(70, solution([5, 'Class', human]), query, [uses(69, answer_applied(1, 5, 'Class', human))]).
