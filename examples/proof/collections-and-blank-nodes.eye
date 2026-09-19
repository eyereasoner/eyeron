# Eyelang result format 2
query(1, [call(knows_named(?v0, ?v1))], [binding("person", ?v0), binding("name", ?v1)]).
result(1, complete, 1).
answer(1, [binding("person", alice), binding("name", "Bob")]).
why(1, [binding("person", alice), binding("name", "Bob")], 4).
query(2, [call(first_member(?v0))], [binding("first", ?v0)]).
result(2, complete, 1).
answer(2, [binding("first", alice)]).
why(2, [binding("first", alice)], 7).
clause(1, knows(alice, blank(person1)), []).
clause(2, name(blank(person1), "Bob"), []).
clause(4, members(team, [alice, bob, carol]), []).
clause(5, knows_named(var("person"), var("name")), [call(knows(var("person"), var("node"))), call(name(var("node"), var("name")))]).
clause(6, first_member(var("first")), [call(members(team, [var("first") | var("rest")]))]).
substitution(1, []).
proof(1, knows(alice, blank(person1)), rule(1), []).
substitution(2, []).
proof(2, name(blank(person1), "Bob"), rule(2), []).
substitution(3, [binding("person", alice), binding("name", "Bob"), binding("node", blank(person1))]).
proof(3, knows_named(alice, "Bob"), rule(5), [uses(1, knows(alice, blank(person1))), uses(2, name(blank(person1), "Bob"))]).
substitution(4, [binding("person", alice), binding("name", "Bob")]).
proof(4, solution([alice, "Bob"]), query, [uses(3, knows_named(alice, "Bob"))]).
substitution(5, []).
proof(5, members(team, [alice, bob, carol]), rule(4), []).
substitution(6, [binding("first", alice), binding("rest", [bob, carol])]).
proof(6, first_member(alice), rule(6), [uses(5, members(team, [alice, bob, carol]))]).
substitution(7, [binding("first", alice)]).
proof(7, solution([alice]), query, [uses(6, first_member(alice))]).
