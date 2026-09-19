# Unit clauses with variables are universally quantified definitions.
append([], ?ys, ?ys).
append([?x | ?xs], ?ys, [?x | ?zs]) if append(?xs, ?ys, ?zs).
member(?x, [?x | ?_]).
member(?x, [?_ | ?xs]) if member(?x, ?xs).
ask append(?left, ?right, [a, b]).
ask member(?x, [a, b, a]).
