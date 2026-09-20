# Eyelang example: equivalence-classes-overlap-implies-same-class.
# Companion to equivalence-classes-overlap-implies-same-class.n3/.srl:
# proves that two equivalence classes sharing a member are the same
# class, over a reflexive/symmetric/transitive :sim relation, as
# ordinary relations.
in_x(a). in_x(b). in_x(c).

sim(?x, ?x) if in_x(?x).
sim(?y, ?x) if sim(?x, ?y).
sim(?x, ?z) if sim(?x, ?y), sim(?y, ?z).

in_class_of(?u, ?x) if sim(?u, ?x).
same_class(?x, ?y) if sim(?x, ?y).
same_class(?y, ?x) if same_class(?x, ?y).

shared_member_shows_same_class(?x, ?y, ?z) if
    in_class_of(?z, ?x), in_class_of(?z, ?y), same_class(?x, ?y).

sim(b, a). sim(b, c).

result_query(?x, ?y, ?z) if shared_member_shows_same_class(?x, ?y, ?z), ?x != ?y.
ask result_query(?x, ?y, ?z).
