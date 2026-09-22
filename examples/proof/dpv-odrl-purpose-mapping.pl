% Prolog result format 4
query(1, is_policy(_0), ['P' = _0]).
result(1, complete, 1).
answer(1, ['P' = alphaPolicy]).
why(1, ['P' = alphaPolicy], [is_policy(alphaPolicy)]).
query(2, is_permission(_0), ['P' = _0]).
result(2, complete, 1).
answer(2, ['P' = alphaPermission]).
why(2, ['P' = alphaPermission], [is_permission(alphaPermission)]).
query(3, assigner(_0, _1), ['P' = _0, 'C' = _1]).
result(3, complete, 1).
answer(3, ['P' = alphaPermission, 'C' = hospitalA]).
why(3, ['P' = alphaPermission, 'C' = hospitalA], [assigner(alphaPermission, hospitalA)]).
query(4, assignee(_0, _1), ['P' = _0, 'R' = _1]).
result(4, complete, 1).
answer(4, ['P' = alphaPermission, 'R' = researchPartner]).
why(4,
    ['P' = alphaPermission, 'R' = researchPartner],
    [assignee(alphaPermission, researchPartner)]).
query(5, target(_0, _1), ['P' = _0, 'D' = _1]).
result(5, complete, 1).
answer(5, ['P' = alphaPermission, 'D' = labResult]).
why(5, ['P' = alphaPermission, 'D' = labResult], [target(alphaPermission, labResult)]).
query(6, action(_0, _1), ['P' = _0, 'A' = _1]).
result(6, complete, 1).
answer(6, ['P' = alphaPermission, 'A' = use_]).
why(6, ['P' = alphaPermission, 'A' = use_], [action(alphaPermission, use_)]).
query(7, derived_from_process(_0, _1), ['P' = _0, 'Pr' = _1]).
result(7, complete, 1).
answer(7, ['P' = alphaPermission, 'Pr' = alphaCareProcess]).
why(7,
    ['P' = alphaPermission, 'Pr' = alphaCareProcess],
    [derived_from_process(alphaPermission, alphaCareProcess)]).
query(8, permission_constraint(_0, _1), ['P' = _0, 'C' = _1]).
result(8, complete, 2).
answer(8, ['P' = alphaPermission, 'C' = alphaPurposeConstraint]).
why(8,
    ['P' = alphaPermission, 'C' = alphaPurposeConstraint],
    [permission_constraint(alphaPermission, alphaPurposeConstraint)]).
answer(8, ['P' = alphaPermission, 'C' = alphaBasisConstraint]).
why(8,
    ['P' = alphaPermission, 'C' = alphaBasisConstraint],
    [permission_constraint(alphaPermission, alphaBasisConstraint)]).
query(9, is_constraint(_0), ['C' = _0]).
result(9, complete, 1).
answer(9, ['C' = alphaPurposeConstraint]).
why(9, ['C' = alphaPurposeConstraint], [is_constraint(alphaPurposeConstraint)]).
query(10, left_operand(_0, _1), ['C' = _0, 'L' = _1]).
result(10, complete, 2).
answer(10, ['C' = alphaPurposeConstraint, 'L' = purpose]).
why(10,
    ['C' = alphaPurposeConstraint, 'L' = purpose],
    [left_operand(alphaPurposeConstraint, purpose)]).
answer(10, ['C' = alphaBasisConstraint, 'L' = legalBasis]).
why(10,
    ['C' = alphaBasisConstraint, 'L' = legalBasis],
    [left_operand(alphaBasisConstraint, legalBasis)]).
query(11, operator(_0, _1), ['C' = _0, 'O' = _1]).
result(11, complete, 2).
answer(11, ['C' = alphaPurposeConstraint, 'O' = isA]).
why(11, ['C' = alphaPurposeConstraint, 'O' = isA], [operator(alphaPurposeConstraint, isA)]).
answer(11, ['C' = alphaBasisConstraint, 'O' = isA]).
why(11, ['C' = alphaBasisConstraint, 'O' = isA], [operator(alphaBasisConstraint, isA)]).
query(12, right_operand(_0, _1), ['C' = _0, 'R' = _1]).
result(12, complete, 2).
answer(12, ['C' = alphaPurposeConstraint, 'R' = healthcare]).
why(12,
    ['C' = alphaPurposeConstraint, 'R' = healthcare],
    [right_operand(alphaPurposeConstraint, healthcare)]).
answer(12, ['C' = alphaBasisConstraint, 'R' = consent]).
why(12,
    ['C' = alphaBasisConstraint, 'R' = consent],
    [right_operand(alphaBasisConstraint, consent)]).

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
clause(12,
       process_info(var('Policy'), var('Permission'), var('Process'), var('Controller'), var('Recipient'), var('Data'), var('Processing')),
       (represents_process(var('Policy'), var('Process')),
        permission_node(var('Policy'), var('Permission')),
        is_process(var('Process')),
        has_data_controller(var('Process'), var('Controller')),
        has_recipient(var('Process'), var('Recipient')),
        has_personal_data(var('Process'), var('Data')),
        has_processing(var('Process'), var('Processing')))).
clause(13,
       is_policy(var('Policy')),
       process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(14,
       is_permission(var('Permission')),
       process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(15,
       assigner(var('Permission'), var('C')),
       process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(16,
       assignee(var('Permission'), var('R')),
       process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(17,
       target(var('Permission'), var('D')),
       process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(18,
       action(var('Permission'), var('Pr')),
       process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(19,
       derived_from_process(var('Permission'), var('Process')),
       process_info(var('Policy'), var('Permission'), var('Process'), var('C'), var('R'), var('D'), var('Pr'))).
clause(20,
       purpose_info(var('Permission'), var('Constraint'), var('Purpose')),
       (represents_process(var('Policy'), var('Process')),
        permission_node(var('Policy'), var('Permission')),
        purpose_constraint(var('Policy'), var('Constraint')),
        has_purpose(var('Process'), var('Purpose')))).
clause(21,
       permission_constraint(var('Permission'), var('Constraint')),
       purpose_info(var('Permission'), var('Constraint'), var('Purpose'))).
clause(22,
       is_constraint(var('Constraint')),
       purpose_info(var('Permission'), var('Constraint'), var('Purpose'))).
clause(23,
       left_operand(var('Constraint'), purpose),
       purpose_info(var('Permission'), var('Constraint'), var('Purpose'))).
clause(24,
       operator(var('Constraint'), isA),
       purpose_info(var('Permission'), var('Constraint'), var('Purpose'))).
clause(25,
       right_operand(var('Constraint'), var('Purpose')),
       purpose_info(var('Permission'), var('Constraint'), var('Purpose'))).
clause(26,
       basis_info(var('Permission'), var('Constraint'), var('Basis')),
       (represents_process(var('Policy'), var('Process')),
        permission_node(var('Policy'), var('Permission')),
        basis_constraint(var('Policy'), var('Constraint')),
        has_legal_basis(var('Process'), var('Basis')))).
clause(27,
       permission_constraint(var('Permission'), var('Constraint')),
       basis_info(var('Permission'), var('Constraint'), var('Basis'))).
clause(28,
       left_operand(var('Constraint'), legalBasis),
       basis_info(var('Permission'), var('Constraint'), var('Basis'))).
clause(29,
       operator(var('Constraint'), isA),
       basis_info(var('Permission'), var('Constraint'), var('Basis'))).
clause(30,
       right_operand(var('Constraint'), var('Basis')),
       basis_info(var('Permission'), var('Constraint'), var('Basis'))).

step(is_policy(alphaPolicy),
     rule(13),
     ['Policy' = alphaPolicy,
      'Permission' = alphaPermission,
      'Process' = alphaCareProcess,
      'C' = hospitalA,
      'R' = researchPartner,
      'D' = labResult,
      'Pr' = use_],
     [process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_)]).
step(process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_),
     rule(12),
     ['Policy' = alphaPolicy,
      'Permission' = alphaPermission,
      'Process' = alphaCareProcess,
      'Controller' = hospitalA,
      'Recipient' = researchPartner,
      'Data' = labResult,
      'Processing' = use_],
     [represents_process(alphaPolicy, alphaCareProcess),
      permission_node(alphaPolicy, alphaPermission),
      is_process(alphaCareProcess),
      has_data_controller(alphaCareProcess, hospitalA),
      has_recipient(alphaCareProcess, researchPartner),
      has_personal_data(alphaCareProcess, labResult),
      has_processing(alphaCareProcess, use_)]).
step(represents_process(alphaPolicy, alphaCareProcess), fact(1), [], []).
step(permission_node(alphaPolicy, alphaPermission), fact(2), [], []).
step(is_process(alphaCareProcess), fact(5), [], []).
step(has_data_controller(alphaCareProcess, hospitalA), fact(6), [], []).
step(has_recipient(alphaCareProcess, researchPartner), fact(7), [], []).
step(has_personal_data(alphaCareProcess, labResult), fact(8), [], []).
step(has_processing(alphaCareProcess, use_), fact(9), [], []).
step(is_permission(alphaPermission),
     rule(14),
     ['Permission' = alphaPermission,
      'Policy' = alphaPolicy,
      'Process' = alphaCareProcess,
      'C' = hospitalA,
      'R' = researchPartner,
      'D' = labResult,
      'Pr' = use_],
     [process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_)]).
step(assigner(alphaPermission, hospitalA),
     rule(15),
     ['Permission' = alphaPermission,
      'C' = hospitalA,
      'Policy' = alphaPolicy,
      'Process' = alphaCareProcess,
      'R' = researchPartner,
      'D' = labResult,
      'Pr' = use_],
     [process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_)]).
step(assignee(alphaPermission, researchPartner),
     rule(16),
     ['Permission' = alphaPermission,
      'R' = researchPartner,
      'Policy' = alphaPolicy,
      'Process' = alphaCareProcess,
      'C' = hospitalA,
      'D' = labResult,
      'Pr' = use_],
     [process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_)]).
step(target(alphaPermission, labResult),
     rule(17),
     ['Permission' = alphaPermission,
      'D' = labResult,
      'Policy' = alphaPolicy,
      'Process' = alphaCareProcess,
      'C' = hospitalA,
      'R' = researchPartner,
      'Pr' = use_],
     [process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_)]).
step(action(alphaPermission, use_),
     rule(18),
     ['Permission' = alphaPermission,
      'Pr' = use_,
      'Policy' = alphaPolicy,
      'Process' = alphaCareProcess,
      'C' = hospitalA,
      'R' = researchPartner,
      'D' = labResult],
     [process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_)]).
step(derived_from_process(alphaPermission, alphaCareProcess),
     rule(19),
     ['Permission' = alphaPermission,
      'Process' = alphaCareProcess,
      'Policy' = alphaPolicy,
      'C' = hospitalA,
      'R' = researchPartner,
      'D' = labResult,
      'Pr' = use_],
     [process_info(alphaPolicy, alphaPermission, alphaCareProcess, hospitalA, researchPartner, labResult, use_)]).
step(permission_constraint(alphaPermission, alphaPurposeConstraint),
     rule(21),
     ['Permission' = alphaPermission,
      'Constraint' = alphaPurposeConstraint,
      'Purpose' = healthcare],
     [purpose_info(alphaPermission, alphaPurposeConstraint, healthcare)]).
step(purpose_info(alphaPermission, alphaPurposeConstraint, healthcare),
     rule(20),
     ['Permission' = alphaPermission,
      'Constraint' = alphaPurposeConstraint,
      'Purpose' = healthcare,
      'Policy' = alphaPolicy,
      'Process' = alphaCareProcess],
     [represents_process(alphaPolicy, alphaCareProcess),
      permission_node(alphaPolicy, alphaPermission),
      purpose_constraint(alphaPolicy, alphaPurposeConstraint),
      has_purpose(alphaCareProcess, healthcare)]).
step(purpose_constraint(alphaPolicy, alphaPurposeConstraint), fact(3), [], []).
step(has_purpose(alphaCareProcess, healthcare), fact(10), [], []).
step(permission_constraint(alphaPermission, alphaBasisConstraint),
     rule(27),
     ['Permission' = alphaPermission, 'Constraint' = alphaBasisConstraint, 'Basis' = consent],
     [basis_info(alphaPermission, alphaBasisConstraint, consent)]).
step(basis_info(alphaPermission, alphaBasisConstraint, consent),
     rule(26),
     ['Permission' = alphaPermission,
      'Constraint' = alphaBasisConstraint,
      'Basis' = consent,
      'Policy' = alphaPolicy,
      'Process' = alphaCareProcess],
     [represents_process(alphaPolicy, alphaCareProcess),
      permission_node(alphaPolicy, alphaPermission),
      basis_constraint(alphaPolicy, alphaBasisConstraint),
      has_legal_basis(alphaCareProcess, consent)]).
step(basis_constraint(alphaPolicy, alphaBasisConstraint), fact(4), [], []).
step(has_legal_basis(alphaCareProcess, consent), fact(11), [], []).
step(is_constraint(alphaPurposeConstraint),
     rule(22),
     ['Constraint' = alphaPurposeConstraint,
      'Permission' = alphaPermission,
      'Purpose' = healthcare],
     [purpose_info(alphaPermission, alphaPurposeConstraint, healthcare)]).
step(left_operand(alphaPurposeConstraint, purpose),
     rule(23),
     ['Constraint' = alphaPurposeConstraint,
      'Permission' = alphaPermission,
      'Purpose' = healthcare],
     [purpose_info(alphaPermission, alphaPurposeConstraint, healthcare)]).
step(left_operand(alphaBasisConstraint, legalBasis),
     rule(28),
     ['Constraint' = alphaBasisConstraint, 'Permission' = alphaPermission, 'Basis' = consent],
     [basis_info(alphaPermission, alphaBasisConstraint, consent)]).
step(operator(alphaPurposeConstraint, isA),
     rule(24),
     ['Constraint' = alphaPurposeConstraint,
      'Permission' = alphaPermission,
      'Purpose' = healthcare],
     [purpose_info(alphaPermission, alphaPurposeConstraint, healthcare)]).
step(operator(alphaBasisConstraint, isA),
     rule(29),
     ['Constraint' = alphaBasisConstraint, 'Permission' = alphaPermission, 'Basis' = consent],
     [basis_info(alphaPermission, alphaBasisConstraint, consent)]).
step(right_operand(alphaPurposeConstraint, healthcare),
     rule(25),
     ['Constraint' = alphaPurposeConstraint,
      'Purpose' = healthcare,
      'Permission' = alphaPermission],
     [purpose_info(alphaPermission, alphaPurposeConstraint, healthcare)]).
step(right_operand(alphaBasisConstraint, consent),
     rule(30),
     ['Constraint' = alphaBasisConstraint, 'Basis' = consent, 'Permission' = alphaPermission],
     [basis_info(alphaPermission, alphaBasisConstraint, consent)]).
