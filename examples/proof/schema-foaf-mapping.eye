# Eyelang result format 2
query(1, [call(foaf_person(?v0))], [binding("p", ?v0)]).
result(1, complete, 1).
answer(1, [binding("p", alice)]).
why(1, [binding("p", alice)], 3).
query(2, [call(foaf_name(?v0, ?v1))], [binding("p", ?v0), binding("name", ?v1)]).
result(2, complete, 1).
answer(2, [binding("p", alice), binding("name", "Alice Example")]).
why(2, [binding("p", alice), binding("name", "Alice Example")], 6).
query(3, [call(foaf_given_name(?v0, ?v1))], [binding("p", ?v0), binding("given", ?v1)]).
result(3, complete, 1).
answer(3, [binding("p", alice), binding("given", "Alice")]).
why(3, [binding("p", alice), binding("given", "Alice")], 9).
query(4, [call(foaf_family_name(?v0, ?v1))], [binding("p", ?v0), binding("family", ?v1)]).
result(4, complete, 1).
answer(4, [binding("p", alice), binding("family", "Example")]).
why(4, [binding("p", alice), binding("family", "Example")], 12).
clause(1, schema_person(alice), []).
clause(2, schema_name(alice, "Alice Example"), []).
clause(3, schema_given_name(alice, "Alice"), []).
clause(4, schema_family_name(alice, "Example"), []).
clause(5, foaf_person(var("p")), [call(schema_person(var("p")))]).
clause(6, foaf_name(var("p"), var("name")), [call(schema_name(var("p"), var("name")))]).
clause(7, foaf_given_name(var("p"), var("given")), [call(schema_given_name(var("p"), var("given")))]).
clause(8, foaf_family_name(var("p"), var("family")), [call(schema_family_name(var("p"), var("family")))]).
substitution(1, []).
proof(1, schema_person(alice), rule(1), []).
substitution(2, [binding("p", alice)]).
proof(2, foaf_person(alice), rule(5), [uses(1, schema_person(alice))]).
substitution(3, [binding("p", alice)]).
proof(3, solution([alice]), query, [uses(2, foaf_person(alice))]).
substitution(4, []).
proof(4, schema_name(alice, "Alice Example"), rule(2), []).
substitution(5, [binding("p", alice), binding("name", "Alice Example")]).
proof(5, foaf_name(alice, "Alice Example"), rule(6), [uses(4, schema_name(alice, "Alice Example"))]).
substitution(6, [binding("p", alice), binding("name", "Alice Example")]).
proof(6, solution([alice, "Alice Example"]), query, [uses(5, foaf_name(alice, "Alice Example"))]).
substitution(7, []).
proof(7, schema_given_name(alice, "Alice"), rule(3), []).
substitution(8, [binding("p", alice), binding("given", "Alice")]).
proof(8, foaf_given_name(alice, "Alice"), rule(7), [uses(7, schema_given_name(alice, "Alice"))]).
substitution(9, [binding("p", alice), binding("given", "Alice")]).
proof(9, solution([alice, "Alice"]), query, [uses(8, foaf_given_name(alice, "Alice"))]).
substitution(10, []).
proof(10, schema_family_name(alice, "Example"), rule(4), []).
substitution(11, [binding("p", alice), binding("family", "Example")]).
proof(11, foaf_family_name(alice, "Example"), rule(8), [uses(10, schema_family_name(alice, "Example"))]).
substitution(12, [binding("p", alice), binding("family", "Example")]).
proof(12, solution([alice, "Example"]), query, [uses(11, foaf_family_name(alice, "Example"))]).
