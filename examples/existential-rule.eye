# Eyelang example: existential-rule.
# Companion to existential-rule.n3/.srl: N3's rule conclusion contains a
# blank node (`_:B`), so each human gets its own fresh, distinct witness
# individual (a Skolem term, deterministic per firing but otherwise
# opaque). Eyelang has no blank-node generation in a rule head, so this
# uses the compound term witness(?s) as that per-person witness instead
# -- distinct per human, the same shape of existential guarantee.
human(socrates). human(plato).
is_(?s, witness(?s)) if human(?s).
ask is_(?s, ?w).
