# Eyelang example: whitehead-becoming.
# Companion to whitehead-becoming.n3/.srl: the same process-philosophy
# model of "becoming" (prehension, inheritance, subjective aim, lure,
# concrescence, satisfaction, and ingression of pure potentials) as
# ordinary relations. The `subjectiveAim` property is named
# `subjective_aim_of` here to avoid colliding with the `subjective_aim/1`
# category-membership relation.
pure_potential(red). pure_potential(warm). pure_potential(bright). pure_potential(dark).

subjective_aim(intensity). subjective_aim(contrast).
lures(intensity, bright). lures(contrast, dark).

actual_occasion(o1). time(o1, 1). realizes(o1, red). realizes(o1, warm). achieves(o1, satisfaction).
actual_occasion(o2). time(o2, 2). prehends(o2, o1). subjective_aim_of(o2, intensity).
actual_occasion(o3). time(o3, 3). prehends(o3, o2). subjective_aim_of(o3, contrast).

becomes_from(?later, ?earlier) if prehends(?later, ?earlier).
inherits(?later, ?form) if prehends(?later, ?earlier), realizes(?earlier, ?form).
may_realize(?o, ?form) if subjective_aim_of(?o, ?aim), lures(?aim, ?form).
integrates(?o, ?pastForm) if inherits(?o, ?pastForm), may_realize(?o, ?novelForm).
integrates(?o, ?novelForm) if inherits(?o, ?pastForm), may_realize(?o, ?novelForm).
achieves(?o, satisfaction) if inherits(?o, ?pastForm), may_realize(?o, ?novelForm).
realizes(?o, ?form) if integrates(?o, ?form), achieves(?o, satisfaction).
ingresses(?o, ?form) if realizes(?o, ?form), pure_potential(?form).
status(?o, objectivelyAvailable) if achieves(?o, satisfaction).
available_for_future_prehension(?o, yes) if achieves(?o, satisfaction).

ask becomes_from(?later, ?earlier).
ask inherits(?o, ?form).
ask may_realize(?o, ?form).
ask integrates(?o, ?form).
ask realizes(?o, ?form).
ask ingresses(?o, ?form).
ask status(?o, ?s).
