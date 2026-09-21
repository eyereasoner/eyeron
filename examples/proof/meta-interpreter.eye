# Eyelang result format 2
query(1, [call(demo(ancestor(ann, ?v0)))], [binding("descendant", ?v0)]).
result(1, complete, 2).
answer(1, [binding("descendant", bob)]).
why(1, [binding("descendant", bob)], 6).
answer(1, [binding("descendant", cid)]).
why(1, [binding("descendant", cid)], 11).
query(2, [call(steps(ancestor(ann, cid), ?v0))], [binding("clauses", ?v0)]).
result(2, complete, 1).
answer(2, [binding("clauses", 4)]).
why(2, [binding("clauses", 4)], 21).
query(3, [call(clause(ancestor(?v0, ?v1), ?v2))], [binding("older", ?v0), binding("younger", ?v1), binding("body", ?v2)]).
result(3, complete, 2).
answer(3, [binding("older", ?v0), binding("younger", ?v1), binding("body", [call(parent(?v0, ?v1))])]).
why(3, [binding("older", ?v0), binding("younger", ?v1), binding("body", [call(parent(?v0, ?v1))])], 22).
answer(3, [binding("older", ?v0), binding("younger", ?v1), binding("body", [call(parent(?v0, ?v2)), call(ancestor(?v2, ?v1))])]).
why(3, [binding("older", ?v0), binding("younger", ?v1), binding("body", [call(parent(?v0, ?v2)), call(ancestor(?v2, ?v1))])], 23).
clause(1, parent(ann, bob), []).
clause(2, parent(bob, cid), []).
clause(3, ancestor(var("older"), var("younger")), [call(parent(var("older"), var("younger")))]).
clause(5, solve([]), []).
clause(6, solve([var("goal") | var("rest")]), [call(prove(var("goal"))), call(solve(var("rest")))]).
clause(7, demo(var("head")), [call(clause(var("head"), var("body"))), call(solve(var("body")))]).
clause(8, steps(var("goal"), var("count")), [call(clause(var("goal"), var("body"))), call(stepsAll(var("body"), var("inner"))), calculate(var("count"), binary("+", value(var("inner")), value(1)))]).
clause(9, stepsAll([], 0), []).
clause(10, stepsAll([call(var("goal")) | var("rest")], var("count")), [call(steps(var("goal"), var("here"))), call(stepsAll(var("rest"), var("later"))), calculate(var("count"), binary("+", value(var("here")), value(var("later"))))]).
substitution(1, []).
proof(1, parent(ann, bob), rule(1), []).
substitution(2, []).
proof(2, solve([]), rule(5), []).
substitution(3, [binding("goal", call(parent(ann, bob))), binding("rest", [])]).
proof(3, solve([call(parent(ann, bob))]), rule(6), [uses(1, parent(ann, bob)), uses(2, solve([]))]).
substitution(4, [binding("head", ancestor(ann, bob)), binding("body", [call(parent(ann, bob))])]).
proof(4, demo(ancestor(ann, bob)), rule(7), [builtin(clause(ancestor(ann, bob), [call(parent(ann, bob))])), uses(3, solve([call(parent(ann, bob))]))]).
substitution(5, []).
proof(5, parent(bob, cid), rule(2), []).
substitution(6, [binding("descendant", bob)]).
proof(6, solution([bob]), query, [uses(4, demo(ancestor(ann, bob)))]).
substitution(7, [binding("older", bob), binding("younger", cid)]).
proof(7, ancestor(bob, cid), rule(3), [uses(5, parent(bob, cid))]).
substitution(8, [binding("goal", call(ancestor(bob, cid))), binding("rest", [])]).
proof(8, solve([call(ancestor(bob, cid))]), rule(6), [uses(7, ancestor(bob, cid)), uses(2, solve([]))]).
substitution(9, [binding("goal", call(parent(ann, bob))), binding("rest", [call(ancestor(bob, cid))])]).
proof(9, solve([call(parent(ann, bob)), call(ancestor(bob, cid))]), rule(6), [uses(1, parent(ann, bob)), uses(8, solve([call(ancestor(bob, cid))]))]).
substitution(10, [binding("head", ancestor(ann, cid)), binding("body", [call(parent(ann, bob)), call(ancestor(bob, cid))])]).
proof(10, demo(ancestor(ann, cid)), rule(7), [builtin(clause(ancestor(ann, cid), [call(parent(ann, bob)), call(ancestor(bob, cid))])), uses(9, solve([call(parent(ann, bob)), call(ancestor(bob, cid))]))]).
substitution(11, [binding("descendant", cid)]).
proof(11, solution([cid]), query, [uses(10, demo(ancestor(ann, cid)))]).
substitution(12, []).
proof(12, stepsAll([], 0), rule(9), []).
substitution(13, [binding("goal", parent(ann, bob)), binding("count", 1), binding("body", []), binding("inner", 0)]).
proof(13, steps(parent(ann, bob), 1), rule(8), [builtin(clause(parent(ann, bob), [])), uses(12, stepsAll([], 0)), calculated(1, binary("+", value(0), value(1)))]).
substitution(14, [binding("goal", parent(bob, cid)), binding("count", 1), binding("body", []), binding("inner", 0)]).
proof(14, steps(parent(bob, cid), 1), rule(8), [builtin(clause(parent(bob, cid), [])), uses(12, stepsAll([], 0)), calculated(1, binary("+", value(0), value(1)))]).
substitution(15, [binding("goal", parent(bob, cid)), binding("count", 1), binding("body", []), binding("inner", 0)]).
proof(15, steps(parent(bob, cid), 1), rule(8), [builtin(clause(parent(bob, cid), [])), uses(12, stepsAll([], 0)), calculated(1, binary("+", value(0), value(1)))]).
substitution(16, [binding("goal", parent(bob, cid)), binding("rest", []), binding("count", 1), binding("here", 1), binding("later", 0)]).
proof(16, stepsAll([call(parent(bob, cid))], 1), rule(10), [uses(14, steps(parent(bob, cid), 1)), uses(12, stepsAll([], 0)), calculated(1, binary("+", value(1), value(0)))]).
substitution(17, [binding("goal", ancestor(bob, cid)), binding("count", 2), binding("body", [call(parent(bob, cid))]), binding("inner", 1)]).
proof(17, steps(ancestor(bob, cid), 2), rule(8), [builtin(clause(ancestor(bob, cid), [call(parent(bob, cid))])), uses(16, stepsAll([call(parent(bob, cid))], 1)), calculated(2, binary("+", value(1), value(1)))]).
substitution(18, [binding("goal", ancestor(bob, cid)), binding("rest", []), binding("count", 2), binding("here", 2), binding("later", 0)]).
proof(18, stepsAll([call(ancestor(bob, cid))], 2), rule(10), [uses(17, steps(ancestor(bob, cid), 2)), uses(12, stepsAll([], 0)), calculated(2, binary("+", value(2), value(0)))]).
substitution(19, [binding("goal", parent(ann, bob)), binding("rest", [call(ancestor(bob, cid))]), binding("count", 3), binding("here", 1), binding("later", 2)]).
proof(19, stepsAll([call(parent(ann, bob)), call(ancestor(bob, cid))], 3), rule(10), [uses(13, steps(parent(ann, bob), 1)), uses(18, stepsAll([call(ancestor(bob, cid))], 2)), calculated(3, binary("+", value(1), value(2)))]).
substitution(20, [binding("goal", ancestor(ann, cid)), binding("count", 4), binding("body", [call(parent(ann, bob)), call(ancestor(bob, cid))]), binding("inner", 3)]).
proof(20, steps(ancestor(ann, cid), 4), rule(8), [builtin(clause(ancestor(ann, cid), [call(parent(ann, bob)), call(ancestor(bob, cid))])), uses(19, stepsAll([call(parent(ann, bob)), call(ancestor(bob, cid))], 3)), calculated(4, binary("+", value(3), value(1)))]).
substitution(21, [binding("clauses", 4)]).
proof(21, solution([4]), query, [uses(20, steps(ancestor(ann, cid), 4))]).
substitution(22, [binding("older", ?v0), binding("younger", ?v1), binding("body", [call(parent(?v0, ?v1))])]).
proof(22, solution([?v0, ?v1, [call(parent(?v0, ?v1))]]), query, [builtin(clause(ancestor(?v0, ?v1), [call(parent(?v0, ?v1))]))]).
substitution(23, [binding("older", ?v0), binding("younger", ?v1), binding("body", [call(parent(?v0, ?v2)), call(ancestor(?v2, ?v1))])]).
proof(23, solution([?v0, ?v1, [call(parent(?v0, ?v2)), call(ancestor(?v2, ?v1))]]), query, [builtin(clause(ancestor(?v0, ?v1), [call(parent(?v0, ?v2)), call(ancestor(?v2, ?v1))]))]).
