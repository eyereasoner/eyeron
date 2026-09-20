# Eyelang result format 2
query(1, [call(inherits_requirement(?v0, ?v1))], [binding("l", ?v0), binding("r", ?v1)]).
result(1, complete, 5).
answer(1, [binding("l", c2), binding("r", stabilityReq)]).
answer(1, [binding("l", c2), binding("r", trackingReq)]).
answer(1, [binding("l", c3), binding("r", overshootReq)]).
answer(1, [binding("l", c3), binding("r", stabilityReq)]).
answer(1, [binding("l", c3), binding("r", trackingReq)]).
query(2, [call(considers(?v0, ?v1))], [binding("c", ?v0), binding("s", ?v1)]).
result(2, complete, 2).
answer(2, [binding("c", c2), binding("s", leadCompensator)]).
answer(2, [binding("c", c3), binding("s", integralAction)]).
query(3, [call(targets(?v0, ?v1))], [binding("c", ?v0), binding("r", ?v1)]).
result(3, complete, 2).
answer(3, [binding("c", c2), binding("r", overshootReq)]).
answer(3, [binding("c", c3), binding("r", disturbanceRejectionReq)]).
query(4, [call(preserves(?v0, ?v1))], [binding("c", ?v0), binding("r", ?v1)]).
result(4, complete, 5).
answer(4, [binding("c", c2), binding("r", stabilityReq)]).
answer(4, [binding("c", c2), binding("r", trackingReq)]).
answer(4, [binding("c", c3), binding("r", overshootReq)]).
answer(4, [binding("c", c3), binding("r", stabilityReq)]).
answer(4, [binding("c", c3), binding("r", trackingReq)]).
query(5, [call(integrates(?v0, ?v1))], [binding("c", ?v0), binding("s", ?v1)]).
result(5, complete, 2).
answer(5, [binding("c", c2), binding("s", leadCompensator)]).
answer(5, [binding("c", c3), binding("s", integralAction)]).
query(6, [call(satisfies(?v0, ?v1))], [binding("c", ?v0), binding("r", ?v1)]).
result(6, complete, 9).
answer(6, [binding("c", c1), binding("r", stabilityReq)]).
answer(6, [binding("c", c1), binding("r", trackingReq)]).
answer(6, [binding("c", c2), binding("r", overshootReq)]).
answer(6, [binding("c", c3), binding("r", disturbanceRejectionReq)]).
answer(6, [binding("c", c2), binding("r", stabilityReq)]).
answer(6, [binding("c", c2), binding("r", trackingReq)]).
answer(6, [binding("c", c3), binding("r", overshootReq)]).
answer(6, [binding("c", c3), binding("r", stabilityReq)]).
answer(6, [binding("c", c3), binding("r", trackingReq)]).
query(7, [call(realizes(?v0, ?v1))], [binding("c", ?v0), binding("s", ?v1)]).
result(7, complete, 3).
answer(7, [binding("c", c1), binding("s", baselinePID)]).
answer(7, [binding("c", c2), binding("s", leadCompensator)]).
answer(7, [binding("c", c3), binding("s", integralAction)]).
query(8, [call(status(?v0, ?v1))], [binding("c", ?v0), binding("s", ?v1)]).
result(8, complete, 3).
answer(8, [binding("c", c1), binding("s", approvedController)]).
answer(8, [binding("c", c2), binding("s", approvedController)]).
answer(8, [binding("c", c3), binding("s", approvedController)]).
query(9, [call(available_for_future_tuning(?v0, ?v1))], [binding("c", ?v0), binding("y", ?v1)]).
result(9, complete, 3).
answer(9, [binding("c", c1), binding("y", yes)]).
answer(9, [binding("c", c2), binding("y", yes)]).
answer(9, [binding("c", c3), binding("y", yes)]).
