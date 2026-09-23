result_query(a, b, b).
result_query(c, b, b).
result_query(a, b, a).
result_query(b, a, b).
result_query(b, c, b).
result_query(c, b, c).
result_query(b, a, a).
result_query(b, c, a).
result_query(b, c, c).
result_query(b, a, c).
result_query(c, b, a).
result_query(a, b, c).
result_query(a, c, b).
result_query(c, a, b).
result_query(a, c, a).
result_query(c, a, c).
result_query(c, a, a).
result_query(a, c, c).

clause(1, in_x(a), true).
clause(2, in_x(b), true).
clause(3, in_x(c), true).
clause(4, sim(var('X'), var('X')), in_x(var('X'))).
clause(5, sim(var('Y'), var('X')), sim(var('X'), var('Y'))).
clause(6, sim(var('X'), var('Z')), (sim(var('X'), var('Y')), sim(var('Y'), var('Z')))).
clause(7, in_class_of(var('U'), var('X')), sim(var('U'), var('X'))).
clause(8, same_class(var('X'), var('Y')), sim(var('X'), var('Y'))).
clause(10,
       shared_member_shows_same_class(var('X'), var('Y'), var('Z')),
       (in_class_of(var('Z'), var('X')),
        in_class_of(var('Z'), var('Y')),
        same_class(var('X'), var('Y')))).
clause(11, sim(b, a), true).
clause(12, sim(b, c), true).
clause(13,
       result_query(var('X'), var('Y'), var('Z')),
       (shared_member_shows_same_class(var('X'), var('Y'), var('Z')), var('X') \== var('Y'))).

step(result_query(a, b, b),
     rule(13),
     ['X' = a, 'Y' = b, 'Z' = b],
     [shared_member_shows_same_class(a, b, b), a \== b]).
step(shared_member_shows_same_class(a, b, b),
     rule(10),
     ['X' = a, 'Y' = b, 'Z' = b],
     [in_class_of(b, a), in_class_of(b, b), same_class(a, b)]).
step(in_class_of(b, a), rule(7), ['U' = b, 'X' = a], [sim(b, a)]).
step(sim(b, a), fact(11), [], []).
step(in_class_of(b, b), rule(7), ['U' = b, 'X' = b], [sim(b, b)]).
step(sim(b, b), rule(4), ['X' = b], [in_x(b)]).
step(in_x(b), fact(2), [], []).
step(same_class(a, b), rule(8), ['X' = a, 'Y' = b], [sim(a, b)]).
step(sim(a, b), rule(5), ['Y' = a, 'X' = b], [sim(b, a)]).
step(a \== b, builtin, [], []).
step(result_query(c, b, b),
     rule(13),
     ['X' = c, 'Y' = b, 'Z' = b],
     [shared_member_shows_same_class(c, b, b), c \== b]).
step(shared_member_shows_same_class(c, b, b),
     rule(10),
     ['X' = c, 'Y' = b, 'Z' = b],
     [in_class_of(b, c), in_class_of(b, b), same_class(c, b)]).
step(in_class_of(b, c), rule(7), ['U' = b, 'X' = c], [sim(b, c)]).
step(sim(b, c), fact(12), [], []).
step(same_class(c, b), rule(8), ['X' = c, 'Y' = b], [sim(c, b)]).
step(sim(c, b), rule(5), ['Y' = c, 'X' = b], [sim(b, c)]).
step(c \== b, builtin, [], []).
step(result_query(a, b, a),
     rule(13),
     ['X' = a, 'Y' = b, 'Z' = a],
     [shared_member_shows_same_class(a, b, a), a \== b]).
step(shared_member_shows_same_class(a, b, a),
     rule(10),
     ['X' = a, 'Y' = b, 'Z' = a],
     [in_class_of(a, a), in_class_of(a, b), same_class(a, b)]).
step(in_class_of(a, a), rule(7), ['U' = a, 'X' = a], [sim(a, a)]).
step(sim(a, a), rule(4), ['X' = a], [in_x(a)]).
step(in_x(a), fact(1), [], []).
step(in_class_of(a, b), rule(7), ['U' = a, 'X' = b], [sim(a, b)]).
step(result_query(b, a, b),
     rule(13),
     ['X' = b, 'Y' = a, 'Z' = b],
     [shared_member_shows_same_class(b, a, b), b \== a]).
step(shared_member_shows_same_class(b, a, b),
     rule(10),
     ['X' = b, 'Y' = a, 'Z' = b],
     [in_class_of(b, b), in_class_of(b, a), same_class(b, a)]).
step(same_class(b, a), rule(8), ['X' = b, 'Y' = a], [sim(b, a)]).
step(b \== a, builtin, [], []).
step(result_query(b, c, b),
     rule(13),
     ['X' = b, 'Y' = c, 'Z' = b],
     [shared_member_shows_same_class(b, c, b), b \== c]).
step(shared_member_shows_same_class(b, c, b),
     rule(10),
     ['X' = b, 'Y' = c, 'Z' = b],
     [in_class_of(b, b), in_class_of(b, c), same_class(b, c)]).
step(same_class(b, c), rule(8), ['X' = b, 'Y' = c], [sim(b, c)]).
step(b \== c, builtin, [], []).
step(result_query(c, b, c),
     rule(13),
     ['X' = c, 'Y' = b, 'Z' = c],
     [shared_member_shows_same_class(c, b, c), c \== b]).
step(shared_member_shows_same_class(c, b, c),
     rule(10),
     ['X' = c, 'Y' = b, 'Z' = c],
     [in_class_of(c, c), in_class_of(c, b), same_class(c, b)]).
step(in_class_of(c, c), rule(7), ['U' = c, 'X' = c], [sim(c, c)]).
step(sim(c, c), rule(4), ['X' = c], [in_x(c)]).
step(in_x(c), fact(3), [], []).
step(in_class_of(c, b), rule(7), ['U' = c, 'X' = b], [sim(c, b)]).
step(result_query(b, a, a),
     rule(13),
     ['X' = b, 'Y' = a, 'Z' = a],
     [shared_member_shows_same_class(b, a, a), b \== a]).
step(shared_member_shows_same_class(b, a, a),
     rule(10),
     ['X' = b, 'Y' = a, 'Z' = a],
     [in_class_of(a, b), in_class_of(a, a), same_class(b, a)]).
step(result_query(b, c, a),
     rule(13),
     ['X' = b, 'Y' = c, 'Z' = a],
     [shared_member_shows_same_class(b, c, a), b \== c]).
step(shared_member_shows_same_class(b, c, a),
     rule(10),
     ['X' = b, 'Y' = c, 'Z' = a],
     [in_class_of(a, b), in_class_of(a, c), same_class(b, c)]).
step(in_class_of(a, c), rule(7), ['U' = a, 'X' = c], [sim(a, c)]).
step(sim(a, c), rule(6), ['X' = a, 'Z' = c, 'Y' = b], [sim(a, b), sim(b, c)]).
step(result_query(b, c, c),
     rule(13),
     ['X' = b, 'Y' = c, 'Z' = c],
     [shared_member_shows_same_class(b, c, c), b \== c]).
step(shared_member_shows_same_class(b, c, c),
     rule(10),
     ['X' = b, 'Y' = c, 'Z' = c],
     [in_class_of(c, b), in_class_of(c, c), same_class(b, c)]).
step(result_query(b, a, c),
     rule(13),
     ['X' = b, 'Y' = a, 'Z' = c],
     [shared_member_shows_same_class(b, a, c), b \== a]).
step(shared_member_shows_same_class(b, a, c),
     rule(10),
     ['X' = b, 'Y' = a, 'Z' = c],
     [in_class_of(c, b), in_class_of(c, a), same_class(b, a)]).
step(in_class_of(c, a), rule(7), ['U' = c, 'X' = a], [sim(c, a)]).
step(sim(c, a), rule(6), ['X' = c, 'Z' = a, 'Y' = b], [sim(c, b), sim(b, a)]).
step(result_query(c, b, a),
     rule(13),
     ['X' = c, 'Y' = b, 'Z' = a],
     [shared_member_shows_same_class(c, b, a), c \== b]).
step(shared_member_shows_same_class(c, b, a),
     rule(10),
     ['X' = c, 'Y' = b, 'Z' = a],
     [in_class_of(a, c), in_class_of(a, b), same_class(c, b)]).
step(result_query(a, b, c),
     rule(13),
     ['X' = a, 'Y' = b, 'Z' = c],
     [shared_member_shows_same_class(a, b, c), a \== b]).
step(shared_member_shows_same_class(a, b, c),
     rule(10),
     ['X' = a, 'Y' = b, 'Z' = c],
     [in_class_of(c, a), in_class_of(c, b), same_class(a, b)]).
step(result_query(a, c, b),
     rule(13),
     ['X' = a, 'Y' = c, 'Z' = b],
     [shared_member_shows_same_class(a, c, b), a \== c]).
step(shared_member_shows_same_class(a, c, b),
     rule(10),
     ['X' = a, 'Y' = c, 'Z' = b],
     [in_class_of(b, a), in_class_of(b, c), same_class(a, c)]).
step(same_class(a, c), rule(8), ['X' = a, 'Y' = c], [sim(a, c)]).
step(a \== c, builtin, [], []).
step(result_query(c, a, b),
     rule(13),
     ['X' = c, 'Y' = a, 'Z' = b],
     [shared_member_shows_same_class(c, a, b), c \== a]).
step(shared_member_shows_same_class(c, a, b),
     rule(10),
     ['X' = c, 'Y' = a, 'Z' = b],
     [in_class_of(b, c), in_class_of(b, a), same_class(c, a)]).
step(same_class(c, a), rule(8), ['X' = c, 'Y' = a], [sim(c, a)]).
step(c \== a, builtin, [], []).
step(result_query(a, c, a),
     rule(13),
     ['X' = a, 'Y' = c, 'Z' = a],
     [shared_member_shows_same_class(a, c, a), a \== c]).
step(shared_member_shows_same_class(a, c, a),
     rule(10),
     ['X' = a, 'Y' = c, 'Z' = a],
     [in_class_of(a, a), in_class_of(a, c), same_class(a, c)]).
step(result_query(c, a, c),
     rule(13),
     ['X' = c, 'Y' = a, 'Z' = c],
     [shared_member_shows_same_class(c, a, c), c \== a]).
step(shared_member_shows_same_class(c, a, c),
     rule(10),
     ['X' = c, 'Y' = a, 'Z' = c],
     [in_class_of(c, c), in_class_of(c, a), same_class(c, a)]).
step(result_query(c, a, a),
     rule(13),
     ['X' = c, 'Y' = a, 'Z' = a],
     [shared_member_shows_same_class(c, a, a), c \== a]).
step(shared_member_shows_same_class(c, a, a),
     rule(10),
     ['X' = c, 'Y' = a, 'Z' = a],
     [in_class_of(a, c), in_class_of(a, a), same_class(c, a)]).
step(result_query(a, c, c),
     rule(13),
     ['X' = a, 'Y' = c, 'Z' = c],
     [shared_member_shows_same_class(a, c, c), a \== c]).
step(shared_member_shows_same_class(a, c, c),
     rule(10),
     ['X' = a, 'Y' = c, 'Z' = c],
     [in_class_of(c, a), in_class_of(c, c), same_class(a, c)]).
