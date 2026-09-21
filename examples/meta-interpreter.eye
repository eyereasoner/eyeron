# Eyelang is homoiconic: a clause is a term. `clause/2` reads the program's
# own clauses, with their bodies in the reified syntax proofs are already
# written in (specification 12.3), and `prove/1` runs one of those terms as
# a goal. So the vanilla meta-interpreter is ordinary Eyelang, and a
# program can reason about its own reasoning.

# The object program: nothing about it is special.
parent(ann, bob).
parent(bob, cid).
ancestor(?older, ?younger) if parent(?older, ?younger).
ancestor(?older, ?younger) if parent(?older, ?middle), ancestor(?middle, ?younger).

# The interpreter, in three clauses.
solve([]).
solve([?goal|?rest]) if prove(?goal), solve(?rest).
demo(?head) if clause(?head, ?body), solve(?body).

# The same interpreter, now also counting the clauses each answer used —
# a measurement the object program says nothing about and does not know is
# being taken.
steps(?goal, ?count) if clause(?goal, ?body), stepsAll(?body, ?inner), let ?count = ?inner + 1.
stepsAll([], 0).
stepsAll([call(?goal)|?rest], ?count) if steps(?goal, ?here), stepsAll(?rest, ?later), let ?count = ?here + ?later.

ask demo(ancestor(ann, ?descendant)).
ask steps(ancestor(ann, cid), ?clauses).
ask clause(ancestor(?older, ?younger), ?body).
