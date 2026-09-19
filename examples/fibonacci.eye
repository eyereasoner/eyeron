# Exact integers, computed only for calls demanded by the question.
fib(0, 0).
fib(1, 1).
fib(?n, ?f) if
    ?n > 1,
    let ?previous = ?n - 1,
    let ?earlier = ?n - 2,
    fib(?previous, ?a),
    fib(?earlier, ?b),
    let ?f = ?a + ?b.
ask fib(100, ?value).
