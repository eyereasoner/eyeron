# Eyelang result format 2
query(1, [call(report(?v0))], [binding("statement", ?v0)]).
result(1, complete, 1).
answer(1, [binding("statement", quoted([triple(joe, is, [good, Cobbler])]))]).
why(1, [binding("statement", quoted([triple(joe, is, [good, Cobbler])]))], 3).
query(2, [call(is(joe, good))], []).
result(2, complete, 0).
clause(1, is(joe, [good, Cobbler]), []).
clause(2, report(quoted([triple(var("person"), is, [good, var("occupation")])])), [call(is(var("person"), [good, var("occupation")]))]).
substitution(1, []).
proof(1, is(joe, [good, Cobbler]), rule(1), []).
substitution(2, [binding("person", joe), binding("occupation", Cobbler)]).
proof(2, report(quoted([triple(joe, is, [good, Cobbler])])), rule(2), [uses(1, is(joe, [good, Cobbler]))]).
substitution(3, [binding("statement", quoted([triple(joe, is, [good, Cobbler])]))]).
proof(3, solution([quoted([triple(joe, is, [good, Cobbler])])]), query, [uses(2, report(quoted([triple(joe, is, [good, Cobbler])])))]).
