# Eyelang result format 2
query(1, [call(statement_source(?v0, ?v1))], [binding("speaker", ?v0), binding("source", ?v1)]).
result(1, complete, 2).
answer(1, [binding("speaker", alice), binding("source", chat)]).
why(1, [binding("speaker", alice), binding("source", chat)], 7).
answer(1, [binding("speaker", bob), binding("source", email)]).
why(1, [binding("speaker", bob), binding("source", email)], 8).
query(2, [call(statement(bob, says, hi))], []).
result(2, complete, 0).
query(3, [call(certainty(blank(claim1), ?v0))], [binding("certainty", ?v0)]).
result(3, complete, 1).
answer(3, [binding("certainty", 0.9)]).
why(3, [binding("certainty", 0.9)], 10).
clause(2, reifies(blank(claim1), triple(alice, says, hello)), []).
clause(3, source(blank(claim1), chat), []).
clause(4, certainty(blank(claim1), 0.9), []).
clause(5, reifies(bobClaim, triple(bob, says, hi)), []).
clause(6, source(bobClaim, email), []).
clause(7, statement_source(var("speaker"), var("source")), [call(reifies(var("claim"), triple(var("speaker"), says, var("object")))), call(source(var("claim"), var("source")))]).
substitution(1, []).
proof(1, reifies(blank(claim1), triple(alice, says, hello)), rule(2), []).
substitution(2, []).
proof(2, reifies(bobClaim, triple(bob, says, hi)), rule(5), []).
substitution(3, []).
proof(3, source(blank(claim1), chat), rule(3), []).
substitution(4, []).
proof(4, source(bobClaim, email), rule(6), []).
substitution(5, [binding("speaker", alice), binding("source", chat), binding("claim", blank(claim1)), binding("object", hello)]).
proof(5, statement_source(alice, chat), rule(7), [uses(1, reifies(blank(claim1), triple(alice, says, hello))), uses(3, source(blank(claim1), chat))]).
substitution(6, [binding("speaker", bob), binding("source", email), binding("claim", bobClaim), binding("object", hi)]).
proof(6, statement_source(bob, email), rule(7), [uses(2, reifies(bobClaim, triple(bob, says, hi))), uses(4, source(bobClaim, email))]).
substitution(7, [binding("speaker", alice), binding("source", chat)]).
proof(7, solution([alice, chat]), query, [uses(5, statement_source(alice, chat))]).
substitution(8, [binding("speaker", bob), binding("source", email)]).
proof(8, solution([bob, email]), query, [uses(6, statement_source(bob, email))]).
substitution(9, []).
proof(9, certainty(blank(claim1), 0.9), rule(4), []).
substitution(10, [binding("certainty", 0.9)]).
proof(10, solution([0.9]), query, [uses(9, certainty(blank(claim1), 0.9))]).
