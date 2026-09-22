% Prolog result format 3
query(1, has_statement, []).
result(1, complete, 1).
answer(1, []).
query(2, named_statement(_0), ['Statement' = _0]).
result(2, complete, 1).
answer(2, ['Statement' = claim]).
query(3, statement_author(_0), ['Who' = _0]).
result(3, complete, 1).
answer(3, ['Who' = bob]).
query(4, statement_date(_0), ['Date' = _0]).
result(4, complete, 1).
answer(4, ['Date' = date(2021, 7, 7)]).
