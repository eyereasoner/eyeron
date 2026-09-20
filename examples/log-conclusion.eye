# Eyelang example: log-conclusion.
# Companion to log-conclusion.n3/.srl: N3's log:conclusion reasons over a
# quoted formula (a fact plus a rule, given as data) and returns its
# closure as a new formula -- a reflective capability Eyelang has no
# counterpart for, since it has no quoted-formula term. This instead
# reifies the outcome directly as ordinary facts and a rule: Felix is a
# cat, and cats say "Meow", so Felix says "Meow" -- the same conclusion
# the source's quoted sub-theory reasons its way to.
cat(felix).
says(?x, "Meow") if cat(?x).
ask says(?x, ?msg).
