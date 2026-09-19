# Relational formulation: [person, wolf, goat, cabbage] occupy west/east banks w/e.
# Enumerate safe paths without revisiting states, then select seven crossings.

member(?x, [?x | ?_]).
member(?x, [?_ | ?rest]) if member(?x, ?rest).
change(e, w).
change(w, e).

move([?x, ?x, ?goat, ?cabbage], wolf, [?y, ?y, ?goat, ?cabbage]) if change(?x, ?y).
move([?x, ?wolf, ?x, ?cabbage], goat, [?y, ?wolf, ?y, ?cabbage]) if change(?x, ?y).
move([?x, ?wolf, ?goat, ?x], cabbage, [?y, ?wolf, ?goat, ?y]) if change(?x, ?y).
move([?x, ?wolf, ?goat, ?cabbage], nothing, [?y, ?wolf, ?goat, ?cabbage]) if change(?x, ?y).

one_equal(?x, ?x, ?_).
one_equal(?x, ?_, ?x).
safe([?person, ?wolf, ?goat, ?cabbage]) if
    one_equal(?person, ?goat, ?wolf), one_equal(?person, ?goat, ?cabbage).

solve(?goal, ?goal, ?_, []).
solve(?state, ?goal, ?visited, [?move | ?rest]) if
    move(?state, ?move, ?next), safe(?next),
    not member(?next, ?visited),
    solve(?next, ?goal, [?next | ?visited], ?rest).

solution(?moves) if
    solve([w,w,w,w], [e,e,e,e], [[w,w,w,w]], ?moves), length(?moves, 7).

ask solution(?moves).
