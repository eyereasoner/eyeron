# Eyelang example: rule-matching.
# Companion to rule-matching.n3: the source rule ({?A => ?B} => {:result
# :is true}) exploits N3's reflective capability where an implication is
# itself a first-class, quotable term that a rule can pattern-match --
# including matching itself, since the rule is itself an implication.
# Eyelang has no such rule reflection (a rule cannot be matched as data
# the way an N3 formula can), so this instead reifies "there is an
# implication" as an ordinary fact and derives the same conclusion from
# its existence.
implication(rule1).
result_is_true if implication(?_).
ask result_is_true.
