# Eyelang example: pillar.
# Companion to pillar.n3/.srl: a small mutually-recursive pair of rules
# (each direction of :to around :Pillar implies the other) that
# ultimately re-derives the original fact from the other direction.
to(post, pillar).
to(pillar, ?what) if to(?what, pillar).
to(?what, pillar) if to(pillar, ?what).
result_is(?what) if to(pillar, ?what).
test_is(true) if result_is(post).
ask test_is(?r).
