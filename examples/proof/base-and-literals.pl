adult(alice).

clause(1, person(alice, literal("Alice Smith", en), typed(22, integer)), true).
clause(3,
       adult(var('Person')),
       (person(var('Person'), literal(var('Name'), en), typed(var('Age'), integer)),
        var('Age') >= 18)).

step(adult(alice),
     rule(3),
     ['Person' = alice, 'Name' = "Alice Smith", 'Age' = 22],
     [person(alice, literal("Alice Smith", en), typed(22, integer)), 22 >= 18]).
step(person(alice, literal("Alice Smith", en), typed(22, integer)), fact(1), [], []).
step(22 >= 18, builtin, [], []).
