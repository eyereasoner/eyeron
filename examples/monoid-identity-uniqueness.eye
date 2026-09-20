# Eyelang example: monoid-identity-uniqueness.
# Companion to monoid-identity-uniqueness.n3/.srl: proves that a monoid's
# identity element is unique. The N3 source never actually asserts any
# :inG/:candidateIdentity facts of its own, so none of its rules ever
# fire; its query only succeeds because log:equalTo, called with a fully
# free left-hand variable, unifies it directly against :e regardless of
# any real derivation. This adds the minimal missing facts (:e and a
# candidate :e2 both in the carrier, :e2 a candidate identity) so the
# same rules actually derive the conclusion the source's own comments
# describe, rather than reproducing that vacuous shortcut.
in_g(e). candidate_identity(e2). in_g(e2).

mul(?a, e, ?a) if in_g(?a).
mul(?e2_, ?a, ?a) if candidate_identity(?e2_), in_g(?a).

unique_identity(?e2_) if
    candidate_identity(?e2_), in_g(?e2_), in_g(e),
    mul(?e2_, e, ?e2_),
    mul(?e2_, e, e).

ask unique_identity(?e2_).
