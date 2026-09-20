# Eyelang result format 2
query(1, [call(is_policy(?v0))], [binding("p", ?v0)]).
result(1, complete, 1).
answer(1, [binding("p", alphaPolicy)]).
why(1, [binding("p", alphaPolicy)], 10).
query(2, [call(is_permission(?v0))], [binding("p", ?v0)]).
result(2, complete, 1).
answer(2, [binding("p", alphaPermission)]).
why(2, [binding("p", alphaPermission)], 20).
query(3, [call(assigner(?v0, ?v1))], [binding("p", ?v0), binding("c", ?v1)]).
result(3, complete, 1).
answer(3, [binding("p", alphaPermission), binding("c", hospitalA)]).
why(3, [binding("p", alphaPermission), binding("c", hospitalA)], 30).
query(4, [call(assignee(?v0, ?v1))], [binding("p", ?v0), binding("r", ?v1)]).
result(4, complete, 1).
answer(4, [binding("p", alphaPermission), binding("r", researchPartner)]).
why(4, [binding("p", alphaPermission), binding("r", researchPartner)], 40).
query(5, [call(target(?v0, ?v1))], [binding("p", ?v0), binding("d", ?v1)]).
result(5, complete, 1).
answer(5, [binding("p", alphaPermission), binding("d", labResult)]).
why(5, [binding("p", alphaPermission), binding("d", labResult)], 50).
query(6, [call(action(?v0, ?v1))], [binding("p", ?v0), binding("a", ?v1)]).
result(6, complete, 1).
answer(6, [binding("p", alphaPermission), binding("a", use_)]).
why(6, [binding("p", alphaPermission), binding("a", use_)], 60).
query(7, [call(derived_from_process(?v0, ?v1))], [binding("p", ?v0), binding("pr", ?v1)]).
result(7, complete, 1).
answer(7, [binding("p", alphaPermission), binding("pr", alphaCareProcess)]).
why(7, [binding("p", alphaPermission), binding("pr", alphaCareProcess)], 70).
query(8, [call(permission_constraint(?v0, ?v1))], [binding("p", ?v0), binding("c", ?v1)]).
result(8, complete, 2).
answer(8, [binding("p", alphaPermission), binding("c", alphaPurposeConstraint)]).
why(8, [binding("p", alphaPermission), binding("c", alphaPurposeConstraint)], 81).
answer(8, [binding("p", alphaPermission), binding("c", alphaBasisConstraint)]).
why(8, [binding("p", alphaPermission), binding("c", alphaBasisConstraint)], 82).
query(9, [call(is_constraint(?v0))], [binding("c", ?v0)]).
result(9, complete, 1).
answer(9, [binding("c", alphaPurposeConstraint)]).
why(9, [binding("c", alphaPurposeConstraint)], 89).
query(10, [call(left_operand(?v0, ?v1))], [binding("c", ?v0), binding("l", ?v1)]).
result(10, complete, 2).
answer(10, [binding("c", alphaPurposeConstraint), binding("l", purpose)]).
why(10, [binding("c", alphaPurposeConstraint), binding("l", purpose)], 100).
answer(10, [binding("c", alphaBasisConstraint), binding("l", legalBasis)]).
why(10, [binding("c", alphaBasisConstraint), binding("l", legalBasis)], 101).
query(11, [call(operator(?v0, ?v1))], [binding("c", ?v0), binding("o", ?v1)]).
result(11, complete, 2).
answer(11, [binding("c", alphaPurposeConstraint), binding("o", isA)]).
why(11, [binding("c", alphaPurposeConstraint), binding("o", isA)], 112).
answer(11, [binding("c", alphaBasisConstraint), binding("o", isA)]).
why(11, [binding("c", alphaBasisConstraint), binding("o", isA)], 113).
query(12, [call(right_operand(?v0, ?v1))], [binding("c", ?v0), binding("r", ?v1)]).
result(12, complete, 2).
answer(12, [binding("c", alphaPurposeConstraint), binding("r", healthcare)]).
why(12, [binding("c", alphaPurposeConstraint), binding("r", healthcare)], 124).
answer(12, [binding("c", alphaBasisConstraint), binding("r", consent)]).
why(12, [binding("c", alphaBasisConstraint), binding("r", consent)], 125).
clause(1, represents_process(alphaPolicy, alphaCareProcess), []).
clause(2, permission_node(alphaPolicy, alphaPermission), []).
clause(3, purpose_constraint(alphaPolicy, alphaPurposeConstraint), []).
clause(4, basis_constraint(alphaPolicy, alphaBasisConstraint), []).
clause(5, is_process(alphaCareProcess), []).
clause(6, has_data_controller(alphaCareProcess, hospitalA), []).
clause(7, has_recipient(alphaCareProcess, researchPartner), []).
clause(8, has_personal_data(alphaCareProcess, labResult), []).
clause(9, has_processing(alphaCareProcess, use_), []).
clause(10, has_purpose(alphaCareProcess, healthcare), []).
clause(11, has_legal_basis(alphaCareProcess, consent), []).
clause(12, process_info(var("policy"), var("permission"), var("process"), var("controller"), var("recipient"), var("data"), var("processing")), [call(represents_process(var("policy"), var("process"))), call(permission_node(var("policy"), var("permission"))), call(is_process(var("process"))), call(has_data_controller(var("process"), var("controller"))), call(has_recipient(var("process"), var("recipient"))), call(has_personal_data(var("process"), var("data"))), call(has_processing(var("process"), var("processing")))]).
clause(13, is_policy(var("policy")), [call(process_info(var("policy"), var("permission"), var("process"), var("c"), var("r"), var("d"), var("pr")))]).
clause(14, is_permission(var("permission")), [call(process_info(var("policy"), var("permission"), var("process"), var("c"), var("r"), var("d"), var("pr")))]).
clause(15, assigner(var("permission"), var("c")), [call(process_info(var("policy"), var("permission"), var("process"), var("c"), var("r"), var("d"), var("pr")))]).
clause(16, assignee(var("permission"), var("r")), [call(process_info(var("policy"), var("permission"), var("process"), var("c"), var("r"), var("d"), var("pr")))]).
clause(17, target(var("permission"), var("d")), [call(process_info(var("policy"), var("permission"), var("process"), var("c"), var("r"), var("d"), var("pr")))]).
clause(18, action(var("permission"), var("pr")), [call(process_info(var("policy"), var("permission"), var("process"), var("c"), var("r"), var("d"), var("pr")))]).
clause(19, derived_from_process(var("permission"), var("process")), [call(process_info(var("policy"), var("permission"), var("process"), var("c"), var("r"), var("d"), var("pr")))]).
clause(20, purpose_info(var("permission"), var("constraint"), var("purpose")), [call(represents_process(var("policy"), var("process"))), call(permission_node(var("policy"), var("permission"))), call(purpose_constraint(var("policy"), var("constraint"))), call(has_purpose(var("process"), var("purpose")))]).
clause(21, permission_constraint(var("permission"), var("constraint")), [call(purpose_info(var("permission"), var("constraint"), var("purpose")))]).
clause(22, is_constraint(var("constraint")), [call(purpose_info(var("permission"), var("constraint"), var("purpose")))]).
clause(23, left_operand(var("constraint"), purpose), [call(purpose_info(var("permission"), var("constraint"), var("purpose")))]).
clause(24, operator(var("constraint"), isA), [call(purpose_info(var("permission"), var("constraint"), var("purpose")))]).
clause(25, right_operand(var("constraint"), var("purpose")), [call(purpose_info(var("permission"), var("constraint"), var("purpose")))]).
clause(26, basis_info(var("permission"), var("constraint"), var("basis")), [call(represents_process(var("policy"), var("process"))), call(permission_node(var("policy"), var("permission"))), call(basis_constraint(var("policy"), var("constraint"))), call(has_legal_basis(var("process"), var("basis")))]).
clause(27, permission_constraint(var("permission"), var("constraint")), [call(basis_info(var("permission"), var("constraint"), var("basis")))]).
clause(28, left_operand(var("constraint"), legalBasis), [call(basis_info(var("permission"), var("constraint"), var("basis")))]).
clause(29, operator(var("constraint"), isA), [call(basis_info(var("permission"), var("constraint"), var("basis")))]).
clause(30, right_operand(var("constraint"), var("basis")), [call(basis_info(var("permission"), var("constraint"), var("basis")))]).
substitution(1, []).
proof(1, represents_process(alphaPolicy, alphaCareProcess), rule(1), []).
substitution(2, []).
proof(2, permission_node(alphaPolicy, alphaPermission), rule(2), []).
substitution(3, []).
proof(3, is_process(alphaCareProcess), rule(5), []).
substitution(4, []).
proof(4, has_data_controller(alphaCareProcess, hospitalA), rule(6), []).
substitution(5, []).
proof(5, has_recipient(alphaCareProcess, researchPartner), rule(7), []).
substitution(6, []).
proof(6, has_personal_data(alphaCareProcess, labResult), rule(8), []).
substitution(7, []).
proof(7, has_processing(alphaCareProcess, use_), rule(9), []).
substitution(8, [binding("policy", alphaPolicy), binding("permission", alphaPermission), binding("process", alphaCareProcess), binding("controller", hospitalA), binding("recipient", researchPartner), binding("data", labResult), binding("processing", use_)]).
proof(8, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(1, represents_process(alphaPolicy, alphaCareProcess)), uses(2, permission_node(alphaPolicy, alphaPermission)), uses(3, is_process(alphaCareProcess)), uses(4, has_data_controller(alphaCareProcess, hospitalA)), uses(5, has_recipient(alphaCareProcess, researchPartner)), uses(6, has_personal_data(alphaCareProcess, labResult)), uses(7, has_processing(alphaCareProcess, use_))]).
substitution(9, [binding("policy", alphaPolicy), binding("permission", alphaPermission), binding("process", alphaCareProcess), binding("c", hospitalA), binding("r", researchPartner), binding("d", labResult), binding("pr", use_)]).
proof(9, is_policy(alphaPolicy), rule(13), [uses(8, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(10, [binding("p", alphaPolicy)]).
proof(10, solution([alphaPolicy]), query, [uses(9, is_policy(alphaPolicy))]).
substitution(11, []).
proof(11, represents_process(alphaPolicy, alphaCareProcess), rule(1), []).
substitution(12, []).
proof(12, permission_node(alphaPolicy, alphaPermission), rule(2), []).
substitution(13, []).
proof(13, is_process(alphaCareProcess), rule(5), []).
substitution(14, []).
proof(14, has_data_controller(alphaCareProcess, hospitalA), rule(6), []).
substitution(15, []).
proof(15, has_recipient(alphaCareProcess, researchPartner), rule(7), []).
substitution(16, []).
proof(16, has_personal_data(alphaCareProcess, labResult), rule(8), []).
substitution(17, []).
proof(17, has_processing(alphaCareProcess, use_), rule(9), []).
substitution(18, [binding("policy", alphaPolicy), binding("permission", alphaPermission), binding("process", alphaCareProcess), binding("controller", hospitalA), binding("recipient", researchPartner), binding("data", labResult), binding("processing", use_)]).
proof(18, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(11, represents_process(alphaPolicy, alphaCareProcess)), uses(12, permission_node(alphaPolicy, alphaPermission)), uses(13, is_process(alphaCareProcess)), uses(14, has_data_controller(alphaCareProcess, hospitalA)), uses(15, has_recipient(alphaCareProcess, researchPartner)), uses(16, has_personal_data(alphaCareProcess, labResult)), uses(17, has_processing(alphaCareProcess, use_))]).
substitution(19, [binding("permission", alphaPermission), binding("policy", alphaPolicy), binding("process", alphaCareProcess), binding("c", hospitalA), binding("r", researchPartner), binding("d", labResult), binding("pr", use_)]).
proof(19, is_permission(alphaPermission), rule(14), [uses(18, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(20, [binding("p", alphaPermission)]).
proof(20, solution([alphaPermission]), query, [uses(19, is_permission(alphaPermission))]).
substitution(21, []).
proof(21, represents_process(alphaPolicy, alphaCareProcess), rule(1), []).
substitution(22, []).
proof(22, permission_node(alphaPolicy, alphaPermission), rule(2), []).
substitution(23, []).
proof(23, is_process(alphaCareProcess), rule(5), []).
substitution(24, []).
proof(24, has_data_controller(alphaCareProcess, hospitalA), rule(6), []).
substitution(25, []).
proof(25, has_recipient(alphaCareProcess, researchPartner), rule(7), []).
substitution(26, []).
proof(26, has_personal_data(alphaCareProcess, labResult), rule(8), []).
substitution(27, []).
proof(27, has_processing(alphaCareProcess, use_), rule(9), []).
substitution(28, [binding("policy", alphaPolicy), binding("permission", alphaPermission), binding("process", alphaCareProcess), binding("controller", hospitalA), binding("recipient", researchPartner), binding("data", labResult), binding("processing", use_)]).
proof(28, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(21, represents_process(alphaPolicy, alphaCareProcess)), uses(22, permission_node(alphaPolicy, alphaPermission)), uses(23, is_process(alphaCareProcess)), uses(24, has_data_controller(alphaCareProcess, hospitalA)), uses(25, has_recipient(alphaCareProcess, researchPartner)), uses(26, has_personal_data(alphaCareProcess, labResult)), uses(27, has_processing(alphaCareProcess, use_))]).
substitution(29, [binding("permission", alphaPermission), binding("c", hospitalA), binding("policy", alphaPolicy), binding("process", alphaCareProcess), binding("r", researchPartner), binding("d", labResult), binding("pr", use_)]).
proof(29, assigner(alphaPermission, hospitalA), rule(15), [uses(28, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(30, [binding("p", alphaPermission), binding("c", hospitalA)]).
proof(30, solution([alphaPermission, hospitalA]), query, [uses(29, assigner(alphaPermission, hospitalA))]).
substitution(31, []).
proof(31, represents_process(alphaPolicy, alphaCareProcess), rule(1), []).
substitution(32, []).
proof(32, permission_node(alphaPolicy, alphaPermission), rule(2), []).
substitution(33, []).
proof(33, is_process(alphaCareProcess), rule(5), []).
substitution(34, []).
proof(34, has_data_controller(alphaCareProcess, hospitalA), rule(6), []).
substitution(35, []).
proof(35, has_recipient(alphaCareProcess, researchPartner), rule(7), []).
substitution(36, []).
proof(36, has_personal_data(alphaCareProcess, labResult), rule(8), []).
substitution(37, []).
proof(37, has_processing(alphaCareProcess, use_), rule(9), []).
substitution(38, [binding("policy", alphaPolicy), binding("permission", alphaPermission), binding("process", alphaCareProcess), binding("controller", hospitalA), binding("recipient", researchPartner), binding("data", labResult), binding("processing", use_)]).
proof(38, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(31, represents_process(alphaPolicy, alphaCareProcess)), uses(32, permission_node(alphaPolicy, alphaPermission)), uses(33, is_process(alphaCareProcess)), uses(34, has_data_controller(alphaCareProcess, hospitalA)), uses(35, has_recipient(alphaCareProcess, researchPartner)), uses(36, has_personal_data(alphaCareProcess, labResult)), uses(37, has_processing(alphaCareProcess, use_))]).
substitution(39, [binding("permission", alphaPermission), binding("r", researchPartner), binding("policy", alphaPolicy), binding("process", alphaCareProcess), binding("c", hospitalA), binding("d", labResult), binding("pr", use_)]).
proof(39, assignee(alphaPermission, researchPartner), rule(16), [uses(38, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(40, [binding("p", alphaPermission), binding("r", researchPartner)]).
proof(40, solution([alphaPermission, researchPartner]), query, [uses(39, assignee(alphaPermission, researchPartner))]).
substitution(41, []).
proof(41, represents_process(alphaPolicy, alphaCareProcess), rule(1), []).
substitution(42, []).
proof(42, permission_node(alphaPolicy, alphaPermission), rule(2), []).
substitution(43, []).
proof(43, is_process(alphaCareProcess), rule(5), []).
substitution(44, []).
proof(44, has_data_controller(alphaCareProcess, hospitalA), rule(6), []).
substitution(45, []).
proof(45, has_recipient(alphaCareProcess, researchPartner), rule(7), []).
substitution(46, []).
proof(46, has_personal_data(alphaCareProcess, labResult), rule(8), []).
substitution(47, []).
proof(47, has_processing(alphaCareProcess, use_), rule(9), []).
substitution(48, [binding("policy", alphaPolicy), binding("permission", alphaPermission), binding("process", alphaCareProcess), binding("controller", hospitalA), binding("recipient", researchPartner), binding("data", labResult), binding("processing", use_)]).
proof(48, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(41, represents_process(alphaPolicy, alphaCareProcess)), uses(42, permission_node(alphaPolicy, alphaPermission)), uses(43, is_process(alphaCareProcess)), uses(44, has_data_controller(alphaCareProcess, hospitalA)), uses(45, has_recipient(alphaCareProcess, researchPartner)), uses(46, has_personal_data(alphaCareProcess, labResult)), uses(47, has_processing(alphaCareProcess, use_))]).
substitution(49, [binding("permission", alphaPermission), binding("d", labResult), binding("policy", alphaPolicy), binding("process", alphaCareProcess), binding("c", hospitalA), binding("r", researchPartner), binding("pr", use_)]).
proof(49, target(alphaPermission, labResult), rule(17), [uses(48, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(50, [binding("p", alphaPermission), binding("d", labResult)]).
proof(50, solution([alphaPermission, labResult]), query, [uses(49, target(alphaPermission, labResult))]).
substitution(51, []).
proof(51, represents_process(alphaPolicy, alphaCareProcess), rule(1), []).
substitution(52, []).
proof(52, permission_node(alphaPolicy, alphaPermission), rule(2), []).
substitution(53, []).
proof(53, is_process(alphaCareProcess), rule(5), []).
substitution(54, []).
proof(54, has_data_controller(alphaCareProcess, hospitalA), rule(6), []).
substitution(55, []).
proof(55, has_recipient(alphaCareProcess, researchPartner), rule(7), []).
substitution(56, []).
proof(56, has_personal_data(alphaCareProcess, labResult), rule(8), []).
substitution(57, []).
proof(57, has_processing(alphaCareProcess, use_), rule(9), []).
substitution(58, [binding("policy", alphaPolicy), binding("permission", alphaPermission), binding("process", alphaCareProcess), binding("controller", hospitalA), binding("recipient", researchPartner), binding("data", labResult), binding("processing", use_)]).
proof(58, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(51, represents_process(alphaPolicy, alphaCareProcess)), uses(52, permission_node(alphaPolicy, alphaPermission)), uses(53, is_process(alphaCareProcess)), uses(54, has_data_controller(alphaCareProcess, hospitalA)), uses(55, has_recipient(alphaCareProcess, researchPartner)), uses(56, has_personal_data(alphaCareProcess, labResult)), uses(57, has_processing(alphaCareProcess, use_))]).
substitution(59, [binding("permission", alphaPermission), binding("pr", use_), binding("policy", alphaPolicy), binding("process", alphaCareProcess), binding("c", hospitalA), binding("r", researchPartner), binding("d", labResult)]).
proof(59, action(alphaPermission, use_), rule(18), [uses(58, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(60, [binding("p", alphaPermission), binding("a", use_)]).
proof(60, solution([alphaPermission, use_]), query, [uses(59, action(alphaPermission, use_))]).
substitution(61, []).
proof(61, represents_process(alphaPolicy, alphaCareProcess), rule(1), []).
substitution(62, []).
proof(62, permission_node(alphaPolicy, alphaPermission), rule(2), []).
substitution(63, []).
proof(63, is_process(alphaCareProcess), rule(5), []).
substitution(64, []).
proof(64, has_data_controller(alphaCareProcess, hospitalA), rule(6), []).
substitution(65, []).
proof(65, has_recipient(alphaCareProcess, researchPartner), rule(7), []).
substitution(66, []).
proof(66, has_personal_data(alphaCareProcess, labResult), rule(8), []).
substitution(67, []).
proof(67, has_processing(alphaCareProcess, use_), rule(9), []).
substitution(68, [binding("policy", alphaPolicy), binding("permission", alphaPermission), binding("process", alphaCareProcess), binding("controller", hospitalA), binding("recipient", researchPartner), binding("data", labResult), binding("processing", use_)]).
proof(68, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(61, represents_process(alphaPolicy, alphaCareProcess)), uses(62, permission_node(alphaPolicy, alphaPermission)), uses(63, is_process(alphaCareProcess)), uses(64, has_data_controller(alphaCareProcess, hospitalA)), uses(65, has_recipient(alphaCareProcess, researchPartner)), uses(66, has_personal_data(alphaCareProcess, labResult)), uses(67, has_processing(alphaCareProcess, use_))]).
substitution(69, [binding("permission", alphaPermission), binding("process", alphaCareProcess), binding("policy", alphaPolicy), binding("c", hospitalA), binding("r", researchPartner), binding("d", labResult), binding("pr", use_)]).
proof(69, derived_from_process(alphaPermission, alphaCareProcess), rule(19), [uses(68, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(70, [binding("p", alphaPermission), binding("pr", alphaCareProcess)]).
proof(70, solution([alphaPermission, alphaCareProcess]), query, [uses(69, derived_from_process(alphaPermission, alphaCareProcess))]).
substitution(71, []).
proof(71, represents_process(alphaPolicy, alphaCareProcess), rule(1), []).
substitution(72, []).
proof(72, permission_node(alphaPolicy, alphaPermission), rule(2), []).
substitution(73, []).
proof(73, purpose_constraint(alphaPolicy, alphaPurposeConstraint), rule(3), []).
substitution(74, []).
proof(74, basis_constraint(alphaPolicy, alphaBasisConstraint), rule(4), []).
substitution(75, []).
proof(75, has_purpose(alphaCareProcess, healthcare), rule(10), []).
substitution(76, []).
proof(76, has_legal_basis(alphaCareProcess, consent), rule(11), []).
substitution(77, [binding("permission", alphaPermission), binding("constraint", alphaPurposeConstraint), binding("purpose", healthcare), binding("policy", alphaPolicy), binding("process", alphaCareProcess)]).
proof(77, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare), rule(20), [uses(71, represents_process(alphaPolicy, alphaCareProcess)), uses(72, permission_node(alphaPolicy, alphaPermission)), uses(73, purpose_constraint(alphaPolicy, alphaPurposeConstraint)), uses(75, has_purpose(alphaCareProcess, healthcare))]).
substitution(78, [binding("permission", alphaPermission), binding("constraint", alphaBasisConstraint), binding("basis", consent), binding("policy", alphaPolicy), binding("process", alphaCareProcess)]).
proof(78, basis_info(alphaPermission, alphaBasisConstraint, consent), rule(26), [uses(71, represents_process(alphaPolicy, alphaCareProcess)), uses(72, permission_node(alphaPolicy, alphaPermission)), uses(74, basis_constraint(alphaPolicy, alphaBasisConstraint)), uses(76, has_legal_basis(alphaCareProcess, consent))]).
substitution(79, [binding("permission", alphaPermission), binding("constraint", alphaPurposeConstraint), binding("purpose", healthcare)]).
proof(79, permission_constraint(alphaPermission, alphaPurposeConstraint), rule(21), [uses(77, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare))]).
substitution(80, [binding("permission", alphaPermission), binding("constraint", alphaBasisConstraint), binding("basis", consent)]).
proof(80, permission_constraint(alphaPermission, alphaBasisConstraint), rule(27), [uses(78, basis_info(alphaPermission, alphaBasisConstraint, consent))]).
substitution(81, [binding("p", alphaPermission), binding("c", alphaPurposeConstraint)]).
proof(81, solution([alphaPermission, alphaPurposeConstraint]), query, [uses(79, permission_constraint(alphaPermission, alphaPurposeConstraint))]).
substitution(82, [binding("p", alphaPermission), binding("c", alphaBasisConstraint)]).
proof(82, solution([alphaPermission, alphaBasisConstraint]), query, [uses(80, permission_constraint(alphaPermission, alphaBasisConstraint))]).
substitution(83, []).
proof(83, represents_process(alphaPolicy, alphaCareProcess), rule(1), []).
substitution(84, []).
proof(84, permission_node(alphaPolicy, alphaPermission), rule(2), []).
substitution(85, []).
proof(85, purpose_constraint(alphaPolicy, alphaPurposeConstraint), rule(3), []).
substitution(86, []).
proof(86, has_purpose(alphaCareProcess, healthcare), rule(10), []).
substitution(87, [binding("permission", alphaPermission), binding("constraint", alphaPurposeConstraint), binding("purpose", healthcare), binding("policy", alphaPolicy), binding("process", alphaCareProcess)]).
proof(87, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare), rule(20), [uses(83, represents_process(alphaPolicy, alphaCareProcess)), uses(84, permission_node(alphaPolicy, alphaPermission)), uses(85, purpose_constraint(alphaPolicy, alphaPurposeConstraint)), uses(86, has_purpose(alphaCareProcess, healthcare))]).
substitution(88, [binding("constraint", alphaPurposeConstraint), binding("permission", alphaPermission), binding("purpose", healthcare)]).
proof(88, is_constraint(alphaPurposeConstraint), rule(22), [uses(87, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare))]).
substitution(89, [binding("c", alphaPurposeConstraint)]).
proof(89, solution([alphaPurposeConstraint]), query, [uses(88, is_constraint(alphaPurposeConstraint))]).
substitution(90, []).
proof(90, represents_process(alphaPolicy, alphaCareProcess), rule(1), []).
substitution(91, []).
proof(91, permission_node(alphaPolicy, alphaPermission), rule(2), []).
substitution(92, []).
proof(92, purpose_constraint(alphaPolicy, alphaPurposeConstraint), rule(3), []).
substitution(93, []).
proof(93, basis_constraint(alphaPolicy, alphaBasisConstraint), rule(4), []).
substitution(94, []).
proof(94, has_purpose(alphaCareProcess, healthcare), rule(10), []).
substitution(95, []).
proof(95, has_legal_basis(alphaCareProcess, consent), rule(11), []).
substitution(96, [binding("permission", alphaPermission), binding("constraint", alphaPurposeConstraint), binding("purpose", healthcare), binding("policy", alphaPolicy), binding("process", alphaCareProcess)]).
proof(96, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare), rule(20), [uses(90, represents_process(alphaPolicy, alphaCareProcess)), uses(91, permission_node(alphaPolicy, alphaPermission)), uses(92, purpose_constraint(alphaPolicy, alphaPurposeConstraint)), uses(94, has_purpose(alphaCareProcess, healthcare))]).
substitution(97, [binding("permission", alphaPermission), binding("constraint", alphaBasisConstraint), binding("basis", consent), binding("policy", alphaPolicy), binding("process", alphaCareProcess)]).
proof(97, basis_info(alphaPermission, alphaBasisConstraint, consent), rule(26), [uses(90, represents_process(alphaPolicy, alphaCareProcess)), uses(91, permission_node(alphaPolicy, alphaPermission)), uses(93, basis_constraint(alphaPolicy, alphaBasisConstraint)), uses(95, has_legal_basis(alphaCareProcess, consent))]).
substitution(98, [binding("constraint", alphaPurposeConstraint), binding("permission", alphaPermission), binding("purpose", healthcare)]).
proof(98, left_operand(alphaPurposeConstraint, purpose), rule(23), [uses(96, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare))]).
substitution(99, [binding("constraint", alphaBasisConstraint), binding("permission", alphaPermission), binding("basis", consent)]).
proof(99, left_operand(alphaBasisConstraint, legalBasis), rule(28), [uses(97, basis_info(alphaPermission, alphaBasisConstraint, consent))]).
substitution(100, [binding("c", alphaPurposeConstraint), binding("l", purpose)]).
proof(100, solution([alphaPurposeConstraint, purpose]), query, [uses(98, left_operand(alphaPurposeConstraint, purpose))]).
substitution(101, [binding("c", alphaBasisConstraint), binding("l", legalBasis)]).
proof(101, solution([alphaBasisConstraint, legalBasis]), query, [uses(99, left_operand(alphaBasisConstraint, legalBasis))]).
substitution(102, []).
proof(102, represents_process(alphaPolicy, alphaCareProcess), rule(1), []).
substitution(103, []).
proof(103, permission_node(alphaPolicy, alphaPermission), rule(2), []).
substitution(104, []).
proof(104, purpose_constraint(alphaPolicy, alphaPurposeConstraint), rule(3), []).
substitution(105, []).
proof(105, basis_constraint(alphaPolicy, alphaBasisConstraint), rule(4), []).
substitution(106, []).
proof(106, has_purpose(alphaCareProcess, healthcare), rule(10), []).
substitution(107, []).
proof(107, has_legal_basis(alphaCareProcess, consent), rule(11), []).
substitution(108, [binding("permission", alphaPermission), binding("constraint", alphaPurposeConstraint), binding("purpose", healthcare), binding("policy", alphaPolicy), binding("process", alphaCareProcess)]).
proof(108, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare), rule(20), [uses(102, represents_process(alphaPolicy, alphaCareProcess)), uses(103, permission_node(alphaPolicy, alphaPermission)), uses(104, purpose_constraint(alphaPolicy, alphaPurposeConstraint)), uses(106, has_purpose(alphaCareProcess, healthcare))]).
substitution(109, [binding("permission", alphaPermission), binding("constraint", alphaBasisConstraint), binding("basis", consent), binding("policy", alphaPolicy), binding("process", alphaCareProcess)]).
proof(109, basis_info(alphaPermission, alphaBasisConstraint, consent), rule(26), [uses(102, represents_process(alphaPolicy, alphaCareProcess)), uses(103, permission_node(alphaPolicy, alphaPermission)), uses(105, basis_constraint(alphaPolicy, alphaBasisConstraint)), uses(107, has_legal_basis(alphaCareProcess, consent))]).
substitution(110, [binding("constraint", alphaPurposeConstraint), binding("permission", alphaPermission), binding("purpose", healthcare)]).
proof(110, operator(alphaPurposeConstraint, isA), rule(24), [uses(108, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare))]).
substitution(111, [binding("constraint", alphaBasisConstraint), binding("permission", alphaPermission), binding("basis", consent)]).
proof(111, operator(alphaBasisConstraint, isA), rule(29), [uses(109, basis_info(alphaPermission, alphaBasisConstraint, consent))]).
substitution(112, [binding("c", alphaPurposeConstraint), binding("o", isA)]).
proof(112, solution([alphaPurposeConstraint, isA]), query, [uses(110, operator(alphaPurposeConstraint, isA))]).
substitution(113, [binding("c", alphaBasisConstraint), binding("o", isA)]).
proof(113, solution([alphaBasisConstraint, isA]), query, [uses(111, operator(alphaBasisConstraint, isA))]).
substitution(114, []).
proof(114, represents_process(alphaPolicy, alphaCareProcess), rule(1), []).
substitution(115, []).
proof(115, permission_node(alphaPolicy, alphaPermission), rule(2), []).
substitution(116, []).
proof(116, purpose_constraint(alphaPolicy, alphaPurposeConstraint), rule(3), []).
substitution(117, []).
proof(117, basis_constraint(alphaPolicy, alphaBasisConstraint), rule(4), []).
substitution(118, []).
proof(118, has_purpose(alphaCareProcess, healthcare), rule(10), []).
substitution(119, []).
proof(119, has_legal_basis(alphaCareProcess, consent), rule(11), []).
substitution(120, [binding("permission", alphaPermission), binding("constraint", alphaPurposeConstraint), binding("purpose", healthcare), binding("policy", alphaPolicy), binding("process", alphaCareProcess)]).
proof(120, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare), rule(20), [uses(114, represents_process(alphaPolicy, alphaCareProcess)), uses(115, permission_node(alphaPolicy, alphaPermission)), uses(116, purpose_constraint(alphaPolicy, alphaPurposeConstraint)), uses(118, has_purpose(alphaCareProcess, healthcare))]).
substitution(121, [binding("permission", alphaPermission), binding("constraint", alphaBasisConstraint), binding("basis", consent), binding("policy", alphaPolicy), binding("process", alphaCareProcess)]).
proof(121, basis_info(alphaPermission, alphaBasisConstraint, consent), rule(26), [uses(114, represents_process(alphaPolicy, alphaCareProcess)), uses(115, permission_node(alphaPolicy, alphaPermission)), uses(117, basis_constraint(alphaPolicy, alphaBasisConstraint)), uses(119, has_legal_basis(alphaCareProcess, consent))]).
substitution(122, [binding("constraint", alphaPurposeConstraint), binding("purpose", healthcare), binding("permission", alphaPermission)]).
proof(122, right_operand(alphaPurposeConstraint, healthcare), rule(25), [uses(120, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare))]).
substitution(123, [binding("constraint", alphaBasisConstraint), binding("basis", consent), binding("permission", alphaPermission)]).
proof(123, right_operand(alphaBasisConstraint, consent), rule(30), [uses(121, basis_info(alphaPermission, alphaBasisConstraint, consent))]).
substitution(124, [binding("c", alphaPurposeConstraint), binding("r", healthcare)]).
proof(124, solution([alphaPurposeConstraint, healthcare]), query, [uses(122, right_operand(alphaPurposeConstraint, healthcare))]).
substitution(125, [binding("c", alphaBasisConstraint), binding("r", consent)]).
proof(125, solution([alphaBasisConstraint, consent]), query, [uses(123, right_operand(alphaBasisConstraint, consent))]).
