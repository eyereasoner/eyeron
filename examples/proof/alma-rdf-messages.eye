# Eyelang result format 2
query(1, [call(title(?v0, ?v1))], [binding("id", ?v0), binding("val", ?v1)]).
result(1, complete, 1).
answer(1, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "Reasoning about RDF Message Logs")]).
why(1, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "Reasoning about RDF Message Logs")], 31).
query(2, [call(subject(?v0, ?v1))], [binding("id", ?v0), binding("val", ?v1)]).
result(2, complete, 1).
answer(2, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "Linked Data Streams")]).
why(2, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "Linked Data Streams")], 62).
query(3, [call(type(?v0, ?v1))], [binding("id", ?v0), binding("val", ?v1)]).
result(3, complete, 1).
answer(3, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "book")]).
why(3, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "book")], 93).
clause(1, member(var("x"), [var("x") | anonymous(1)]), []).
clause(2, member(var("x"), [anonymous(1) | var("tail")]), [call(member(var("x"), var("tail")))]).
clause(3, member_at([var("x") | anonymous(1)], 0, var("x")), []).
clause(4, member_at([anonymous(1) | var("xs")], var("i"), var("x")), [compare(">", var("i"), 0), calculate(var("prev"), binary("-", value(var("i")), value(1))), call(member_at(var("xs"), var("prev"), var("x")))]).
clause(5, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), []).
clause(6, marc_id(var("rec"), var("id")), [call(member(var("field"), var("rec"))), call(member_at(var("field"), 0, "001")), call(member_at(var("field"), 4, var("ctrl"))), calculate(var("id"), function("concat", [value("http://lib.ugent.be/record/"), value(var("ctrl"))]))]).
clause(7, marc_map(var("rec"), var("tag"), var("subfield"), var("val")), [call(member(var("field"), var("rec"))), call(member_at(var("field"), 0, var("tag"))), call(member_at(var("field"), 3, var("subfield"))), call(member_at(var("field"), 4, var("val")))]).
clause(8, title(var("id"), var("val")), [call(record(var("rec"))), call(marc_id(var("rec"), var("id"))), call(marc_map(var("rec"), "245", "a", var("val")))]).
clause(9, subject(var("id"), var("val")), [call(record(var("rec"))), call(marc_id(var("rec"), var("id"))), call(marc_map(var("rec"), "650", "a", var("val")))]).
clause(10, type(var("id"), var("val")), [call(record(var("rec"))), call(marc_id(var("rec"), var("id"))), call(marc_map(var("rec"), "920", "a", var("val")))]).
substitution(1, []).
proof(1, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(5), []).
substitution(2, [binding("x", ["001", "", "", "_", "rec42"])]).
proof(2, member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(3, [binding("x", ["245", "1", "0", "a", "Reasoning about RDF Message Logs"])]).
proof(3, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(4, [binding("x", "001")]).
proof(4, member_at(["001", "", "", "_", "rec42"], 0, "001"), rule(3), []).
substitution(5, [binding("x", ["245", "1", "0", "a", "Reasoning about RDF Message Logs"]), binding("tail", [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(5, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(3, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(6, [binding("x", ["650", " ", "0", "a", "Linked Data Streams"])]).
proof(6, member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(7, [binding("x", ["650", " ", "0", "a", "Linked Data Streams"]), binding("tail", [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(7, member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(6, member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(8, [binding("x", ["920", " ", " ", "a", "book"])]).
proof(8, member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(9, [binding("x", ["650", " ", "0", "a", "Linked Data Streams"]), binding("tail", [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(9, member(["650", " ", "0", "a", "Linked Data Streams"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(7, member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(10, [binding("x", ["920", " ", " ", "a", "book"]), binding("tail", [["920", " ", " ", "a", "book"]])]).
proof(10, member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(8, member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]]))]).
substitution(11, [binding("x", ["920", " ", " ", "a", "book"]), binding("tail", [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(11, member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(10, member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(12, [binding("x", ["920", " ", " ", "a", "book"]), binding("tail", [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(12, member(["920", " ", " ", "a", "book"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(11, member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(13, [binding("x", "rec42")]).
proof(13, member_at(["rec42"], 0, "rec42"), rule(3), []).
substitution(14, [binding("xs", ["rec42"]), binding("i", 1), binding("x", "rec42"), binding("prev", 0)]).
proof(14, member_at(["_", "rec42"], 1, "rec42"), rule(4), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(13, member_at(["rec42"], 0, "rec42"))]).
substitution(15, [binding("xs", ["_", "rec42"]), binding("i", 2), binding("x", "rec42"), binding("prev", 1)]).
proof(15, member_at(["", "_", "rec42"], 2, "rec42"), rule(4), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(14, member_at(["_", "rec42"], 1, "rec42"))]).
substitution(16, [binding("xs", ["", "_", "rec42"]), binding("i", 3), binding("x", "rec42"), binding("prev", 2)]).
proof(16, member_at(["", "", "_", "rec42"], 3, "rec42"), rule(4), [compared(">", 3, 0), calculated(2, binary("-", value(3), value(1))), uses(15, member_at(["", "_", "rec42"], 2, "rec42"))]).
substitution(17, [binding("xs", ["", "", "_", "rec42"]), binding("i", 4), binding("x", "rec42"), binding("prev", 3)]).
proof(17, member_at(["001", "", "", "_", "rec42"], 4, "rec42"), rule(4), [compared(">", 4, 0), calculated(3, binary("-", value(4), value(1))), uses(16, member_at(["", "", "_", "rec42"], 3, "rec42"))]).
substitution(18, [binding("rec", [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), binding("id", "http://lib.ugent.be/record/rec42"), binding("field", ["001", "", "", "_", "rec42"]), binding("ctrl", "rec42")]).
proof(18, marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42"), rule(6), [uses(2, member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(4, member_at(["001", "", "", "_", "rec42"], 0, "001")), uses(17, member_at(["001", "", "", "_", "rec42"], 4, "rec42")), calculated("http://lib.ugent.be/record/rec42", function("concat", [value("http://lib.ugent.be/record/"), value("rec42")]))]).
substitution(19, [binding("x", "245")]).
proof(19, member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 0, "245"), rule(3), []).
substitution(20, [binding("x", "a")]).
proof(20, member_at(["a", "Reasoning about RDF Message Logs"], 0, "a"), rule(3), []).
substitution(21, [binding("xs", ["a", "Reasoning about RDF Message Logs"]), binding("i", 1), binding("x", "a"), binding("prev", 0)]).
proof(21, member_at(["0", "a", "Reasoning about RDF Message Logs"], 1, "a"), rule(4), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(20, member_at(["a", "Reasoning about RDF Message Logs"], 0, "a"))]).
substitution(22, [binding("xs", ["0", "a", "Reasoning about RDF Message Logs"]), binding("i", 2), binding("x", "a"), binding("prev", 1)]).
proof(22, member_at(["1", "0", "a", "Reasoning about RDF Message Logs"], 2, "a"), rule(4), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(21, member_at(["0", "a", "Reasoning about RDF Message Logs"], 1, "a"))]).
substitution(23, [binding("xs", ["1", "0", "a", "Reasoning about RDF Message Logs"]), binding("i", 3), binding("x", "a"), binding("prev", 2)]).
proof(23, member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 3, "a"), rule(4), [compared(">", 3, 0), calculated(2, binary("-", value(3), value(1))), uses(22, member_at(["1", "0", "a", "Reasoning about RDF Message Logs"], 2, "a"))]).
substitution(24, [binding("x", "Reasoning about RDF Message Logs")]).
proof(24, member_at(["Reasoning about RDF Message Logs"], 0, "Reasoning about RDF Message Logs"), rule(3), []).
substitution(25, [binding("xs", ["Reasoning about RDF Message Logs"]), binding("i", 1), binding("x", "Reasoning about RDF Message Logs"), binding("prev", 0)]).
proof(25, member_at(["a", "Reasoning about RDF Message Logs"], 1, "Reasoning about RDF Message Logs"), rule(4), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(24, member_at(["Reasoning about RDF Message Logs"], 0, "Reasoning about RDF Message Logs"))]).
substitution(26, [binding("xs", ["a", "Reasoning about RDF Message Logs"]), binding("i", 2), binding("x", "Reasoning about RDF Message Logs"), binding("prev", 1)]).
proof(26, member_at(["0", "a", "Reasoning about RDF Message Logs"], 2, "Reasoning about RDF Message Logs"), rule(4), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(25, member_at(["a", "Reasoning about RDF Message Logs"], 1, "Reasoning about RDF Message Logs"))]).
substitution(27, [binding("xs", ["0", "a", "Reasoning about RDF Message Logs"]), binding("i", 3), binding("x", "Reasoning about RDF Message Logs"), binding("prev", 2)]).
proof(27, member_at(["1", "0", "a", "Reasoning about RDF Message Logs"], 3, "Reasoning about RDF Message Logs"), rule(4), [compared(">", 3, 0), calculated(2, binary("-", value(3), value(1))), uses(26, member_at(["0", "a", "Reasoning about RDF Message Logs"], 2, "Reasoning about RDF Message Logs"))]).
substitution(28, [binding("xs", ["1", "0", "a", "Reasoning about RDF Message Logs"]), binding("i", 4), binding("x", "Reasoning about RDF Message Logs"), binding("prev", 3)]).
proof(28, member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 4, "Reasoning about RDF Message Logs"), rule(4), [compared(">", 4, 0), calculated(3, binary("-", value(4), value(1))), uses(27, member_at(["1", "0", "a", "Reasoning about RDF Message Logs"], 3, "Reasoning about RDF Message Logs"))]).
substitution(29, [binding("rec", [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), binding("tag", "245"), binding("subfield", "a"), binding("val", "Reasoning about RDF Message Logs"), binding("field", ["245", "1", "0", "a", "Reasoning about RDF Message Logs"])]).
proof(29, marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "245", "a", "Reasoning about RDF Message Logs"), rule(7), [uses(5, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(19, member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 0, "245")), uses(23, member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 3, "a")), uses(28, member_at(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], 4, "Reasoning about RDF Message Logs"))]).
substitution(30, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "Reasoning about RDF Message Logs"), binding("rec", [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(30, title("http://lib.ugent.be/record/rec42", "Reasoning about RDF Message Logs"), rule(8), [uses(1, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(18, marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42")), uses(29, marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "245", "a", "Reasoning about RDF Message Logs"))]).
substitution(31, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "Reasoning about RDF Message Logs")]).
proof(31, solution(["http://lib.ugent.be/record/rec42", "Reasoning about RDF Message Logs"]), query, [uses(30, title("http://lib.ugent.be/record/rec42", "Reasoning about RDF Message Logs"))]).
substitution(32, []).
proof(32, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(5), []).
substitution(33, [binding("x", ["001", "", "", "_", "rec42"])]).
proof(33, member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(34, [binding("x", ["245", "1", "0", "a", "Reasoning about RDF Message Logs"])]).
proof(34, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(35, [binding("x", "001")]).
proof(35, member_at(["001", "", "", "_", "rec42"], 0, "001"), rule(3), []).
substitution(36, [binding("x", ["245", "1", "0", "a", "Reasoning about RDF Message Logs"]), binding("tail", [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(36, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(34, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(37, [binding("x", ["650", " ", "0", "a", "Linked Data Streams"])]).
proof(37, member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(38, [binding("x", ["650", " ", "0", "a", "Linked Data Streams"]), binding("tail", [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(38, member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(37, member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(39, [binding("x", ["920", " ", " ", "a", "book"])]).
proof(39, member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(40, [binding("x", ["650", " ", "0", "a", "Linked Data Streams"]), binding("tail", [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(40, member(["650", " ", "0", "a", "Linked Data Streams"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(38, member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(41, [binding("x", ["920", " ", " ", "a", "book"]), binding("tail", [["920", " ", " ", "a", "book"]])]).
proof(41, member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(39, member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]]))]).
substitution(42, [binding("x", ["920", " ", " ", "a", "book"]), binding("tail", [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(42, member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(41, member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(43, [binding("x", ["920", " ", " ", "a", "book"]), binding("tail", [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(43, member(["920", " ", " ", "a", "book"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(42, member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(44, [binding("x", "rec42")]).
proof(44, member_at(["rec42"], 0, "rec42"), rule(3), []).
substitution(45, [binding("xs", ["rec42"]), binding("i", 1), binding("x", "rec42"), binding("prev", 0)]).
proof(45, member_at(["_", "rec42"], 1, "rec42"), rule(4), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(44, member_at(["rec42"], 0, "rec42"))]).
substitution(46, [binding("xs", ["_", "rec42"]), binding("i", 2), binding("x", "rec42"), binding("prev", 1)]).
proof(46, member_at(["", "_", "rec42"], 2, "rec42"), rule(4), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(45, member_at(["_", "rec42"], 1, "rec42"))]).
substitution(47, [binding("xs", ["", "_", "rec42"]), binding("i", 3), binding("x", "rec42"), binding("prev", 2)]).
proof(47, member_at(["", "", "_", "rec42"], 3, "rec42"), rule(4), [compared(">", 3, 0), calculated(2, binary("-", value(3), value(1))), uses(46, member_at(["", "_", "rec42"], 2, "rec42"))]).
substitution(48, [binding("xs", ["", "", "_", "rec42"]), binding("i", 4), binding("x", "rec42"), binding("prev", 3)]).
proof(48, member_at(["001", "", "", "_", "rec42"], 4, "rec42"), rule(4), [compared(">", 4, 0), calculated(3, binary("-", value(4), value(1))), uses(47, member_at(["", "", "_", "rec42"], 3, "rec42"))]).
substitution(49, [binding("rec", [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), binding("id", "http://lib.ugent.be/record/rec42"), binding("field", ["001", "", "", "_", "rec42"]), binding("ctrl", "rec42")]).
proof(49, marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42"), rule(6), [uses(33, member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(35, member_at(["001", "", "", "_", "rec42"], 0, "001")), uses(48, member_at(["001", "", "", "_", "rec42"], 4, "rec42")), calculated("http://lib.ugent.be/record/rec42", function("concat", [value("http://lib.ugent.be/record/"), value("rec42")]))]).
substitution(50, [binding("x", "650")]).
proof(50, member_at(["650", " ", "0", "a", "Linked Data Streams"], 0, "650"), rule(3), []).
substitution(51, [binding("x", "a")]).
proof(51, member_at(["a", "Linked Data Streams"], 0, "a"), rule(3), []).
substitution(52, [binding("xs", ["a", "Linked Data Streams"]), binding("i", 1), binding("x", "a"), binding("prev", 0)]).
proof(52, member_at(["0", "a", "Linked Data Streams"], 1, "a"), rule(4), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(51, member_at(["a", "Linked Data Streams"], 0, "a"))]).
substitution(53, [binding("xs", ["0", "a", "Linked Data Streams"]), binding("i", 2), binding("x", "a"), binding("prev", 1)]).
proof(53, member_at([" ", "0", "a", "Linked Data Streams"], 2, "a"), rule(4), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(52, member_at(["0", "a", "Linked Data Streams"], 1, "a"))]).
substitution(54, [binding("xs", [" ", "0", "a", "Linked Data Streams"]), binding("i", 3), binding("x", "a"), binding("prev", 2)]).
proof(54, member_at(["650", " ", "0", "a", "Linked Data Streams"], 3, "a"), rule(4), [compared(">", 3, 0), calculated(2, binary("-", value(3), value(1))), uses(53, member_at([" ", "0", "a", "Linked Data Streams"], 2, "a"))]).
substitution(55, [binding("x", "Linked Data Streams")]).
proof(55, member_at(["Linked Data Streams"], 0, "Linked Data Streams"), rule(3), []).
substitution(56, [binding("xs", ["Linked Data Streams"]), binding("i", 1), binding("x", "Linked Data Streams"), binding("prev", 0)]).
proof(56, member_at(["a", "Linked Data Streams"], 1, "Linked Data Streams"), rule(4), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(55, member_at(["Linked Data Streams"], 0, "Linked Data Streams"))]).
substitution(57, [binding("xs", ["a", "Linked Data Streams"]), binding("i", 2), binding("x", "Linked Data Streams"), binding("prev", 1)]).
proof(57, member_at(["0", "a", "Linked Data Streams"], 2, "Linked Data Streams"), rule(4), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(56, member_at(["a", "Linked Data Streams"], 1, "Linked Data Streams"))]).
substitution(58, [binding("xs", ["0", "a", "Linked Data Streams"]), binding("i", 3), binding("x", "Linked Data Streams"), binding("prev", 2)]).
proof(58, member_at([" ", "0", "a", "Linked Data Streams"], 3, "Linked Data Streams"), rule(4), [compared(">", 3, 0), calculated(2, binary("-", value(3), value(1))), uses(57, member_at(["0", "a", "Linked Data Streams"], 2, "Linked Data Streams"))]).
substitution(59, [binding("xs", [" ", "0", "a", "Linked Data Streams"]), binding("i", 4), binding("x", "Linked Data Streams"), binding("prev", 3)]).
proof(59, member_at(["650", " ", "0", "a", "Linked Data Streams"], 4, "Linked Data Streams"), rule(4), [compared(">", 4, 0), calculated(3, binary("-", value(4), value(1))), uses(58, member_at([" ", "0", "a", "Linked Data Streams"], 3, "Linked Data Streams"))]).
substitution(60, [binding("rec", [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), binding("tag", "650"), binding("subfield", "a"), binding("val", "Linked Data Streams"), binding("field", ["650", " ", "0", "a", "Linked Data Streams"])]).
proof(60, marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "650", "a", "Linked Data Streams"), rule(7), [uses(40, member(["650", " ", "0", "a", "Linked Data Streams"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(50, member_at(["650", " ", "0", "a", "Linked Data Streams"], 0, "650")), uses(54, member_at(["650", " ", "0", "a", "Linked Data Streams"], 3, "a")), uses(59, member_at(["650", " ", "0", "a", "Linked Data Streams"], 4, "Linked Data Streams"))]).
substitution(61, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "Linked Data Streams"), binding("rec", [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(61, subject("http://lib.ugent.be/record/rec42", "Linked Data Streams"), rule(9), [uses(32, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(49, marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42")), uses(60, marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "650", "a", "Linked Data Streams"))]).
substitution(62, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "Linked Data Streams")]).
proof(62, solution(["http://lib.ugent.be/record/rec42", "Linked Data Streams"]), query, [uses(61, subject("http://lib.ugent.be/record/rec42", "Linked Data Streams"))]).
substitution(63, []).
proof(63, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(5), []).
substitution(64, [binding("x", ["001", "", "", "_", "rec42"])]).
proof(64, member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(65, [binding("x", ["245", "1", "0", "a", "Reasoning about RDF Message Logs"])]).
proof(65, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(66, [binding("x", "001")]).
proof(66, member_at(["001", "", "", "_", "rec42"], 0, "001"), rule(3), []).
substitution(67, [binding("x", ["245", "1", "0", "a", "Reasoning about RDF Message Logs"]), binding("tail", [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(67, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(65, member(["245", "1", "0", "a", "Reasoning about RDF Message Logs"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(68, [binding("x", ["650", " ", "0", "a", "Linked Data Streams"])]).
proof(68, member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(69, [binding("x", ["650", " ", "0", "a", "Linked Data Streams"]), binding("tail", [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(69, member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(68, member(["650", " ", "0", "a", "Linked Data Streams"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(70, [binding("x", ["920", " ", " ", "a", "book"])]).
proof(70, member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]]), rule(1), []).
substitution(71, [binding("x", ["650", " ", "0", "a", "Linked Data Streams"]), binding("tail", [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(71, member(["650", " ", "0", "a", "Linked Data Streams"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(69, member(["650", " ", "0", "a", "Linked Data Streams"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(72, [binding("x", ["920", " ", " ", "a", "book"]), binding("tail", [["920", " ", " ", "a", "book"]])]).
proof(72, member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(70, member(["920", " ", " ", "a", "book"], [["920", " ", " ", "a", "book"]]))]).
substitution(73, [binding("x", ["920", " ", " ", "a", "book"]), binding("tail", [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(73, member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(72, member(["920", " ", " ", "a", "book"], [["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(74, [binding("x", ["920", " ", " ", "a", "book"]), binding("tail", [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(74, member(["920", " ", " ", "a", "book"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), rule(2), [uses(73, member(["920", " ", " ", "a", "book"], [["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]))]).
substitution(75, [binding("x", "rec42")]).
proof(75, member_at(["rec42"], 0, "rec42"), rule(3), []).
substitution(76, [binding("xs", ["rec42"]), binding("i", 1), binding("x", "rec42"), binding("prev", 0)]).
proof(76, member_at(["_", "rec42"], 1, "rec42"), rule(4), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(75, member_at(["rec42"], 0, "rec42"))]).
substitution(77, [binding("xs", ["_", "rec42"]), binding("i", 2), binding("x", "rec42"), binding("prev", 1)]).
proof(77, member_at(["", "_", "rec42"], 2, "rec42"), rule(4), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(76, member_at(["_", "rec42"], 1, "rec42"))]).
substitution(78, [binding("xs", ["", "_", "rec42"]), binding("i", 3), binding("x", "rec42"), binding("prev", 2)]).
proof(78, member_at(["", "", "_", "rec42"], 3, "rec42"), rule(4), [compared(">", 3, 0), calculated(2, binary("-", value(3), value(1))), uses(77, member_at(["", "_", "rec42"], 2, "rec42"))]).
substitution(79, [binding("xs", ["", "", "_", "rec42"]), binding("i", 4), binding("x", "rec42"), binding("prev", 3)]).
proof(79, member_at(["001", "", "", "_", "rec42"], 4, "rec42"), rule(4), [compared(">", 4, 0), calculated(3, binary("-", value(4), value(1))), uses(78, member_at(["", "", "_", "rec42"], 3, "rec42"))]).
substitution(80, [binding("rec", [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), binding("id", "http://lib.ugent.be/record/rec42"), binding("field", ["001", "", "", "_", "rec42"]), binding("ctrl", "rec42")]).
proof(80, marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42"), rule(6), [uses(64, member(["001", "", "", "_", "rec42"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(66, member_at(["001", "", "", "_", "rec42"], 0, "001")), uses(79, member_at(["001", "", "", "_", "rec42"], 4, "rec42")), calculated("http://lib.ugent.be/record/rec42", function("concat", [value("http://lib.ugent.be/record/"), value("rec42")]))]).
substitution(81, [binding("x", "920")]).
proof(81, member_at(["920", " ", " ", "a", "book"], 0, "920"), rule(3), []).
substitution(82, [binding("x", "a")]).
proof(82, member_at(["a", "book"], 0, "a"), rule(3), []).
substitution(83, [binding("xs", ["a", "book"]), binding("i", 1), binding("x", "a"), binding("prev", 0)]).
proof(83, member_at([" ", "a", "book"], 1, "a"), rule(4), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(82, member_at(["a", "book"], 0, "a"))]).
substitution(84, [binding("xs", [" ", "a", "book"]), binding("i", 2), binding("x", "a"), binding("prev", 1)]).
proof(84, member_at([" ", " ", "a", "book"], 2, "a"), rule(4), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(83, member_at([" ", "a", "book"], 1, "a"))]).
substitution(85, [binding("xs", [" ", " ", "a", "book"]), binding("i", 3), binding("x", "a"), binding("prev", 2)]).
proof(85, member_at(["920", " ", " ", "a", "book"], 3, "a"), rule(4), [compared(">", 3, 0), calculated(2, binary("-", value(3), value(1))), uses(84, member_at([" ", " ", "a", "book"], 2, "a"))]).
substitution(86, [binding("x", "book")]).
proof(86, member_at(["book"], 0, "book"), rule(3), []).
substitution(87, [binding("xs", ["book"]), binding("i", 1), binding("x", "book"), binding("prev", 0)]).
proof(87, member_at(["a", "book"], 1, "book"), rule(4), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(86, member_at(["book"], 0, "book"))]).
substitution(88, [binding("xs", ["a", "book"]), binding("i", 2), binding("x", "book"), binding("prev", 1)]).
proof(88, member_at([" ", "a", "book"], 2, "book"), rule(4), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(87, member_at(["a", "book"], 1, "book"))]).
substitution(89, [binding("xs", [" ", "a", "book"]), binding("i", 3), binding("x", "book"), binding("prev", 2)]).
proof(89, member_at([" ", " ", "a", "book"], 3, "book"), rule(4), [compared(">", 3, 0), calculated(2, binary("-", value(3), value(1))), uses(88, member_at([" ", "a", "book"], 2, "book"))]).
substitution(90, [binding("xs", [" ", " ", "a", "book"]), binding("i", 4), binding("x", "book"), binding("prev", 3)]).
proof(90, member_at(["920", " ", " ", "a", "book"], 4, "book"), rule(4), [compared(">", 4, 0), calculated(3, binary("-", value(4), value(1))), uses(89, member_at([" ", " ", "a", "book"], 3, "book"))]).
substitution(91, [binding("rec", [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]]), binding("tag", "920"), binding("subfield", "a"), binding("val", "book"), binding("field", ["920", " ", " ", "a", "book"])]).
proof(91, marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "920", "a", "book"), rule(7), [uses(74, member(["920", " ", " ", "a", "book"], [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(81, member_at(["920", " ", " ", "a", "book"], 0, "920")), uses(85, member_at(["920", " ", " ", "a", "book"], 3, "a")), uses(90, member_at(["920", " ", " ", "a", "book"], 4, "book"))]).
substitution(92, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "book"), binding("rec", [["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])]).
proof(92, type("http://lib.ugent.be/record/rec42", "book"), rule(10), [uses(63, record([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]])), uses(80, marc_id([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "http://lib.ugent.be/record/rec42")), uses(91, marc_map([["001", "", "", "_", "rec42"], ["245", "1", "0", "a", "Reasoning about RDF Message Logs"], ["650", " ", "0", "a", "Linked Data Streams"], ["920", " ", " ", "a", "book"]], "920", "a", "book"))]).
substitution(93, [binding("id", "http://lib.ugent.be/record/rec42"), binding("val", "book")]).
proof(93, solution(["http://lib.ugent.be/record/rec42", "book"]), query, [uses(92, type("http://lib.ugent.be/record/rec42", "book"))]).
