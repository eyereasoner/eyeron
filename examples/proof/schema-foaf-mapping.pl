% Prolog result format 4
query(1, foaf_person(_0), ['P' = _0]).
result(1, complete, 1).
answer(1, ['P' = alice]).
why(1, ['P' = alice], [foaf_person(alice)]).
query(2, foaf_name(_0, _1), ['P' = _0, 'Name' = _1]).
result(2, complete, 1).
answer(2, ['P' = alice, 'Name' = "Alice Example"]).
why(2, ['P' = alice, 'Name' = "Alice Example"], [foaf_name(alice, "Alice Example")]).
query(3, foaf_given_name(_0, _1), ['P' = _0, 'Given' = _1]).
result(3, complete, 1).
answer(3, ['P' = alice, 'Given' = "Alice"]).
why(3, ['P' = alice, 'Given' = "Alice"], [foaf_given_name(alice, "Alice")]).
query(4, foaf_family_name(_0, _1), ['P' = _0, 'Family' = _1]).
result(4, complete, 1).
answer(4, ['P' = alice, 'Family' = "Example"]).
why(4, ['P' = alice, 'Family' = "Example"], [foaf_family_name(alice, "Example")]).

clause(1, schema_person(alice), true).
clause(2, schema_name(alice, "Alice Example"), true).
clause(3, schema_given_name(alice, "Alice"), true).
clause(4, schema_family_name(alice, "Example"), true).
clause(5, foaf_person(var('P')), schema_person(var('P'))).
clause(6, foaf_name(var('P'), var('Name')), schema_name(var('P'), var('Name'))).
clause(7, foaf_given_name(var('P'), var('Given')), schema_given_name(var('P'), var('Given'))).
clause(8,
       foaf_family_name(var('P'), var('Family')),
       schema_family_name(var('P'), var('Family'))).

step(foaf_person(alice), rule(5), ['P' = alice], [schema_person(alice)]).
step(schema_person(alice), fact(1), [], []).
step(foaf_name(alice, "Alice Example"),
     rule(6),
     ['P' = alice, 'Name' = "Alice Example"],
     [schema_name(alice, "Alice Example")]).
step(schema_name(alice, "Alice Example"), fact(2), [], []).
step(foaf_given_name(alice, "Alice"),
     rule(7),
     ['P' = alice, 'Given' = "Alice"],
     [schema_given_name(alice, "Alice")]).
step(schema_given_name(alice, "Alice"), fact(3), [], []).
step(foaf_family_name(alice, "Example"),
     rule(8),
     ['P' = alice, 'Family' = "Example"],
     [schema_family_name(alice, "Example")]).
step(schema_family_name(alice, "Example"), fact(4), [], []).
