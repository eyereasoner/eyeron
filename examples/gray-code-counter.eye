# Relational circuit with gate truth tables, flip-flops, and clocks.
# No bitwise or puzzle-specific built-in is needed.

and_gate(0, 0, 0).
and_gate(0, 1, 0).
and_gate(1, 0, 0).
and_gate(1, 1, 1).
or_gate(0, 0, 0).
or_gate(0, 1, 1).
or_gate(1, 0, 1).
or_gate(1, 1, 1).
inv(0, 1).
inv(1, 0).
dff(?_, 0, ?q, ?q).
dff(?d, 1, ?_, ?d).

neta(?a, ?b, ?q) if
    and_gate(?a, ?b, ?t1), inv(?a, ?na), inv(?b, ?nb),
    and_gate(?na, ?nb, ?t2), or_gate(?t1, ?t2, ?q).
netb(?a, ?b, ?c, ?q1, ?q2) if
    and_gate(?a, ?c, ?t1), inv(?c, ?nc), and_gate(?b, ?nc, ?t2),
    inv(?a, ?na), and_gate(?na, ?c, ?t3),
    or_gate(?t1, ?t2, ?q1), or_gate(?t2, ?t3, ?q2).
gcc(?clock, [?qa, ?qb, ?qc], [?za, ?zb, ?zc]) if
    netb(?qa, ?qb, ?qc, ?d1, ?d2), neta(?qa, ?qb, ?d3),
    dff(?d1, ?clock, ?qa, ?za), dff(?d2, ?clock, ?qb, ?zb), dff(?d3, ?clock, ?qc, ?zc).

counter([], ?_, []).
counter([?clock | ?clocks], ?state, [?next | ?states]) if
    gcc(?clock, ?state, ?next), counter(?clocks, ?next, ?states).

ask counter([1,1,1,1,1,1,1,1,1], [0,0,0], ?states).
# With the clock low the flip-flops hold their previous state.
ask gcc(0, [1,0,1], ?state).
