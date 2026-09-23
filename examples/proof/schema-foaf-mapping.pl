foaf_person(alice).
foaf_name(alice, "Alice Example").
foaf_given_name(alice, "Alice").
foaf_family_name(alice, "Example").

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
