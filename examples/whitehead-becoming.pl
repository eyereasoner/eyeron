% Prolog example: whitehead-becoming.
% Companion to whitehead-becoming.n3/.srl: the same process-philosophy
% model of "becoming" (prehension, inheritance, subjective aim, lure,
% concrescence, satisfaction, and ingression of pure potentials) as
% ordinary relations. The `subjectiveAim` property is named
% `subjective_aim_of` here to avoid colliding with the `subjective_aim/1`
% category-membership relation.
pure_potential(red).
pure_potential(warm).
pure_potential(bright).
pure_potential(dark).

subjective_aim(intensity).
subjective_aim(contrast).
lures(intensity, bright).
lures(contrast, dark).

actual_occasion(o1).
time(o1, 1).
realizes(o1, red).
realizes(o1, warm).
achieves(o1, satisfaction).
actual_occasion(o2).
time(o2, 2).
prehends(o2, o1).
subjective_aim_of(o2, intensity).
actual_occasion(o3).
time(o3, 3).
prehends(o3, o2).
subjective_aim_of(o3, contrast).

becomes_from(Later, Earlier) :-
    prehends(Later, Earlier).
inherits(Later, Form) :-
    prehends(Later, Earlier),
    realizes(Earlier, Form).
may_realize(O, Form) :-
    subjective_aim_of(O, Aim),
    lures(Aim, Form).
integrates(O, PastForm) :-
    inherits(O, PastForm),
    may_realize(O, NovelForm).
integrates(O, NovelForm) :-
    inherits(O, PastForm),
    may_realize(O, NovelForm).
achieves(O, satisfaction) :-
    inherits(O, PastForm),
    may_realize(O, NovelForm).
realizes(O, Form) :-
    integrates(O, Form),
    achieves(O, satisfaction).
ingresses(O, Form) :-
    realizes(O, Form),
    pure_potential(Form).
status(O, objectivelyAvailable) :-
    achieves(O, satisfaction).
available_for_future_prehension(O, yes) :-
    achieves(O, satisfaction).

?- becomes_from(Later, Earlier).
?- inherits(O, Form).
?- may_realize(O, Form).
?- integrates(O, Form).
?- realizes(O, Form).
?- ingresses(O, Form).
?- status(O, S).
