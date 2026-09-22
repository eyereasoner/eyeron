% Prolog example: constructor-theory-becoming.
% Companion to constructor-theory-becoming.n3/.srl: a constructor-theory
% model of possible/impossible tasks and how a sequence of possible
% tasks transforms a substrate, as ordinary relations.
task_input(writeTask, blankMemory).
task_output(writeTask, encodedMemory).
task_input(stabilizeTask, encodedMemory).
task_output(stabilizeTask, stabilizedMemory).
task_input(perfectRestoreTask, damagedMemory).
task_output(perfectRestoreTask, pristineMemory).
forbidden_by(perfectRestoreTask, noMiraclePrinciple).

can_perform(writer, writeTask).
can_perform(stabilizer, stabilizeTask).

has_attribute(v1, blankMemory).
derives_from(v2, v1).
intends_task(v2, writeTask).
derives_from(v3, v2).
intends_task(v3, stabilizeTask).
has_attribute(damaged1, damagedMemory).
derives_from(vBad, damaged1).
intends_task(vBad, perfectRestoreTask).

status(Task, impossibleTask) :-
    forbidden_by(Task, Principle).
status(Task, possibleTask) :-
    can_perform(Constructor, Task).
retains_capacity_for(Constructor, Task) :-
    can_perform(Constructor, Task).

can_undergo(Next, Task) :-
    derives_from(Next, Prev),
    intends_task(Next, Task),
    status(Task, possibleTask),
    task_input(Task, In),
    has_attribute(Prev, In).
becomes_from(Next, Prev) :-
    derives_from(Next, Prev),
    intends_task(Next, Task),
    status(Task, possibleTask),
    task_input(Task, In),
    has_attribute(Prev, In).

has_attribute(Next, Out) :-
    can_undergo(Next, Task),
    task_output(Task, Out).

status(Next, blockedTransition) :-
    intends_task(Next, Task),
    status(Task, impossibleTask).

available_for_further_task(Next, yes) :-
    has_attribute(Next, Attr).

?- status(X, S).
?- retains_capacity_for(C, T).
?- can_undergo(Next, Task).
?- becomes_from(Next, Prev).
?- has_attribute(X, Attr).
?- available_for_further_task(X, Y).
