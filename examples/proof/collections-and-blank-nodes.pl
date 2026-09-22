% Prolog result format 4
query(1, knows_named(_0, _1), ['Person' = _0, 'Name' = _1]).
result(1, complete, 1).
answer(1, ['Person' = alice, 'Name' = "Bob"]).
why(1, ['Person' = alice, 'Name' = "Bob"], [knows_named(alice, "Bob")]).
query(2, first_member(_0), ['First' = _0]).
result(2, complete, 1).
answer(2, ['First' = alice]).
why(2, ['First' = alice], [first_member(alice)]).

clause(1, knows(alice, blank(person1)), true).
clause(2, name(blank(person1), "Bob"), true).
clause(4, members(team, [alice, bob, carol]), true).
clause(5,
       knows_named(var('Person'), var('Name')),
       (knows(var('Person'), var('Node')), name(var('Node'), var('Name')))).
clause(6, first_member(var('First')), members(team, [var('First')|var('Rest')])).

step(knows_named(alice, "Bob"),
     rule(5),
     ['Person' = alice, 'Name' = "Bob", 'Node' = blank(person1)],
     [knows(alice, blank(person1)), name(blank(person1), "Bob")]).
step(knows(alice, blank(person1)), fact(1), [], []).
step(name(blank(person1), "Bob"), fact(2), [], []).
step(first_member(alice),
     rule(6),
     ['First' = alice, 'Rest' = [bob, carol]],
     [members(team, [alice, bob, carol])]).
step(members(team, [alice, bob, carol]), fact(4), [], []).
