# Eyelang result format 2
query(1, [call(is_policy(?v0))], [binding("p", ?v0)]).
result(1, complete, 1).
answer(1, [binding("p", alphaPolicy)]).
query(2, [call(is_permission(?v0))], [binding("p", ?v0)]).
result(2, complete, 1).
answer(2, [binding("p", alphaPermission)]).
query(3, [call(assigner(?v0, ?v1))], [binding("p", ?v0), binding("c", ?v1)]).
result(3, complete, 1).
answer(3, [binding("p", alphaPermission), binding("c", hospitalA)]).
query(4, [call(assignee(?v0, ?v1))], [binding("p", ?v0), binding("r", ?v1)]).
result(4, complete, 1).
answer(4, [binding("p", alphaPermission), binding("r", researchPartner)]).
query(5, [call(target(?v0, ?v1))], [binding("p", ?v0), binding("d", ?v1)]).
result(5, complete, 1).
answer(5, [binding("p", alphaPermission), binding("d", labResult)]).
query(6, [call(action(?v0, ?v1))], [binding("p", ?v0), binding("a", ?v1)]).
result(6, complete, 1).
answer(6, [binding("p", alphaPermission), binding("a", use_)]).
query(7, [call(derived_from_process(?v0, ?v1))], [binding("p", ?v0), binding("pr", ?v1)]).
result(7, complete, 1).
answer(7, [binding("p", alphaPermission), binding("pr", alphaCareProcess)]).
query(8, [call(permission_constraint(?v0, ?v1))], [binding("p", ?v0), binding("c", ?v1)]).
result(8, complete, 2).
answer(8, [binding("p", alphaPermission), binding("c", alphaPurposeConstraint)]).
answer(8, [binding("p", alphaPermission), binding("c", alphaBasisConstraint)]).
query(9, [call(is_constraint(?v0))], [binding("c", ?v0)]).
result(9, complete, 1).
answer(9, [binding("c", alphaPurposeConstraint)]).
query(10, [call(left_operand(?v0, ?v1))], [binding("c", ?v0), binding("l", ?v1)]).
result(10, complete, 2).
answer(10, [binding("c", alphaPurposeConstraint), binding("l", purpose)]).
answer(10, [binding("c", alphaBasisConstraint), binding("l", legalBasis)]).
query(11, [call(operator(?v0, ?v1))], [binding("c", ?v0), binding("o", ?v1)]).
result(11, complete, 2).
answer(11, [binding("c", alphaPurposeConstraint), binding("o", isA)]).
answer(11, [binding("c", alphaBasisConstraint), binding("o", isA)]).
query(12, [call(right_operand(?v0, ?v1))], [binding("c", ?v0), binding("r", ?v1)]).
result(12, complete, 2).
answer(12, [binding("c", alphaPurposeConstraint), binding("r", healthcare)]).
answer(12, [binding("c", alphaBasisConstraint), binding("r", consent)]).
