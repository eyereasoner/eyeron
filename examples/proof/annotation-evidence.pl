has_statement.
named_statement(claim).
statement_author(bob).
statement_date(date(2021, 7, 7)).

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
