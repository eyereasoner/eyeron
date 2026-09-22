% Prolog result format 4
query(1, inherits_requirement(_0, _1), ['L' = _0, 'R' = _1]).
result(1, complete, 5).
answer(1, ['L' = c2, 'R' = stabilityReq]).
why(1, ['L' = c2, 'R' = stabilityReq], [inherits_requirement(c2, stabilityReq)]).
answer(1, ['L' = c2, 'R' = trackingReq]).
why(1, ['L' = c2, 'R' = trackingReq], [inherits_requirement(c2, trackingReq)]).
answer(1, ['L' = c3, 'R' = overshootReq]).
why(1, ['L' = c3, 'R' = overshootReq], [inherits_requirement(c3, overshootReq)]).
answer(1, ['L' = c3, 'R' = stabilityReq]).
why(1, ['L' = c3, 'R' = stabilityReq], [inherits_requirement(c3, stabilityReq)]).
answer(1, ['L' = c3, 'R' = trackingReq]).
why(1, ['L' = c3, 'R' = trackingReq], [inherits_requirement(c3, trackingReq)]).
query(2, considers(_0, _1), ['C' = _0, 'S' = _1]).
result(2, complete, 2).
answer(2, ['C' = c2, 'S' = leadCompensator]).
why(2, ['C' = c2, 'S' = leadCompensator], [considers(c2, leadCompensator)]).
answer(2, ['C' = c3, 'S' = integralAction]).
why(2, ['C' = c3, 'S' = integralAction], [considers(c3, integralAction)]).
query(3, targets(_0, _1), ['C' = _0, 'R' = _1]).
result(3, complete, 2).
answer(3, ['C' = c2, 'R' = overshootReq]).
why(3, ['C' = c2, 'R' = overshootReq], [targets(c2, overshootReq)]).
answer(3, ['C' = c3, 'R' = disturbanceRejectionReq]).
why(3, ['C' = c3, 'R' = disturbanceRejectionReq], [targets(c3, disturbanceRejectionReq)]).
query(4, preserves(_0, _1), ['C' = _0, 'R' = _1]).
result(4, complete, 5).
answer(4, ['C' = c2, 'R' = stabilityReq]).
why(4, ['C' = c2, 'R' = stabilityReq], [preserves(c2, stabilityReq)]).
answer(4, ['C' = c2, 'R' = trackingReq]).
why(4, ['C' = c2, 'R' = trackingReq], [preserves(c2, trackingReq)]).
answer(4, ['C' = c3, 'R' = overshootReq]).
why(4, ['C' = c3, 'R' = overshootReq], [preserves(c3, overshootReq)]).
answer(4, ['C' = c3, 'R' = stabilityReq]).
why(4, ['C' = c3, 'R' = stabilityReq], [preserves(c3, stabilityReq)]).
answer(4, ['C' = c3, 'R' = trackingReq]).
why(4, ['C' = c3, 'R' = trackingReq], [preserves(c3, trackingReq)]).
query(5, integrates(_0, _1), ['C' = _0, 'S' = _1]).
result(5, complete, 2).
answer(5, ['C' = c2, 'S' = leadCompensator]).
why(5, ['C' = c2, 'S' = leadCompensator], [integrates(c2, leadCompensator)]).
answer(5, ['C' = c3, 'S' = integralAction]).
why(5, ['C' = c3, 'S' = integralAction], [integrates(c3, integralAction)]).
query(6, satisfies(_0, _1), ['C' = _0, 'R' = _1]).
result(6, complete, 9).
answer(6, ['C' = c1, 'R' = stabilityReq]).
why(6, ['C' = c1, 'R' = stabilityReq], [satisfies(c1, stabilityReq)]).
answer(6, ['C' = c1, 'R' = trackingReq]).
why(6, ['C' = c1, 'R' = trackingReq], [satisfies(c1, trackingReq)]).
answer(6, ['C' = c2, 'R' = overshootReq]).
why(6, ['C' = c2, 'R' = overshootReq], [satisfies(c2, overshootReq)]).
answer(6, ['C' = c3, 'R' = disturbanceRejectionReq]).
why(6, ['C' = c3, 'R' = disturbanceRejectionReq], [satisfies(c3, disturbanceRejectionReq)]).
answer(6, ['C' = c2, 'R' = stabilityReq]).
why(6, ['C' = c2, 'R' = stabilityReq], [satisfies(c2, stabilityReq)]).
answer(6, ['C' = c2, 'R' = trackingReq]).
why(6, ['C' = c2, 'R' = trackingReq], [satisfies(c2, trackingReq)]).
answer(6, ['C' = c3, 'R' = overshootReq]).
why(6, ['C' = c3, 'R' = overshootReq], [satisfies(c3, overshootReq)]).
answer(6, ['C' = c3, 'R' = stabilityReq]).
why(6, ['C' = c3, 'R' = stabilityReq], [satisfies(c3, stabilityReq)]).
answer(6, ['C' = c3, 'R' = trackingReq]).
why(6, ['C' = c3, 'R' = trackingReq], [satisfies(c3, trackingReq)]).
query(7, realizes(_0, _1), ['C' = _0, 'S' = _1]).
result(7, complete, 3).
answer(7, ['C' = c1, 'S' = baselinePID]).
why(7, ['C' = c1, 'S' = baselinePID], [realizes(c1, baselinePID)]).
answer(7, ['C' = c2, 'S' = leadCompensator]).
why(7, ['C' = c2, 'S' = leadCompensator], [realizes(c2, leadCompensator)]).
answer(7, ['C' = c3, 'S' = integralAction]).
why(7, ['C' = c3, 'S' = integralAction], [realizes(c3, integralAction)]).
query(8, status(_0, _1), ['C' = _0, 'S' = _1]).
result(8, complete, 3).
answer(8, ['C' = c1, 'S' = approvedController]).
why(8, ['C' = c1, 'S' = approvedController], [status(c1, approvedController)]).
answer(8, ['C' = c2, 'S' = approvedController]).
why(8, ['C' = c2, 'S' = approvedController], [status(c2, approvedController)]).
answer(8, ['C' = c3, 'S' = approvedController]).
why(8, ['C' = c3, 'S' = approvedController], [status(c3, approvedController)]).
query(9, available_for_future_tuning(_0, _1), ['C' = _0, 'Y' = _1]).
result(9, complete, 3).
answer(9, ['C' = c1, 'Y' = yes]).
why(9, ['C' = c1, 'Y' = yes], [available_for_future_tuning(c1, yes)]).
answer(9, ['C' = c2, 'Y' = yes]).
why(9, ['C' = c2, 'Y' = yes], [available_for_future_tuning(c2, yes)]).
answer(9, ['C' = c3, 'Y' = yes]).
why(9, ['C' = c3, 'Y' = yes], [available_for_future_tuning(c3, yes)]).

clause(1, suggests(reduceOvershoot, leadCompensator), true).
clause(2, introduces_requirement(reduceOvershoot, overshootReq), true).
clause(3, suggests(rejectDisturbance, integralAction), true).
clause(4, introduces_requirement(rejectDisturbance, disturbanceRejectionReq), true).
clause(5, compatible_with(leadCompensator, stabilityReq), true).
clause(6, compatible_with(leadCompensator, trackingReq), true).
clause(7, enables(leadCompensator, overshootReq), true).
clause(8, compatible_with(integralAction, stabilityReq), true).
clause(9, compatible_with(integralAction, trackingReq), true).
clause(10, compatible_with(integralAction, overshootReq), true).
clause(11, enables(integralAction, disturbanceRejectionReq), true).
clause(12, satisfies(c1, stabilityReq), true).
clause(13, satisfies(c1, trackingReq), true).
clause(14, realizes(c1, baselinePID), true).
clause(15, achieves(c1, approvedController), true).
clause(16, derives_from(c2, c1), true).
clause(17, design_goal(c2, reduceOvershoot), true).
clause(18, derives_from(c3, c2), true).
clause(19, design_goal(c3, rejectDisturbance), true).
clause(20,
       inherits_requirement(var('Later'), var('Req')),
       (derives_from(var('Later'), var('Earlier')), satisfies(var('Earlier'), var('Req')))).
clause(21,
       considers(var('Ctrl'), var('Strategy')),
       (design_goal(var('Ctrl'), var('Goal')), suggests(var('Goal'), var('Strategy')))).
clause(22,
       targets(var('Ctrl'), var('Req')),
       (design_goal(var('Ctrl'), var('Goal')), introduces_requirement(var('Goal'), var('Req')))).
clause(23,
       preserves(var('Ctrl'), var('Req')),
       (inherits_requirement(var('Ctrl'), var('Req')),
        considers(var('Ctrl'), var('Strategy')),
        compatible_with(var('Strategy'), var('Req')))).
clause(24,
       integrates(var('Ctrl'), var('Strategy')),
       (inherits_requirement(var('Ctrl'), var('Req')),
        considers(var('Ctrl'), var('Strategy')),
        compatible_with(var('Strategy'), var('Req')))).
clause(25,
       satisfies(var('Ctrl'), var('Req')),
       (targets(var('Ctrl'), var('Req')),
        considers(var('Ctrl'), var('Strategy')),
        enables(var('Strategy'), var('Req')))).
clause(26,
       integrates(var('Ctrl'), var('Strategy')),
       (targets(var('Ctrl'), var('Req')),
        considers(var('Ctrl'), var('Strategy')),
        enables(var('Strategy'), var('Req')))).
clause(27, satisfies(var('Ctrl'), var('Req')), preserves(var('Ctrl'), var('Req'))).
clause(28, realizes(var('Ctrl'), var('Strategy')), integrates(var('Ctrl'), var('Strategy'))).
clause(29, achieves(var('Ctrl'), approvedController), realizes(var('Ctrl'), var('Strategy'))).
clause(30,
       available_for_future_tuning(var('Ctrl'), yes),
       realizes(var('Ctrl'), var('Strategy'))).
clause(31, status(var('Ctrl'), approvedController), achieves(var('Ctrl'), approvedController)).

step(inherits_requirement(c2, stabilityReq),
     rule(20),
     ['Later' = c2, 'Req' = stabilityReq, 'Earlier' = c1],
     [derives_from(c2, c1), satisfies(c1, stabilityReq)]).
step(derives_from(c2, c1), fact(16), [], []).
step(satisfies(c1, stabilityReq), fact(12), [], []).
step(inherits_requirement(c2, trackingReq),
     rule(20),
     ['Later' = c2, 'Req' = trackingReq, 'Earlier' = c1],
     [derives_from(c2, c1), satisfies(c1, trackingReq)]).
step(satisfies(c1, trackingReq), fact(13), [], []).
step(inherits_requirement(c3, overshootReq),
     rule(20),
     ['Later' = c3, 'Req' = overshootReq, 'Earlier' = c2],
     [derives_from(c3, c2), satisfies(c2, overshootReq)]).
step(derives_from(c3, c2), fact(18), [], []).
step(satisfies(c2, overshootReq),
     rule(25),
     ['Ctrl' = c2, 'Req' = overshootReq, 'Strategy' = leadCompensator],
     [targets(c2, overshootReq),
      considers(c2, leadCompensator),
      enables(leadCompensator, overshootReq)]).
step(targets(c2, overshootReq),
     rule(22),
     ['Ctrl' = c2, 'Req' = overshootReq, 'Goal' = reduceOvershoot],
     [design_goal(c2, reduceOvershoot), introduces_requirement(reduceOvershoot, overshootReq)]).
step(design_goal(c2, reduceOvershoot), fact(17), [], []).
step(introduces_requirement(reduceOvershoot, overshootReq), fact(2), [], []).
step(considers(c2, leadCompensator),
     rule(21),
     ['Ctrl' = c2, 'Strategy' = leadCompensator, 'Goal' = reduceOvershoot],
     [design_goal(c2, reduceOvershoot), suggests(reduceOvershoot, leadCompensator)]).
step(suggests(reduceOvershoot, leadCompensator), fact(1), [], []).
step(enables(leadCompensator, overshootReq), fact(7), [], []).
step(inherits_requirement(c3, stabilityReq),
     rule(20),
     ['Later' = c3, 'Req' = stabilityReq, 'Earlier' = c2],
     [derives_from(c3, c2), satisfies(c2, stabilityReq)]).
step(satisfies(c2, stabilityReq),
     rule(27),
     ['Ctrl' = c2, 'Req' = stabilityReq],
     [preserves(c2, stabilityReq)]).
step(preserves(c2, stabilityReq),
     rule(23),
     ['Ctrl' = c2, 'Req' = stabilityReq, 'Strategy' = leadCompensator],
     [inherits_requirement(c2, stabilityReq),
      considers(c2, leadCompensator),
      compatible_with(leadCompensator, stabilityReq)]).
step(compatible_with(leadCompensator, stabilityReq), fact(5), [], []).
step(inherits_requirement(c3, trackingReq),
     rule(20),
     ['Later' = c3, 'Req' = trackingReq, 'Earlier' = c2],
     [derives_from(c3, c2), satisfies(c2, trackingReq)]).
step(satisfies(c2, trackingReq),
     rule(27),
     ['Ctrl' = c2, 'Req' = trackingReq],
     [preserves(c2, trackingReq)]).
step(preserves(c2, trackingReq),
     rule(23),
     ['Ctrl' = c2, 'Req' = trackingReq, 'Strategy' = leadCompensator],
     [inherits_requirement(c2, trackingReq),
      considers(c2, leadCompensator),
      compatible_with(leadCompensator, trackingReq)]).
step(compatible_with(leadCompensator, trackingReq), fact(6), [], []).
step(considers(c3, integralAction),
     rule(21),
     ['Ctrl' = c3, 'Strategy' = integralAction, 'Goal' = rejectDisturbance],
     [design_goal(c3, rejectDisturbance), suggests(rejectDisturbance, integralAction)]).
step(design_goal(c3, rejectDisturbance), fact(19), [], []).
step(suggests(rejectDisturbance, integralAction), fact(3), [], []).
step(targets(c3, disturbanceRejectionReq),
     rule(22),
     ['Ctrl' = c3, 'Req' = disturbanceRejectionReq, 'Goal' = rejectDisturbance],
     [design_goal(c3, rejectDisturbance),
      introduces_requirement(rejectDisturbance, disturbanceRejectionReq)]).
step(introduces_requirement(rejectDisturbance, disturbanceRejectionReq), fact(4), [], []).
step(preserves(c3, overshootReq),
     rule(23),
     ['Ctrl' = c3, 'Req' = overshootReq, 'Strategy' = integralAction],
     [inherits_requirement(c3, overshootReq),
      considers(c3, integralAction),
      compatible_with(integralAction, overshootReq)]).
step(compatible_with(integralAction, overshootReq), fact(10), [], []).
step(preserves(c3, stabilityReq),
     rule(23),
     ['Ctrl' = c3, 'Req' = stabilityReq, 'Strategy' = integralAction],
     [inherits_requirement(c3, stabilityReq),
      considers(c3, integralAction),
      compatible_with(integralAction, stabilityReq)]).
step(compatible_with(integralAction, stabilityReq), fact(8), [], []).
step(preserves(c3, trackingReq),
     rule(23),
     ['Ctrl' = c3, 'Req' = trackingReq, 'Strategy' = integralAction],
     [inherits_requirement(c3, trackingReq),
      considers(c3, integralAction),
      compatible_with(integralAction, trackingReq)]).
step(compatible_with(integralAction, trackingReq), fact(9), [], []).
step(integrates(c2, leadCompensator),
     rule(24),
     ['Ctrl' = c2, 'Strategy' = leadCompensator, 'Req' = stabilityReq],
     [inherits_requirement(c2, stabilityReq),
      considers(c2, leadCompensator),
      compatible_with(leadCompensator, stabilityReq)]).
step(integrates(c3, integralAction),
     rule(26),
     ['Ctrl' = c3, 'Strategy' = integralAction, 'Req' = disturbanceRejectionReq],
     [targets(c3, disturbanceRejectionReq),
      considers(c3, integralAction),
      enables(integralAction, disturbanceRejectionReq)]).
step(enables(integralAction, disturbanceRejectionReq), fact(11), [], []).
step(satisfies(c3, disturbanceRejectionReq),
     rule(25),
     ['Ctrl' = c3, 'Req' = disturbanceRejectionReq, 'Strategy' = integralAction],
     [targets(c3, disturbanceRejectionReq),
      considers(c3, integralAction),
      enables(integralAction, disturbanceRejectionReq)]).
step(satisfies(c3, overshootReq),
     rule(27),
     ['Ctrl' = c3, 'Req' = overshootReq],
     [preserves(c3, overshootReq)]).
step(satisfies(c3, stabilityReq),
     rule(27),
     ['Ctrl' = c3, 'Req' = stabilityReq],
     [preserves(c3, stabilityReq)]).
step(satisfies(c3, trackingReq),
     rule(27),
     ['Ctrl' = c3, 'Req' = trackingReq],
     [preserves(c3, trackingReq)]).
step(realizes(c1, baselinePID), fact(14), [], []).
step(realizes(c2, leadCompensator),
     rule(28),
     ['Ctrl' = c2, 'Strategy' = leadCompensator],
     [integrates(c2, leadCompensator)]).
step(realizes(c3, integralAction),
     rule(28),
     ['Ctrl' = c3, 'Strategy' = integralAction],
     [integrates(c3, integralAction)]).
step(status(c1, approvedController),
     rule(31),
     ['Ctrl' = c1],
     [achieves(c1, approvedController)]).
step(achieves(c1, approvedController), fact(15), [], []).
step(status(c2, approvedController),
     rule(31),
     ['Ctrl' = c2],
     [achieves(c2, approvedController)]).
step(achieves(c2, approvedController),
     rule(29),
     ['Ctrl' = c2, 'Strategy' = leadCompensator],
     [realizes(c2, leadCompensator)]).
step(status(c3, approvedController),
     rule(31),
     ['Ctrl' = c3],
     [achieves(c3, approvedController)]).
step(achieves(c3, approvedController),
     rule(29),
     ['Ctrl' = c3, 'Strategy' = integralAction],
     [realizes(c3, integralAction)]).
step(available_for_future_tuning(c1, yes),
     rule(30),
     ['Ctrl' = c1, 'Strategy' = baselinePID],
     [realizes(c1, baselinePID)]).
step(available_for_future_tuning(c2, yes),
     rule(30),
     ['Ctrl' = c2, 'Strategy' = leadCompensator],
     [realizes(c2, leadCompensator)]).
step(available_for_future_tuning(c3, yes),
     rule(30),
     ['Ctrl' = c3, 'Strategy' = integralAction],
     [realizes(c3, integralAction)]).
