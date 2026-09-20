# Eyelang example: log-for-all-in.
# Companion to log-for-all-in.n3/.srl: N3's log:forAllIn checks a
# universal implication (every subtask matching the left formula also
# satisfies the right one); this is the standard double-negation
# encoding of "for all" in a closed-world engine -- there is no subtask
# that is *not* completed.
composite_task(c).
sub_task(c, s1). sub_task(c, s2). sub_task(c, s3).
state(s1, completed). state(s2, completed). state(s3, completed).

incomplete(?c) if sub_task(?c, ?s), not state(?s, completed).
all_completed(?c) if composite_task(?c), not incomplete(?c).

result_is(true) if all_completed(c).
ask result_is(?r).
