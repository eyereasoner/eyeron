% Prolog example: control-system-becoming.
% Companion to control-system-becoming.n3/.srl: a controller-design
% iteration model (inheriting requirements, considering a strategy for a
% design goal, and integrating it into a validated baseline), as ordinary
% relations.
suggests(reduceOvershoot, leadCompensator).
introduces_requirement(reduceOvershoot, overshootReq).
suggests(rejectDisturbance, integralAction).
introduces_requirement(rejectDisturbance, disturbanceRejectionReq).

compatible_with(leadCompensator, stabilityReq).
compatible_with(leadCompensator, trackingReq).
enables(leadCompensator, overshootReq).
compatible_with(integralAction, stabilityReq).
compatible_with(integralAction, trackingReq).
compatible_with(integralAction, overshootReq).
enables(integralAction, disturbanceRejectionReq).

satisfies(c1, stabilityReq).
satisfies(c1, trackingReq).
realizes(c1, baselinePID).
achieves(c1, approvedController).
derives_from(c2, c1).
design_goal(c2, reduceOvershoot).
derives_from(c3, c2).
design_goal(c3, rejectDisturbance).

inherits_requirement(Later, Req) :-
    derives_from(Later, Earlier),
    satisfies(Earlier, Req).
considers(Ctrl, Strategy) :-
    design_goal(Ctrl, Goal),
    suggests(Goal, Strategy).
targets(Ctrl, Req) :-
    design_goal(Ctrl, Goal),
    introduces_requirement(Goal, Req).
preserves(Ctrl, Req) :-
    inherits_requirement(Ctrl, Req),
    considers(Ctrl, Strategy),
    compatible_with(Strategy, Req).
integrates(Ctrl, Strategy) :-
    inherits_requirement(Ctrl, Req),
    considers(Ctrl, Strategy),
    compatible_with(Strategy, Req).
satisfies(Ctrl, Req) :-
    targets(Ctrl, Req),
    considers(Ctrl, Strategy),
    enables(Strategy, Req).
integrates(Ctrl, Strategy) :-
    targets(Ctrl, Req),
    considers(Ctrl, Strategy),
    enables(Strategy, Req).
satisfies(Ctrl, Req) :-
    preserves(Ctrl, Req).
realizes(Ctrl, Strategy) :-
    integrates(Ctrl, Strategy).
achieves(Ctrl, approvedController) :-
    realizes(Ctrl, Strategy).
available_for_future_tuning(Ctrl, yes) :-
    realizes(Ctrl, Strategy).
status(Ctrl, approvedController) :-
    achieves(Ctrl, approvedController).

?- inherits_requirement(L, R).
?- considers(C, S).
?- targets(C, R).
?- preserves(C, R).
?- integrates(C, S).
?- satisfies(C, R).
?- realizes(C, S).
?- status(C, S).
?- available_for_future_tuning(C, Y).
