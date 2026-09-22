% Prolog result format 3
query(1, report(_0), ['Statement' = _0]).
result(1, complete, 1).
answer(1, ['Statement' = quoted(triple(joe, is_a, [good, cobbler]))]).
why(1, ['Statement' = quoted(triple(joe, is_a, [good, cobbler]))], 3).
query(2, is_a(joe, good), []).
result(2, complete, 0).
clause(1, is_a(joe, [good, cobbler]), true).
clause(2, report(quoted(triple(var('Person'), is_a, [good, var('Occupation')]))), is_a(var('Person'), [good, var('Occupation')])).
substitution(1, []).
proof(1, is_a(joe, [good, cobbler]), rule(1), []).
substitution(2, ['Person' = joe, 'Occupation' = cobbler]).
proof(2, report(quoted(triple(joe, is_a, [good, cobbler]))), rule(2), [uses(1, is_a(joe, [good, cobbler]))]).
substitution(3, ['Statement' = quoted(triple(joe, is_a, [good, cobbler]))]).
proof(3, solution([quoted(triple(joe, is_a, [good, cobbler]))]), query, [uses(2, report(quoted(triple(joe, is_a, [good, cobbler]))))]).
