% Prolog result format 4
query(1, social(_0), ['Graph' = _0]).
result(1, complete, 1).
answer(1, ['Graph' = g1]).
why(1, ['Graph' = g1], [social(g1)]).
query(2, mentions(_0, _1), ['Graph' = _0, 'Resource' = _1]).
result(2, complete, 5).
answer(2, ['Graph' = g1, 'Resource' = alice]).
why(2, ['Graph' = g1, 'Resource' = alice], [mentions(g1, alice)]).
answer(2, ['Graph' = g2, 'Resource' = alice]).
why(2, ['Graph' = g2, 'Resource' = alice], [mentions(g2, alice)]).
answer(2, ['Graph' = g1, 'Resource' = bob]).
why(2, ['Graph' = g1, 'Resource' = bob], [mentions(g1, bob)]).
answer(2, ['Graph' = g2, 'Resource' = tea]).
why(2, ['Graph' = g2, 'Resource' = tea], [mentions(g2, tea)]).
answer(2, ['Graph' = g1, 'Resource' = carol]).
why(2, ['Graph' = g1, 'Resource' = carol], [mentions(g1, carol)]).

clause(1, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])), true).
clause(2, graph_term(g2, graph([triple(alice, likes, tea)])), true).
clause(4,
       contains(var('Graph'), var('Statement')),
       graph_term(var('Graph'), graph([var('Statement')|var('Rest')]))).
clause(5,
       contains(var('Graph'), var('Statement')),
       (graph_term(var('Graph'), graph([var('First')|var('Rest')])),
        member(var('Statement'), var('Rest')))).
clause(6, member(var('X'), [var('X')|var('Tail')]), true).
clause(8, social(var('Graph')), contains(var('Graph'), triple(var('S'), knows, var('O')))).
clause(9,
       mentions(var('Graph'), var('Subject')),
       contains(var('Graph'), triple(var('Subject'), var('Predicate'), var('Object')))).
clause(10,
       mentions(var('Graph'), var('Object')),
       contains(var('Graph'), triple(var('Subject'), var('Predicate'), var('Object')))).

step(social(g1),
     rule(8),
     ['Graph' = g1, 'S' = alice, 'O' = bob],
     [contains(g1, triple(alice, knows, bob))]).
step(contains(g1, triple(alice, knows, bob)),
     rule(4),
     ['Graph' = g1,
      'Statement' = triple(alice, knows, bob),
      'Rest' = [triple(bob, knows, carol)]],
     [graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)]))]).
step(graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])),
     fact(1),
     [],
     []).
step(mentions(g1, alice),
     rule(9),
     ['Graph' = g1, 'Subject' = alice, 'Predicate' = knows, 'Object' = bob],
     [contains(g1, triple(alice, knows, bob))]).
step(mentions(g2, alice),
     rule(9),
     ['Graph' = g2, 'Subject' = alice, 'Predicate' = likes, 'Object' = tea],
     [contains(g2, triple(alice, likes, tea))]).
step(contains(g2, triple(alice, likes, tea)),
     rule(4),
     ['Graph' = g2, 'Statement' = triple(alice, likes, tea), 'Rest' = []],
     [graph_term(g2, graph([triple(alice, likes, tea)]))]).
step(graph_term(g2, graph([triple(alice, likes, tea)])), fact(2), [], []).
step(mentions(g1, bob),
     rule(10),
     ['Graph' = g1, 'Object' = bob, 'Subject' = alice, 'Predicate' = knows],
     [contains(g1, triple(alice, knows, bob))]).
step(mentions(g2, tea),
     rule(10),
     ['Graph' = g2, 'Object' = tea, 'Subject' = alice, 'Predicate' = likes],
     [contains(g2, triple(alice, likes, tea))]).
step(mentions(g1, carol),
     rule(10),
     ['Graph' = g1, 'Object' = carol, 'Subject' = bob, 'Predicate' = knows],
     [contains(g1, triple(bob, knows, carol))]).
step(contains(g1, triple(bob, knows, carol)),
     rule(5),
     ['Graph' = g1,
      'Statement' = triple(bob, knows, carol),
      'First' = triple(alice, knows, bob),
      'Rest' = [triple(bob, knows, carol)]],
     [graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])),
      member(triple(bob, knows, carol), [triple(bob, knows, carol)])]).
step(member(triple(bob, knows, carol), [triple(bob, knows, carol)]),
     fact(6),
     ['X' = triple(bob, knows, carol), 'Tail' = []],
     []).
