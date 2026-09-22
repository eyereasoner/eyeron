% Prolog result format 4
query(1, has_statement, []).
result(1, complete, 1).
answer(1, []).
why(1, [], [has_statement]).
query(2, named_statement(_0), ['Statement' = _0]).
result(2, complete, 1).
answer(2, ['Statement' = claim]).
why(2, ['Statement' = claim], [named_statement(claim)]).
query(3, statement_author(_0), ['Who' = _0]).
result(3, complete, 1).
answer(3, ['Who' = bob]).
why(3, ['Who' = bob], [statement_author(bob)]).
query(4, statement_date(_0), ['Date' = _0]).
result(4, complete, 1).
answer(4, ['Date' = date(2021, 7, 7)]).
why(4, ['Date' = date(2021, 7, 7)], [statement_date(date(2021, 7, 7))]).

clause(1, statement(alice, name, "Alice"), true).
clause(2, reifies(claim, triple(alice, name, "Alice")), true).
clause(3, stated_by(claim, bob), true).
clause(4, recorded(claim, date(2021, 7, 7)), true).
clause(5, has_statement, statement(alice, name, "Alice")).
clause(6,
       named_statement(var('Statement')),
       reifies(var('Statement'), triple(alice, name, "Alice"))).
clause(7,
       statement_author(var('Who')),
       (reifies(var('Claim'), triple(alice, name, "Alice")),
        stated_by(var('Claim'), var('Who')))).
clause(8,
       statement_date(var('Date')),
       (reifies(var('Claim'), triple(alice, name, "Alice")),
        recorded(var('Claim'), var('Date')))).

step(has_statement, rule(5), [], [statement(alice, name, "Alice")]).
step(statement(alice, name, "Alice"), fact(1), [], []).
step(named_statement(claim),
     rule(6),
     ['Statement' = claim],
     [reifies(claim, triple(alice, name, "Alice"))]).
step(reifies(claim, triple(alice, name, "Alice")), fact(2), [], []).
step(statement_author(bob),
     rule(7),
     ['Who' = bob, 'Claim' = claim],
     [reifies(claim, triple(alice, name, "Alice")), stated_by(claim, bob)]).
step(stated_by(claim, bob), fact(3), [], []).
step(statement_date(date(2021, 7, 7)),
     rule(8),
     ['Date' = date(2021, 7, 7), 'Claim' = claim],
     [reifies(claim, triple(alice, name, "Alice")), recorded(claim, date(2021, 7, 7))]).
step(recorded(claim, date(2021, 7, 7)), fact(4), [], []).
