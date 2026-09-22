% Prolog result format 4
query(1, is_policy(_0), ['P' = _0]).
result(1, complete, 1).
answer(1, ['P' = alphaPolicy]).
query(2, is_permission(_0), ['P' = _0]).
result(2, complete, 1).
answer(2, ['P' = alphaPermission]).
query(3, assigner(_0, _1), ['P' = _0, 'C' = _1]).
result(3, complete, 1).
answer(3, ['P' = alphaPermission, 'C' = hospitalA]).
query(4, assignee(_0, _1), ['P' = _0, 'R' = _1]).
result(4, complete, 1).
answer(4, ['P' = alphaPermission, 'R' = researchPartner]).
query(5, target(_0, _1), ['P' = _0, 'D' = _1]).
result(5, complete, 1).
answer(5, ['P' = alphaPermission, 'D' = labResult]).
query(6, action(_0, _1), ['P' = _0, 'A' = _1]).
result(6, complete, 1).
answer(6, ['P' = alphaPermission, 'A' = use_]).
query(7, derived_from_process(_0, _1), ['P' = _0, 'Pr' = _1]).
result(7, complete, 1).
answer(7, ['P' = alphaPermission, 'Pr' = alphaCareProcess]).
query(8, permission_constraint(_0, _1), ['P' = _0, 'C' = _1]).
result(8, complete, 2).
answer(8, ['P' = alphaPermission, 'C' = alphaPurposeConstraint]).
answer(8, ['P' = alphaPermission, 'C' = alphaBasisConstraint]).
query(9, is_constraint(_0), ['C' = _0]).
result(9, complete, 1).
answer(9, ['C' = alphaPurposeConstraint]).
query(10, left_operand(_0, _1), ['C' = _0, 'L' = _1]).
result(10, complete, 2).
answer(10, ['C' = alphaPurposeConstraint, 'L' = purpose]).
answer(10, ['C' = alphaBasisConstraint, 'L' = legalBasis]).
query(11, operator(_0, _1), ['C' = _0, 'O' = _1]).
result(11, complete, 2).
answer(11, ['C' = alphaPurposeConstraint, 'O' = isA]).
answer(11, ['C' = alphaBasisConstraint, 'O' = isA]).
query(12, right_operand(_0, _1), ['C' = _0, 'R' = _1]).
result(12, complete, 2).
answer(12, ['C' = alphaPurposeConstraint, 'R' = healthcare]).
answer(12, ['C' = alphaBasisConstraint, 'R' = consent]).
