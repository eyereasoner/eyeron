% Relational circuit with gate truth tables, flip-flops, and clocks.
% No bitwise or puzzle-specific built-in is needed.

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
dff(_, 0, Q, Q).
dff(D, 1, _, D).

neta(A, B, Q) :-
    and_gate(A, B, T1),
    inv(A, Na),
    inv(B, Nb),
    and_gate(Na, Nb, T2),
    or_gate(T1, T2, Q).

netb(A, B, C, Q1, Q2) :-
    and_gate(A, C, T1),
    inv(C, Nc),
    and_gate(B, Nc, T2),
    inv(A, Na),
    and_gate(Na, C, T3),
    or_gate(T1, T2, Q1),
    or_gate(T2, T3, Q2).

gcc(Clock, [Qa, Qb, Qc], [Za, Zb, Zc]) :-
    netb(Qa, Qb, Qc, D1, D2),
    neta(Qa, Qb, D3),
    dff(D1, Clock, Qa, Za),
    dff(D2, Clock, Qb, Zb),
    dff(D3, Clock, Qc, Zc).

counter([], _, []).

counter([Clock|Clocks], State, [Next|States]) :-
    gcc(Clock, State, Next),
    counter(Clocks, Next, States).

?- counter([1, 1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 0], States).

% With the clock low the flip-flops hold their previous state.
?- gcc(0, [1, 0, 1], State).
