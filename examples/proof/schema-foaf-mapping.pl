% Prolog result format 3
query(1, foaf_person(_0), ['P' = _0]).
result(1, complete, 1).
answer(1, ['P' = alice]).
why(1, ['P' = alice], 3).
query(2, foaf_name(_0, _1), ['P' = _0, 'Name' = _1]).
result(2, complete, 1).
answer(2, ['P' = alice, 'Name' = "Alice Example"]).
why(2, ['P' = alice, 'Name' = "Alice Example"], 6).
query(3, foaf_given_name(_0, _1), ['P' = _0, 'Given' = _1]).
result(3, complete, 1).
answer(3, ['P' = alice, 'Given' = "Alice"]).
why(3, ['P' = alice, 'Given' = "Alice"], 9).
query(4, foaf_family_name(_0, _1), ['P' = _0, 'Family' = _1]).
result(4, complete, 1).
answer(4, ['P' = alice, 'Family' = "Example"]).
why(4, ['P' = alice, 'Family' = "Example"], 12).
clause(1, schema_person(alice), true).
clause(2, schema_name(alice, "Alice Example"), true).
clause(3, schema_given_name(alice, "Alice"), true).
clause(4, schema_family_name(alice, "Example"), true).
clause(5, foaf_person(var('P')), schema_person(var('P'))).
clause(6, foaf_name(var('P'), var('Name')), schema_name(var('P'), var('Name'))).
clause(7, foaf_given_name(var('P'), var('Given')), schema_given_name(var('P'), var('Given'))).
clause(8, foaf_family_name(var('P'), var('Family')), schema_family_name(var('P'), var('Family'))).
substitution(1, []).
proof(1, schema_person(alice), rule(1), []).
substitution(2, ['P' = alice]).
proof(2, foaf_person(alice), rule(5), [uses(1, schema_person(alice))]).
substitution(3, ['P' = alice]).
proof(3, solution([alice]), query, [uses(2, foaf_person(alice))]).
substitution(4, []).
proof(4, schema_name(alice, "Alice Example"), rule(2), []).
substitution(5, ['P' = alice, 'Name' = "Alice Example"]).
proof(5, foaf_name(alice, "Alice Example"), rule(6), [uses(4, schema_name(alice, "Alice Example"))]).
substitution(6, ['P' = alice, 'Name' = "Alice Example"]).
proof(6, solution([alice, "Alice Example"]), query, [uses(5, foaf_name(alice, "Alice Example"))]).
substitution(7, []).
proof(7, schema_given_name(alice, "Alice"), rule(3), []).
substitution(8, ['P' = alice, 'Given' = "Alice"]).
proof(8, foaf_given_name(alice, "Alice"), rule(7), [uses(7, schema_given_name(alice, "Alice"))]).
substitution(9, ['P' = alice, 'Given' = "Alice"]).
proof(9, solution([alice, "Alice"]), query, [uses(8, foaf_given_name(alice, "Alice"))]).
substitution(10, []).
proof(10, schema_family_name(alice, "Example"), rule(4), []).
substitution(11, ['P' = alice, 'Family' = "Example"]).
proof(11, foaf_family_name(alice, "Example"), rule(8), [uses(10, schema_family_name(alice, "Example"))]).
substitution(12, ['P' = alice, 'Family' = "Example"]).
proof(12, solution([alice, "Example"]), query, [uses(11, foaf_family_name(alice, "Example"))]).
