% Prolog result format 4
query(1, inherits_requirement(_0, _1), ['L' = _0, 'R' = _1]).
result(1, complete, 5).
answer(1, ['L' = c2, 'R' = stabilityReq]).
answer(1, ['L' = c2, 'R' = trackingReq]).
answer(1, ['L' = c3, 'R' = overshootReq]).
answer(1, ['L' = c3, 'R' = stabilityReq]).
answer(1, ['L' = c3, 'R' = trackingReq]).
query(2, considers(_0, _1), ['C' = _0, 'S' = _1]).
result(2, complete, 2).
answer(2, ['C' = c2, 'S' = leadCompensator]).
answer(2, ['C' = c3, 'S' = integralAction]).
query(3, targets(_0, _1), ['C' = _0, 'R' = _1]).
result(3, complete, 2).
answer(3, ['C' = c2, 'R' = overshootReq]).
answer(3, ['C' = c3, 'R' = disturbanceRejectionReq]).
query(4, preserves(_0, _1), ['C' = _0, 'R' = _1]).
result(4, complete, 5).
answer(4, ['C' = c2, 'R' = stabilityReq]).
answer(4, ['C' = c2, 'R' = trackingReq]).
answer(4, ['C' = c3, 'R' = overshootReq]).
answer(4, ['C' = c3, 'R' = stabilityReq]).
answer(4, ['C' = c3, 'R' = trackingReq]).
query(5, integrates(_0, _1), ['C' = _0, 'S' = _1]).
result(5, complete, 2).
answer(5, ['C' = c2, 'S' = leadCompensator]).
answer(5, ['C' = c3, 'S' = integralAction]).
query(6, satisfies(_0, _1), ['C' = _0, 'R' = _1]).
result(6, complete, 9).
answer(6, ['C' = c1, 'R' = stabilityReq]).
answer(6, ['C' = c1, 'R' = trackingReq]).
answer(6, ['C' = c2, 'R' = overshootReq]).
answer(6, ['C' = c3, 'R' = disturbanceRejectionReq]).
answer(6, ['C' = c2, 'R' = stabilityReq]).
answer(6, ['C' = c2, 'R' = trackingReq]).
answer(6, ['C' = c3, 'R' = overshootReq]).
answer(6, ['C' = c3, 'R' = stabilityReq]).
answer(6, ['C' = c3, 'R' = trackingReq]).
query(7, realizes(_0, _1), ['C' = _0, 'S' = _1]).
result(7, complete, 3).
answer(7, ['C' = c1, 'S' = baselinePID]).
answer(7, ['C' = c2, 'S' = leadCompensator]).
answer(7, ['C' = c3, 'S' = integralAction]).
query(8, status(_0, _1), ['C' = _0, 'S' = _1]).
result(8, complete, 3).
answer(8, ['C' = c1, 'S' = approvedController]).
answer(8, ['C' = c2, 'S' = approvedController]).
answer(8, ['C' = c3, 'S' = approvedController]).
query(9, available_for_future_tuning(_0, _1), ['C' = _0, 'Y' = _1]).
result(9, complete, 3).
answer(9, ['C' = c1, 'Y' = yes]).
answer(9, ['C' = c2, 'Y' = yes]).
answer(9, ['C' = c3, 'Y' = yes]).
