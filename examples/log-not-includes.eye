# Eyelang example: log-not-includes.
# Companion to log-not-includes.n3/.srl: the N3 source demonstrates that
# log:notIncludes is deferred until closure saturation, so a fact
# produced by a *generated* rule (a rule whose own conclusion contains
# another rule -- something Eyelang has no counterpart for) is already
# present by the time the negative check runs, so it correctly never
# fires. This reifies the same outcome directly: once :a:b:c (here
# a_b_c) is derivable, `not a_b_c(true)` correctly yields no answer.
equal_one(1).
x_y(1) if equal_one(1).
a_b_c(true) if x_y(1).

test_is(false) if not a_b_c(true).

ask a_b_c(?r).
ask test_is(?r).
