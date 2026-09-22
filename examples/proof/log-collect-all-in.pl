% Prolog result format 4
query(1, result1(_0), ['All' = _0]).
result(1, complete, 1).
answer(1, ['All' = ["Dewey", "Huey", "Louie"]]).
why(1, ['All' = ["Dewey", "Huey", "Louie"]], [result1(["Dewey", "Huey", "Louie"])]).
query(2, result2(_0), ['Nested' = _0]).
result(2, complete, 1).
answer(2, ['Nested' = [["Dewey"], ["Huey"], ["Louie"]]]).
why(2,
    ['Nested' = [["Dewey"], ["Huey"], ["Louie"]]],
    [result2([["Dewey"], ["Huey"], ["Louie"]])]).
query(3, result3(_0), ['Filtered' = _0]).
result(3, complete, 1).
answer(3, ['Filtered' = ["Dewey", "Huey"]]).
why(3, ['Filtered' = ["Dewey", "Huey"]], [result3(["Dewey", "Huey"])]).

clause(1, param("Huey"), true).
clause(2, param("Dewey"), true).
clause(3, param("Louie"), true).
clause(4,
       result1(var('All')),
       (findall(var('P'), param(var('P')), var('Bag1')), sort(var('Bag1'), var('All')))).
clause(5,
       result2(var('Nested')),
       (findall([var('P')], param(var('P')), var('Bag1')), sort(var('Bag1'), var('Nested')))).
clause(6,
       result3(var('Filtered')),
       (findall(var('P'), (param(var('P')), var('P') \== "Louie"), var('Bag1')),
        sort(var('Bag1'), var('Filtered')))).

step(result1(["Dewey", "Huey", "Louie"]),
     rule(4),
     ['All' = ["Dewey", "Huey", "Louie"], 'P' = _0, 'Bag1' = ["Huey", "Dewey", "Louie"]],
     [findall(_1, param(_1), ["Huey", "Dewey", "Louie"]),
      sort(["Huey", "Dewey", "Louie"], ["Dewey", "Huey", "Louie"])]).
step(findall(_0, param(_0), ["Huey", "Dewey", "Louie"]),
     collected,
     [],
     [param("Huey"), param("Dewey"), param("Louie")]).
step(param("Huey"), fact(1), [], []).
step(param("Dewey"), fact(2), [], []).
step(param("Louie"), fact(3), [], []).
step(sort(["Huey", "Dewey", "Louie"], ["Dewey", "Huey", "Louie"]), builtin, [], []).
step(result2([["Dewey"], ["Huey"], ["Louie"]]),
     rule(5),
     ['Nested' = [["Dewey"], ["Huey"], ["Louie"]],
      'P' = _0,
      'Bag1' = [["Huey"], ["Dewey"], ["Louie"]]],
     [findall([_1], param(_1), [["Huey"], ["Dewey"], ["Louie"]]),
      sort([["Huey"], ["Dewey"], ["Louie"]], [["Dewey"], ["Huey"], ["Louie"]])]).
step(findall([_0], param(_0), [["Huey"], ["Dewey"], ["Louie"]]),
     collected,
     [],
     [param("Huey"), param("Dewey"), param("Louie")]).
step(sort([["Huey"], ["Dewey"], ["Louie"]], [["Dewey"], ["Huey"], ["Louie"]]), builtin, [], []).
step(result3(["Dewey", "Huey"]),
     rule(6),
     ['Filtered' = ["Dewey", "Huey"], 'P' = _0, 'Bag1' = ["Huey", "Dewey"]],
     [findall(_1, (param(_1), _1 \== "Louie"), ["Huey", "Dewey"]),
      sort(["Huey", "Dewey"], ["Dewey", "Huey"])]).
step(findall(_0, (param(_0), _0 \== "Louie"), ["Huey", "Dewey"]),
     collected,
     [],
     [param("Huey"), "Huey" \== "Louie", param("Dewey"), "Dewey" \== "Louie"]).
step("Huey" \== "Louie", builtin, [], []).
step("Dewey" \== "Louie", builtin, [], []).
step(sort(["Huey", "Dewey"], ["Dewey", "Huey"]), builtin, [], []).
