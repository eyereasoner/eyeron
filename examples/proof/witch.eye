# Eyelang result format 2
query(1, [call(witch(?v0))], [binding("x", ?v0)]).
result(1, complete, 1).
answer(1, [binding("x", girl)]).
why(1, [binding("x", girl)], 10).
clause(1, burns(var("x")), [call(is_made_of_wood(var("x")))]).
clause(2, is_made_of_wood(var("x")), [call(floats(var("x")))]).
clause(3, floats(duck), []).
clause(4, floats(var("y")), [call(floats(var("x"))), call(same_weight(var("x"), var("y")))]).
clause(5, same_weight(duck, girl), []).
clause(6, woman(girl), []).
clause(7, witch(var("x")), [call(burns(var("x"))), call(woman(var("x")))]).
substitution(1, []).
proof(1, floats(duck), rule(3), []).
substitution(2, [binding("x", duck)]).
proof(2, is_made_of_wood(duck), rule(2), [uses(1, floats(duck))]).
substitution(3, []).
proof(3, same_weight(duck, girl), rule(5), []).
substitution(4, [binding("x", duck)]).
proof(4, burns(duck), rule(1), [uses(2, is_made_of_wood(duck))]).
substitution(5, [binding("y", girl), binding("x", duck)]).
proof(5, floats(girl), rule(4), [uses(1, floats(duck)), uses(3, same_weight(duck, girl))]).
substitution(6, [binding("x", girl)]).
proof(6, is_made_of_wood(girl), rule(2), [uses(5, floats(girl))]).
substitution(7, [binding("x", girl)]).
proof(7, burns(girl), rule(1), [uses(6, is_made_of_wood(girl))]).
substitution(8, []).
proof(8, woman(girl), rule(6), []).
substitution(9, [binding("x", girl)]).
proof(9, witch(girl), rule(7), [uses(7, burns(girl)), uses(8, woman(girl))]).
substitution(10, [binding("x", girl)]).
proof(10, solution([girl]), query, [uses(9, witch(girl))]).
