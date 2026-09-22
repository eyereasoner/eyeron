% Prolog example: existential-rule.
% Companion to existential-rule.n3/.srl: N3's rule conclusion contains a
% blank node (`_:B`), so each human gets its own fresh, distinct witness
% individual (a Skolem term, deterministic per firing but otherwise
% opaque). Prolog has no blank-node generation in a rule head, so this
% uses the compound term witness(?s) as that per-person witness instead
% -- distinct per human, the same shape of existential guarantee.
human(socrates).
human(plato).
is_(S, witness(S)) :-
    human(S).
?- is_(S, W).
