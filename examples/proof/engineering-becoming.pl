% Prolog result format 4
query(1, inherits_requirement(_0, _1), ['L' = _0, 'R' = _1]).
result(1, complete, 4).
answer(1, ['L' = r2, 'R' = stiffnessReq]).
why(1, ['L' = r2, 'R' = stiffnessReq], [inherits_requirement(r2, stiffnessReq)]).
answer(1, ['L' = r2, 'R' = assemblyReq]).
why(1, ['L' = r2, 'R' = assemblyReq], [inherits_requirement(r2, assemblyReq)]).
answer(1, ['L' = r3, 'R' = stiffnessReq]).
why(1, ['L' = r3, 'R' = stiffnessReq], [inherits_requirement(r3, stiffnessReq)]).
answer(1, ['L' = r3, 'R' = assemblyReq]).
why(1, ['L' = r3, 'R' = assemblyReq], [inherits_requirement(r3, assemblyReq)]).
query(2, considers(_0, _1), ['Rev' = _0, 'O' = _1]).
result(2, complete, 2).
answer(2, ['Rev' = r2, 'O' = carbonFrame]).
why(2, ['Rev' = r2, 'O' = carbonFrame], [considers(r2, carbonFrame)]).
answer(2, ['Rev' = r3, 'O' = ribbedHousing]).
why(2, ['Rev' = r3, 'O' = ribbedHousing], [considers(r3, ribbedHousing)]).
query(3, preserves(_0, _1), ['Rev' = _0, 'R' = _1]).
result(3, complete, 3).
answer(3, ['Rev' = r2, 'R' = stiffnessReq]).
why(3, ['Rev' = r2, 'R' = stiffnessReq], [preserves(r2, stiffnessReq)]).
answer(3, ['Rev' = r2, 'R' = assemblyReq]).
why(3, ['Rev' = r2, 'R' = assemblyReq], [preserves(r2, assemblyReq)]).
answer(3, ['Rev' = r3, 'R' = assemblyReq]).
why(3, ['Rev' = r3, 'R' = assemblyReq], [preserves(r3, assemblyReq)]).
query(4, integrates(_0, _1), ['Rev' = _0, 'O' = _1]).
result(4, complete, 2).
answer(4, ['Rev' = r2, 'O' = carbonFrame]).
why(4, ['Rev' = r2, 'O' = carbonFrame], [integrates(r2, carbonFrame)]).
answer(4, ['Rev' = r3, 'O' = ribbedHousing]).
why(4, ['Rev' = r3, 'O' = ribbedHousing], [integrates(r3, ribbedHousing)]).
query(5, satisfies(_0, _1), ['Rev' = _0, 'R' = _1]).
result(5, complete, 5).
answer(5, ['Rev' = r1, 'R' = stiffnessReq]).
why(5, ['Rev' = r1, 'R' = stiffnessReq], [satisfies(r1, stiffnessReq)]).
answer(5, ['Rev' = r1, 'R' = assemblyReq]).
why(5, ['Rev' = r1, 'R' = assemblyReq], [satisfies(r1, assemblyReq)]).
answer(5, ['Rev' = r2, 'R' = stiffnessReq]).
why(5, ['Rev' = r2, 'R' = stiffnessReq], [satisfies(r2, stiffnessReq)]).
answer(5, ['Rev' = r2, 'R' = assemblyReq]).
why(5, ['Rev' = r2, 'R' = assemblyReq], [satisfies(r2, assemblyReq)]).
answer(5, ['Rev' = r3, 'R' = assemblyReq]).
why(5, ['Rev' = r3, 'R' = assemblyReq], [satisfies(r3, assemblyReq)]).
query(6, realizes(_0, _1), ['Rev' = _0, 'O' = _1]).
result(6, complete, 3).
answer(6, ['Rev' = r1, 'O' = aluminumFrame]).
why(6, ['Rev' = r1, 'O' = aluminumFrame], [realizes(r1, aluminumFrame)]).
answer(6, ['Rev' = r2, 'O' = carbonFrame]).
why(6, ['Rev' = r2, 'O' = carbonFrame], [realizes(r2, carbonFrame)]).
answer(6, ['Rev' = r3, 'O' = ribbedHousing]).
why(6, ['Rev' = r3, 'O' = ribbedHousing], [realizes(r3, ribbedHousing)]).
query(7, status(_0, _1), ['Rev' = _0, 'S' = _1]).
result(7, complete, 3).
answer(7, ['Rev' = r1, 'S' = approvedBaseline]).
why(7, ['Rev' = r1, 'S' = approvedBaseline], [status(r1, approvedBaseline)]).
answer(7, ['Rev' = r2, 'S' = approvedBaseline]).
why(7, ['Rev' = r2, 'S' = approvedBaseline], [status(r2, approvedBaseline)]).
answer(7, ['Rev' = r3, 'S' = approvedBaseline]).
why(7, ['Rev' = r3, 'S' = approvedBaseline], [status(r3, approvedBaseline)]).
query(8, available_for_future_iteration(_0, _1), ['Rev' = _0, 'Y' = _1]).
result(8, complete, 3).
answer(8, ['Rev' = r1, 'Y' = yes]).
why(8, ['Rev' = r1, 'Y' = yes], [available_for_future_iteration(r1, yes)]).
answer(8, ['Rev' = r2, 'Y' = yes]).
why(8, ['Rev' = r2, 'Y' = yes], [available_for_future_iteration(r2, yes)]).
answer(8, ['Rev' = r3, 'Y' = yes]).
why(8, ['Rev' = r3, 'Y' = yes], [available_for_future_iteration(r3, yes)]).

clause(1, suggests(reduceWeight, carbonFrame), true).
clause(2, suggests(improveCooling, ribbedHousing), true).
clause(3, compatible_with(carbonFrame, stiffnessReq), true).
clause(4, compatible_with(carbonFrame, assemblyReq), true).
clause(6, compatible_with(ribbedHousing, assemblyReq), true).
clause(7, satisfies(r1, stiffnessReq), true).
clause(8, satisfies(r1, assemblyReq), true).
clause(9, realizes(r1, aluminumFrame), true).
clause(10, achieves(r1, approvedBaseline), true).
clause(11, derives_from(r2, r1), true).
clause(12, design_goal(r2, reduceWeight), true).
clause(13, derives_from(r3, r2), true).
clause(14, design_goal(r3, improveCooling), true).
clause(15,
       inherits_requirement(var('Later'), var('Req')),
       (derives_from(var('Later'), var('Earlier')), satisfies(var('Earlier'), var('Req')))).
clause(16,
       considers(var('Rev'), var('Opt')),
       (design_goal(var('Rev'), var('Goal')), suggests(var('Goal'), var('Opt')))).
clause(17,
       preserves(var('Rev'), var('Req')),
       (inherits_requirement(var('Rev'), var('Req')),
        considers(var('Rev'), var('Opt')),
        compatible_with(var('Opt'), var('Req')))).
clause(18,
       integrates(var('Rev'), var('Opt')),
       (inherits_requirement(var('Rev'), var('Req')),
        considers(var('Rev'), var('Opt')),
        compatible_with(var('Opt'), var('Req')))).
clause(19, satisfies(var('Rev'), var('Req')), preserves(var('Rev'), var('Req'))).
clause(20, realizes(var('Rev'), var('Opt')), integrates(var('Rev'), var('Opt'))).
clause(21, achieves(var('Rev'), approvedBaseline), realizes(var('Rev'), var('Opt'))).
clause(22, available_for_future_iteration(var('Rev'), yes), realizes(var('Rev'), var('Opt'))).
clause(23, status(var('Rev'), approvedBaseline), achieves(var('Rev'), approvedBaseline)).

step(inherits_requirement(r2, stiffnessReq),
     rule(15),
     ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1],
     [derives_from(r2, r1), satisfies(r1, stiffnessReq)]).
step(derives_from(r2, r1), fact(11), [], []).
step(satisfies(r1, stiffnessReq), fact(7), [], []).
step(inherits_requirement(r2, assemblyReq),
     rule(15),
     ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1],
     [derives_from(r2, r1), satisfies(r1, assemblyReq)]).
step(satisfies(r1, assemblyReq), fact(8), [], []).
step(inherits_requirement(r3, stiffnessReq),
     rule(15),
     ['Later' = r3, 'Req' = stiffnessReq, 'Earlier' = r2],
     [derives_from(r3, r2), satisfies(r2, stiffnessReq)]).
step(derives_from(r3, r2), fact(13), [], []).
step(satisfies(r2, stiffnessReq),
     rule(19),
     ['Rev' = r2, 'Req' = stiffnessReq],
     [preserves(r2, stiffnessReq)]).
step(preserves(r2, stiffnessReq),
     rule(17),
     ['Rev' = r2, 'Req' = stiffnessReq, 'Opt' = carbonFrame],
     [inherits_requirement(r2, stiffnessReq),
      considers(r2, carbonFrame),
      compatible_with(carbonFrame, stiffnessReq)]).
step(considers(r2, carbonFrame),
     rule(16),
     ['Rev' = r2, 'Opt' = carbonFrame, 'Goal' = reduceWeight],
     [design_goal(r2, reduceWeight), suggests(reduceWeight, carbonFrame)]).
step(design_goal(r2, reduceWeight), fact(12), [], []).
step(suggests(reduceWeight, carbonFrame), fact(1), [], []).
step(compatible_with(carbonFrame, stiffnessReq), fact(3), [], []).
step(inherits_requirement(r3, assemblyReq),
     rule(15),
     ['Later' = r3, 'Req' = assemblyReq, 'Earlier' = r2],
     [derives_from(r3, r2), satisfies(r2, assemblyReq)]).
step(satisfies(r2, assemblyReq),
     rule(19),
     ['Rev' = r2, 'Req' = assemblyReq],
     [preserves(r2, assemblyReq)]).
step(preserves(r2, assemblyReq),
     rule(17),
     ['Rev' = r2, 'Req' = assemblyReq, 'Opt' = carbonFrame],
     [inherits_requirement(r2, assemblyReq),
      considers(r2, carbonFrame),
      compatible_with(carbonFrame, assemblyReq)]).
step(compatible_with(carbonFrame, assemblyReq), fact(4), [], []).
step(considers(r3, ribbedHousing),
     rule(16),
     ['Rev' = r3, 'Opt' = ribbedHousing, 'Goal' = improveCooling],
     [design_goal(r3, improveCooling), suggests(improveCooling, ribbedHousing)]).
step(design_goal(r3, improveCooling), fact(14), [], []).
step(suggests(improveCooling, ribbedHousing), fact(2), [], []).
step(preserves(r3, assemblyReq),
     rule(17),
     ['Rev' = r3, 'Req' = assemblyReq, 'Opt' = ribbedHousing],
     [inherits_requirement(r3, assemblyReq),
      considers(r3, ribbedHousing),
      compatible_with(ribbedHousing, assemblyReq)]).
step(compatible_with(ribbedHousing, assemblyReq), fact(6), [], []).
step(integrates(r2, carbonFrame),
     rule(18),
     ['Rev' = r2, 'Opt' = carbonFrame, 'Req' = stiffnessReq],
     [inherits_requirement(r2, stiffnessReq),
      considers(r2, carbonFrame),
      compatible_with(carbonFrame, stiffnessReq)]).
step(integrates(r3, ribbedHousing),
     rule(18),
     ['Rev' = r3, 'Opt' = ribbedHousing, 'Req' = assemblyReq],
     [inherits_requirement(r3, assemblyReq),
      considers(r3, ribbedHousing),
      compatible_with(ribbedHousing, assemblyReq)]).
step(satisfies(r3, assemblyReq),
     rule(19),
     ['Rev' = r3, 'Req' = assemblyReq],
     [preserves(r3, assemblyReq)]).
step(realizes(r1, aluminumFrame), fact(9), [], []).
step(realizes(r2, carbonFrame),
     rule(20),
     ['Rev' = r2, 'Opt' = carbonFrame],
     [integrates(r2, carbonFrame)]).
step(realizes(r3, ribbedHousing),
     rule(20),
     ['Rev' = r3, 'Opt' = ribbedHousing],
     [integrates(r3, ribbedHousing)]).
step(status(r1, approvedBaseline), rule(23), ['Rev' = r1], [achieves(r1, approvedBaseline)]).
step(achieves(r1, approvedBaseline), fact(10), [], []).
step(status(r2, approvedBaseline), rule(23), ['Rev' = r2], [achieves(r2, approvedBaseline)]).
step(achieves(r2, approvedBaseline),
     rule(21),
     ['Rev' = r2, 'Opt' = carbonFrame],
     [realizes(r2, carbonFrame)]).
step(status(r3, approvedBaseline), rule(23), ['Rev' = r3], [achieves(r3, approvedBaseline)]).
step(achieves(r3, approvedBaseline),
     rule(21),
     ['Rev' = r3, 'Opt' = ribbedHousing],
     [realizes(r3, ribbedHousing)]).
step(available_for_future_iteration(r1, yes),
     rule(22),
     ['Rev' = r1, 'Opt' = aluminumFrame],
     [realizes(r1, aluminumFrame)]).
step(available_for_future_iteration(r2, yes),
     rule(22),
     ['Rev' = r2, 'Opt' = carbonFrame],
     [realizes(r2, carbonFrame)]).
step(available_for_future_iteration(r3, yes),
     rule(22),
     ['Rev' = r3, 'Opt' = ribbedHousing],
     [realizes(r3, ribbedHousing)]).
