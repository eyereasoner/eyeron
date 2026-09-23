title("http://lib.ugent.be/record/rec42", "Reasoning about RDF Message Logs").
subject("http://lib.ugent.be/record/rec42", "Linked Data Streams").
type("http://lib.ugent.be/record/rec42", "book").

clause(1, member(var('X'), [var('X')|anonymous(1)]), true).
clause(2, member(var('X'), [anonymous(1)|var('Tail')]), member(var('X'), var('Tail'))).
clause(3, member_at([var('X')|anonymous(1)], 0, var('X')), true).
clause(4,
       member_at([anonymous(1)|var('Xs')], var('I'), var('X')),
       (var('I') > 0, var('Prev') is var('I') - 1, member_at(var('Xs'), var('Prev'), var('X')))).
clause(5,
       record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
       true).
clause(6,
       marc_id(var('Rec'), var('Id')),
       (member(var('Field'), var('Rec')),
        member_at(var('Field'), 0, "001"),
        member_at(var('Field'), 4, var('Ctrl')),
        atomics_to_string(["http://lib.ugent.be/record/", var('Ctrl')], var('Id')))).
clause(7,
       marc_map(var('Rec'), var('Tag'), var('Subfield'), var('Val')),
       (member(var('Field'), var('Rec')),
        member_at(var('Field'), 0, var('Tag')),
        member_at(var('Field'), 3, var('Subfield')),
        member_at(var('Field'), 4, var('Val')))).
clause(8,
       title(var('Id'), var('Val')),
       (record(var('Rec')),
        marc_id(var('Rec'), var('Id')),
        marc_map(var('Rec'), "245", "a", var('Val')))).
clause(9,
       subject(var('Id'), var('Val')),
       (record(var('Rec')),
        marc_id(var('Rec'), var('Id')),
        marc_map(var('Rec'), "650", "a", var('Val')))).
clause(10,
       type(var('Id'), var('Val')),
       (record(var('Rec')),
        marc_id(var('Rec'), var('Id')),
        marc_map(var('Rec'), "920", "a", var('Val')))).

step(title("http://lib.ugent.be/record/rec42", "Reasoning about RDF Message Logs"),
     rule(8),
     ['Id' = "http://lib.ugent.be/record/rec42",
      'Val' = "Reasoning about RDF Message Logs",
      'Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]],
     [record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
      marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42"),
      marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "245", "a", "Reasoning about RDF Message Logs")]).
step(record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
     fact(5),
     [],
     []).
step(marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42"),
     rule(6),
     ['Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]],
      'Id' = "http://lib.ugent.be/record/rec42",
      'Field' = ["001", "", "", "_", "rec42"],
      'Ctrl' = "rec42"],
     [member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
      member_at(["001", "", "", "_", "rec42"], 0, "001"),
      member_at(["001", "", "", "_", "rec42"], 4, "rec42"),
      atomics_to_string(["http://lib.ugent.be/record/", "rec42"], "http://lib.ugent.be/record/rec42")]).
step(member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
     fact(1),
     ['X' = ["001", "", "", "_", "rec42"]],
     []).
step(member_at(["001", "", "", "_", "rec42"], 0, "001"), fact(3), ['X' = "001"], []).
step(member_at(["001", "", "", "_", "rec42"], 4, "rec42"),
     rule(4),
     ['Xs' = ["", "", "_", "rec42"], 'I' = 4, 'X' = "rec42", 'Prev' = 3],
     [4 > 0, 3 is 4 - 1, member_at(["", "", "_", "rec42"], 3, "rec42")]).
step(4 > 0, builtin, [], []).
step(3 is 4 - 1, builtin, [], []).
step(member_at(["", "", "_", "rec42"], 3, "rec42"),
     rule(4),
     ['Xs' = ["", "_", "rec42"], 'I' = 3, 'X' = "rec42", 'Prev' = 2],
     [3 > 0, 2 is 3 - 1, member_at(["", "_", "rec42"], 2, "rec42")]).
step(3 > 0, builtin, [], []).
step(2 is 3 - 1, builtin, [], []).
step(member_at(["", "_", "rec42"], 2, "rec42"),
     rule(4),
     ['Xs' = ["_", "rec42"], 'I' = 2, 'X' = "rec42", 'Prev' = 1],
     [2 > 0, 1 is 2 - 1, member_at(["_", "rec42"], 1, "rec42")]).
step(2 > 0, builtin, [], []).
step(1 is 2 - 1, builtin, [], []).
step(member_at(["_", "rec42"], 1, "rec42"),
     rule(4),
     ['Xs' = ["rec42"], 'I' = 1, 'X' = "rec42", 'Prev' = 0],
     [1 > 0, 0 is 1 - 1, member_at(["rec42"], 0, "rec42")]).
step(1 > 0, builtin, [], []).
step(0 is 1 - 1, builtin, [], []).
step(member_at(["rec42"], 0, "rec42"), fact(3), ['X' = "rec42"], []).
step(atomics_to_string(["http://lib.ugent.be/record/", "rec42"], "http://lib.ugent.be/record/rec42"),
     builtin,
     [],
     []).
step(marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "245", "a", "Reasoning about RDF Message Logs"),
     rule(7),
     ['Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]],
      'Tag' = "245",
      'Subfield' = "a",
      'Val' = "Reasoning about RDF Message Logs",
      'Field' = ["245", "1", "0", "a", "Reasoning about RDF Message Logs"]],
     [member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
      member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 0, "245"),
      member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 3, "a"),
      member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 4, "Reasoning about RDF Message Logs")]).
step(member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
     rule(2),
     ['X' = ["245", "1", "0", "a", "Reasoning about RDF Message Logs"],
      'Tail' = [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]],
     [member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
step(member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
     fact(1),
     ['X' = ["245", "1", "0", "a", "Reasoning about RDF Message Logs"]],
     []).
step(member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 0, "245"),
     fact(3),
     ['X' = "245"],
     []).
step(member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 3, "a"),
     rule(4),
     ['Xs' = ["1", "0", "a", "Reasoning about RDF Message Logs"],
      'I' = 3,
      'X' = "a",
      'Prev' = 2],
     [3 > 0, 2 is 3 - 1, member_at(["1", "0", "a", "Reasoning about RDF Message Logs"], 2, "a")]).
step(member_at(["1", "0", "a", "Reasoning about RDF Message Logs"], 2, "a"),
     rule(4),
     ['Xs' = ["0", "a", "Reasoning about RDF Message Logs"], 'I' = 2, 'X' = "a", 'Prev' = 1],
     [2 > 0, 1 is 2 - 1, member_at(["0", "a", "Reasoning about RDF Message Logs"], 1, "a")]).
step(member_at(["0", "a", "Reasoning about RDF Message Logs"], 1, "a"),
     rule(4),
     ['Xs' = ["a", "Reasoning about RDF Message Logs"], 'I' = 1, 'X' = "a", 'Prev' = 0],
     [1 > 0, 0 is 1 - 1, member_at(["a", "Reasoning about RDF Message Logs"], 0, "a")]).
step(member_at(["a", "Reasoning about RDF Message Logs"], 0, "a"), fact(3), ['X' = "a"], []).
step(member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 4, "Reasoning about RDF Message Logs"),
     rule(4),
     ['Xs' = ["1", "0", "a", "Reasoning about RDF Message Logs"],
      'I' = 4,
      'X' = "Reasoning about RDF Message Logs",
      'Prev' = 3],
     [4 > 0,
      3 is 4 - 1,
      member_at(["1", "0", "a", "Reasoning about RDF Message Logs"], 3, "Reasoning about RDF Message Logs")]).
step(member_at(["1", "0", "a", "Reasoning about RDF Message Logs"], 3, "Reasoning about RDF Message Logs"),
     rule(4),
     ['Xs' = ["0", "a", "Reasoning about RDF Message Logs"],
      'I' = 3,
      'X' = "Reasoning about RDF Message Logs",
      'Prev' = 2],
     [3 > 0,
      2 is 3 - 1,
      member_at(["0", "a", "Reasoning about RDF Message Logs"], 2, "Reasoning about RDF Message Logs")]).
step(member_at(["0", "a", "Reasoning about RDF Message Logs"], 2, "Reasoning about RDF Message Logs"),
     rule(4),
     ['Xs' = ["a", "Reasoning about RDF Message Logs"],
      'I' = 2,
      'X' = "Reasoning about RDF Message Logs",
      'Prev' = 1],
     [2 > 0,
      1 is 2 - 1,
      member_at(["a", "Reasoning about RDF Message Logs"], 1, "Reasoning about RDF Message Logs")]).
step(member_at(["a", "Reasoning about RDF Message Logs"], 1, "Reasoning about RDF Message Logs"),
     rule(4),
     ['Xs' = ["Reasoning about RDF Message Logs"],
      'I' = 1,
      'X' = "Reasoning about RDF Message Logs",
      'Prev' = 0],
     [1 > 0,
      0 is 1 - 1,
      member_at(["Reasoning about RDF Message Logs"], 0, "Reasoning about RDF Message Logs")]).
step(member_at(["Reasoning about RDF Message Logs"], 0, "Reasoning about RDF Message Logs"),
     fact(3),
     ['X' = "Reasoning about RDF Message Logs"],
     []).
step(subject("http://lib.ugent.be/record/rec42", "Linked Data Streams"),
     rule(9),
     ['Id' = "http://lib.ugent.be/record/rec42",
      'Val' = "Linked Data Streams",
      'Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]],
     [record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
      marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42"),
      marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "650", "a", "Linked Data Streams")]).
step(marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "650", "a", "Linked Data Streams"),
     rule(7),
     ['Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]],
      'Tag' = "650",
      'Subfield' = "a",
      'Val' = "Linked Data Streams",
      'Field' = ["650", " ", "0", "a", "Linked Data Streams"]],
     [member(["650", " ", "0", "a", "Linked Data Streams"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
      member_at(["650", " ", "0", "a", "Linked Data Streams"], 0, "650"),
      member_at(["650", " ", "0", "a", "Linked Data Streams"], 3, "a"),
      member_at(["650", " ", "0", "a", "Linked Data Streams"], 4, "Linked Data Streams")]).
step(member(["650", " ", "0", "a", "Linked Data Streams"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
     rule(2),
     ['X' = ["650", " ", "0", "a", "Linked Data Streams"],
      'Tail' = [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]],
     [member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
step(member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
     rule(2),
     ['X' = ["650", " ", "0", "a", "Linked Data Streams"],
      'Tail' = [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]],
     [member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
step(member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
     fact(1),
     ['X' = ["650", " ", "0", "a", "Linked Data Streams"]],
     []).
step(member_at(["650", " ", "0", "a", "Linked Data Streams"], 0, "650"),
     fact(3),
     ['X' = "650"],
     []).
step(member_at(["650", " ", "0", "a", "Linked Data Streams"], 3, "a"),
     rule(4),
     ['Xs' = [" ", "0", "a", "Linked Data Streams"], 'I' = 3, 'X' = "a", 'Prev' = 2],
     [3 > 0, 2 is 3 - 1, member_at([" ", "0", "a", "Linked Data Streams"], 2, "a")]).
step(member_at([" ", "0", "a", "Linked Data Streams"], 2, "a"),
     rule(4),
     ['Xs' = ["0", "a", "Linked Data Streams"], 'I' = 2, 'X' = "a", 'Prev' = 1],
     [2 > 0, 1 is 2 - 1, member_at(["0", "a", "Linked Data Streams"], 1, "a")]).
step(member_at(["0", "a", "Linked Data Streams"], 1, "a"),
     rule(4),
     ['Xs' = ["a", "Linked Data Streams"], 'I' = 1, 'X' = "a", 'Prev' = 0],
     [1 > 0, 0 is 1 - 1, member_at(["a", "Linked Data Streams"], 0, "a")]).
step(member_at(["a", "Linked Data Streams"], 0, "a"), fact(3), ['X' = "a"], []).
step(member_at(["650", " ", "0", "a", "Linked Data Streams"], 4, "Linked Data Streams"),
     rule(4),
     ['Xs' = [" ", "0", "a", "Linked Data Streams"],
      'I' = 4,
      'X' = "Linked Data Streams",
      'Prev' = 3],
     [4 > 0,
      3 is 4 - 1,
      member_at([" ", "0", "a", "Linked Data Streams"], 3, "Linked Data Streams")]).
step(member_at([" ", "0", "a", "Linked Data Streams"], 3, "Linked Data Streams"),
     rule(4),
     ['Xs' = ["0", "a", "Linked Data Streams"],
      'I' = 3,
      'X' = "Linked Data Streams",
      'Prev' = 2],
     [3 > 0, 2 is 3 - 1, member_at(["0", "a", "Linked Data Streams"], 2, "Linked Data Streams")]).
step(member_at(["0", "a", "Linked Data Streams"], 2, "Linked Data Streams"),
     rule(4),
     ['Xs' = ["a", "Linked Data Streams"], 'I' = 2, 'X' = "Linked Data Streams", 'Prev' = 1],
     [2 > 0, 1 is 2 - 1, member_at(["a", "Linked Data Streams"], 1, "Linked Data Streams")]).
step(member_at(["a", "Linked Data Streams"], 1, "Linked Data Streams"),
     rule(4),
     ['Xs' = ["Linked Data Streams"], 'I' = 1, 'X' = "Linked Data Streams", 'Prev' = 0],
     [1 > 0, 0 is 1 - 1, member_at(["Linked Data Streams"], 0, "Linked Data Streams")]).
step(member_at(["Linked Data Streams"], 0, "Linked Data Streams"),
     fact(3),
     ['X' = "Linked Data Streams"],
     []).
step(type("http://lib.ugent.be/record/rec42", "book"),
     rule(10),
     ['Id' = "http://lib.ugent.be/record/rec42",
      'Val' = "book",
      'Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]],
     [record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
      marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42"),
      marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "920", "a", "book")]).
step(marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "920", "a", "book"),
     rule(7),
     ['Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]],
      'Tag' = "920",
      'Subfield' = "a",
      'Val' = "book",
      'Field' = ["920", " ", " ", "a", "book"]],
     [member(["920", " ", " ", "a", "book"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
      member_at(["920", " ", " ", "a", "book"], 0, "920"),
      member_at(["920", " ", " ", "a", "book"], 3, "a"),
      member_at(["920", " ", " ", "a", "book"], 4, "book")]).
step(member(["920", " ", " ", "a", "book"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
     rule(2),
     ['X' = ["920", " ", " ", "a", "book"],
      'Tail' = [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]],
     [member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
step(member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
     rule(2),
     ['X' = ["920", " ", " ", "a", "book"],
      'Tail' = [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]],
     [member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
step(member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]),
     rule(2),
     ['X' = ["920", " ", " ", "a", "book"], 'Tail' = [["920", " ", " ", "a", "book"]]],
     [member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]])]).
step(member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]]),
     fact(1),
     ['X' = ["920", " ", " ", "a", "book"]],
     []).
step(member_at(["920", " ", " ", "a", "book"], 0, "920"), fact(3), ['X' = "920"], []).
step(member_at(["920", " ", " ", "a", "book"], 3, "a"),
     rule(4),
     ['Xs' = [" ", " ", "a", "book"], 'I' = 3, 'X' = "a", 'Prev' = 2],
     [3 > 0, 2 is 3 - 1, member_at([" ", " ", "a", "book"], 2, "a")]).
step(member_at([" ", " ", "a", "book"], 2, "a"),
     rule(4),
     ['Xs' = [" ", "a", "book"], 'I' = 2, 'X' = "a", 'Prev' = 1],
     [2 > 0, 1 is 2 - 1, member_at([" ", "a", "book"], 1, "a")]).
step(member_at([" ", "a", "book"], 1, "a"),
     rule(4),
     ['Xs' = ["a", "book"], 'I' = 1, 'X' = "a", 'Prev' = 0],
     [1 > 0, 0 is 1 - 1, member_at(["a", "book"], 0, "a")]).
step(member_at(["a", "book"], 0, "a"), fact(3), ['X' = "a"], []).
step(member_at(["920", " ", " ", "a", "book"], 4, "book"),
     rule(4),
     ['Xs' = [" ", " ", "a", "book"], 'I' = 4, 'X' = "book", 'Prev' = 3],
     [4 > 0, 3 is 4 - 1, member_at([" ", " ", "a", "book"], 3, "book")]).
step(member_at([" ", " ", "a", "book"], 3, "book"),
     rule(4),
     ['Xs' = [" ", "a", "book"], 'I' = 3, 'X' = "book", 'Prev' = 2],
     [3 > 0, 2 is 3 - 1, member_at([" ", "a", "book"], 2, "book")]).
step(member_at([" ", "a", "book"], 2, "book"),
     rule(4),
     ['Xs' = ["a", "book"], 'I' = 2, 'X' = "book", 'Prev' = 1],
     [2 > 0, 1 is 2 - 1, member_at(["a", "book"], 1, "book")]).
step(member_at(["a", "book"], 1, "book"),
     rule(4),
     ['Xs' = ["book"], 'I' = 1, 'X' = "book", 'Prev' = 0],
     [1 > 0, 0 is 1 - 1, member_at(["book"], 0, "book")]).
step(member_at(["book"], 0, "book"), fact(3), ['X' = "book"], []).
