solution([goat, nothing, wolf, goat, cabbage, nothing, goat]).
solution([goat, nothing, cabbage, goat, wolf, nothing, goat]).

clause(3, change(e, w), true).
clause(4, change(w, e), true).
clause(5,
       move([var('X'), var('X'), var('Goat'), var('Cabbage')], wolf, [var('Y'), var('Y'), var('Goat'), var('Cabbage')]),
       change(var('X'), var('Y'))).
clause(6,
       move([var('X'), var('Wolf'), var('X'), var('Cabbage')], goat, [var('Y'), var('Wolf'), var('Y'), var('Cabbage')]),
       change(var('X'), var('Y'))).
clause(7,
       move([var('X'), var('Wolf'), var('Goat'), var('X')], cabbage, [var('Y'), var('Wolf'), var('Goat'), var('Y')]),
       change(var('X'), var('Y'))).
clause(8,
       move([var('X'), var('Wolf'), var('Goat'), var('Cabbage')], nothing, [var('Y'), var('Wolf'), var('Goat'), var('Cabbage')]),
       change(var('X'), var('Y'))).
clause(9, one_equal(var('X'), var('X'), anonymous(1)), true).
clause(10, one_equal(var('X'), anonymous(1), var('X')), true).
clause(11,
       safe([var('Person'), var('Wolf'), var('Goat'), var('Cabbage')]),
       (one_equal(var('Person'), var('Goat'), var('Wolf')),
        one_equal(var('Person'), var('Goat'), var('Cabbage')))).
clause(12, solve(var('Goal'), var('Goal'), anonymous(1), []), true).
clause(13,
       solve(var('State'), var('Goal'), var('Visited'), [var('Move')|var('Rest')]),
       (move(var('State'), var('Move'), var('Next')),
        safe(var('Next')),
        \+member(var('Next'), var('Visited')),
        solve(var('Next'), var('Goal'), [var('Next')|var('Visited')], var('Rest')))).
clause(14,
       solution(var('Moves')),
       (solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], var('Moves')),
        length(var('Moves'), 7))).

step(solution([goat, nothing, wolf, goat, cabbage, nothing, goat]),
     rule(14),
     ['Moves' = [goat, nothing, wolf, goat, cabbage, nothing, goat]],
     [solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], [goat, nothing, wolf, goat, cabbage, nothing, goat]),
      length([goat, nothing, wolf, goat, cabbage, nothing, goat], 7)]).
step(solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], [goat, nothing, wolf, goat, cabbage, nothing, goat]),
     rule(13),
     ['State' = [w, w, w, w],
      'Goal' = [e, e, e, e],
      'Visited' = [[w, w, w, w]],
      'Move' = goat,
      'Rest' = [nothing, wolf, goat, cabbage, nothing, goat],
      'Next' = [e, w, e, w]],
     [move([w, w, w, w], goat, [e, w, e, w]),
      safe([e, w, e, w]),
      \+member([e, w, e, w], [[w, w, w, w]]),
      solve([e, w, e, w], [e, e, e, e], [[e, w, e, w], [w, w, w, w]], [nothing, wolf, goat, cabbage, nothing, goat])]).
step(move([w, w, w, w], goat, [e, w, e, w]),
     rule(6),
     ['X' = w, 'Wolf' = w, 'Cabbage' = w, 'Y' = e],
     [change(w, e)]).
step(change(w, e), fact(4), [], []).
step(safe([e, w, e, w]),
     rule(11),
     ['Person' = e, 'Wolf' = w, 'Goat' = e, 'Cabbage' = w],
     [one_equal(e, e, w), one_equal(e, e, w)]).
step(one_equal(e, e, w), fact(9), ['X' = e], []).
step(\+member([e, w, e, w], [[w, w, w, w]]), absent, [], []).
step(solve([e, w, e, w], [e, e, e, e], [[e, w, e, w], [w, w, w, w]], [nothing, wolf, goat, cabbage, nothing, goat]),
     rule(13),
     ['State' = [e, w, e, w],
      'Goal' = [e, e, e, e],
      'Visited' = [[e, w, e, w], [w, w, w, w]],
      'Move' = nothing,
      'Rest' = [wolf, goat, cabbage, nothing, goat],
      'Next' = [w, w, e, w]],
     [move([e, w, e, w], nothing, [w, w, e, w]),
      safe([w, w, e, w]),
      \+member([w, w, e, w], [[e, w, e, w], [w, w, w, w]]),
      solve([w, w, e, w], [e, e, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]], [wolf, goat, cabbage, nothing, goat])]).
step(move([e, w, e, w], nothing, [w, w, e, w]),
     rule(8),
     ['X' = e, 'Wolf' = w, 'Goat' = e, 'Cabbage' = w, 'Y' = w],
     [change(e, w)]).
step(change(e, w), fact(3), [], []).
step(safe([w, w, e, w]),
     rule(11),
     ['Person' = w, 'Wolf' = w, 'Goat' = e, 'Cabbage' = w],
     [one_equal(w, e, w), one_equal(w, e, w)]).
step(one_equal(w, e, w), fact(10), ['X' = w], []).
step(\+member([w, w, e, w], [[e, w, e, w], [w, w, w, w]]), absent, [], []).
step(solve([w, w, e, w], [e, e, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]], [wolf, goat, cabbage, nothing, goat]),
     rule(13),
     ['State' = [w, w, e, w],
      'Goal' = [e, e, e, e],
      'Visited' = [[w, w, e, w], [e, w, e, w], [w, w, w, w]],
      'Move' = wolf,
      'Rest' = [goat, cabbage, nothing, goat],
      'Next' = [e, e, e, w]],
     [move([w, w, e, w], wolf, [e, e, e, w]),
      safe([e, e, e, w]),
      \+member([e, e, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]),
      solve([e, e, e, w], [e, e, e, e], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat, cabbage, nothing, goat])]).
step(move([w, w, e, w], wolf, [e, e, e, w]),
     rule(5),
     ['X' = w, 'Goat' = e, 'Cabbage' = w, 'Y' = e],
     [change(w, e)]).
step(safe([e, e, e, w]),
     rule(11),
     ['Person' = e, 'Wolf' = e, 'Goat' = e, 'Cabbage' = w],
     [one_equal(e, e, e), one_equal(e, e, w)]).
step(one_equal(e, e, e), fact(9), ['X' = e], []).
step(\+member([e, e, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), absent, [], []).
step(solve([e, e, e, w], [e, e, e, e], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat, cabbage, nothing, goat]),
     rule(13),
     ['State' = [e, e, e, w],
      'Goal' = [e, e, e, e],
      'Visited' = [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]],
      'Move' = goat,
      'Rest' = [cabbage, nothing, goat],
      'Next' = [w, e, w, w]],
     [move([e, e, e, w], goat, [w, e, w, w]),
      safe([w, e, w, w]),
      \+member([w, e, w, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
      solve([w, e, w, w], [e, e, e, e], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [cabbage, nothing, goat])]).
step(move([e, e, e, w], goat, [w, e, w, w]),
     rule(6),
     ['X' = e, 'Wolf' = e, 'Cabbage' = w, 'Y' = w],
     [change(e, w)]).
step(safe([w, e, w, w]),
     rule(11),
     ['Person' = w, 'Wolf' = e, 'Goat' = w, 'Cabbage' = w],
     [one_equal(w, w, e), one_equal(w, w, w)]).
step(one_equal(w, w, e), fact(9), ['X' = w], []).
step(one_equal(w, w, w), fact(9), ['X' = w], []).
step(\+member([w, e, w, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
     absent,
     [],
     []).
step(solve([w, e, w, w], [e, e, e, e], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [cabbage, nothing, goat]),
     rule(13),
     ['State' = [w, e, w, w],
      'Goal' = [e, e, e, e],
      'Visited' = [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]],
      'Move' = cabbage,
      'Rest' = [nothing, goat],
      'Next' = [e, e, w, e]],
     [move([w, e, w, w], cabbage, [e, e, w, e]),
      safe([e, e, w, e]),
      \+member([e, e, w, e], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
      solve([e, e, w, e], [e, e, e, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [nothing, goat])]).
step(move([w, e, w, w], cabbage, [e, e, w, e]),
     rule(7),
     ['X' = w, 'Wolf' = e, 'Goat' = w, 'Y' = e],
     [change(w, e)]).
step(safe([e, e, w, e]),
     rule(11),
     ['Person' = e, 'Wolf' = e, 'Goat' = w, 'Cabbage' = e],
     [one_equal(e, w, e), one_equal(e, w, e)]).
step(one_equal(e, w, e), fact(10), ['X' = e], []).
step(\+member([e, e, w, e], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
     absent,
     [],
     []).
step(solve([e, e, w, e], [e, e, e, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [nothing, goat]),
     rule(13),
     ['State' = [e, e, w, e],
      'Goal' = [e, e, e, e],
      'Visited' = [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]],
      'Move' = nothing,
      'Rest' = [goat],
      'Next' = [w, e, w, e]],
     [move([e, e, w, e], nothing, [w, e, w, e]),
      safe([w, e, w, e]),
      \+member([w, e, w, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
      solve([w, e, w, e], [e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat])]).
step(move([e, e, w, e], nothing, [w, e, w, e]),
     rule(8),
     ['X' = e, 'Wolf' = e, 'Goat' = w, 'Cabbage' = e, 'Y' = w],
     [change(e, w)]).
step(safe([w, e, w, e]),
     rule(11),
     ['Person' = w, 'Wolf' = e, 'Goat' = w, 'Cabbage' = e],
     [one_equal(w, w, e), one_equal(w, w, e)]).
step(\+member([w, e, w, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
     absent,
     [],
     []).
step(solve([w, e, w, e], [e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat]),
     rule(13),
     ['State' = [w, e, w, e],
      'Goal' = [e, e, e, e],
      'Visited' = [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]],
      'Move' = goat,
      'Rest' = [],
      'Next' = [e, e, e, e]],
     [move([w, e, w, e], goat, [e, e, e, e]),
      safe([e, e, e, e]),
      \+member([e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
      solve([e, e, e, e], [e, e, e, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [])]).
step(move([w, e, w, e], goat, [e, e, e, e]),
     rule(6),
     ['X' = w, 'Wolf' = e, 'Cabbage' = e, 'Y' = e],
     [change(w, e)]).
step(safe([e, e, e, e]),
     rule(11),
     ['Person' = e, 'Wolf' = e, 'Goat' = e, 'Cabbage' = e],
     [one_equal(e, e, e), one_equal(e, e, e)]).
step(\+member([e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
     absent,
     [],
     []).
step(solve([e, e, e, e], [e, e, e, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], []),
     fact(12),
     ['Goal' = [e, e, e, e]],
     []).
step(length([goat, nothing, wolf, goat, cabbage, nothing, goat], 7), builtin, [], []).
step(solution([goat, nothing, cabbage, goat, wolf, nothing, goat]),
     rule(14),
     ['Moves' = [goat, nothing, cabbage, goat, wolf, nothing, goat]],
     [solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], [goat, nothing, cabbage, goat, wolf, nothing, goat]),
      length([goat, nothing, cabbage, goat, wolf, nothing, goat], 7)]).
step(solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], [goat, nothing, cabbage, goat, wolf, nothing, goat]),
     rule(13),
     ['State' = [w, w, w, w],
      'Goal' = [e, e, e, e],
      'Visited' = [[w, w, w, w]],
      'Move' = goat,
      'Rest' = [nothing, cabbage, goat, wolf, nothing, goat],
      'Next' = [e, w, e, w]],
     [move([w, w, w, w], goat, [e, w, e, w]),
      safe([e, w, e, w]),
      \+member([e, w, e, w], [[w, w, w, w]]),
      solve([e, w, e, w], [e, e, e, e], [[e, w, e, w], [w, w, w, w]], [nothing, cabbage, goat, wolf, nothing, goat])]).
step(solve([e, w, e, w], [e, e, e, e], [[e, w, e, w], [w, w, w, w]], [nothing, cabbage, goat, wolf, nothing, goat]),
     rule(13),
     ['State' = [e, w, e, w],
      'Goal' = [e, e, e, e],
      'Visited' = [[e, w, e, w], [w, w, w, w]],
      'Move' = nothing,
      'Rest' = [cabbage, goat, wolf, nothing, goat],
      'Next' = [w, w, e, w]],
     [move([e, w, e, w], nothing, [w, w, e, w]),
      safe([w, w, e, w]),
      \+member([w, w, e, w], [[e, w, e, w], [w, w, w, w]]),
      solve([w, w, e, w], [e, e, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]], [cabbage, goat, wolf, nothing, goat])]).
step(solve([w, w, e, w], [e, e, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]], [cabbage, goat, wolf, nothing, goat]),
     rule(13),
     ['State' = [w, w, e, w],
      'Goal' = [e, e, e, e],
      'Visited' = [[w, w, e, w], [e, w, e, w], [w, w, w, w]],
      'Move' = cabbage,
      'Rest' = [goat, wolf, nothing, goat],
      'Next' = [e, w, e, e]],
     [move([w, w, e, w], cabbage, [e, w, e, e]),
      safe([e, w, e, e]),
      \+member([e, w, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]),
      solve([e, w, e, e], [e, e, e, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat, wolf, nothing, goat])]).
step(move([w, w, e, w], cabbage, [e, w, e, e]),
     rule(7),
     ['X' = w, 'Wolf' = w, 'Goat' = e, 'Y' = e],
     [change(w, e)]).
step(safe([e, w, e, e]),
     rule(11),
     ['Person' = e, 'Wolf' = w, 'Goat' = e, 'Cabbage' = e],
     [one_equal(e, e, w), one_equal(e, e, e)]).
step(\+member([e, w, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), absent, [], []).
step(solve([e, w, e, e], [e, e, e, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat, wolf, nothing, goat]),
     rule(13),
     ['State' = [e, w, e, e],
      'Goal' = [e, e, e, e],
      'Visited' = [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]],
      'Move' = goat,
      'Rest' = [wolf, nothing, goat],
      'Next' = [w, w, w, e]],
     [move([e, w, e, e], goat, [w, w, w, e]),
      safe([w, w, w, e]),
      \+member([w, w, w, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
      solve([w, w, w, e], [e, e, e, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [wolf, nothing, goat])]).
step(move([e, w, e, e], goat, [w, w, w, e]),
     rule(6),
     ['X' = e, 'Wolf' = w, 'Cabbage' = e, 'Y' = w],
     [change(e, w)]).
step(safe([w, w, w, e]),
     rule(11),
     ['Person' = w, 'Wolf' = w, 'Goat' = w, 'Cabbage' = e],
     [one_equal(w, w, w), one_equal(w, w, e)]).
step(\+member([w, w, w, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
     absent,
     [],
     []).
step(solve([w, w, w, e], [e, e, e, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [wolf, nothing, goat]),
     rule(13),
     ['State' = [w, w, w, e],
      'Goal' = [e, e, e, e],
      'Visited' = [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]],
      'Move' = wolf,
      'Rest' = [nothing, goat],
      'Next' = [e, e, w, e]],
     [move([w, w, w, e], wolf, [e, e, w, e]),
      safe([e, e, w, e]),
      \+member([e, e, w, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
      solve([e, e, w, e], [e, e, e, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [nothing, goat])]).
step(move([w, w, w, e], wolf, [e, e, w, e]),
     rule(5),
     ['X' = w, 'Goat' = w, 'Cabbage' = e, 'Y' = e],
     [change(w, e)]).
step(\+member([e, e, w, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
     absent,
     [],
     []).
step(solve([e, e, w, e], [e, e, e, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [nothing, goat]),
     rule(13),
     ['State' = [e, e, w, e],
      'Goal' = [e, e, e, e],
      'Visited' = [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]],
      'Move' = nothing,
      'Rest' = [goat],
      'Next' = [w, e, w, e]],
     [move([e, e, w, e], nothing, [w, e, w, e]),
      safe([w, e, w, e]),
      \+member([w, e, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
      solve([w, e, w, e], [e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat])]).
step(\+member([w, e, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
     absent,
     [],
     []).
step(solve([w, e, w, e], [e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat]),
     rule(13),
     ['State' = [w, e, w, e],
      'Goal' = [e, e, e, e],
      'Visited' = [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]],
      'Move' = goat,
      'Rest' = [],
      'Next' = [e, e, e, e]],
     [move([w, e, w, e], goat, [e, e, e, e]),
      safe([e, e, e, e]),
      \+member([e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
      solve([e, e, e, e], [e, e, e, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [])]).
step(\+member([e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]),
     absent,
     [],
     []).
step(solve([e, e, e, e], [e, e, e, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], []),
     fact(12),
     ['Goal' = [e, e, e, e]],
     []).
step(length([goat, nothing, cabbage, goat, wolf, nothing, goat], 7), builtin, [], []).
