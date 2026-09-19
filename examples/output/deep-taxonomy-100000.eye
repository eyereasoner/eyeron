# Eyelang result format 2
query(1, [call(direct_subclass(n(49999), n(50000)))], []).
result(1, complete, 1).
answer(1, []).
query(2, [call(direct_subclass(n(49999), i(50000)))], []).
result(2, complete, 1).
answer(2, []).
query(3, [call(direct_subclass(n(49999), j(50000)))], []).
result(3, complete, 1).
answer(3, []).
query(4, [call(subsumed(n(0), n(100000)))], []).
result(4, complete, 1).
answer(4, []).
query(5, [call(classified_as(ind, i(50000)))], []).
result(5, complete, 1).
answer(5, []).
query(6, [call(classified_as(ind, j(100000)))], []).
result(6, complete, 1).
answer(6, []).
query(7, [call(classified_as(ind, a2))], []).
result(7, complete, 1).
answer(7, []).
query(8, [absent(subsumed(i(50000), n(100000)))], []).
result(8, complete, 1).
answer(8, []).
query(9, [absent(subsumed(i(50000), j(50000)))], []).
result(9, complete, 1).
answer(9, []).
query(10, [absent(classified_as(ind, i(100001)))], []).
result(10, complete, 1).
answer(10, []).
query(11, [absent(direct_subclass(n(-1), n(0)))], []).
result(11, complete, 1).
answer(11, []).
query(12, [absent(subsumed(a2, n(100000)))], []).
result(12, complete, 1).
answer(12, []).
