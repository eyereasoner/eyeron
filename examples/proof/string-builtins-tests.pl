% Prolog result format 3
query(1, test_concatenation(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], 2).
query(2, test_equal(_0), ['R' = _0]).
result(2, complete, 1).
answer(2, ['R' = true]).
why(2, ['R' = true], 4).
query(3, test_not_equal(_0), ['R' = _0]).
result(3, complete, 1).
answer(3, ['R' = true]).
why(3, ['R' = true], 6).
clause(1, test_concatenation(true), (atomics_to_string(["hello", " ", "world!"], var('S')), var('S') = "hello world!")).
clause(2, test_equal(true), "hello world!" = "hello world!").
clause(3, test_not_equal(true), "hello world!" \== "hi").
substitution(1, ['S' = "hello world!"]).
proof(1, test_concatenation(true), rule(1), [builtin(atomics_to_string(["hello", " ", "world!"], "hello world!")), builtin("hello world!" = "hello world!")]).
substitution(2, ['R' = true]).
proof(2, solution([true]), query, [uses(1, test_concatenation(true))]).
substitution(3, []).
proof(3, test_equal(true), rule(2), [builtin("hello world!" = "hello world!")]).
substitution(4, ['R' = true]).
proof(4, solution([true]), query, [uses(3, test_equal(true))]).
substitution(5, []).
proof(5, test_not_equal(true), rule(3), [builtin("hello world!" \== "hi")]).
substitution(6, ['R' = true]).
proof(6, solution([true]), query, [uses(5, test_not_equal(true))]).
