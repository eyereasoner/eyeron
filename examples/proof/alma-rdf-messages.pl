% Prolog result format 3
query(1, title(_0, _1), ['Id' = _0, 'Val' = _1]).
result(1, complete, 1).
answer(1, ['Id' = "http://lib.ugent.be/record/rec42", 'Val' = "Reasoning about RDF Message Logs"]).
why(1, ['Id' = "http://lib.ugent.be/record/rec42", 'Val' = "Reasoning about RDF Message Logs"], 31).
query(2, subject(_0, _1), ['Id' = _0, 'Val' = _1]).
result(2, complete, 1).
answer(2, ['Id' = "http://lib.ugent.be/record/rec42", 'Val' = "Linked Data Streams"]).
why(2, ['Id' = "http://lib.ugent.be/record/rec42", 'Val' = "Linked Data Streams"], 62).
query(3, type(_0, _1), ['Id' = _0, 'Val' = _1]).
result(3, complete, 1).
answer(3, ['Id' = "http://lib.ugent.be/record/rec42", 'Val' = "book"]).
why(3, ['Id' = "http://lib.ugent.be/record/rec42", 'Val' = "book"], 93).
clause(1, member(var('X'), [var('X')|anonymous(1)]), true).
clause(2, member(var('X'), [anonymous(1)|var('Tail')]), member(var('X'), var('Tail'))).
clause(3, member_at([var('X')|anonymous(1)], 0, var('X')), true).
clause(4, member_at([anonymous(1)|var('Xs')], var('I'), var('X')), (var('I') > 0, var('Prev') is var('I') - 1, member_at(var('Xs'), var('Prev'), var('X')))).
clause(5, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), true).
clause(6, marc_id(var('Rec'), var('Id')), (member(var('Field'), var('Rec')), member_at(var('Field'), 0, "001"), member_at(var('Field'), 4, var('Ctrl')), atomics_to_string(["http://lib.ugent.be/record/", var('Ctrl')], var('Id')))).
clause(7, marc_map(var('Rec'), var('Tag'), var('Subfield'), var('Val')), (member(var('Field'), var('Rec')), member_at(var('Field'), 0, var('Tag')), member_at(var('Field'), 3, var('Subfield')), member_at(var('Field'), 4, var('Val')))).
clause(8, title(var('Id'), var('Val')), (record(var('Rec')), marc_id(var('Rec'), var('Id')), marc_map(var('Rec'), "245", "a", var('Val')))).
clause(9, subject(var('Id'), var('Val')), (record(var('Rec')), marc_id(var('Rec'), var('Id')), marc_map(var('Rec'), "650", "a", var('Val')))).
clause(10, type(var('Id'), var('Val')), (record(var('Rec')), marc_id(var('Rec'), var('Id')), marc_map(var('Rec'), "920", "a", var('Val')))).
substitution(1, []).
proof(1, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(5), []).
substitution(2, ['X' = ["001", "", "", "_", "rec42"]]).
proof(2, member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(3, ['X' = ["245", "1", "0", "a", "Reasoning about RDF Message Logs"]]).
proof(3, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(4, ['X' = "001"]).
proof(4, member_at(["001", "", "", "_", "rec42"], 0, "001"), rule(3), []).
substitution(5, ['X' = ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 'Tail' = [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(5, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(3, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(6, ['X' = ["650", " ", "0", "a", "Linked Data Streams"]]).
proof(6, member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(7, ['X' = ["650", " ", "0", "a", "Linked Data Streams"], 'Tail' = [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(7, member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(6, member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(8, ['X' = ["920", " ", " ", "a", "book"]]).
proof(8, member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(9, ['X' = ["650", " ", "0", "a", "Linked Data Streams"], 'Tail' = [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(9, member(["650", " ", "0", "a", "Linked Data Streams"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(7, member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(10, ['X' = ["920", " ", " ", "a", "book"], 'Tail' = [["920", " ", " ", "a", "book"]]]).
proof(10, member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(8, member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]]))]).
substitution(11, ['X' = ["920", " ", " ", "a", "book"], 'Tail' = [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(11, member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(10, member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(12, ['X' = ["920", " ", " ", "a", "book"], 'Tail' = [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(12, member(["920", " ", " ", "a", "book"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(11, member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(13, ['X' = "rec42"]).
proof(13, member_at(["rec42"], 0, "rec42"), rule(3), []).
substitution(14, ['Xs' = ["rec42"], 'I' = 1, 'X' = "rec42", 'Prev' = 0]).
proof(14, member_at(["_", "rec42"], 1, "rec42"), rule(4), [builtin(1 > 0), builtin(0 is 1 - 1), uses(13, member_at(["rec42"], 0, "rec42"))]).
substitution(15, ['Xs' = ["_", "rec42"], 'I' = 2, 'X' = "rec42", 'Prev' = 1]).
proof(15, member_at(["", "_", "rec42"], 2, "rec42"), rule(4), [builtin(2 > 0), builtin(1 is 2 - 1), uses(14, member_at(["_", "rec42"], 1, "rec42"))]).
substitution(16, ['Xs' = ["", "_", "rec42"], 'I' = 3, 'X' = "rec42", 'Prev' = 2]).
proof(16, member_at(["", "", "_", "rec42"], 3, "rec42"), rule(4), [builtin(3 > 0), builtin(2 is 3 - 1), uses(15, member_at(["", "_", "rec42"], 2, "rec42"))]).
substitution(17, ['Xs' = ["", "", "_", "rec42"], 'I' = 4, 'X' = "rec42", 'Prev' = 3]).
proof(17, member_at(["001", "", "", "_", "rec42"], 4, "rec42"), rule(4), [builtin(4 > 0), builtin(3 is 4 - 1), uses(16, member_at(["", "", "_", "rec42"], 3, "rec42"))]).
substitution(18, ['Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], 'Id' = "http://lib.ugent.be/record/rec42", 'Field' = ["001", "", "", "_", "rec42"], 'Ctrl' = "rec42"]).
proof(18, marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42"), rule(6), [uses(2, member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(4, member_at(["001", "", "", "_", "rec42"], 0, "001")), uses(17, member_at(["001", "", "", "_", "rec42"], 4, "rec42")), builtin(atomics_to_string(["http://lib.ugent.be/record/", "rec42"], "http://lib.ugent.be/record/rec42"))]).
substitution(19, ['X' = "245"]).
proof(19, member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 0, "245"), rule(3), []).
substitution(20, ['X' = "a"]).
proof(20, member_at(["a", "Reasoning about RDF Message Logs"], 0, "a"), rule(3), []).
substitution(21, ['Xs' = ["a", "Reasoning about RDF Message Logs"], 'I' = 1, 'X' = "a", 'Prev' = 0]).
proof(21, member_at(["0", "a", "Reasoning about RDF Message Logs"], 1, "a"), rule(4), [builtin(1 > 0), builtin(0 is 1 - 1), uses(20, member_at(["a", "Reasoning about RDF Message Logs"], 0, "a"))]).
substitution(22, ['Xs' = ["0", "a", "Reasoning about RDF Message Logs"], 'I' = 2, 'X' = "a", 'Prev' = 1]).
proof(22, member_at(["1", "0", "a", "Reasoning about RDF Message Logs"], 2, "a"), rule(4), [builtin(2 > 0), builtin(1 is 2 - 1), uses(21, member_at(["0", "a", "Reasoning about RDF Message Logs"], 1, "a"))]).
substitution(23, ['Xs' = ["1", "0", "a", "Reasoning about RDF Message Logs"], 'I' = 3, 'X' = "a", 'Prev' = 2]).
proof(23, member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 3, "a"), rule(4), [builtin(3 > 0), builtin(2 is 3 - 1), uses(22, member_at(["1", "0", "a", "Reasoning about RDF Message Logs"], 2, "a"))]).
substitution(24, ['X' = "Reasoning about RDF Message Logs"]).
proof(24, member_at(["Reasoning about RDF Message Logs"], 0, "Reasoning about RDF Message Logs"), rule(3), []).
substitution(25, ['Xs' = ["Reasoning about RDF Message Logs"], 'I' = 1, 'X' = "Reasoning about RDF Message Logs", 'Prev' = 0]).
proof(25, member_at(["a", "Reasoning about RDF Message Logs"], 1, "Reasoning about RDF Message Logs"), rule(4), [builtin(1 > 0), builtin(0 is 1 - 1), uses(24, member_at(["Reasoning about RDF Message Logs"], 0, "Reasoning about RDF Message Logs"))]).
substitution(26, ['Xs' = ["a", "Reasoning about RDF Message Logs"], 'I' = 2, 'X' = "Reasoning about RDF Message Logs", 'Prev' = 1]).
proof(26, member_at(["0", "a", "Reasoning about RDF Message Logs"], 2, "Reasoning about RDF Message Logs"), rule(4), [builtin(2 > 0), builtin(1 is 2 - 1), uses(25, member_at(["a", "Reasoning about RDF Message Logs"], 1, "Reasoning about RDF Message Logs"))]).
substitution(27, ['Xs' = ["0", "a", "Reasoning about RDF Message Logs"], 'I' = 3, 'X' = "Reasoning about RDF Message Logs", 'Prev' = 2]).
proof(27, member_at(["1", "0", "a", "Reasoning about RDF Message Logs"], 3, "Reasoning about RDF Message Logs"), rule(4), [builtin(3 > 0), builtin(2 is 3 - 1), uses(26, member_at(["0", "a", "Reasoning about RDF Message Logs"], 2, "Reasoning about RDF Message Logs"))]).
substitution(28, ['Xs' = ["1", "0", "a", "Reasoning about RDF Message Logs"], 'I' = 4, 'X' = "Reasoning about RDF Message Logs", 'Prev' = 3]).
proof(28, member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 4, "Reasoning about RDF Message Logs"), rule(4), [builtin(4 > 0), builtin(3 is 4 - 1), uses(27, member_at(["1", "0", "a", "Reasoning about RDF Message Logs"], 3, "Reasoning about RDF Message Logs"))]).
substitution(29, ['Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], 'Tag' = "245", 'Subfield' = "a", 'Val' = "Reasoning about RDF Message Logs", 'Field' = ["245", "1", "0", "a", "Reasoning about RDF Message Logs"]]).
proof(29, marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "245", "a", "Reasoning about RDF Message Logs"), rule(7), [uses(5, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(19, member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 0, "245")), uses(23, member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 3, "a")), uses(28, member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 4, "Reasoning about RDF Message Logs"))]).
substitution(30, ['Id' = "http://lib.ugent.be/record/rec42", 'Val' = "Reasoning about RDF Message Logs", 'Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(30, title("http://lib.ugent.be/record/rec42", "Reasoning about RDF Message Logs"), rule(8), [uses(1, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(18, marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42")), uses(29, marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "245", "a", "Reasoning about RDF Message Logs"))]).
substitution(31, ['Id' = "http://lib.ugent.be/record/rec42", 'Val' = "Reasoning about RDF Message Logs"]).
proof(31, solution(["http://lib.ugent.be/record/rec42", "Reasoning about RDF Message Logs"]), query, [uses(30, title("http://lib.ugent.be/record/rec42", "Reasoning about RDF Message Logs"))]).
substitution(32, []).
proof(32, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(5), []).
substitution(33, ['X' = ["001", "", "", "_", "rec42"]]).
proof(33, member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(34, ['X' = ["245", "1", "0", "a", "Reasoning about RDF Message Logs"]]).
proof(34, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(35, ['X' = "001"]).
proof(35, member_at(["001", "", "", "_", "rec42"], 0, "001"), rule(3), []).
substitution(36, ['X' = ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 'Tail' = [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(36, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(34, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(37, ['X' = ["650", " ", "0", "a", "Linked Data Streams"]]).
proof(37, member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(38, ['X' = ["650", " ", "0", "a", "Linked Data Streams"], 'Tail' = [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(38, member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(37, member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(39, ['X' = ["920", " ", " ", "a", "book"]]).
proof(39, member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(40, ['X' = ["650", " ", "0", "a", "Linked Data Streams"], 'Tail' = [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(40, member(["650", " ", "0", "a", "Linked Data Streams"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(38, member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(41, ['X' = ["920", " ", " ", "a", "book"], 'Tail' = [["920", " ", " ", "a", "book"]]]).
proof(41, member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(39, member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]]))]).
substitution(42, ['X' = ["920", " ", " ", "a", "book"], 'Tail' = [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(42, member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(41, member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(43, ['X' = ["920", " ", " ", "a", "book"], 'Tail' = [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(43, member(["920", " ", " ", "a", "book"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(42, member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(44, ['X' = "rec42"]).
proof(44, member_at(["rec42"], 0, "rec42"), rule(3), []).
substitution(45, ['Xs' = ["rec42"], 'I' = 1, 'X' = "rec42", 'Prev' = 0]).
proof(45, member_at(["_", "rec42"], 1, "rec42"), rule(4), [builtin(1 > 0), builtin(0 is 1 - 1), uses(44, member_at(["rec42"], 0, "rec42"))]).
substitution(46, ['Xs' = ["_", "rec42"], 'I' = 2, 'X' = "rec42", 'Prev' = 1]).
proof(46, member_at(["", "_", "rec42"], 2, "rec42"), rule(4), [builtin(2 > 0), builtin(1 is 2 - 1), uses(45, member_at(["_", "rec42"], 1, "rec42"))]).
substitution(47, ['Xs' = ["", "_", "rec42"], 'I' = 3, 'X' = "rec42", 'Prev' = 2]).
proof(47, member_at(["", "", "_", "rec42"], 3, "rec42"), rule(4), [builtin(3 > 0), builtin(2 is 3 - 1), uses(46, member_at(["", "_", "rec42"], 2, "rec42"))]).
substitution(48, ['Xs' = ["", "", "_", "rec42"], 'I' = 4, 'X' = "rec42", 'Prev' = 3]).
proof(48, member_at(["001", "", "", "_", "rec42"], 4, "rec42"), rule(4), [builtin(4 > 0), builtin(3 is 4 - 1), uses(47, member_at(["", "", "_", "rec42"], 3, "rec42"))]).
substitution(49, ['Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], 'Id' = "http://lib.ugent.be/record/rec42", 'Field' = ["001", "", "", "_", "rec42"], 'Ctrl' = "rec42"]).
proof(49, marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42"), rule(6), [uses(33, member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(35, member_at(["001", "", "", "_", "rec42"], 0, "001")), uses(48, member_at(["001", "", "", "_", "rec42"], 4, "rec42")), builtin(atomics_to_string(["http://lib.ugent.be/record/", "rec42"], "http://lib.ugent.be/record/rec42"))]).
substitution(50, ['X' = "650"]).
proof(50, member_at(["650", " ", "0", "a", "Linked Data Streams"], 0, "650"), rule(3), []).
substitution(51, ['X' = "a"]).
proof(51, member_at(["a", "Linked Data Streams"], 0, "a"), rule(3), []).
substitution(52, ['Xs' = ["a", "Linked Data Streams"], 'I' = 1, 'X' = "a", 'Prev' = 0]).
proof(52, member_at(["0", "a", "Linked Data Streams"], 1, "a"), rule(4), [builtin(1 > 0), builtin(0 is 1 - 1), uses(51, member_at(["a", "Linked Data Streams"], 0, "a"))]).
substitution(53, ['Xs' = ["0", "a", "Linked Data Streams"], 'I' = 2, 'X' = "a", 'Prev' = 1]).
proof(53, member_at([" ", "0", "a", "Linked Data Streams"], 2, "a"), rule(4), [builtin(2 > 0), builtin(1 is 2 - 1), uses(52, member_at(["0", "a", "Linked Data Streams"], 1, "a"))]).
substitution(54, ['Xs' = [" ", "0", "a", "Linked Data Streams"], 'I' = 3, 'X' = "a", 'Prev' = 2]).
proof(54, member_at(["650", " ", "0", "a", "Linked Data Streams"], 3, "a"), rule(4), [builtin(3 > 0), builtin(2 is 3 - 1), uses(53, member_at([" ", "0", "a", "Linked Data Streams"], 2, "a"))]).
substitution(55, ['X' = "Linked Data Streams"]).
proof(55, member_at(["Linked Data Streams"], 0, "Linked Data Streams"), rule(3), []).
substitution(56, ['Xs' = ["Linked Data Streams"], 'I' = 1, 'X' = "Linked Data Streams", 'Prev' = 0]).
proof(56, member_at(["a", "Linked Data Streams"], 1, "Linked Data Streams"), rule(4), [builtin(1 > 0), builtin(0 is 1 - 1), uses(55, member_at(["Linked Data Streams"], 0, "Linked Data Streams"))]).
substitution(57, ['Xs' = ["a", "Linked Data Streams"], 'I' = 2, 'X' = "Linked Data Streams", 'Prev' = 1]).
proof(57, member_at(["0", "a", "Linked Data Streams"], 2, "Linked Data Streams"), rule(4), [builtin(2 > 0), builtin(1 is 2 - 1), uses(56, member_at(["a", "Linked Data Streams"], 1, "Linked Data Streams"))]).
substitution(58, ['Xs' = ["0", "a", "Linked Data Streams"], 'I' = 3, 'X' = "Linked Data Streams", 'Prev' = 2]).
proof(58, member_at([" ", "0", "a", "Linked Data Streams"], 3, "Linked Data Streams"), rule(4), [builtin(3 > 0), builtin(2 is 3 - 1), uses(57, member_at(["0", "a", "Linked Data Streams"], 2, "Linked Data Streams"))]).
substitution(59, ['Xs' = [" ", "0", "a", "Linked Data Streams"], 'I' = 4, 'X' = "Linked Data Streams", 'Prev' = 3]).
proof(59, member_at(["650", " ", "0", "a", "Linked Data Streams"], 4, "Linked Data Streams"), rule(4), [builtin(4 > 0), builtin(3 is 4 - 1), uses(58, member_at([" ", "0", "a", "Linked Data Streams"], 3, "Linked Data Streams"))]).
substitution(60, ['Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], 'Tag' = "650", 'Subfield' = "a", 'Val' = "Linked Data Streams", 'Field' = ["650", " ", "0", "a", "Linked Data Streams"]]).
proof(60, marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "650", "a", "Linked Data Streams"), rule(7), [uses(40, member(["650", " ", "0", "a", "Linked Data Streams"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(50, member_at(["650", " ", "0", "a", "Linked Data Streams"], 0, "650")), uses(54, member_at(["650", " ", "0", "a", "Linked Data Streams"], 3, "a")), uses(59, member_at(["650", " ", "0", "a", "Linked Data Streams"], 4, "Linked Data Streams"))]).
substitution(61, ['Id' = "http://lib.ugent.be/record/rec42", 'Val' = "Linked Data Streams", 'Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(61, subject("http://lib.ugent.be/record/rec42", "Linked Data Streams"), rule(9), [uses(32, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(49, marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42")), uses(60, marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "650", "a", "Linked Data Streams"))]).
substitution(62, ['Id' = "http://lib.ugent.be/record/rec42", 'Val' = "Linked Data Streams"]).
proof(62, solution(["http://lib.ugent.be/record/rec42", "Linked Data Streams"]), query, [uses(61, subject("http://lib.ugent.be/record/rec42", "Linked Data Streams"))]).
substitution(63, []).
proof(63, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(5), []).
substitution(64, ['X' = ["001", "", "", "_", "rec42"]]).
proof(64, member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(65, ['X' = ["245", "1", "0", "a", "Reasoning about RDF Message Logs"]]).
proof(65, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(66, ['X' = "001"]).
proof(66, member_at(["001", "", "", "_", "rec42"], 0, "001"), rule(3), []).
substitution(67, ['X' = ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 'Tail' = [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(67, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(65, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(68, ['X' = ["650", " ", "0", "a", "Linked Data Streams"]]).
proof(68, member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(69, ['X' = ["650", " ", "0", "a", "Linked Data Streams"], 'Tail' = [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(69, member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(68, member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(70, ['X' = ["920", " ", " ", "a", "book"]]).
proof(70, member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(71, ['X' = ["650", " ", "0", "a", "Linked Data Streams"], 'Tail' = [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(71, member(["650", " ", "0", "a", "Linked Data Streams"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(69, member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(72, ['X' = ["920", " ", " ", "a", "book"], 'Tail' = [["920", " ", " ", "a", "book"]]]).
proof(72, member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(70, member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]]))]).
substitution(73, ['X' = ["920", " ", " ", "a", "book"], 'Tail' = [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(73, member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(72, member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(74, ['X' = ["920", " ", " ", "a", "book"], 'Tail' = [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(74, member(["920", " ", " ", "a", "book"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(73, member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(75, ['X' = "rec42"]).
proof(75, member_at(["rec42"], 0, "rec42"), rule(3), []).
substitution(76, ['Xs' = ["rec42"], 'I' = 1, 'X' = "rec42", 'Prev' = 0]).
proof(76, member_at(["_", "rec42"], 1, "rec42"), rule(4), [builtin(1 > 0), builtin(0 is 1 - 1), uses(75, member_at(["rec42"], 0, "rec42"))]).
substitution(77, ['Xs' = ["_", "rec42"], 'I' = 2, 'X' = "rec42", 'Prev' = 1]).
proof(77, member_at(["", "_", "rec42"], 2, "rec42"), rule(4), [builtin(2 > 0), builtin(1 is 2 - 1), uses(76, member_at(["_", "rec42"], 1, "rec42"))]).
substitution(78, ['Xs' = ["", "_", "rec42"], 'I' = 3, 'X' = "rec42", 'Prev' = 2]).
proof(78, member_at(["", "", "_", "rec42"], 3, "rec42"), rule(4), [builtin(3 > 0), builtin(2 is 3 - 1), uses(77, member_at(["", "_", "rec42"], 2, "rec42"))]).
substitution(79, ['Xs' = ["", "", "_", "rec42"], 'I' = 4, 'X' = "rec42", 'Prev' = 3]).
proof(79, member_at(["001", "", "", "_", "rec42"], 4, "rec42"), rule(4), [builtin(4 > 0), builtin(3 is 4 - 1), uses(78, member_at(["", "", "_", "rec42"], 3, "rec42"))]).
substitution(80, ['Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], 'Id' = "http://lib.ugent.be/record/rec42", 'Field' = ["001", "", "", "_", "rec42"], 'Ctrl' = "rec42"]).
proof(80, marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42"), rule(6), [uses(64, member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(66, member_at(["001", "", "", "_", "rec42"], 0, "001")), uses(79, member_at(["001", "", "", "_", "rec42"], 4, "rec42")), builtin(atomics_to_string(["http://lib.ugent.be/record/", "rec42"], "http://lib.ugent.be/record/rec42"))]).
substitution(81, ['X' = "920"]).
proof(81, member_at(["920", " ", " ", "a", "book"], 0, "920"), rule(3), []).
substitution(82, ['X' = "a"]).
proof(82, member_at(["a", "book"], 0, "a"), rule(3), []).
substitution(83, ['Xs' = ["a", "book"], 'I' = 1, 'X' = "a", 'Prev' = 0]).
proof(83, member_at([" ", "a", "book"], 1, "a"), rule(4), [builtin(1 > 0), builtin(0 is 1 - 1), uses(82, member_at(["a", "book"], 0, "a"))]).
substitution(84, ['Xs' = [" ", "a", "book"], 'I' = 2, 'X' = "a", 'Prev' = 1]).
proof(84, member_at([" ", " ", "a", "book"], 2, "a"), rule(4), [builtin(2 > 0), builtin(1 is 2 - 1), uses(83, member_at([" ", "a", "book"], 1, "a"))]).
substitution(85, ['Xs' = [" ", " ", "a", "book"], 'I' = 3, 'X' = "a", 'Prev' = 2]).
proof(85, member_at(["920", " ", " ", "a", "book"], 3, "a"), rule(4), [builtin(3 > 0), builtin(2 is 3 - 1), uses(84, member_at([" ", " ", "a", "book"], 2, "a"))]).
substitution(86, ['X' = "book"]).
proof(86, member_at(["book"], 0, "book"), rule(3), []).
substitution(87, ['Xs' = ["book"], 'I' = 1, 'X' = "book", 'Prev' = 0]).
proof(87, member_at(["a", "book"], 1, "book"), rule(4), [builtin(1 > 0), builtin(0 is 1 - 1), uses(86, member_at(["book"], 0, "book"))]).
substitution(88, ['Xs' = ["a", "book"], 'I' = 2, 'X' = "book", 'Prev' = 1]).
proof(88, member_at([" ", "a", "book"], 2, "book"), rule(4), [builtin(2 > 0), builtin(1 is 2 - 1), uses(87, member_at(["a", "book"], 1, "book"))]).
substitution(89, ['Xs' = [" ", "a", "book"], 'I' = 3, 'X' = "book", 'Prev' = 2]).
proof(89, member_at([" ", " ", "a", "book"], 3, "book"), rule(4), [builtin(3 > 0), builtin(2 is 3 - 1), uses(88, member_at([" ", "a", "book"], 2, "book"))]).
substitution(90, ['Xs' = [" ", " ", "a", "book"], 'I' = 4, 'X' = "book", 'Prev' = 3]).
proof(90, member_at(["920", " ", " ", "a", "book"], 4, "book"), rule(4), [builtin(4 > 0), builtin(3 is 4 - 1), uses(89, member_at([" ", " ", "a", "book"], 3, "book"))]).
substitution(91, ['Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], 'Tag' = "920", 'Subfield' = "a", 'Val' = "book", 'Field' = ["920", " ", " ", "a", "book"]]).
proof(91, marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "920", "a", "book"), rule(7), [uses(74, member(["920", " ", " ", "a", "book"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(81, member_at(["920", " ", " ", "a", "book"], 0, "920")), uses(85, member_at(["920", " ", " ", "a", "book"], 3, "a")), uses(90, member_at(["920", " ", " ", "a", "book"], 4, "book"))]).
substitution(92, ['Id' = "http://lib.ugent.be/record/rec42", 'Val' = "book", 'Rec' = [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]]).
proof(92, type("http://lib.ugent.be/record/rec42", "book"), rule(10), [uses(63, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(80, marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42")), uses(91, marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "920", "a", "book"))]).
substitution(93, ['Id' = "http://lib.ugent.be/record/rec42", 'Val' = "book"]).
proof(93, solution(["http://lib.ugent.be/record/rec42", "book"]), query, [uses(92, type("http://lib.ugent.be/record/rec42", "book"))]).
