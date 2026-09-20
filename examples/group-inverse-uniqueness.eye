# Eyelang example: group-inverse-uniqueness.
# Companion to group-inverse-uniqueness.n3/.srl: proves that a group
# element's inverse is unique, over one element :x with two differently-
# named candidate inverses :i and :j, as ordinary relations.
in_g(x_). in_g(i_). in_g(j_). in_g(e_).
inverse_of(i_, x_).
inverse_of(j_, x_).

mul(?a, e_, ?a) if in_g(?a).
mul(e_, ?a, ?a) if in_g(?a).
mul(?x_, ?y_, e_) if in_g(?x_), in_g(?y_), inverse_of(?y_, ?x_).
mul(?y_, ?x_, e_) if in_g(?x_), in_g(?y_), inverse_of(?y_, ?x_).

same_term(?left, ?right) if mul(?a, ?b, ?ab), mul(?ab, ?c, ?left), mul(?b, ?c, ?bc), mul(?a, ?bc, ?right).
same_term(?b_, ?a_) if same_term(?a_, ?b_).

same_inverse(?x_, ?y_, ?z_) if inverse_of(?y_, ?x_), inverse_of(?z_, ?x_), same_term(?y_, ?z_).

result_query(?x_, ?y_, ?z_) if same_inverse(?x_, ?y_, ?z_), ?y_ != ?z_.
ask result_query(?x_, ?y_, ?z_).
