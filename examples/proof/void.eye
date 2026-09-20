# Eyelang result format 2
query(1, [call(made(?v0, ?v1))], [binding("person", ?v0), binding("book", ?v1)]).
result(1, complete, 1).
answer(1, [binding("person", jamesWeatherall), binding("book", book2016)]).
why(1, [binding("person", jamesWeatherall), binding("book", book2016)], 3).
query(2, [call(subject_of(?v0, ?v1))], [binding("person", ?v0), binding("book", ?v1)]).
result(2, complete, 2).
answer(2, [binding("person", isaacNewton), binding("book", book2016)]).
why(2, [binding("person", isaacNewton), binding("book", book2016)], 18).
answer(2, [binding("person", albertEinstein), binding("book", book2016)]).
why(2, [binding("person", albertEinstein), binding("book", book2016)], 19).
query(3, [call(subject(?v0, ?v1))], [binding("book", ?v0), binding("topic", ?v1)]).
result(3, complete, 1).
answer(3, [binding("book", book2016), binding("topic", quantumTheory)]).
why(3, [binding("book", book2016), binding("topic", quantumTheory)], 22).
query(4, [call(recommended_for(?v0, ?v1))], [binding("book", ?v0), binding("reader", ?v1)]).
result(4, complete, 1).
answer(4, [binding("book", book2016), binding("reader", curiousPhysicsReaderEn)]).
why(4, [binding("book", book2016), binding("reader", curiousPhysicsReaderEn)], 27).
clause(1, author(book2016, jamesWeatherall), []).
clause(2, in_language(book2016, en), []).
clause(3, about(book2016, vacuum), []).
clause(4, about(book2016, spaceTime), []).
clause(5, about(book2016, quantumFieldTheory), []).
clause(6, about(book2016, generalRelativity), []).
clause(7, about(book2016, cosmologicalConstant), []).
clause(8, about(book2016, casimirEffect), []).
clause(9, about(book2016, isaacNewton), []).
clause(10, about(book2016, albertEinstein), []).
clause(12, person(isaacNewton), []).
clause(13, person(albertEinstein), []).
clause(14, made(var("person"), var("book")), [call(author(var("book"), var("person")))]).
clause(15, subject_of(var("person"), var("book")), [call(about(var("book"), var("person"))), call(person(var("person")))]).
clause(16, subject(var("book"), quantumTheory), [call(about(var("book"), quantumFieldTheory))]).
clause(17, about(var("book"), darkEnergy), [call(about(var("book"), cosmologicalConstant))]).
clause(18, recommended_for(var("book"), curiousPhysicsReaderEn), [call(subject(var("book"), quantumTheory)), call(in_language(var("book"), en))]).
substitution(1, []).
proof(1, author(book2016, jamesWeatherall), rule(1), []).
substitution(2, [binding("person", jamesWeatherall), binding("book", book2016)]).
proof(2, made(jamesWeatherall, book2016), rule(14), [uses(1, author(book2016, jamesWeatherall))]).
substitution(3, [binding("person", jamesWeatherall), binding("book", book2016)]).
proof(3, solution([jamesWeatherall, book2016]), query, [uses(2, made(jamesWeatherall, book2016))]).
substitution(4, []).
proof(4, about(book2016, vacuum), rule(3), []).
substitution(5, []).
proof(5, about(book2016, spaceTime), rule(4), []).
substitution(6, []).
proof(6, about(book2016, quantumFieldTheory), rule(5), []).
substitution(7, []).
proof(7, about(book2016, generalRelativity), rule(6), []).
substitution(8, []).
proof(8, about(book2016, cosmologicalConstant), rule(7), []).
substitution(9, []).
proof(9, about(book2016, casimirEffect), rule(8), []).
substitution(10, []).
proof(10, about(book2016, isaacNewton), rule(9), []).
substitution(11, []).
proof(11, about(book2016, albertEinstein), rule(10), []).
substitution(12, []).
proof(12, about(book2016, cosmologicalConstant), rule(7), []).
substitution(13, []).
proof(13, person(isaacNewton), rule(12), []).
substitution(14, []).
proof(14, person(albertEinstein), rule(13), []).
substitution(15, [binding("book", book2016)]).
proof(15, about(book2016, darkEnergy), rule(17), [uses(12, about(book2016, cosmologicalConstant))]).
substitution(16, [binding("person", isaacNewton), binding("book", book2016)]).
proof(16, subject_of(isaacNewton, book2016), rule(15), [uses(10, about(book2016, isaacNewton)), uses(13, person(isaacNewton))]).
substitution(17, [binding("person", albertEinstein), binding("book", book2016)]).
proof(17, subject_of(albertEinstein, book2016), rule(15), [uses(11, about(book2016, albertEinstein)), uses(14, person(albertEinstein))]).
substitution(18, [binding("person", isaacNewton), binding("book", book2016)]).
proof(18, solution([isaacNewton, book2016]), query, [uses(16, subject_of(isaacNewton, book2016))]).
substitution(19, [binding("person", albertEinstein), binding("book", book2016)]).
proof(19, solution([albertEinstein, book2016]), query, [uses(17, subject_of(albertEinstein, book2016))]).
substitution(20, []).
proof(20, about(book2016, quantumFieldTheory), rule(5), []).
substitution(21, [binding("book", book2016)]).
proof(21, subject(book2016, quantumTheory), rule(16), [uses(20, about(book2016, quantumFieldTheory))]).
substitution(22, [binding("book", book2016), binding("topic", quantumTheory)]).
proof(22, solution([book2016, quantumTheory]), query, [uses(21, subject(book2016, quantumTheory))]).
substitution(23, []).
proof(23, about(book2016, quantumFieldTheory), rule(5), []).
substitution(24, [binding("book", book2016)]).
proof(24, subject(book2016, quantumTheory), rule(16), [uses(23, about(book2016, quantumFieldTheory))]).
substitution(25, []).
proof(25, in_language(book2016, en), rule(2), []).
substitution(26, [binding("book", book2016)]).
proof(26, recommended_for(book2016, curiousPhysicsReaderEn), rule(18), [uses(24, subject(book2016, quantumTheory)), uses(25, in_language(book2016, en))]).
substitution(27, [binding("book", book2016), binding("reader", curiousPhysicsReaderEn)]).
proof(27, solution([book2016, curiousPhysicsReaderEn]), query, [uses(26, recommended_for(book2016, curiousPhysicsReaderEn))]).
