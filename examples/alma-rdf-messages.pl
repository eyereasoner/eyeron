% Companion to alma-rdf-messages.n3/.srl: the N3 source is meant to run
% against a remote 9+ GB Alma RDF Message Log via --stream-messages, and
% is deliberately excluded from the packaged golden-output tests for
% that reason (see PARSE_ONLY_EXAMPLES in tests/examples.rs). This tests
% the same MARC field-extraction logic (marc:id / marc:map from the N3
% source's backward helper rules) against one small, self-contained
% sample record instead of the remote log, using Prolog's native list
% syntax and the member/member_at helpers list-builtins-tests.pl
% already defines, rather than a general regex-driven subfield walk
% (this sample only ever needs one subfield per field).

member(X, [X|_]).
member(X, [_|Tail]) :-
    member(X, Tail).

member_at([X|_], 0, X).
member_at([_|Xs], I, X) :-
    I > 0,
    Prev is I - 1,
    member_at(Xs, Prev, X).

record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]).

marc_id(Rec, Id) :-
    member(Field, Rec),
    member_at(Field, 0, "001"),
    member_at(Field, 4, Ctrl),
    atomics_to_string(["http://lib.ugent.be/record/", Ctrl], Id).

marc_map(Rec, Tag, Subfield, Val) :-
    member(Field, Rec),
    member_at(Field, 0, Tag),
    member_at(Field, 3, Subfield),
    member_at(Field, 4, Val).

title(Id, Val) :-
    record(Rec),
    marc_id(Rec, Id),
    marc_map(Rec, "245", "a", Val).

subject(Id, Val) :-
    record(Rec),
    marc_id(Rec, Id),
    marc_map(Rec, "650", "a", Val).

type(Id, Val) :-
    record(Rec),
    marc_id(Rec, Id),
    marc_map(Rec, "920", "a", Val).

?- title(Id, Val).
?- subject(Id, Val).
?- type(Id, Val).
