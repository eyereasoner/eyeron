# Eyelang example: engineering-becoming.
# Companion to engineering-becoming.n3/.srl: an engineering design
# iteration model (inheriting requirements, considering a design option,
# and integrating it into a new approved baseline), as ordinary
# relations.
suggests(reduceWeight, carbonFrame).
suggests(improveCooling, ribbedHousing).

compatible_with(carbonFrame, stiffnessReq). compatible_with(carbonFrame, assemblyReq).
compatible_with(ribbedHousing, thermalReq). compatible_with(ribbedHousing, assemblyReq).

satisfies(r1, stiffnessReq). satisfies(r1, assemblyReq). realizes(r1, aluminumFrame). achieves(r1, approvedBaseline).
derives_from(r2, r1). design_goal(r2, reduceWeight).
derives_from(r3, r2). design_goal(r3, improveCooling).

inherits_requirement(?later, ?req) if derives_from(?later, ?earlier), satisfies(?earlier, ?req).
considers(?rev, ?opt) if design_goal(?rev, ?goal), suggests(?goal, ?opt).
preserves(?rev, ?req) if inherits_requirement(?rev, ?req), considers(?rev, ?opt), compatible_with(?opt, ?req).
integrates(?rev, ?opt) if inherits_requirement(?rev, ?req), considers(?rev, ?opt), compatible_with(?opt, ?req).
satisfies(?rev, ?req) if preserves(?rev, ?req).
realizes(?rev, ?opt) if integrates(?rev, ?opt).
achieves(?rev, approvedBaseline) if realizes(?rev, ?opt).
available_for_future_iteration(?rev, yes) if realizes(?rev, ?opt).
status(?rev, approvedBaseline) if achieves(?rev, approvedBaseline).

ask inherits_requirement(?l, ?r).
ask considers(?rev, ?o).
ask preserves(?rev, ?r).
ask integrates(?rev, ?o).
ask satisfies(?rev, ?r).
ask realizes(?rev, ?o).
ask status(?rev, ?s).
ask available_for_future_iteration(?rev, ?y).
