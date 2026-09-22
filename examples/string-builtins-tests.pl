% Prolog example: string-builtins-tests.
% Companion to string-builtins-tests.n3/.srl: N3's version exhaustively
% checks 20 different string: builtins (contains, case-insensitive
% comparison, ordering, format, regex matching/scraping, replace, ...).
% Prolog has a much smaller string surface -- only `concat(...)` and
% `str()`, plus structural `=`/`!=` (there is no string ordering
% operator at all; see log-collect-all-in.pl's own note) -- so this
% covers only concatenation and equality/inequality, the parts that
% carry over, rather than attempting a one-to-one port of the rest.
test_concatenation(true) :-
    atomics_to_string(["hello", " ", "world!"], S),
    S = "hello world!".
test_equal(true) :-
    "hello world!" = "hello world!".
test_not_equal(true) :-
    "hello world!" \== "hi".

?- test_concatenation(R).
?- test_equal(R).
?- test_not_equal(R).
