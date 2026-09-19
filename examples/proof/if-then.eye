# Eyelang result format 2
query(1, [call(mortal(socrates))], []).
result(1, complete, 1).
answer(1, []).
why(1, [], 3).
clause(1, man(socrates), []).
clause(2, mortal(var("x")), [call(man(var("x")))]).
substitution(1, []).
proof(1, man(socrates), rule(1), []).
substitution(2, [binding("x", socrates)]).
proof(2, mortal(socrates), rule(2), [uses(1, man(socrates))]).
substitution(3, []).
proof(3, solution([]), query, [uses(2, mortal(socrates))]).
