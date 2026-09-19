# Eyelang result format 2
query(1, [call(statement_source(?v0, ?v1))], [binding("speaker", ?v0), binding("source", ?v1)]).
result(1, complete, 2).
answer(1, [binding("speaker", alice), binding("source", chat)]).
why(1, [binding("speaker", alice), binding("source", chat)], 7).
answer(1, [binding("speaker", bob), binding("source", email)]).
why(1, [binding("speaker", bob), binding("source", email)], 8).
query(2, [call(reifies(?v0, ?v1))], [binding("claim", ?v0), binding("statement", ?v1)]).
result(2, complete, 2).
answer(2, [binding("claim", claim1), binding("statement", triple(alice, says, hello))]).
why(2, [binding("claim", claim1), binding("statement", triple(alice, says, hello))], 11).
answer(2, [binding("claim", claim2), binding("statement", triple(bob, says, hi))]).
why(2, [binding("claim", claim2), binding("statement", triple(bob, says, hi))], 12).
clause(1, reifies(claim1, triple(alice, says, hello)), []).
clause(2, source(claim1, chat), []).
clause(3, reifies(claim2, triple(bob, says, hi)), []).
clause(4, source(claim2, email), []).
clause(5, statement_source(var("speaker"), var("source")), [call(reifies(var("claim"), triple(var("speaker"), says, var("object")))), call(source(var("claim"), var("source")))]).
substitution(1, []).
proof(1, reifies(claim1, triple(alice, says, hello)), rule(1), []).
substitution(2, []).
proof(2, reifies(claim2, triple(bob, says, hi)), rule(3), []).
substitution(3, []).
proof(3, source(claim1, chat), rule(2), []).
substitution(4, []).
proof(4, source(claim2, email), rule(4), []).
substitution(5, [binding("speaker", alice), binding("source", chat), binding("claim", claim1), binding("object", hello)]).
proof(5, statement_source(alice, chat), rule(5), [uses(1, reifies(claim1, triple(alice, says, hello))), uses(3, source(claim1, chat))]).
substitution(6, [binding("speaker", bob), binding("source", email), binding("claim", claim2), binding("object", hi)]).
proof(6, statement_source(bob, email), rule(5), [uses(2, reifies(claim2, triple(bob, says, hi))), uses(4, source(claim2, email))]).
substitution(7, [binding("speaker", alice), binding("source", chat)]).
proof(7, solution([alice, chat]), query, [uses(5, statement_source(alice, chat))]).
substitution(8, [binding("speaker", bob), binding("source", email)]).
proof(8, solution([bob, email]), query, [uses(6, statement_source(bob, email))]).
substitution(9, []).
proof(9, reifies(claim1, triple(alice, says, hello)), rule(1), []).
substitution(10, []).
proof(10, reifies(claim2, triple(bob, says, hi)), rule(3), []).
substitution(11, [binding("claim", claim1), binding("statement", triple(alice, says, hello))]).
proof(11, solution([claim1, triple(alice, says, hello)]), query, [uses(9, reifies(claim1, triple(alice, says, hello)))]).
substitution(12, [binding("claim", claim2), binding("statement", triple(bob, says, hi))]).
proof(12, solution([claim2, triple(bob, says, hi)]), query, [uses(10, reifies(claim2, triple(bob, says, hi)))]).
