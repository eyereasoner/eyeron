% Prolog example: log-for-all-in.
% Companion to log-for-all-in.n3/.srl: N3's log:forAllIn checks a
% universal implication (every subtask matching the left formula also
% satisfies the right one); this is the standard double-negation
% encoding of "for all" in a closed-world engine -- there is no subtask
% that is *not* completed.
composite_task(c).
sub_task(c, s1).
sub_task(c, s2).
sub_task(c, s3).
state(s1, completed).
state(s2, completed).
state(s3, completed).

incomplete(C) :-
    sub_task(C, S),
    \+ state(S, completed).
all_completed(C) :-
    composite_task(C),
    \+ incomplete(C).

result_is(true) :-
    all_completed(c).
?- result_is(R).
