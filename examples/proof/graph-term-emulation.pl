% Prolog result format 3
query(1, social(_0), ['Graph' = _0]).
result(1, complete, 1).
answer(1, ['Graph' = g1]).
why(1, ['Graph' = g1], 7).
query(2, mentions(_0, _1), ['Graph' = _0, 'Resource' = _1]).
result(2, complete, 5).
answer(2, ['Graph' = g1, 'Resource' = alice]).
why(2, ['Graph' = g1, 'Resource' = alice], 20).
answer(2, ['Graph' = g2, 'Resource' = alice]).
why(2, ['Graph' = g2, 'Resource' = alice], 21).
answer(2, ['Graph' = g1, 'Resource' = bob]).
why(2, ['Graph' = g1, 'Resource' = bob], 22).
answer(2, ['Graph' = g2, 'Resource' = tea]).
why(2, ['Graph' = g2, 'Resource' = tea], 23).
answer(2, ['Graph' = g1, 'Resource' = carol]).
why(2, ['Graph' = g1, 'Resource' = carol], 26).
clause(1, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])), true).
clause(2, graph_term(g2, graph([triple(alice, likes, tea)])), true).
clause(4, contains(var('Graph'), var('Statement')), graph_term(var('Graph'), graph([var('Statement')|var('Rest')]))).
clause(5, contains(var('Graph'), var('Statement')), (graph_term(var('Graph'), graph([var('First')|var('Rest')])), member(var('Statement'), var('Rest')))).
clause(6, member(var('X'), [var('X')|var('Tail')]), true).
clause(8, social(var('Graph')), contains(var('Graph'), triple(var('S'), knows, var('O')))).
clause(9, mentions(var('Graph'), var('Subject')), contains(var('Graph'), triple(var('Subject'), var('Predicate'), var('Object')))).
clause(10, mentions(var('Graph'), var('Object')), contains(var('Graph'), triple(var('Subject'), var('Predicate'), var('Object')))).
substitution(1, []).
proof(1, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])), rule(1), []).
substitution(2, []).
proof(2, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])), rule(1), []).
substitution(3, []).
proof(3, graph_term(g2, graph([triple(alice, likes, tea)])), rule(2), []).
substitution(4, ['Graph' = g1, 'Statement' = triple(alice, knows, bob), 'Rest' = [triple(bob, knows, carol)]]).
proof(4, contains(g1, triple(alice, knows, bob)), rule(4), [uses(1, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])))]).
substitution(5, ['Graph' = g1, 'S' = alice, 'O' = bob]).
proof(5, social(g1), rule(8), [uses(4, contains(g1, triple(alice, knows, bob)))]).
substitution(6, ['X' = triple(bob, knows, carol), 'Tail' = []]).
proof(6, member(triple(bob, knows, carol), [triple(bob, knows, carol)]), rule(6), []).
substitution(7, ['Graph' = g1]).
proof(7, solution([g1]), query, [uses(5, social(g1))]).
substitution(8, ['Graph' = g1, 'Statement' = triple(bob, knows, carol), 'First' = triple(alice, knows, bob), 'Rest' = [triple(bob, knows, carol)]]).
proof(8, contains(g1, triple(bob, knows, carol)), rule(5), [uses(2, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)]))), uses(6, member(triple(bob, knows, carol), [triple(bob, knows, carol)]))]).
substitution(9, []).
proof(9, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])), rule(1), []).
substitution(10, []).
proof(10, graph_term(g2, graph([triple(alice, likes, tea)])), rule(2), []).
substitution(11, []).
proof(11, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])), rule(1), []).
substitution(12, []).
proof(12, graph_term(g2, graph([triple(alice, likes, tea)])), rule(2), []).
substitution(13, ['Graph' = g1, 'Statement' = triple(alice, knows, bob), 'Rest' = [triple(bob, knows, carol)]]).
proof(13, contains(g1, triple(alice, knows, bob)), rule(4), [uses(9, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])))]).
substitution(14, ['Graph' = g2, 'Statement' = triple(alice, likes, tea), 'Rest' = []]).
proof(14, contains(g2, triple(alice, likes, tea)), rule(4), [uses(10, graph_term(g2, graph([triple(alice, likes, tea)])))]).
substitution(15, ['Graph' = g1, 'Subject' = alice, 'Predicate' = knows, 'Object' = bob]).
proof(15, mentions(g1, alice), rule(9), [uses(13, contains(g1, triple(alice, knows, bob)))]).
substitution(16, ['Graph' = g2, 'Subject' = alice, 'Predicate' = likes, 'Object' = tea]).
proof(16, mentions(g2, alice), rule(9), [uses(14, contains(g2, triple(alice, likes, tea)))]).
substitution(17, ['Graph' = g1, 'Object' = bob, 'Subject' = alice, 'Predicate' = knows]).
proof(17, mentions(g1, bob), rule(10), [uses(13, contains(g1, triple(alice, knows, bob)))]).
substitution(18, ['Graph' = g2, 'Object' = tea, 'Subject' = alice, 'Predicate' = likes]).
proof(18, mentions(g2, tea), rule(10), [uses(14, contains(g2, triple(alice, likes, tea)))]).
substitution(19, ['X' = triple(bob, knows, carol), 'Tail' = []]).
proof(19, member(triple(bob, knows, carol), [triple(bob, knows, carol)]), rule(6), []).
substitution(20, ['Graph' = g1, 'Resource' = alice]).
proof(20, solution([g1, alice]), query, [uses(15, mentions(g1, alice))]).
substitution(21, ['Graph' = g2, 'Resource' = alice]).
proof(21, solution([g2, alice]), query, [uses(16, mentions(g2, alice))]).
substitution(22, ['Graph' = g1, 'Resource' = bob]).
proof(22, solution([g1, bob]), query, [uses(17, mentions(g1, bob))]).
substitution(23, ['Graph' = g2, 'Resource' = tea]).
proof(23, solution([g2, tea]), query, [uses(18, mentions(g2, tea))]).
substitution(24, ['Graph' = g1, 'Statement' = triple(bob, knows, carol), 'First' = triple(alice, knows, bob), 'Rest' = [triple(bob, knows, carol)]]).
proof(24, contains(g1, triple(bob, knows, carol)), rule(5), [uses(11, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)]))), uses(19, member(triple(bob, knows, carol), [triple(bob, knows, carol)]))]).
substitution(25, ['Graph' = g1, 'Object' = carol, 'Subject' = bob, 'Predicate' = knows]).
proof(25, mentions(g1, carol), rule(10), [uses(24, contains(g1, triple(bob, knows, carol)))]).
substitution(26, ['Graph' = g1, 'Resource' = carol]).
proof(26, solution([g1, carol]), query, [uses(25, mentions(g1, carol))]).
