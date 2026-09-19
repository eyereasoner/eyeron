# Eyelang example: annotation-evidence.
statement(alice, name, "Alice"). reifies(claim, triple(alice, name, "Alice")).
stated_by(claim, bob). recorded(claim, date(2021, 7, 7)).
has_statement if statement(alice, name, "Alice").
named_statement(?statement) if reifies(?statement, triple(alice, name, "Alice")).
statement_author(?who) if reifies(?claim, triple(alice, name, "Alice")), stated_by(?claim, ?who).
statement_date(?date) if reifies(?claim, triple(alice, name, "Alice")), recorded(?claim, ?date).
ask has_statement.
ask named_statement(?statement).
ask statement_author(?who).
ask statement_date(?date).
