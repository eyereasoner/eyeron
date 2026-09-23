is_policy(alphaPolicy).
is_permission(alphaPermission).
assigner(alphaPermission, hospitalA).
assignee(alphaPermission, researchPartner).
target(alphaPermission, labResult).
action(alphaPermission, use_).
derived_from_process(alphaPermission, alphaCareProcess).
permission_constraint(alphaPermission, alphaPurposeConstraint).
permission_constraint(alphaPermission, alphaBasisConstraint).
is_constraint(alphaPurposeConstraint).
left_operand(alphaPurposeConstraint, purpose).
left_operand(alphaBasisConstraint, legalBasis).
operator(alphaPurposeConstraint, isA).
operator(alphaBasisConstraint, isA).
right_operand(alphaPurposeConstraint, healthcare).
right_operand(alphaBasisConstraint, consent).

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
