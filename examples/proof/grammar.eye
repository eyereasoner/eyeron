# Eyelang result format 2
query(1, [call(sentence(?v0, [open, door], []))], [binding("ast", ?v0)]).
result(1, complete, 1).
answer(1, [binding("ast", command(open, door))]).
why(1, [binding("ast", command(open, door))], 4).
query(2, [call(sentence(command(close, window), ?v0, []))], [binding("words", ?v0)]).
result(2, complete, 1).
answer(2, [binding("words", [close, window])]).
why(2, [binding("words", [close, window])], 8).
clause(1, sentence(command(var("verb"), var("object")), var("input"), var("rest")), [call(verb(var("verb"), var("input"), var("middle"))), call(noun(var("object"), var("middle"), var("rest")))]).
clause(2, verb(open, [open | var("rest")], var("rest")), []).
clause(3, verb(close, [close | var("rest")], var("rest")), []).
clause(4, noun(door, [door | var("rest")], var("rest")), []).
clause(5, noun(window, [window | var("rest")], var("rest")), []).
substitution(1, [binding("rest", [door])]).
proof(1, verb(open, [open, door], [door]), rule(2), []).
substitution(2, [binding("rest", [])]).
proof(2, noun(door, [door], []), rule(4), []).
substitution(3, [binding("verb", open), binding("object", door), binding("input", [open, door]), binding("rest", []), binding("middle", [door])]).
proof(3, sentence(command(open, door), [open, door], []), rule(1), [uses(1, verb(open, [open, door], [door])), uses(2, noun(door, [door], []))]).
substitution(4, [binding("ast", command(open, door))]).
proof(4, solution([command(open, door)]), query, [uses(3, sentence(command(open, door), [open, door], []))]).
substitution(5, [binding("rest", ?v0)]).
proof(5, verb(close, [close | ?v0], ?v0), rule(3), []).
substitution(6, [binding("rest", [])]).
proof(6, noun(window, [window], []), rule(5), []).
substitution(7, [binding("verb", close), binding("object", window), binding("input", [close, window]), binding("rest", []), binding("middle", [window])]).
proof(7, sentence(command(close, window), [close, window], []), rule(1), [uses(5, verb(close, [close, window], [window])), uses(6, noun(window, [window], []))]).
substitution(8, [binding("words", [close, window])]).
proof(8, solution([[close, window]]), query, [uses(7, sentence(command(close, window), [close, window], []))]).
