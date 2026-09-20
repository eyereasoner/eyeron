# Eyelang example: greatest-lower-bound-uniqueness.
# Companion to greatest-lower-bound-uniqueness.n3/.srl: proves that a
# greatest lower bound in a partial order is unique, over two
# differently-named candidates (:g1, :g2) for the same pair, as ordinary
# relations.
in_p(a). in_p(b). in_p(g1). in_p(g2).
glb_of(g1, a, b).
glb_of(g2, a, b).

leq(?x, ?x) if in_p(?x).
leq(?x, ?z) if leq(?x, ?y), leq(?y, ?z).
same_term(?x, ?y) if leq(?x, ?y), leq(?y, ?x).
same_term(?y, ?x) if same_term(?x, ?y).

lower_bound_of(?m, ?a, ?b) if glb_of(?m, ?a, ?b).
leq(?m, ?a) if glb_of(?m, ?a, ?b).
leq(?m, ?b) if glb_of(?m, ?a, ?b).

leq(?l, ?m) if glb_of(?m, ?a, ?b), lower_bound_of(?l, ?a, ?b).

same_glb(?a, ?b, ?m, ?n) if
    glb_of(?m, ?a, ?b), glb_of(?n, ?a, ?b), same_term(?m, ?n).

result_query(?a, ?b, ?m, ?n) if same_glb(?a, ?b, ?m, ?n), ?m != ?n.
ask result_query(?a, ?b, ?m, ?n).
