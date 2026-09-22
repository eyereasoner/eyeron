% Prolog example: engineering-becoming.
% Companion to engineering-becoming.n3/.srl: an engineering design
% iteration model (inheriting requirements, considering a design option,
% and integrating it into a new approved baseline), as ordinary
% relations.
suggests(reduceWeight, carbonFrame).
suggests(improveCooling, ribbedHousing).

compatible_with(carbonFrame, stiffnessReq).
compatible_with(carbonFrame, assemblyReq).
compatible_with(ribbedHousing, thermalReq).
compatible_with(ribbedHousing, assemblyReq).

satisfies(r1, stiffnessReq).
satisfies(r1, assemblyReq).
realizes(r1, aluminumFrame).
achieves(r1, approvedBaseline).
derives_from(r2, r1).
design_goal(r2, reduceWeight).
derives_from(r3, r2).
design_goal(r3, improveCooling).

inherits_requirement(Later, Req) :-
    derives_from(Later, Earlier),
    satisfies(Earlier, Req).
considers(Rev, Opt) :-
    design_goal(Rev, Goal),
    suggests(Goal, Opt).
preserves(Rev, Req) :-
    inherits_requirement(Rev, Req),
    considers(Rev, Opt),
    compatible_with(Opt, Req).
integrates(Rev, Opt) :-
    inherits_requirement(Rev, Req),
    considers(Rev, Opt),
    compatible_with(Opt, Req).
satisfies(Rev, Req) :-
    preserves(Rev, Req).
realizes(Rev, Opt) :-
    integrates(Rev, Opt).
achieves(Rev, approvedBaseline) :-
    realizes(Rev, Opt).
available_for_future_iteration(Rev, yes) :-
    realizes(Rev, Opt).
status(Rev, approvedBaseline) :-
    achieves(Rev, approvedBaseline).

?- inherits_requirement(L, R).
?- considers(Rev, O).
?- preserves(Rev, R).
?- integrates(Rev, O).
?- satisfies(Rev, R).
?- realizes(Rev, O).
?- status(Rev, S).
?- available_for_future_iteration(Rev, Y).
