becomes_from(o2, o1).
becomes_from(o3, o2).
inherits(o2, red).
inherits(o2, warm).
inherits(o3, red).
inherits(o3, warm).
inherits(o3, bright).
may_realize(o2, bright).
may_realize(o3, dark).
integrates(o2, red).
integrates(o2, warm).
integrates(o2, bright).
integrates(o3, red).
integrates(o3, warm).
integrates(o3, bright).
integrates(o3, dark).
realizes(o1, red).
realizes(o1, warm).
realizes(o2, red).
realizes(o2, warm).
realizes(o2, bright).
realizes(o3, red).
realizes(o3, warm).
realizes(o3, bright).
realizes(o3, dark).
ingresses(o1, red).
ingresses(o1, warm).
ingresses(o2, red).
ingresses(o2, warm).
ingresses(o2, bright).
ingresses(o3, red).
ingresses(o3, warm).
ingresses(o3, bright).
ingresses(o3, dark).
status(o1, objectivelyAvailable).
status(o2, objectivelyAvailable).
status(o3, objectivelyAvailable).

clause(1, pure_potential(red), true).
clause(2, pure_potential(warm), true).
clause(3, pure_potential(bright), true).
clause(4, pure_potential(dark), true).
clause(7, lures(intensity, bright), true).
clause(8, lures(contrast, dark), true).
clause(11, realizes(o1, red), true).
clause(12, realizes(o1, warm), true).
clause(13, achieves(o1, satisfaction), true).
clause(16, prehends(o2, o1), true).
clause(17, subjective_aim_of(o2, intensity), true).
clause(20, prehends(o3, o2), true).
clause(21, subjective_aim_of(o3, contrast), true).
clause(22, becomes_from(var('Later'), var('Earlier')), prehends(var('Later'), var('Earlier'))).
clause(23,
       inherits(var('Later'), var('Form')),
       (prehends(var('Later'), var('Earlier')), realizes(var('Earlier'), var('Form')))).
clause(24,
       may_realize(var('O'), var('Form')),
       (subjective_aim_of(var('O'), var('Aim')), lures(var('Aim'), var('Form')))).
clause(25,
       integrates(var('O'), var('PastForm')),
       (inherits(var('O'), var('PastForm')), may_realize(var('O'), var('NovelForm')))).
clause(26,
       integrates(var('O'), var('NovelForm')),
       (inherits(var('O'), var('PastForm')), may_realize(var('O'), var('NovelForm')))).
clause(27,
       achieves(var('O'), satisfaction),
       (inherits(var('O'), var('PastForm')), may_realize(var('O'), var('NovelForm')))).
clause(28,
       realizes(var('O'), var('Form')),
       (integrates(var('O'), var('Form')), achieves(var('O'), satisfaction))).
clause(29,
       ingresses(var('O'), var('Form')),
       (realizes(var('O'), var('Form')), pure_potential(var('Form')))).
clause(30, status(var('O'), objectivelyAvailable), achieves(var('O'), satisfaction)).

step(becomes_from(o2, o1), rule(22), ['Later' = o2, 'Earlier' = o1], [prehends(o2, o1)]).
step(prehends(o2, o1), fact(16), [], []).
step(becomes_from(o3, o2), rule(22), ['Later' = o3, 'Earlier' = o2], [prehends(o3, o2)]).
step(prehends(o3, o2), fact(20), [], []).
step(inherits(o2, red),
     rule(23),
     ['Later' = o2, 'Form' = red, 'Earlier' = o1],
     [prehends(o2, o1), realizes(o1, red)]).
step(realizes(o1, red), fact(11), [], []).
step(inherits(o2, warm),
     rule(23),
     ['Later' = o2, 'Form' = warm, 'Earlier' = o1],
     [prehends(o2, o1), realizes(o1, warm)]).
step(realizes(o1, warm), fact(12), [], []).
step(inherits(o3, red),
     rule(23),
     ['Later' = o3, 'Form' = red, 'Earlier' = o2],
     [prehends(o3, o2), realizes(o2, red)]).
step(realizes(o2, red),
     rule(28),
     ['O' = o2, 'Form' = red],
     [integrates(o2, red), achieves(o2, satisfaction)]).
step(integrates(o2, red),
     rule(25),
     ['O' = o2, 'PastForm' = red, 'NovelForm' = bright],
     [inherits(o2, red), may_realize(o2, bright)]).
step(may_realize(o2, bright),
     rule(24),
     ['O' = o2, 'Form' = bright, 'Aim' = intensity],
     [subjective_aim_of(o2, intensity), lures(intensity, bright)]).
step(subjective_aim_of(o2, intensity), fact(17), [], []).
step(lures(intensity, bright), fact(7), [], []).
step(achieves(o2, satisfaction),
     rule(27),
     ['O' = o2, 'PastForm' = red, 'NovelForm' = bright],
     [inherits(o2, red), may_realize(o2, bright)]).
step(inherits(o3, warm),
     rule(23),
     ['Later' = o3, 'Form' = warm, 'Earlier' = o2],
     [prehends(o3, o2), realizes(o2, warm)]).
step(realizes(o2, warm),
     rule(28),
     ['O' = o2, 'Form' = warm],
     [integrates(o2, warm), achieves(o2, satisfaction)]).
step(integrates(o2, warm),
     rule(25),
     ['O' = o2, 'PastForm' = warm, 'NovelForm' = bright],
     [inherits(o2, warm), may_realize(o2, bright)]).
step(inherits(o3, bright),
     rule(23),
     ['Later' = o3, 'Form' = bright, 'Earlier' = o2],
     [prehends(o3, o2), realizes(o2, bright)]).
step(realizes(o2, bright),
     rule(28),
     ['O' = o2, 'Form' = bright],
     [integrates(o2, bright), achieves(o2, satisfaction)]).
step(integrates(o2, bright),
     rule(26),
     ['O' = o2, 'NovelForm' = bright, 'PastForm' = red],
     [inherits(o2, red), may_realize(o2, bright)]).
step(may_realize(o3, dark),
     rule(24),
     ['O' = o3, 'Form' = dark, 'Aim' = contrast],
     [subjective_aim_of(o3, contrast), lures(contrast, dark)]).
step(subjective_aim_of(o3, contrast), fact(21), [], []).
step(lures(contrast, dark), fact(8), [], []).
step(integrates(o3, red),
     rule(25),
     ['O' = o3, 'PastForm' = red, 'NovelForm' = dark],
     [inherits(o3, red), may_realize(o3, dark)]).
step(integrates(o3, warm),
     rule(25),
     ['O' = o3, 'PastForm' = warm, 'NovelForm' = dark],
     [inherits(o3, warm), may_realize(o3, dark)]).
step(integrates(o3, bright),
     rule(25),
     ['O' = o3, 'PastForm' = bright, 'NovelForm' = dark],
     [inherits(o3, bright), may_realize(o3, dark)]).
step(integrates(o3, dark),
     rule(26),
     ['O' = o3, 'NovelForm' = dark, 'PastForm' = red],
     [inherits(o3, red), may_realize(o3, dark)]).
step(realizes(o3, red),
     rule(28),
     ['O' = o3, 'Form' = red],
     [integrates(o3, red), achieves(o3, satisfaction)]).
step(achieves(o3, satisfaction),
     rule(27),
     ['O' = o3, 'PastForm' = red, 'NovelForm' = dark],
     [inherits(o3, red), may_realize(o3, dark)]).
step(realizes(o3, warm),
     rule(28),
     ['O' = o3, 'Form' = warm],
     [integrates(o3, warm), achieves(o3, satisfaction)]).
step(realizes(o3, bright),
     rule(28),
     ['O' = o3, 'Form' = bright],
     [integrates(o3, bright), achieves(o3, satisfaction)]).
step(realizes(o3, dark),
     rule(28),
     ['O' = o3, 'Form' = dark],
     [integrates(o3, dark), achieves(o3, satisfaction)]).
step(ingresses(o1, red),
     rule(29),
     ['O' = o1, 'Form' = red],
     [realizes(o1, red), pure_potential(red)]).
step(pure_potential(red), fact(1), [], []).
step(ingresses(o1, warm),
     rule(29),
     ['O' = o1, 'Form' = warm],
     [realizes(o1, warm), pure_potential(warm)]).
step(pure_potential(warm), fact(2), [], []).
step(ingresses(o2, red),
     rule(29),
     ['O' = o2, 'Form' = red],
     [realizes(o2, red), pure_potential(red)]).
step(ingresses(o2, warm),
     rule(29),
     ['O' = o2, 'Form' = warm],
     [realizes(o2, warm), pure_potential(warm)]).
step(ingresses(o2, bright),
     rule(29),
     ['O' = o2, 'Form' = bright],
     [realizes(o2, bright), pure_potential(bright)]).
step(pure_potential(bright), fact(3), [], []).
step(ingresses(o3, red),
     rule(29),
     ['O' = o3, 'Form' = red],
     [realizes(o3, red), pure_potential(red)]).
step(ingresses(o3, warm),
     rule(29),
     ['O' = o3, 'Form' = warm],
     [realizes(o3, warm), pure_potential(warm)]).
step(ingresses(o3, bright),
     rule(29),
     ['O' = o3, 'Form' = bright],
     [realizes(o3, bright), pure_potential(bright)]).
step(ingresses(o3, dark),
     rule(29),
     ['O' = o3, 'Form' = dark],
     [realizes(o3, dark), pure_potential(dark)]).
step(pure_potential(dark), fact(4), [], []).
step(status(o1, objectivelyAvailable), rule(30), ['O' = o1], [achieves(o1, satisfaction)]).
step(achieves(o1, satisfaction), fact(13), [], []).
step(status(o2, objectivelyAvailable), rule(30), ['O' = o2], [achieves(o2, satisfaction)]).
step(status(o3, objectivelyAvailable), rule(30), ['O' = o3], [achieves(o3, satisfaction)]).
