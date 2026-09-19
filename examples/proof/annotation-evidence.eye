# Eyelang result format 2
query(1, [call(has_statement())], []).
result(1, complete, 1).
answer(1, []).
why(1, [], 3).
query(2, [call(named_statement(?v0))], [binding("statement", ?v0)]).
result(2, complete, 1).
answer(2, [binding("statement", claim)]).
why(2, [binding("statement", claim)], 6).
query(3, [call(statement_author(?v0))], [binding("who", ?v0)]).
result(3, complete, 1).
answer(3, [binding("who", bob)]).
why(3, [binding("who", bob)], 10).
query(4, [call(statement_date(?v0))], [binding("date", ?v0)]).
result(4, complete, 1).
answer(4, [binding("date", date(2021, 7, 7))]).
why(4, [binding("date", date(2021, 7, 7))], 14).
clause(1, statement(alice, name, "Alice"), []).
clause(2, reifies(claim, triple(alice, name, "Alice")), []).
clause(3, stated_by(claim, bob), []).
clause(4, recorded(claim, date(2021, 7, 7)), []).
clause(5, has_statement(), [call(statement(alice, name, "Alice"))]).
clause(6, named_statement(var("statement")), [call(reifies(var("statement"), triple(alice, name, "Alice")))]).
clause(7, statement_author(var("who")), [call(reifies(var("claim"), triple(alice, name, "Alice"))), call(stated_by(var("claim"), var("who")))]).
clause(8, statement_date(var("date")), [call(reifies(var("claim"), triple(alice, name, "Alice"))), call(recorded(var("claim"), var("date")))]).
substitution(1, []).
proof(1, statement(alice, name, "Alice"), rule(1), []).
substitution(2, []).
proof(2, has_statement(), rule(5), [uses(1, statement(alice, name, "Alice"))]).
substitution(3, []).
proof(3, solution([]), query, [uses(2, has_statement())]).
substitution(4, []).
proof(4, reifies(claim, triple(alice, name, "Alice")), rule(2), []).
substitution(5, [binding("statement", claim)]).
proof(5, named_statement(claim), rule(6), [uses(4, reifies(claim, triple(alice, name, "Alice")))]).
substitution(6, [binding("statement", claim)]).
proof(6, solution([claim]), query, [uses(5, named_statement(claim))]).
substitution(7, []).
proof(7, reifies(claim, triple(alice, name, "Alice")), rule(2), []).
substitution(8, []).
proof(8, stated_by(claim, bob), rule(3), []).
substitution(9, [binding("who", bob), binding("claim", claim)]).
proof(9, statement_author(bob), rule(7), [uses(7, reifies(claim, triple(alice, name, "Alice"))), uses(8, stated_by(claim, bob))]).
substitution(10, [binding("who", bob)]).
proof(10, solution([bob]), query, [uses(9, statement_author(bob))]).
substitution(11, []).
proof(11, reifies(claim, triple(alice, name, "Alice")), rule(2), []).
substitution(12, []).
proof(12, recorded(claim, date(2021, 7, 7)), rule(4), []).
substitution(13, [binding("date", date(2021, 7, 7)), binding("claim", claim)]).
proof(13, statement_date(date(2021, 7, 7)), rule(8), [uses(11, reifies(claim, triple(alice, name, "Alice"))), uses(12, recorded(claim, date(2021, 7, 7)))]).
substitution(14, [binding("date", date(2021, 7, 7))]).
proof(14, solution([date(2021, 7, 7)]), query, [uses(13, statement_date(date(2021, 7, 7)))]).
