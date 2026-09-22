% Prolog example: developmental-genetics-becoming.
% Companion to developmental-genetics-becoming.n3/.srl: a developmental
% genetics model of lineage, inheritance, signal-driven activation, and
% differentiation, as ordinary relations.
suggests(neurogenicSignal, proneuralProgram).
introduces_marker(neurogenicSignal, neuroD1).
suggests(maturationSignal, neuronalMaturationProgram).
introduces_marker(maturationSignal, tubb3).

compatible_with(proneuralProgram, sox2).
compatible_with(proneuralProgram, pax6).
enables(proneuralProgram, neuroD1).
compatible_with(neuronalMaturationProgram, pax6).
compatible_with(neuronalMaturationProgram, neuroD1).
enables(neuronalMaturationProgram, tubb3).

expresses(s1, sox2).
expresses(s1, pax6).
achieves(s1, stableCellState).
derives_from(s2, s1).
receives(s2, neurogenicSignal).
derives_from(s3, s2).
receives(s3, maturationSignal).

inherits_marker(Later, Marker) :-
    derives_from(Later, Earlier),
    expresses(Earlier, Marker).
considers(Cell, Program) :-
    receives(Cell, Signal),
    suggests(Signal, Program).
targets_marker(Cell, Marker) :-
    receives(Cell, Signal),
    introduces_marker(Signal, Marker).
preserves_marker(Cell, Marker) :-
    inherits_marker(Cell, Marker),
    considers(Cell, Program),
    compatible_with(Program, Marker).
integrates(Cell, Program) :-
    inherits_marker(Cell, Marker),
    considers(Cell, Program),
    compatible_with(Program, Marker).
expresses(Cell, Marker) :-
    targets_marker(Cell, Marker),
    considers(Cell, Program),
    enables(Program, Marker).
integrates(Cell, Program) :-
    targets_marker(Cell, Marker),
    considers(Cell, Program),
    enables(Program, Marker).
expresses(Cell, Marker) :-
    preserves_marker(Cell, Marker).
realizes(Cell, Program) :-
    integrates(Cell, Program).
achieves(Cell, stableCellState) :-
    realizes(Cell, Program).
available_for_further_differentiation(Cell, yes) :-
    realizes(Cell, Program).
status(Cell, stableCellState) :-
    achieves(Cell, stableCellState).

?- inherits_marker(L, M).
?- considers(C, P).
?- targets_marker(C, M).
?- preserves_marker(C, M).
?- integrates(C, P).
?- expresses(C, M).
?- realizes(C, P).
?- status(C, S).
?- available_for_further_differentiation(C, Y).
