test_concatenation(true).
test_equal(true).
test_not_equal(true).

clause(1,
       test_concatenation(true),
       (atomics_to_string(["hello", " ", "world!"], var('S')), var('S') = "hello world!")).
clause(2, test_equal(true), "hello world!" = "hello world!").
clause(3, test_not_equal(true), "hello world!" \== "hi").

step(test_concatenation(true),
     rule(1),
     ['S' = "hello world!"],
     [atomics_to_string(["hello", " ", "world!"], "hello world!"),
      "hello world!" = "hello world!"]).
step(atomics_to_string(["hello", " ", "world!"], "hello world!"), builtin, [], []).
step("hello world!" = "hello world!", builtin, [], []).
step(test_equal(true), rule(2), [], ["hello world!" = "hello world!"]).
step(test_not_equal(true), rule(3), [], ["hello world!" \== "hi"]).
step("hello world!" \== "hi", builtin, [], []).
