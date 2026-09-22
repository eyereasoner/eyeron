% Prolog result format 3
query(1, has_statement, []).
result(1, complete, 1).
answer(1, []).
why(1, [], 3).
query(2, named_statement(_0), ['Statement' = _0]).
result(2, complete, 1).
answer(2, ['Statement' = claim]).
why(2, ['Statement' = claim], 6).
query(3, statement_author(_0), ['Who' = _0]).
result(3, complete, 1).
answer(3, ['Who' = bob]).
why(3, ['Who' = bob], 10).
query(4, statement_date(_0), ['Date' = _0]).
result(4, complete, 1).
answer(4, ['Date' = date(2021, 7, 7)]).
why(4, ['Date' = date(2021, 7, 7)], 14).
clause(1, statement(alice, name, "Alice"), true).
clause(2, reifies(claim, triple(alice, name, "Alice")), true).
clause(3, stated_by(claim, bob), true).
clause(4, recorded(claim, date(2021, 7, 7)), true).
clause(5, has_statement, statement(alice, name, "Alice")).
clause(6, named_statement(var('Statement')), reifies(var('Statement'), triple(alice, name, "Alice"))).
clause(7, statement_author(var('Who')), (reifies(var('Claim'), triple(alice, name, "Alice")), stated_by(var('Claim'), var('Who')))).
clause(8, statement_date(var('Date')), (reifies(var('Claim'), triple(alice, name, "Alice")), recorded(var('Claim'), var('Date')))).
substitution(1, []).
proof(1, statement(alice, name, "Alice"), rule(1), []).
substitution(2, []).
proof(2, has_statement, rule(5), [uses(1, statement(alice, name, "Alice"))]).
substitution(3, []).
proof(3, solution([]), query, [uses(2, has_statement)]).
substitution(4, []).
proof(4, reifies(claim, triple(alice, name, "Alice")), rule(2), []).
substitution(5, ['Statement' = claim]).
proof(5, named_statement(claim), rule(6), [uses(4, reifies(claim, triple(alice, name, "Alice")))]).
substitution(6, ['Statement' = claim]).
proof(6, solution([claim]), query, [uses(5, named_statement(claim))]).
substitution(7, []).
proof(7, reifies(claim, triple(alice, name, "Alice")), rule(2), []).
substitution(8, []).
proof(8, stated_by(claim, bob), rule(3), []).
substitution(9, ['Who' = bob, 'Claim' = claim]).
proof(9, statement_author(bob), rule(7), [uses(7, reifies(claim, triple(alice, name, "Alice"))), uses(8, stated_by(claim, bob))]).
substitution(10, ['Who' = bob]).
proof(10, solution([bob]), query, [uses(9, statement_author(bob))]).
substitution(11, []).
proof(11, reifies(claim, triple(alice, name, "Alice")), rule(2), []).
substitution(12, []).
proof(12, recorded(claim, date(2021, 7, 7)), rule(4), []).
substitution(13, ['Date' = date(2021, 7, 7), 'Claim' = claim]).
proof(13, statement_date(date(2021, 7, 7)), rule(8), [uses(11, reifies(claim, triple(alice, name, "Alice"))), uses(12, recorded(claim, date(2021, 7, 7)))]).
substitution(14, ['Date' = date(2021, 7, 7)]).
proof(14, solution([date(2021, 7, 7)]), query, [uses(13, statement_date(date(2021, 7, 7)))]).
