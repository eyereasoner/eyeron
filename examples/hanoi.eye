# Relational formulation: same three-disk problem and ordered seven-move answer.
# Recursive calls build move lists; append is an ordinary relation.

append([], ?ys, ?ys).
append([?x | ?xs], ?ys, [?x | ?zs]) if append(?xs, ?ys, ?zs).

hanoi(0, ?_, ?_, ?_, []).
hanoi(?n, ?from, ?to, ?via, ?moves) if
    ?n > 0,
    let ?smaller = ?n - 1,
    hanoi(?smaller, ?from, ?via, ?to, ?before),
    hanoi(?smaller, ?via, ?to, ?from, ?after),
    append(?before, [[?from, ?to] | ?after], ?moves).

ask hanoi(3, left, right, center, ?moves).
