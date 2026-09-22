% Prolog result format 3
query(1, is_policy(_0), ['P' = _0]).
result(1, complete, 1).
answer(1, ['P' = alphaPolicy]).
why(1, ['P' = alphaPolicy], 10).
query(2, is_permission(_0), ['P' = _0]).
result(2, complete, 1).
answer(2, ['P' = alphaPermission]).
why(2, ['P' = alphaPermission], 20).
query(3, assigner(_0, _1), ['P' = _0, 'C' = _1]).
result(3, complete, 1).
answer(3, ['P' = alphaPermission, 'C' = hospitalA]).
why(3, ['P' = alphaPermission, 'C' = hospitalA], 30).
query(4, assignee(_0, _1), ['P' = _0, 'R' = _1]).
result(4, complete, 1).
answer(4, ['P' = alphaPermission, 'R' = researchPartner]).
why(4, ['P' = alphaPermission, 'R' = researchPartner], 40).
query(5, target(_0, _1), ['P' = _0, 'D' = _1]).
result(5, complete, 1).
answer(5, ['P' = alphaPermission, 'D' = labResult]).
why(5, ['P' = alphaPermission, 'D' = labResult], 50).
query(6, action(_0, _1), ['P' = _0, 'A' = _1]).
result(6, complete, 1).
answer(6, ['P' = alphaPermission, 'A' = use_]).
why(6, ['P' = alphaPermission, 'A' = use_], 60).
query(7, derived_from_process(_0, _1), ['P' = _0, 'Pr' = _1]).
result(7, complete, 1).
answer(7, ['P' = alphaPermission, 'Pr' = alphaCareProcess]).
why(7, ['P' = alphaPermission, 'Pr' = alphaCareProcess], 70).
query(8, permission_constraint(_0, _1), ['P' = _0, 'C' = _1]).
result(8, complete, 2).
answer(8, ['P' = alphaPermission, 'C' = alphaPurposeConstraint]).
why(8, ['P' = alphaPermission, 'C' = alphaPurposeConstraint], 81).
answer(8, ['P' = alphaPermission, 'C' = alphaBasisConstraint]).
why(8, ['P' = alphaPermission, 'C' = alphaBasisConstraint], 82).
query(9, is_constraint(_0), ['C' = _0]).
result(9, complete, 1).
answer(9, ['C' = alphaPurposeConstraint]).
why(9, ['C' = alphaPurposeConstraint], 89).
query(10, left_operand(_0, _1), ['C' = _0, 'L' = _1]).
result(10, complete, 2).
answer(10, ['C' = alphaPurposeConstraint, 'L' = purpose]).
why(10, ['C' = alphaPurposeConstraint, 'L' = purpose], 100).
answer(10, ['C' = alphaBasisConstraint, 'L' = legalBasis]).
why(10, ['C' = alphaBasisConstraint, 'L' = legalBasis], 101).
query(11, operator(_0, _1), ['C' = _0, 'O' = _1]).
result(11, complete, 2).
answer(11, ['C' = alphaPurposeConstraint, 'O' = isA]).
why(11, ['C' = alphaPurposeConstraint, 'O' = isA], 112).
answer(11, ['C' = alphaBasisConstraint, 'O' = isA]).
why(11, ['C' = alphaBasisConstraint, 'O' = isA], 113).
query(12, right_operand(_0, _1), ['C' = _0, 'R' = _1]).
result(12, complete, 2).
answer(12, ['C' = alphaPurposeConstraint, 'R' = healthcare]).
why(12, ['C' = alphaPurposeConstraint, 'R' = healthcare], 124).
answer(12, ['C' = alphaBasisConstraint, 'R' = consent]).
why(12, ['C' = alphaBasisConstraint, 'R' = consent], 125).
clause(1, represents_process(alphaPolicy, alphaCareProcess), true).
clause(2, permission_node(alphaPolicy, alphaPermission), true).
clause(3, purpose_constraint(alphaPolicy, alphaPurposeConstraint), true).
clause(4, basis_constraint(alphaPolicy, alphaBasisConstraint), true).
clause(5, is_process(alphaCareProcess), true).
clause(6, has_data_controller(alphaCareProcess, hospitalA), true).
clause(7, has_recipient(alphaCareProcess, researchPartner), true).
clause(8, has_personal_data(alphaCareProcess, labResult), true).
clause(9, has_processing(alphaCareProcess, use_), true).
clause(10, has_purpose(alphaCareProcess, healthcare), true).
clause(11, has_legal_basis(alphaCareProcess, consent), true).
clause(12, process_info(var('Policy'), var('Permission'), var('Process'), var('Controller'), var('Recipient'), var('Data'), var('Processing')), (represents_process(var('Policy'), var('Process')), permission_node(var('Policy'), var('Permission')), is_process(var('Process')), has_data_controller(var('Process'), var('Controller')), has_recipient(var('Process'), var('Recipient')), has_personal_data(var('Process'), var('Data')), has_processing(var('Process'), var('Processing')))).
clause(13, is_policy(var('Policy')), process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(14, is_permission(var('Permission')), process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(15, assigner(var('Permission'), var('C')), process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(16, assignee(var('Permission'), var('R')), process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(17, target(var('Permission'), var('D')), process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(18, action(var('Permission'), var('Pr')), process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(19, derived_from_process(var('Permission'), var('Process')), process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(20, purpose_info(var('Permission'), var('Constraint'), var('Purpose')), (represents_process(var('Policy'), var('Process')), permission_node(var('Policy'), var('Permission')), purpose_constraint(var('Policy'), var('Constraint')), has_purpose(var('Process'), var('Purpose')))).
clause(21, permission_constraint(var('Permission'), var('Constraint')), purpose_info(var('Permission'), var('Constraint'), var('Purpose'))).
clause(22, is_constraint(var('Constraint')), purpose_info(var('Permission'), var('Constraint'), var('Purpose'))).
clause(23, left_operand(var('Constraint'), purpose), purpose_info(var('Permission'), var('Constraint'), var('Purpose'))).
clause(24, operator(var('Constraint'), isA), purpose_info(var('Permission'), var('Constraint'), var('Purpose'))).
clause(25, right_operand(var('Constraint'), var('Purpose')), purpose_info(var('Permission'), var('Constraint'), var('Purpose'))).
clause(26, basis_info(var('Permission'), var('Constraint'), var('Basis')), (represents_process(var('Policy'), var('Process')), permission_node(var('Policy'), var('Permission')), basis_constraint(var('Policy'), var('Constraint')), has_legal_basis(var('Process'), var('Basis')))).
clause(27, permission_constraint(var('Permission'), var('Constraint')), basis_info(var('Permission'), var('Constraint'), var('Basis'))).
clause(28, left_operand(var('Constraint'), legalBasis), basis_info(var('Permission'), var('Constraint'), var('Basis'))).
clause(29, operator(var('Constraint'), isA), basis_info(var('Permission'), var('Constraint'), var('Basis'))).
clause(30, right_operand(var('Constraint'), var('Basis')), basis_info(var('Permission'), var('Constraint'), var('Basis'))).
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
substitution(8, ['Policy' = alphaPolicy, 'Permission' = alphaPermission, 'Process' = alphaCareProcess, 'Controller' = hospitalA, 'Recipient' = researchPartner, 'Data' = labResult, 'Processing' = use_]).
proof(8, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(1, represents_process(alphaPolicy, alphaCareProcess)), uses(2, permission_node(alphaPolicy, alphaPermission)), uses(3, is_process(alphaCareProcess)), uses(4, has_data_controller(alphaCareProcess, hospitalA)), uses(5, has_recipient(alphaCareProcess, researchPartner)), uses(6, has_personal_data(alphaCareProcess, labResult)), uses(7, has_processing(alphaCareProcess, use_))]).
substitution(9, ['Policy' = alphaPolicy, 'Permission' = alphaPermission, 'Process' = alphaCareProcess, 'C' = hospitalA, 'R' = researchPartner, 'D' = labResult, 'Pr' = use_]).
proof(9, is_policy(alphaPolicy), rule(13), [uses(8, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(10, ['P' = alphaPolicy]).
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
substitution(18, ['Policy' = alphaPolicy, 'Permission' = alphaPermission, 'Process' = alphaCareProcess, 'Controller' = hospitalA, 'Recipient' = researchPartner, 'Data' = labResult, 'Processing' = use_]).
proof(18, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(11, represents_process(alphaPolicy, alphaCareProcess)), uses(12, permission_node(alphaPolicy, alphaPermission)), uses(13, is_process(alphaCareProcess)), uses(14, has_data_controller(alphaCareProcess, hospitalA)), uses(15, has_recipient(alphaCareProcess, researchPartner)), uses(16, has_personal_data(alphaCareProcess, labResult)), uses(17, has_processing(alphaCareProcess, use_))]).
substitution(19, ['Permission' = alphaPermission, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess, 'C' = hospitalA, 'R' = researchPartner, 'D' = labResult, 'Pr' = use_]).
proof(19, is_permission(alphaPermission), rule(14), [uses(18, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(20, ['P' = alphaPermission]).
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
substitution(28, ['Policy' = alphaPolicy, 'Permission' = alphaPermission, 'Process' = alphaCareProcess, 'Controller' = hospitalA, 'Recipient' = researchPartner, 'Data' = labResult, 'Processing' = use_]).
proof(28, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(21, represents_process(alphaPolicy, alphaCareProcess)), uses(22, permission_node(alphaPolicy, alphaPermission)), uses(23, is_process(alphaCareProcess)), uses(24, has_data_controller(alphaCareProcess, hospitalA)), uses(25, has_recipient(alphaCareProcess, researchPartner)), uses(26, has_personal_data(alphaCareProcess, labResult)), uses(27, has_processing(alphaCareProcess, use_))]).
substitution(29, ['Permission' = alphaPermission, 'C' = hospitalA, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess, 'R' = researchPartner, 'D' = labResult, 'Pr' = use_]).
proof(29, assigner(alphaPermission, hospitalA), rule(15), [uses(28, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(30, ['P' = alphaPermission, 'C' = hospitalA]).
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
substitution(38, ['Policy' = alphaPolicy, 'Permission' = alphaPermission, 'Process' = alphaCareProcess, 'Controller' = hospitalA, 'Recipient' = researchPartner, 'Data' = labResult, 'Processing' = use_]).
proof(38, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(31, represents_process(alphaPolicy, alphaCareProcess)), uses(32, permission_node(alphaPolicy, alphaPermission)), uses(33, is_process(alphaCareProcess)), uses(34, has_data_controller(alphaCareProcess, hospitalA)), uses(35, has_recipient(alphaCareProcess, researchPartner)), uses(36, has_personal_data(alphaCareProcess, labResult)), uses(37, has_processing(alphaCareProcess, use_))]).
substitution(39, ['Permission' = alphaPermission, 'R' = researchPartner, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess, 'C' = hospitalA, 'D' = labResult, 'Pr' = use_]).
proof(39, assignee(alphaPermission, researchPartner), rule(16), [uses(38, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(40, ['P' = alphaPermission, 'R' = researchPartner]).
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
substitution(48, ['Policy' = alphaPolicy, 'Permission' = alphaPermission, 'Process' = alphaCareProcess, 'Controller' = hospitalA, 'Recipient' = researchPartner, 'Data' = labResult, 'Processing' = use_]).
proof(48, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(41, represents_process(alphaPolicy, alphaCareProcess)), uses(42, permission_node(alphaPolicy, alphaPermission)), uses(43, is_process(alphaCareProcess)), uses(44, has_data_controller(alphaCareProcess, hospitalA)), uses(45, has_recipient(alphaCareProcess, researchPartner)), uses(46, has_personal_data(alphaCareProcess, labResult)), uses(47, has_processing(alphaCareProcess, use_))]).
substitution(49, ['Permission' = alphaPermission, 'D' = labResult, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess, 'C' = hospitalA, 'R' = researchPartner, 'Pr' = use_]).
proof(49, target(alphaPermission, labResult), rule(17), [uses(48, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(50, ['P' = alphaPermission, 'D' = labResult]).
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
substitution(58, ['Policy' = alphaPolicy, 'Permission' = alphaPermission, 'Process' = alphaCareProcess, 'Controller' = hospitalA, 'Recipient' = researchPartner, 'Data' = labResult, 'Processing' = use_]).
proof(58, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(51, represents_process(alphaPolicy, alphaCareProcess)), uses(52, permission_node(alphaPolicy, alphaPermission)), uses(53, is_process(alphaCareProcess)), uses(54, has_data_controller(alphaCareProcess, hospitalA)), uses(55, has_recipient(alphaCareProcess, researchPartner)), uses(56, has_personal_data(alphaCareProcess, labResult)), uses(57, has_processing(alphaCareProcess, use_))]).
substitution(59, ['Permission' = alphaPermission, 'Pr' = use_, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess, 'C' = hospitalA, 'R' = researchPartner, 'D' = labResult]).
proof(59, action(alphaPermission, use_), rule(18), [uses(58, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(60, ['P' = alphaPermission, 'A' = use_]).
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
substitution(68, ['Policy' = alphaPolicy, 'Permission' = alphaPermission, 'Process' = alphaCareProcess, 'Controller' = hospitalA, 'Recipient' = researchPartner, 'Data' = labResult, 'Processing' = use_]).
proof(68, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_), rule(12), [uses(61, represents_process(alphaPolicy, alphaCareProcess)), uses(62, permission_node(alphaPolicy, alphaPermission)), uses(63, is_process(alphaCareProcess)), uses(64, has_data_controller(alphaCareProcess, hospitalA)), uses(65, has_recipient(alphaCareProcess, researchPartner)), uses(66, has_personal_data(alphaCareProcess, labResult)), uses(67, has_processing(alphaCareProcess, use_))]).
substitution(69, ['Permission' = alphaPermission, 'Process' = alphaCareProcess, 'Policy' = alphaPolicy, 'C' = hospitalA, 'R' = researchPartner, 'D' = labResult, 'Pr' = use_]).
proof(69, derived_from_process(alphaPermission, alphaCareProcess), rule(19), [uses(68, process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_))]).
substitution(70, ['P' = alphaPermission, 'Pr' = alphaCareProcess]).
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
substitution(77, ['Permission' = alphaPermission, 'Constraint' = alphaPurposeConstraint, 'Purpose' = healthcare, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess]).
proof(77, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare), rule(20), [uses(71, represents_process(alphaPolicy, alphaCareProcess)), uses(72, permission_node(alphaPolicy, alphaPermission)), uses(73, purpose_constraint(alphaPolicy, alphaPurposeConstraint)), uses(75, has_purpose(alphaCareProcess, healthcare))]).
substitution(78, ['Permission' = alphaPermission, 'Constraint' = alphaBasisConstraint, 'Basis' = consent, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess]).
proof(78, basis_info(alphaPermission, alphaBasisConstraint, consent), rule(26), [uses(71, represents_process(alphaPolicy, alphaCareProcess)), uses(72, permission_node(alphaPolicy, alphaPermission)), uses(74, basis_constraint(alphaPolicy, alphaBasisConstraint)), uses(76, has_legal_basis(alphaCareProcess, consent))]).
substitution(79, ['Permission' = alphaPermission, 'Constraint' = alphaPurposeConstraint, 'Purpose' = healthcare]).
proof(79, permission_constraint(alphaPermission, alphaPurposeConstraint), rule(21), [uses(77, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare))]).
substitution(80, ['Permission' = alphaPermission, 'Constraint' = alphaBasisConstraint, 'Basis' = consent]).
proof(80, permission_constraint(alphaPermission, alphaBasisConstraint), rule(27), [uses(78, basis_info(alphaPermission, alphaBasisConstraint, consent))]).
substitution(81, ['P' = alphaPermission, 'C' = alphaPurposeConstraint]).
proof(81, solution([alphaPermission, alphaPurposeConstraint]), query, [uses(79, permission_constraint(alphaPermission, alphaPurposeConstraint))]).
substitution(82, ['P' = alphaPermission, 'C' = alphaBasisConstraint]).
proof(82, solution([alphaPermission, alphaBasisConstraint]), query, [uses(80, permission_constraint(alphaPermission, alphaBasisConstraint))]).
substitution(83, []).
proof(83, represents_process(alphaPolicy, alphaCareProcess), rule(1), []).
substitution(84, []).
proof(84, permission_node(alphaPolicy, alphaPermission), rule(2), []).
substitution(85, []).
proof(85, purpose_constraint(alphaPolicy, alphaPurposeConstraint), rule(3), []).
substitution(86, []).
proof(86, has_purpose(alphaCareProcess, healthcare), rule(10), []).
substitution(87, ['Permission' = alphaPermission, 'Constraint' = alphaPurposeConstraint, 'Purpose' = healthcare, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess]).
proof(87, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare), rule(20), [uses(83, represents_process(alphaPolicy, alphaCareProcess)), uses(84, permission_node(alphaPolicy, alphaPermission)), uses(85, purpose_constraint(alphaPolicy, alphaPurposeConstraint)), uses(86, has_purpose(alphaCareProcess, healthcare))]).
substitution(88, ['Constraint' = alphaPurposeConstraint, 'Permission' = alphaPermission, 'Purpose' = healthcare]).
proof(88, is_constraint(alphaPurposeConstraint), rule(22), [uses(87, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare))]).
substitution(89, ['C' = alphaPurposeConstraint]).
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
substitution(96, ['Permission' = alphaPermission, 'Constraint' = alphaPurposeConstraint, 'Purpose' = healthcare, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess]).
proof(96, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare), rule(20), [uses(90, represents_process(alphaPolicy, alphaCareProcess)), uses(91, permission_node(alphaPolicy, alphaPermission)), uses(92, purpose_constraint(alphaPolicy, alphaPurposeConstraint)), uses(94, has_purpose(alphaCareProcess, healthcare))]).
substitution(97, ['Permission' = alphaPermission, 'Constraint' = alphaBasisConstraint, 'Basis' = consent, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess]).
proof(97, basis_info(alphaPermission, alphaBasisConstraint, consent), rule(26), [uses(90, represents_process(alphaPolicy, alphaCareProcess)), uses(91, permission_node(alphaPolicy, alphaPermission)), uses(93, basis_constraint(alphaPolicy, alphaBasisConstraint)), uses(95, has_legal_basis(alphaCareProcess, consent))]).
substitution(98, ['Constraint' = alphaPurposeConstraint, 'Permission' = alphaPermission, 'Purpose' = healthcare]).
proof(98, left_operand(alphaPurposeConstraint, purpose), rule(23), [uses(96, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare))]).
substitution(99, ['Constraint' = alphaBasisConstraint, 'Permission' = alphaPermission, 'Basis' = consent]).
proof(99, left_operand(alphaBasisConstraint, legalBasis), rule(28), [uses(97, basis_info(alphaPermission, alphaBasisConstraint, consent))]).
substitution(100, ['C' = alphaPurposeConstraint, 'L' = purpose]).
proof(100, solution([alphaPurposeConstraint, purpose]), query, [uses(98, left_operand(alphaPurposeConstraint, purpose))]).
substitution(101, ['C' = alphaBasisConstraint, 'L' = legalBasis]).
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
substitution(108, ['Permission' = alphaPermission, 'Constraint' = alphaPurposeConstraint, 'Purpose' = healthcare, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess]).
proof(108, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare), rule(20), [uses(102, represents_process(alphaPolicy, alphaCareProcess)), uses(103, permission_node(alphaPolicy, alphaPermission)), uses(104, purpose_constraint(alphaPolicy, alphaPurposeConstraint)), uses(106, has_purpose(alphaCareProcess, healthcare))]).
substitution(109, ['Permission' = alphaPermission, 'Constraint' = alphaBasisConstraint, 'Basis' = consent, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess]).
proof(109, basis_info(alphaPermission, alphaBasisConstraint, consent), rule(26), [uses(102, represents_process(alphaPolicy, alphaCareProcess)), uses(103, permission_node(alphaPolicy, alphaPermission)), uses(105, basis_constraint(alphaPolicy, alphaBasisConstraint)), uses(107, has_legal_basis(alphaCareProcess, consent))]).
substitution(110, ['Constraint' = alphaPurposeConstraint, 'Permission' = alphaPermission, 'Purpose' = healthcare]).
proof(110, operator(alphaPurposeConstraint, isA), rule(24), [uses(108, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare))]).
substitution(111, ['Constraint' = alphaBasisConstraint, 'Permission' = alphaPermission, 'Basis' = consent]).
proof(111, operator(alphaBasisConstraint, isA), rule(29), [uses(109, basis_info(alphaPermission, alphaBasisConstraint, consent))]).
substitution(112, ['C' = alphaPurposeConstraint, 'O' = isA]).
proof(112, solution([alphaPurposeConstraint, isA]), query, [uses(110, operator(alphaPurposeConstraint, isA))]).
substitution(113, ['C' = alphaBasisConstraint, 'O' = isA]).
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
substitution(120, ['Permission' = alphaPermission, 'Constraint' = alphaPurposeConstraint, 'Purpose' = healthcare, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess]).
proof(120, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare), rule(20), [uses(114, represents_process(alphaPolicy, alphaCareProcess)), uses(115, permission_node(alphaPolicy, alphaPermission)), uses(116, purpose_constraint(alphaPolicy, alphaPurposeConstraint)), uses(118, has_purpose(alphaCareProcess, healthcare))]).
substitution(121, ['Permission' = alphaPermission, 'Constraint' = alphaBasisConstraint, 'Basis' = consent, 'Policy' = alphaPolicy, 'Process' = alphaCareProcess]).
proof(121, basis_info(alphaPermission, alphaBasisConstraint, consent), rule(26), [uses(114, represents_process(alphaPolicy, alphaCareProcess)), uses(115, permission_node(alphaPolicy, alphaPermission)), uses(117, basis_constraint(alphaPolicy, alphaBasisConstraint)), uses(119, has_legal_basis(alphaCareProcess, consent))]).
substitution(122, ['Constraint' = alphaPurposeConstraint, 'Purpose' = healthcare, 'Permission' = alphaPermission]).
proof(122, right_operand(alphaPurposeConstraint, healthcare), rule(25), [uses(120, purpose_info(alphaPermission, alphaPurposeConstraint, healthcare))]).
substitution(123, ['Constraint' = alphaBasisConstraint, 'Basis' = consent, 'Permission' = alphaPermission]).
proof(123, right_operand(alphaBasisConstraint, consent), rule(30), [uses(121, basis_info(alphaPermission, alphaBasisConstraint, consent))]).
substitution(124, ['C' = alphaPurposeConstraint, 'R' = healthcare]).
proof(124, solution([alphaPurposeConstraint, healthcare]), query, [uses(122, right_operand(alphaPurposeConstraint, healthcare))]).
substitution(125, ['C' = alphaBasisConstraint, 'R' = consent]).
proof(125, solution([alphaBasisConstraint, consent]), query, [uses(123, right_operand(alphaBasisConstraint, consent))]).
