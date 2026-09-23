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
