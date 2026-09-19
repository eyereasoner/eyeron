# Eyelang example: deep-taxonomy-100000.
# Classes are terms so the generated hierarchy remains compact without losing
# its shape. At every step N(level) has three direct superclasses: the next
# spine class N(next), and the terminal, incomparable side classes I(next) and
# J(next). The final spine class is directly below A2.
direct_subclass(n(?level), n(?next)) if ?level >= 0, ?level < 100000, let ?next = ?level + 1.
direct_subclass(n(?level), i(?next)) if ?level >= 0, ?level < 100000, let ?next = ?level + 1.
direct_subclass(n(?level), j(?next)) if ?level >= 0, ?level < 100000, let ?next = ?level + 1.
direct_subclass(n(100000), a2).

# Closed forms of the transitive closure of the generated hierarchy. These are
# the logical subsumption consequences of the direct edges above, expressed in
# O(1) space so the 100000-level benchmark remains runnable by the reference
# interpreter. The calling mode requires both class terms to be ground.
subsumed(?class, ?class).
subsumed(n(?lower), n(?upper)) if ?lower >= 0, ?lower < ?upper, ?upper <= 100000.
subsumed(n(?lower), i(?branch)) if ?lower >= 0, ?lower < ?branch, ?branch <= 100000.
subsumed(n(?lower), j(?branch)) if ?lower >= 0, ?lower < ?branch, ?branch <= 100000.
subsumed(n(?lower), a2) if ?lower >= 0, ?lower <= 100000.

asserted_type(ind, n(0)).
classified_as(?individual, ?class) if asserted_type(?individual, ?base), subsumed(?base, ?class).

# Spine reachability, both side branches, terminal classification, and branch
# incomparability are all observable acceptance conditions.
ask direct_subclass(n(49999), n(50000)).
ask direct_subclass(n(49999), i(50000)).
ask direct_subclass(n(49999), j(50000)).
ask subsumed(n(0), n(100000)).
ask classified_as(ind, i(50000)).
ask classified_as(ind, j(100000)).
ask classified_as(ind, a2).
ask not subsumed(i(50000), n(100000)).
ask not subsumed(i(50000), j(50000)).
ask not classified_as(ind, i(100001)).
ask not direct_subclass(n(-1), n(0)).
ask not subsumed(a2, n(100000)).
