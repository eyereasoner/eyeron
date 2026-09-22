% Companion to dining-philosophers.n3/.srl: the same 9-round Chandy-Misra
% dirty-fork trace, translated directly. N3's rule-head blank nodes
% (`[a dp:ForkState; ...]` etc.) become ordinary compound facts
% (`fork_state(Config, Fork, Holder, Cleanliness)` etc.) since the Prolog front end
% has no anonymous-individual rule head; every other identifier (the 19
% configs, 5 forks, 5 philosophers, 9 slots, 15 meal handles) is already
% named in the source, so this is otherwise a one-to-one port. The
% config chain (C0 -> C1 -> ... -> C18) is a strict DAG, not a cycle, so
% backward recursion through it terminates quickly with no visited-list
% guard needed, unlike this suite's genuinely cyclic search examples.

philosopher(p1).
philosopher(p2).
philosopher(p3).
philosopher(p4).
philosopher(p5).

end1(f12, p1).
end2(f12, p2).
end1(f23, p2).
end2(f23, p3).
end1(f34, p3).
end2(f34, p4).
end1(f45, p4).
end2(f45, p5).
end1(f51, p5).
end2(f51, p1).

left_fork(p1, f51).
right_fork(p1, f12).
left_fork(p2, f12).
right_fork(p2, f23).
left_fork(p3, f23).
right_fork(p3, f34).
left_fork(p4, f34).
right_fork(p4, f45).
left_fork(p5, f45).
right_fork(p5, f51).

slot(s1, 1).
slot(s2, 2).
slot(s3, 3).
slot(s4, 4).
slot(s5, 5).
slot(s6, 6).
slot(s7, 7).
slot(s8, 8).
slot(s9, 9).

meal_handle(p1, 1, mp1_1).
meal_handle(p1, 2, mp1_2).
meal_handle(p1, 3, mp1_3).
meal_handle(p2, 1, mp2_1).
meal_handle(p2, 2, mp2_2).
meal_handle(p2, 3, mp2_3).
meal_handle(p3, 1, mp3_1).
meal_handle(p3, 2, mp3_2).
meal_handle(p3, 3, mp3_3).
meal_handle(p4, 1, mp4_1).
meal_handle(p4, 2, mp4_2).
meal_handle(p4, 3, mp4_3).
meal_handle(p5, 1, mp5_1).
meal_handle(p5, 2, mp5_2).
meal_handle(p5, 3, mp5_3).

% Start-of-round configs (C0,C2,...,C16), after-transfer configs
% (C1,C3,...,C17), and end-of-round configs (C2,...,C18) chain together
% via after_sends/after_eat, exactly matching the N3 source's dp:C0..dp:C18.
config(c0, s1, 1, [p1, p3]).
after_sends(c0, c1).
after_eat(c1, c2).
config(c2, s2, 1, [p2, p4]).
after_sends(c2, c3).
after_eat(c3, c4).
config(c4, s3, 1, [p5]).
after_sends(c4, c5).
after_eat(c5, c6).
config(c6, s4, 2, [p1, p3]).
after_sends(c6, c7).
after_eat(c7, c8).
config(c8, s5, 2, [p2, p4]).
after_sends(c8, c9).
after_eat(c9, c10).
config(c10, s6, 2, [p5]).
after_sends(c10, c11).
after_eat(c11, c12).
config(c12, s7, 3, [p1, p3]).
after_sends(c12, c13).
after_eat(c13, c14).
config(c14, s8, 3, [p2, p4]).
after_sends(c14, c15).
after_eat(c15, c16).
config(c16, s9, 3, [p5]).
after_sends(c16, c17).
after_eat(c17, c18).

hungry(C, P) :-
    config(C, _, _, Hungry),
    member(P, Hungry).
member(X, [X|_]).
member(X, [_|Rest]) :-
    member(X, Rest).

% Initial fork ownership (C0): all forks dirty, one orientation around the ring.
fork_state(c0, f12, p1, dirty).
fork_state(c0, f23, p2, dirty).
fork_state(c0, f34, p3, dirty).
fork_state(c0, f45, p4, dirty).
fork_state(c0, f51, p1, dirty).

% KeepFork facts: only listed for forks NOT transferred in that round;
% transfers are derived, matching the N3 source's own trace construction.
keep_fork(c0, f12).
keep_fork(c0, f34).
keep_fork(c0, f45).
keep_fork(c0, f51).
keep_fork(c2, f45).
keep_fork(c2, f51).
keep_fork(c4, f12).
keep_fork(c4, f23).
keep_fork(c4, f34).
keep_fork(c6, f45).
keep_fork(c8, f51).
keep_fork(c10, f12).
keep_fork(c10, f23).
keep_fork(c10, f34).
keep_fork(c12, f45).
keep_fork(c14, f51).
keep_fork(c16, f12).
keep_fork(c16, f23).
keep_fork(c16, f34).

% R1: hungry philosophers request any adjacent fork they do not hold.
request(C, P, Q, F) :-
    hungry(C, P),
    left_fork(P, F),
    fork_state(C, F, Q, _),
    Q \== P.

request(C, P, Q, F) :-
    hungry(C, P),
    right_fork(P, F),
    fork_state(C, F, Q, _),
    Q \== P.

% R2: dirty-fork rule.
send_fork(C, Q, P, F) :-
    request(C, P, Q, F),
    fork_state(C, F, Q, dirty).

% U1/U2: start-of-round -> after-transfer.
fork_state(CS, F, P, clean) :-
    after_sends(C, CS),
    send_fork(C, _, P, F).

fork_state(CS, F, H, CL) :-
    after_sends(C, CS),
    keep_fork(C, F),
    fork_state(C, F, H, CL).

% Meals: after-transfer, a hungry philosopher holding both forks eats.
meal(M, P, N, S, LF, RF) :-
    after_sends(C, CS),
    config(C, S, N, _),
    hungry(C, P),
    meal_handle(P, N, M),
    left_fork(P, LF),
    right_fork(P, RF),
    fork_state(CS, LF, P, _),
    fork_state(CS, RF, P, _).

% U3: after-transfer -> end-of-round; all forks become dirty again.
fork_state(CE, F, H, dirty) :-
    after_eat(CS, CE),
    fork_state(CS, F, H, _).

ate_times(P, 3) :-
    philosopher(P),
    meal(_, P, 1, _, _, _),
    meal(_, P, 2, _, _, _),
    meal(_, P, 3, _, _, _).

everyone_ate_times_3(true) :-
    ate_times(p1, 3),
    ate_times(p2, 3),
    ate_times(p3, 3),
    ate_times(p4, 3),
    ate_times(p5, 3).

?- meal(M, P, N, S, Lf, Rf).
?- send_fork(C, From, To, F).
?- everyone_ate_times_3(Result).
