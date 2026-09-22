% Prolog result format 3
query(1, made(_0, _1), ['Person' = _0, 'Book' = _1]).
result(1, complete, 1).
answer(1, ['Person' = jamesWeatherall, 'Book' = book2016]).
why(1, ['Person' = jamesWeatherall, 'Book' = book2016], 3).
query(2, subject_of(_0, _1), ['Person' = _0, 'Book' = _1]).
result(2, complete, 2).
answer(2, ['Person' = isaacNewton, 'Book' = book2016]).
why(2, ['Person' = isaacNewton, 'Book' = book2016], 18).
answer(2, ['Person' = albertEinstein, 'Book' = book2016]).
why(2, ['Person' = albertEinstein, 'Book' = book2016], 19).
query(3, subject(_0, _1), ['Book' = _0, 'Topic' = _1]).
result(3, complete, 1).
answer(3, ['Book' = book2016, 'Topic' = quantumTheory]).
why(3, ['Book' = book2016, 'Topic' = quantumTheory], 22).
query(4, recommended_for(_0, _1), ['Book' = _0, 'Reader' = _1]).
result(4, complete, 1).
answer(4, ['Book' = book2016, 'Reader' = curiousPhysicsReaderEn]).
why(4, ['Book' = book2016, 'Reader' = curiousPhysicsReaderEn], 27).
clause(1, author(book2016, jamesWeatherall), true).
clause(2, in_language(book2016, en), true).
clause(3, about(book2016, vacuum), true).
clause(4, about(book2016, spaceTime), true).
clause(5, about(book2016, quantumFieldTheory), true).
clause(6, about(book2016, generalRelativity), true).
clause(7, about(book2016, cosmologicalConstant), true).
clause(8, about(book2016, casimirEffect), true).
clause(9, about(book2016, isaacNewton), true).
clause(10, about(book2016, albertEinstein), true).
clause(12, person(isaacNewton), true).
clause(13, person(albertEinstein), true).
clause(14, made(var('Person'), var('Book')), author(var('Book'), var('Person'))).
clause(15, subject_of(var('Person'), var('Book')), (about(var('Book'), var('Person')), person(var('Person')))).
clause(16, subject(var('Book'), quantumTheory), about(var('Book'), quantumFieldTheory)).
clause(17, about(var('Book'), darkEnergy), about(var('Book'), cosmologicalConstant)).
clause(18, recommended_for(var('Book'), curiousPhysicsReaderEn), (subject(var('Book'), quantumTheory), in_language(var('Book'), en))).
substitution(1, []).
proof(1, author(book2016, jamesWeatherall), rule(1), []).
substitution(2, ['Person' = jamesWeatherall, 'Book' = book2016]).
proof(2, made(jamesWeatherall, book2016), rule(14), [uses(1, author(book2016, jamesWeatherall))]).
substitution(3, ['Person' = jamesWeatherall, 'Book' = book2016]).
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
substitution(15, ['Book' = book2016]).
proof(15, about(book2016, darkEnergy), rule(17), [uses(12, about(book2016, cosmologicalConstant))]).
substitution(16, ['Person' = isaacNewton, 'Book' = book2016]).
proof(16, subject_of(isaacNewton, book2016), rule(15), [uses(10, about(book2016, isaacNewton)), uses(13, person(isaacNewton))]).
substitution(17, ['Person' = albertEinstein, 'Book' = book2016]).
proof(17, subject_of(albertEinstein, book2016), rule(15), [uses(11, about(book2016, albertEinstein)), uses(14, person(albertEinstein))]).
substitution(18, ['Person' = isaacNewton, 'Book' = book2016]).
proof(18, solution([isaacNewton, book2016]), query, [uses(16, subject_of(isaacNewton, book2016))]).
substitution(19, ['Person' = albertEinstein, 'Book' = book2016]).
proof(19, solution([albertEinstein, book2016]), query, [uses(17, subject_of(albertEinstein, book2016))]).
substitution(20, []).
proof(20, about(book2016, quantumFieldTheory), rule(5), []).
substitution(21, ['Book' = book2016]).
proof(21, subject(book2016, quantumTheory), rule(16), [uses(20, about(book2016, quantumFieldTheory))]).
substitution(22, ['Book' = book2016, 'Topic' = quantumTheory]).
proof(22, solution([book2016, quantumTheory]), query, [uses(21, subject(book2016, quantumTheory))]).
substitution(23, []).
proof(23, about(book2016, quantumFieldTheory), rule(5), []).
substitution(24, ['Book' = book2016]).
proof(24, subject(book2016, quantumTheory), rule(16), [uses(23, about(book2016, quantumFieldTheory))]).
substitution(25, []).
proof(25, in_language(book2016, en), rule(2), []).
substitution(26, ['Book' = book2016]).
proof(26, recommended_for(book2016, curiousPhysicsReaderEn), rule(18), [uses(24, subject(book2016, quantumTheory)), uses(25, in_language(book2016, en))]).
substitution(27, ['Book' = book2016, 'Reader' = curiousPhysicsReaderEn]).
proof(27, solution([book2016, curiousPhysicsReaderEn]), query, [uses(26, recommended_for(book2016, curiousPhysicsReaderEn))]).
