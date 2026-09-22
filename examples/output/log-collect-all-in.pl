% Prolog result format 3
query(1, result1(_0), ['All' = _0]).
result(1, complete, 1).
answer(1, ['All' = ["Dewey", "Huey", "Louie"]]).
query(2, result2(_0), ['Nested' = _0]).
result(2, complete, 1).
answer(2, ['Nested' = [["Dewey"], ["Huey"], ["Louie"]]]).
query(3, result3(_0), ['Filtered' = _0]).
result(3, complete, 1).
answer(3, ['Filtered' = ["Dewey", "Huey"]]).
