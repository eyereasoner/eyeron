# Eyelang example: composition-of-injective-functions-is-injective.
# Companion to composition-of-injective-functions-is-injective.n3/.srl:
# proves that composing two injective functions yields an injective
# function, over a small concrete example (f: a->p, b->q; g: p->r, q->r;
# h = g . f), as ordinary relations.
in_x(a). in_x(b).
in_y(p). in_y(q).
in_z(r).

same_term(?x, ?x) if in_x(?x).
same_term(?y, ?y) if in_y(?y).
same_term(?z, ?z) if in_z(?z).
same_term(?b_, ?a_) if same_term(?a_, ?b_).

same_term(?u, ?v) if app(?f, ?x, ?u), app(?f, ?x, ?v).

same_term(?x, ?y) if injective(?f), app(?f, ?x, ?u), app(?f, ?y, ?v), same_term(?u, ?v).

app(?h, ?x, ?z) if composite_of(?h, ?g, ?f), app(?f, ?x, ?y), app(?g, ?y, ?z).

same_input_under_equal_composite_output(?h, ?x, ?y) if
    composite_of(?h, ?g, ?f), injective(?f), injective(?g),
    app(?f, ?x, ?fx), app(?f, ?y, ?fy),
    app(?g, ?fx, ?u), app(?g, ?fy, ?v),
    same_term(?u, ?v), same_term(?x, ?y).

injective(f). injective(g).
composite_of(h, g, f).
app(f, a, p). app(f, b, q).
app(g, p, r). app(g, q, r).

result_query(?h, ?x, ?y) if same_input_under_equal_composite_output(?h, ?x, ?y), ?x != ?y.
ask result_query(?h, ?x, ?y).
