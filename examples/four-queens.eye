# Genuine finite search using a general range relation, no puzzle built-in.
safe(?_, [], ?_).
safe(?row, [?other | ?rest], ?distance) if
    ?row != ?other,
    let ?delta = abs(?row - ?other),
    ?delta != ?distance,
    let ?next = ?distance + 1,
    safe(?row, ?rest, ?next).
place(0, ?_, ?placed, ?placed).
place(?remaining, ?size, ?placed, ?rows) if
    ?remaining > 0,
    range(1, ?size, ?row),
    safe(?row, ?placed, 1),
    let ?next = ?remaining - 1,
    place(?next, ?size, [?row | ?placed], ?rows).
ask place(4, 4, [], ?rows).
