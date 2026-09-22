% Prolog result format 3
query(1, knows_named(_0, _1), ['Person' = _0, 'Name' = _1]).
result(1, complete, 1).
answer(1, ['Person' = alice, 'Name' = "Bob"]).
why(1, ['Person' = alice, 'Name' = "Bob"], 4).
query(2, first_member(_0), ['First' = _0]).
result(2, complete, 1).
answer(2, ['First' = alice]).
why(2, ['First' = alice], 7).
clause(1, knows(alice, blank(person1)), true).
clause(2, name(blank(person1), "Bob"), true).
clause(4, members(team, [alice, bob, carol]), true).
clause(5, knows_named(var('Person'), var('Name')), (knows(var('Person'), var('Node')), name(var('Node'), var('Name')))).
clause(6, first_member(var('First')), members(team, [var('First')|var('Rest')])).
substitution(1, []).
proof(1, knows(alice, blank(person1)), rule(1), []).
substitution(2, []).
proof(2, name(blank(person1), "Bob"), rule(2), []).
substitution(3, ['Person' = alice, 'Name' = "Bob", 'Node' = blank(person1)]).
proof(3, knows_named(alice, "Bob"), rule(5), [uses(1, knows(alice, blank(person1))), uses(2, name(blank(person1), "Bob"))]).
substitution(4, ['Person' = alice, 'Name' = "Bob"]).
proof(4, solution([alice, "Bob"]), query, [uses(3, knows_named(alice, "Bob"))]).
substitution(5, []).
proof(5, members(team, [alice, bob, carol]), rule(4), []).
substitution(6, ['First' = alice, 'Rest' = [bob, carol]]).
proof(6, first_member(alice), rule(6), [uses(5, members(team, [alice, bob, carol]))]).
substitution(7, ['First' = alice]).
proof(7, solution([alice]), query, [uses(6, first_member(alice))]).
