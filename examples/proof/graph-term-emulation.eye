# Eyelang result format 2
query(1, [call(social(?v0))], [binding("graph", ?v0)]).
result(1, complete, 1).
answer(1, [binding("graph", g1)]).
why(1, [binding("graph", g1)], 7).
query(2, [call(mentions(?v0, ?v1))], [binding("graph", ?v0), binding("resource", ?v1)]).
result(2, complete, 5).
answer(2, [binding("graph", g1), binding("resource", alice)]).
why(2, [binding("graph", g1), binding("resource", alice)], 20).
answer(2, [binding("graph", g2), binding("resource", alice)]).
why(2, [binding("graph", g2), binding("resource", alice)], 21).
answer(2, [binding("graph", g1), binding("resource", bob)]).
why(2, [binding("graph", g1), binding("resource", bob)], 22).
answer(2, [binding("graph", g2), binding("resource", tea)]).
why(2, [binding("graph", g2), binding("resource", tea)], 23).
answer(2, [binding("graph", g1), binding("resource", carol)]).
why(2, [binding("graph", g1), binding("resource", carol)], 26).
clause(1, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])), []).
clause(2, graph_term(g2, graph([triple(alice, likes, tea)])), []).
clause(4, contains(var("graph"), var("statement")), [call(graph_term(var("graph"), graph([var("statement") | var("rest")])))]).
clause(5, contains(var("graph"), var("statement")), [call(graph_term(var("graph"), graph([var("first") | var("rest")]))), call(member(var("statement"), var("rest")))]).
clause(6, member(var("x"), [var("x") | var("tail")]), []).
clause(8, social(var("graph")), [call(contains(var("graph"), triple(var("s"), knows, var("o"))))]).
clause(9, mentions(var("graph"), var("subject")), [call(contains(var("graph"), triple(var("subject"), var("predicate"), var("object"))))]).
clause(10, mentions(var("graph"), var("object")), [call(contains(var("graph"), triple(var("subject"), var("predicate"), var("object"))))]).
substitution(1, []).
proof(1, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])), rule(1), []).
substitution(2, []).
proof(2, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])), rule(1), []).
substitution(3, []).
proof(3, graph_term(g2, graph([triple(alice, likes, tea)])), rule(2), []).
substitution(4, [binding("graph", g1), binding("statement", triple(alice, knows, bob)), binding("rest", [triple(bob, knows, carol)])]).
proof(4, contains(g1, triple(alice, knows, bob)), rule(4), [uses(1, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])))]).
substitution(5, [binding("graph", g1), binding("s", alice), binding("o", bob)]).
proof(5, social(g1), rule(8), [uses(4, contains(g1, triple(alice, knows, bob)))]).
substitution(6, [binding("x", triple(bob, knows, carol)), binding("tail", [])]).
proof(6, member(triple(bob, knows, carol), [triple(bob, knows, carol)]), rule(6), []).
substitution(7, [binding("graph", g1)]).
proof(7, solution([g1]), query, [uses(5, social(g1))]).
substitution(8, [binding("graph", g1), binding("statement", triple(bob, knows, carol)), binding("first", triple(alice, knows, bob)), binding("rest", [triple(bob, knows, carol)])]).
proof(8, contains(g1, triple(bob, knows, carol)), rule(5), [uses(2, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)]))), uses(6, member(triple(bob, knows, carol), [triple(bob, knows, carol)]))]).
substitution(9, []).
proof(9, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])), rule(1), []).
substitution(10, []).
proof(10, graph_term(g2, graph([triple(alice, likes, tea)])), rule(2), []).
substitution(11, []).
proof(11, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])), rule(1), []).
substitution(12, []).
proof(12, graph_term(g2, graph([triple(alice, likes, tea)])), rule(2), []).
substitution(13, [binding("graph", g1), binding("statement", triple(alice, knows, bob)), binding("rest", [triple(bob, knows, carol)])]).
proof(13, contains(g1, triple(alice, knows, bob)), rule(4), [uses(9, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)])))]).
substitution(14, [binding("graph", g2), binding("statement", triple(alice, likes, tea)), binding("rest", [])]).
proof(14, contains(g2, triple(alice, likes, tea)), rule(4), [uses(10, graph_term(g2, graph([triple(alice, likes, tea)])))]).
substitution(15, [binding("graph", g1), binding("subject", alice), binding("predicate", knows), binding("object", bob)]).
proof(15, mentions(g1, alice), rule(9), [uses(13, contains(g1, triple(alice, knows, bob)))]).
substitution(16, [binding("graph", g2), binding("subject", alice), binding("predicate", likes), binding("object", tea)]).
proof(16, mentions(g2, alice), rule(9), [uses(14, contains(g2, triple(alice, likes, tea)))]).
substitution(17, [binding("graph", g1), binding("object", bob), binding("subject", alice), binding("predicate", knows)]).
proof(17, mentions(g1, bob), rule(10), [uses(13, contains(g1, triple(alice, knows, bob)))]).
substitution(18, [binding("graph", g2), binding("object", tea), binding("subject", alice), binding("predicate", likes)]).
proof(18, mentions(g2, tea), rule(10), [uses(14, contains(g2, triple(alice, likes, tea)))]).
substitution(19, [binding("x", triple(bob, knows, carol)), binding("tail", [])]).
proof(19, member(triple(bob, knows, carol), [triple(bob, knows, carol)]), rule(6), []).
substitution(20, [binding("graph", g1), binding("resource", alice)]).
proof(20, solution([g1, alice]), query, [uses(15, mentions(g1, alice))]).
substitution(21, [binding("graph", g2), binding("resource", alice)]).
proof(21, solution([g2, alice]), query, [uses(16, mentions(g2, alice))]).
substitution(22, [binding("graph", g1), binding("resource", bob)]).
proof(22, solution([g1, bob]), query, [uses(17, mentions(g1, bob))]).
substitution(23, [binding("graph", g2), binding("resource", tea)]).
proof(23, solution([g2, tea]), query, [uses(18, mentions(g2, tea))]).
substitution(24, [binding("graph", g1), binding("statement", triple(bob, knows, carol)), binding("first", triple(alice, knows, bob)), binding("rest", [triple(bob, knows, carol)])]).
proof(24, contains(g1, triple(bob, knows, carol)), rule(5), [uses(11, graph_term(g1, graph([triple(alice, knows, bob), triple(bob, knows, carol)]))), uses(19, member(triple(bob, knows, carol), [triple(bob, knows, carol)]))]).
substitution(25, [binding("graph", g1), binding("object", carol), binding("subject", bob), binding("predicate", knows)]).
proof(25, mentions(g1, carol), rule(10), [uses(24, contains(g1, triple(bob, knows, carol)))]).
substitution(26, [binding("graph", g1), binding("resource", carol)]).
proof(26, solution([g1, carol]), query, [uses(25, mentions(g1, carol))]).
