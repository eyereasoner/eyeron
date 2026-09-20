# Eyelang example: control-system-becoming.
# Companion to control-system-becoming.n3/.srl: a controller-design
# iteration model (inheriting requirements, considering a strategy for a
# design goal, and integrating it into a validated baseline), as ordinary
# relations.
suggests(reduceOvershoot, leadCompensator). introduces_requirement(reduceOvershoot, overshootReq).
suggests(rejectDisturbance, integralAction). introduces_requirement(rejectDisturbance, disturbanceRejectionReq).

compatible_with(leadCompensator, stabilityReq). compatible_with(leadCompensator, trackingReq). enables(leadCompensator, overshootReq).
compatible_with(integralAction, stabilityReq). compatible_with(integralAction, trackingReq). compatible_with(integralAction, overshootReq). enables(integralAction, disturbanceRejectionReq).

satisfies(c1, stabilityReq). satisfies(c1, trackingReq). realizes(c1, baselinePID). achieves(c1, approvedController).
derives_from(c2, c1). design_goal(c2, reduceOvershoot).
derives_from(c3, c2). design_goal(c3, rejectDisturbance).

inherits_requirement(?later, ?req) if derives_from(?later, ?earlier), satisfies(?earlier, ?req).
considers(?ctrl, ?strategy) if design_goal(?ctrl, ?goal), suggests(?goal, ?strategy).
targets(?ctrl, ?req) if design_goal(?ctrl, ?goal), introduces_requirement(?goal, ?req).
preserves(?ctrl, ?req) if inherits_requirement(?ctrl, ?req), considers(?ctrl, ?strategy), compatible_with(?strategy, ?req).
integrates(?ctrl, ?strategy) if inherits_requirement(?ctrl, ?req), considers(?ctrl, ?strategy), compatible_with(?strategy, ?req).
satisfies(?ctrl, ?req) if targets(?ctrl, ?req), considers(?ctrl, ?strategy), enables(?strategy, ?req).
integrates(?ctrl, ?strategy) if targets(?ctrl, ?req), considers(?ctrl, ?strategy), enables(?strategy, ?req).
satisfies(?ctrl, ?req) if preserves(?ctrl, ?req).
realizes(?ctrl, ?strategy) if integrates(?ctrl, ?strategy).
achieves(?ctrl, approvedController) if realizes(?ctrl, ?strategy).
available_for_future_tuning(?ctrl, yes) if realizes(?ctrl, ?strategy).
status(?ctrl, approvedController) if achieves(?ctrl, approvedController).

ask inherits_requirement(?l, ?r).
ask considers(?c, ?s).
ask targets(?c, ?r).
ask preserves(?c, ?r).
ask integrates(?c, ?s).
ask satisfies(?c, ?r).
ask realizes(?c, ?s).
ask status(?c, ?s).
ask available_for_future_tuning(?c, ?y).
