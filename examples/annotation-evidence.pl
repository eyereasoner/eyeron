% Prolog example: annotation-evidence.
statement(alice, name, "Alice").
reifies(claim, triple(alice, name, "Alice")).
stated_by(claim, bob).
recorded(claim, date(2021, 7, 7)).
has_statement :-
    statement(alice, name, "Alice").
named_statement(Statement) :-
    reifies(Statement, triple(alice, name, "Alice")).
statement_author(Who) :-
    reifies(Claim, triple(alice, name, "Alice")),
    stated_by(Claim, Who).
statement_date(Date) :-
    reifies(Claim, triple(alice, name, "Alice")),
    recorded(Claim, Date).
?- has_statement.
?- named_statement(Statement).
?- statement_author(Who).
?- statement_date(Date).
