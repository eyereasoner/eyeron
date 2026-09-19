# Eyelang result format 2
query(1, [call(query_dependency(1, ?v0))], [binding("ancestor", ?v0)]).
result(1, complete, 3).
answer(1, [binding("ancestor", 5)]).
why(1, [binding("ancestor", 5)], 7).
answer(1, [binding("ancestor", 1)]).
why(1, [binding("ancestor", 1)], 18).
answer(1, [binding("ancestor", 3)]).
why(1, [binding("ancestor", 3)], 22).
query(2, [call(support(1, ?v0))], [binding("fact", ?v0)]).
result(2, complete, 2).
answer(2, [binding("fact", instance_of(socrates, human))]).
why(2, [binding("fact", instance_of(socrates, human))], 47).
answer(2, [binding("fact", subclass_of(human, mortal))]).
why(2, [binding("fact", subclass_of(human, mortal))], 50).
query(3, [call(answer_applied(1, ?v0, ?v1, ?v2))], [binding("proof", ?v0), binding("name", ?v1), binding("value", ?v2)]).
result(3, complete, 3).
answer(3, [binding("proof", 5), binding("name", "individual"), binding("value", socrates)]).
why(3, [binding("proof", 5), binding("name", "individual"), binding("value", socrates)], 62).
answer(3, [binding("proof", 5), binding("name", "superclass"), binding("value", mortal)]).
why(3, [binding("proof", 5), binding("name", "superclass"), binding("value", mortal)], 67).
answer(3, [binding("proof", 5), binding("name", "class"), binding("value", human)]).
why(3, [binding("proof", 5), binding("name", "class"), binding("value", human)], 70).
clause(4, why(1, [], 6), []).
clause(9, proof(1, instance_of(socrates, human), rule(1), []), []).
clause(13, proof(3, subclass_of(human, mortal), rule(2), []), []).
clause(16, substitution(5, [binding("individual", socrates), binding("superclass", mortal), binding("class", human)]), []).
clause(17, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), []).
clause(19, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))]), []).
clause(20, member(var("x"), [var("x") | anonymous(1)]), []).
clause(21, member(var("x"), [anonymous(1) | var("rest")]), [call(member(var("x"), var("rest")))]).
clause(22, parent_proof(var("id"), var("parent")), [call(proof(var("id"), anonymous(1), anonymous(2), var("premises"))), call(member(uses(var("parent"), anonymous(3)), var("premises")))]).
clause(24, depends_on(var("id"), var("parent")), [call(parent_proof(var("id"), var("parent")))]).
clause(25, depends_on(var("id"), var("ancestor")), [call(parent_proof(var("id"), var("parent"))), call(depends_on(var("parent"), var("ancestor")))]).
clause(26, source_fact(var("id"), var("fact")), [call(proof(var("id"), var("fact"), rule(anonymous(1)), []))]).
clause(29, supporting_fact(var("id"), var("fact")), [call(depends_on(var("id"), var("ancestor"))), call(source_fact(var("ancestor"), var("fact")))]).
clause(30, support(var("query"), var("fact")), [call(why(var("query"), anonymous(1), var("proof"))), call(supporting_fact(var("proof"), var("fact")))]).
clause(31, applied(var("proof"), var("name"), var("value")), [call(substitution(var("proof"), var("bindings"))), call(member(binding(var("name"), var("value")), var("bindings")))]).
clause(32, query_dependency(var("query"), var("ancestor")), [call(why(var("query"), anonymous(1), var("root"))), call(depends_on(var("root"), var("ancestor")))]).
clause(33, answer_rule_proof(var("query"), var("proof")), [call(why(var("query"), anonymous(1), var("root"))), call(proof(var("root"), anonymous(2), query, var("premises"))), call(member(uses(var("proof"), anonymous(3)), var("premises")))]).
clause(34, answer_applied(var("query"), var("proof"), var("name"), var("value")), [call(answer_rule_proof(var("query"), var("proof"))), call(applied(var("proof"), var("name"), var("value")))]).
substitution(1, []).
proof(1, why(1, [], 6), rule(4), []).
substitution(2, []).
proof(2, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))]), rule(19), []).
substitution(3, [binding("x", uses(5, instance_of(socrates, mortal)))]).
proof(3, member(uses(5, instance_of(socrates, mortal)), [uses(5, instance_of(socrates, mortal))]), rule(20), []).
substitution(4, [binding("id", 6), binding("parent", 5), binding("premises", [uses(5, instance_of(socrates, mortal))])]).
proof(4, parent_proof(6, 5), rule(22), [uses(2, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))])), uses(3, member(uses(5, instance_of(socrates, mortal)), [uses(5, instance_of(socrates, mortal))]))]).
substitution(5, [binding("id", 6), binding("parent", 5)]).
proof(5, depends_on(6, 5), rule(24), [uses(4, parent_proof(6, 5))]).
substitution(6, [binding("query", 1), binding("ancestor", 5), binding("root", 6)]).
proof(6, query_dependency(1, 5), rule(32), [uses(1, why(1, [], 6)), uses(5, depends_on(6, 5))]).
substitution(7, [binding("ancestor", 5)]).
proof(7, solution([5]), query, [uses(6, query_dependency(1, 5))]).
substitution(8, []).
proof(8, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), rule(17), []).
substitution(9, [binding("x", uses(1, instance_of(socrates, human)))]).
proof(9, member(uses(1, instance_of(socrates, human)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), rule(20), []).
substitution(10, [binding("id", 5), binding("parent", 1), binding("premises", [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))])]).
proof(10, parent_proof(5, 1), rule(22), [uses(8, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))])), uses(9, member(uses(1, instance_of(socrates, human)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]))]).
substitution(11, [binding("x", uses(3, subclass_of(human, mortal)))]).
proof(11, member(uses(3, subclass_of(human, mortal)), [uses(3, subclass_of(human, mortal))]), rule(20), []).
substitution(12, [binding("id", 5), binding("parent", 1)]).
proof(12, depends_on(5, 1), rule(24), [uses(10, parent_proof(5, 1))]).
substitution(13, [binding("x", uses(3, subclass_of(human, mortal))), binding("rest", [uses(3, subclass_of(human, mortal))])]).
proof(13, member(uses(3, subclass_of(human, mortal)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), rule(21), [uses(11, member(uses(3, subclass_of(human, mortal)), [uses(3, subclass_of(human, mortal))]))]).
substitution(14, [binding("id", 6), binding("ancestor", 1), binding("parent", 5)]).
proof(14, depends_on(6, 1), rule(25), [uses(4, parent_proof(6, 5)), uses(12, depends_on(5, 1))]).
substitution(15, [binding("id", 5), binding("parent", 3), binding("premises", [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))])]).
proof(15, parent_proof(5, 3), rule(22), [uses(8, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))])), uses(13, member(uses(3, subclass_of(human, mortal)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]))]).
substitution(16, [binding("query", 1), binding("ancestor", 1), binding("root", 6)]).
proof(16, query_dependency(1, 1), rule(32), [uses(1, why(1, [], 6)), uses(14, depends_on(6, 1))]).
substitution(17, [binding("id", 5), binding("parent", 3)]).
proof(17, depends_on(5, 3), rule(24), [uses(15, parent_proof(5, 3))]).
substitution(18, [binding("ancestor", 1)]).
proof(18, solution([1]), query, [uses(16, query_dependency(1, 1))]).
substitution(19, []).
proof(19, proof(1, instance_of(socrates, human), rule(1), []), rule(9), []).
substitution(20, [binding("id", 6), binding("ancestor", 3), binding("parent", 5)]).
proof(20, depends_on(6, 3), rule(25), [uses(4, parent_proof(6, 5)), uses(17, depends_on(5, 3))]).
substitution(21, [binding("query", 1), binding("ancestor", 3), binding("root", 6)]).
proof(21, query_dependency(1, 3), rule(32), [uses(1, why(1, [], 6)), uses(20, depends_on(6, 3))]).
substitution(22, [binding("ancestor", 3)]).
proof(22, solution([3]), query, [uses(21, query_dependency(1, 3))]).
substitution(23, []).
proof(23, proof(3, subclass_of(human, mortal), rule(2), []), rule(13), []).
substitution(24, []).
proof(24, why(1, [], 6), rule(4), []).
substitution(25, []).
proof(25, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))]), rule(19), []).
substitution(26, [binding("x", uses(5, instance_of(socrates, mortal)))]).
proof(26, member(uses(5, instance_of(socrates, mortal)), [uses(5, instance_of(socrates, mortal))]), rule(20), []).
substitution(27, [binding("id", 6), binding("parent", 5), binding("premises", [uses(5, instance_of(socrates, mortal))])]).
proof(27, parent_proof(6, 5), rule(22), [uses(25, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))])), uses(26, member(uses(5, instance_of(socrates, mortal)), [uses(5, instance_of(socrates, mortal))]))]).
substitution(28, [binding("id", 6), binding("parent", 5)]).
proof(28, depends_on(6, 5), rule(24), [uses(27, parent_proof(6, 5))]).
substitution(29, []).
proof(29, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), rule(17), []).
substitution(30, [binding("x", uses(1, instance_of(socrates, human)))]).
proof(30, member(uses(1, instance_of(socrates, human)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), rule(20), []).
substitution(31, [binding("id", 5), binding("parent", 1), binding("premises", [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))])]).
proof(31, parent_proof(5, 1), rule(22), [uses(29, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))])), uses(30, member(uses(1, instance_of(socrates, human)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]))]).
substitution(32, [binding("x", uses(3, subclass_of(human, mortal)))]).
proof(32, member(uses(3, subclass_of(human, mortal)), [uses(3, subclass_of(human, mortal))]), rule(20), []).
substitution(33, [binding("id", 5), binding("parent", 1)]).
proof(33, depends_on(5, 1), rule(24), [uses(31, parent_proof(5, 1))]).
substitution(34, [binding("x", uses(3, subclass_of(human, mortal))), binding("rest", [uses(3, subclass_of(human, mortal))])]).
proof(34, member(uses(3, subclass_of(human, mortal)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]), rule(21), [uses(32, member(uses(3, subclass_of(human, mortal)), [uses(3, subclass_of(human, mortal))]))]).
substitution(35, [binding("id", 6), binding("ancestor", 1), binding("parent", 5)]).
proof(35, depends_on(6, 1), rule(25), [uses(27, parent_proof(6, 5)), uses(33, depends_on(5, 1))]).
substitution(36, [binding("id", 5), binding("parent", 3), binding("premises", [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))])]).
proof(36, parent_proof(5, 3), rule(22), [uses(29, proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))])), uses(34, member(uses(3, subclass_of(human, mortal)), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]))]).
substitution(37, [binding("id", 5), binding("parent", 3)]).
proof(37, depends_on(5, 3), rule(24), [uses(36, parent_proof(5, 3))]).
substitution(38, []).
proof(38, proof(1, instance_of(socrates, human), rule(1), []), rule(9), []).
substitution(39, [binding("id", 6), binding("ancestor", 3), binding("parent", 5)]).
proof(39, depends_on(6, 3), rule(25), [uses(27, parent_proof(6, 5)), uses(37, depends_on(5, 3))]).
substitution(40, []).
proof(40, proof(1, instance_of(socrates, human), rule(1), []), rule(9), []).
substitution(41, [binding("id", 1), binding("fact", instance_of(socrates, human))]).
proof(41, source_fact(1, instance_of(socrates, human)), rule(26), [uses(40, proof(1, instance_of(socrates, human), rule(1), []))]).
substitution(42, []).
proof(42, proof(3, subclass_of(human, mortal), rule(2), []), rule(13), []).
substitution(43, [binding("id", 6), binding("fact", instance_of(socrates, human)), binding("ancestor", 1)]).
proof(43, supporting_fact(6, instance_of(socrates, human)), rule(29), [uses(35, depends_on(6, 1)), uses(41, source_fact(1, instance_of(socrates, human)))]).
substitution(44, []).
proof(44, proof(3, subclass_of(human, mortal), rule(2), []), rule(13), []).
substitution(45, [binding("query", 1), binding("fact", instance_of(socrates, human)), binding("proof", 6)]).
proof(45, support(1, instance_of(socrates, human)), rule(30), [uses(24, why(1, [], 6)), uses(43, supporting_fact(6, instance_of(socrates, human)))]).
substitution(46, [binding("id", 3), binding("fact", subclass_of(human, mortal))]).
proof(46, source_fact(3, subclass_of(human, mortal)), rule(26), [uses(44, proof(3, subclass_of(human, mortal), rule(2), []))]).
substitution(47, [binding("fact", instance_of(socrates, human))]).
proof(47, solution([instance_of(socrates, human)]), query, [uses(45, support(1, instance_of(socrates, human)))]).
substitution(48, [binding("id", 6), binding("fact", subclass_of(human, mortal)), binding("ancestor", 3)]).
proof(48, supporting_fact(6, subclass_of(human, mortal)), rule(29), [uses(39, depends_on(6, 3)), uses(46, source_fact(3, subclass_of(human, mortal)))]).
substitution(49, [binding("query", 1), binding("fact", subclass_of(human, mortal)), binding("proof", 6)]).
proof(49, support(1, subclass_of(human, mortal)), rule(30), [uses(24, why(1, [], 6)), uses(48, supporting_fact(6, subclass_of(human, mortal)))]).
substitution(50, [binding("fact", subclass_of(human, mortal))]).
proof(50, solution([subclass_of(human, mortal)]), query, [uses(49, support(1, subclass_of(human, mortal)))]).
substitution(51, []).
proof(51, why(1, [], 6), rule(4), []).
substitution(52, []).
proof(52, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))]), rule(19), []).
substitution(53, [binding("x", uses(5, instance_of(socrates, mortal)))]).
proof(53, member(uses(5, instance_of(socrates, mortal)), [uses(5, instance_of(socrates, mortal))]), rule(20), []).
substitution(54, [binding("query", 1), binding("proof", 5), binding("root", 6), binding("premises", [uses(5, instance_of(socrates, mortal))])]).
proof(54, answer_rule_proof(1, 5), rule(33), [uses(51, why(1, [], 6)), uses(52, proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))])), uses(53, member(uses(5, instance_of(socrates, mortal)), [uses(5, instance_of(socrates, mortal))]))]).
substitution(55, []).
proof(55, substitution(5, [binding("individual", socrates), binding("superclass", mortal), binding("class", human)]), rule(16), []).
substitution(56, [binding("x", binding("individual", socrates))]).
proof(56, member(binding("individual", socrates), [binding("individual", socrates), binding("superclass", mortal), binding("class", human)]), rule(20), []).
substitution(57, [binding("proof", 5), binding("name", "individual"), binding("value", socrates), binding("bindings", [binding("individual", socrates), binding("superclass", mortal), binding("class", human)])]).
proof(57, applied(5, "individual", socrates), rule(31), [uses(55, substitution(5, [binding("individual", socrates), binding("superclass", mortal), binding("class", human)])), uses(56, member(binding("individual", socrates), [binding("individual", socrates), binding("superclass", mortal), binding("class", human)]))]).
substitution(58, [binding("x", binding("superclass", mortal))]).
proof(58, member(binding("superclass", mortal), [binding("superclass", mortal), binding("class", human)]), rule(20), []).
substitution(59, [binding("query", 1), binding("proof", 5), binding("name", "individual"), binding("value", socrates)]).
proof(59, answer_applied(1, 5, "individual", socrates), rule(34), [uses(54, answer_rule_proof(1, 5)), uses(57, applied(5, "individual", socrates))]).
substitution(60, [binding("x", binding("superclass", mortal)), binding("rest", [binding("superclass", mortal), binding("class", human)])]).
proof(60, member(binding("superclass", mortal), [binding("individual", socrates), binding("superclass", mortal), binding("class", human)]), rule(21), [uses(58, member(binding("superclass", mortal), [binding("superclass", mortal), binding("class", human)]))]).
substitution(61, [binding("x", binding("class", human))]).
proof(61, member(binding("class", human), [binding("class", human)]), rule(20), []).
substitution(62, [binding("proof", 5), binding("name", "individual"), binding("value", socrates)]).
proof(62, solution([5, "individual", socrates]), query, [uses(59, answer_applied(1, 5, "individual", socrates))]).
substitution(63, [binding("proof", 5), binding("name", "superclass"), binding("value", mortal), binding("bindings", [binding("individual", socrates), binding("superclass", mortal), binding("class", human)])]).
proof(63, applied(5, "superclass", mortal), rule(31), [uses(55, substitution(5, [binding("individual", socrates), binding("superclass", mortal), binding("class", human)])), uses(60, member(binding("superclass", mortal), [binding("individual", socrates), binding("superclass", mortal), binding("class", human)]))]).
substitution(64, [binding("x", binding("class", human)), binding("rest", [binding("class", human)])]).
proof(64, member(binding("class", human), [binding("superclass", mortal), binding("class", human)]), rule(21), [uses(61, member(binding("class", human), [binding("class", human)]))]).
substitution(65, [binding("query", 1), binding("proof", 5), binding("name", "superclass"), binding("value", mortal)]).
proof(65, answer_applied(1, 5, "superclass", mortal), rule(34), [uses(54, answer_rule_proof(1, 5)), uses(63, applied(5, "superclass", mortal))]).
substitution(66, [binding("x", binding("class", human)), binding("rest", [binding("superclass", mortal), binding("class", human)])]).
proof(66, member(binding("class", human), [binding("individual", socrates), binding("superclass", mortal), binding("class", human)]), rule(21), [uses(64, member(binding("class", human), [binding("superclass", mortal), binding("class", human)]))]).
substitution(67, [binding("proof", 5), binding("name", "superclass"), binding("value", mortal)]).
proof(67, solution([5, "superclass", mortal]), query, [uses(65, answer_applied(1, 5, "superclass", mortal))]).
substitution(68, [binding("proof", 5), binding("name", "class"), binding("value", human), binding("bindings", [binding("individual", socrates), binding("superclass", mortal), binding("class", human)])]).
proof(68, applied(5, "class", human), rule(31), [uses(55, substitution(5, [binding("individual", socrates), binding("superclass", mortal), binding("class", human)])), uses(66, member(binding("class", human), [binding("individual", socrates), binding("superclass", mortal), binding("class", human)]))]).
substitution(69, [binding("query", 1), binding("proof", 5), binding("name", "class"), binding("value", human)]).
proof(69, answer_applied(1, 5, "class", human), rule(34), [uses(54, answer_rule_proof(1, 5)), uses(68, applied(5, "class", human))]).
substitution(70, [binding("proof", 5), binding("name", "class"), binding("value", human)]).
proof(70, solution([5, "class", human]), query, [uses(69, answer_applied(1, 5, "class", human))]).
