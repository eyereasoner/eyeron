inherits_requirement(r2, stiffnessReq).
inherits_requirement(r2, assemblyReq).
inherits_requirement(r3, stiffnessReq).
inherits_requirement(r3, assemblyReq).
considers(r2, carbonFrame).
considers(r3, ribbedHousing).
preserves(r2, stiffnessReq).
preserves(r2, assemblyReq).
preserves(r3, assemblyReq).
integrates(r2, carbonFrame).
integrates(r3, ribbedHousing).
satisfies(r1, stiffnessReq).
satisfies(r1, assemblyReq).
satisfies(r2, stiffnessReq).
satisfies(r2, assemblyReq).
satisfies(r3, assemblyReq).
realizes(r1, aluminumFrame).
realizes(r2, carbonFrame).
realizes(r3, ribbedHousing).
status(r1, approvedBaseline).
status(r2, approvedBaseline).
status(r3, approvedBaseline).
available_for_future_iteration(r1, yes).
available_for_future_iteration(r2, yes).
available_for_future_iteration(r3, yes).

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
