# Companion to alma-rdf-messages.n3/.srl: the N3 source is meant to run
# against a remote 9+ GB Alma RDF Message Log via --stream-messages, and
# is deliberately excluded from the packaged golden-output tests for
# that reason (see PARSE_ONLY_EXAMPLES in tests/examples.rs). This tests
# the same MARC field-extraction logic (marc:id / marc:map from the N3
# source's backward helper rules) against one small, self-contained
# sample record instead of the remote log, using eyelang's native list
# syntax and the member/member_at helpers list-builtins-tests.eye
# already defines, rather than a general regex-driven subfield walk
# (this sample only ever needs one subfield per field).

member(?x, [?x | ?_]).
member(?x, [?_ | ?tail]) if member(?x, ?tail).

member_at([?x | ?_], 0, ?x).
member_at([?_ | ?xs], ?i, ?x) if ?i > 0, let ?prev = ?i - 1, member_at(?xs, ?prev, ?x).

record([
  ["001", "", "", "_", "rec42"],
  ["245", "1", "0", "a", "Reasoning about RDF Message Logs"],
  ["650", " ", "0", "a", "Linked Data Streams"],
  ["920", " ", " ", "a", "book"]
]).

marc_id(?rec, ?id) if
    member(?field, ?rec), member_at(?field, 0, "001"), member_at(?field, 4, ?ctrl),
    let ?id = concat("http://lib.ugent.be/record/", ?ctrl).

marc_map(?rec, ?tag, ?subfield, ?val) if
    member(?field, ?rec), member_at(?field, 0, ?tag), member_at(?field, 3, ?subfield),
    member_at(?field, 4, ?val).

title(?id, ?val) if
    record(?rec), marc_id(?rec, ?id), marc_map(?rec, "245", "a", ?val).

subject(?id, ?val) if
    record(?rec), marc_id(?rec, ?id), marc_map(?rec, "650", "a", ?val).

type(?id, ?val) if
    record(?rec), marc_id(?rec, ?id), marc_map(?rec, "920", "a", ?val).

ask title(?id, ?val).
ask subject(?id, ?val).
ask type(?id, ?val).
