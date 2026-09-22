% Prolog result format 4
query(1, made(_0, _1), ['Person' = _0, 'Book' = _1]).
result(1, complete, 1).
answer(1, ['Person' = jamesWeatherall, 'Book' = book2016]).
why(1, ['Person' = jamesWeatherall, 'Book' = book2016], [made(jamesWeatherall, book2016)]).
query(2, subject_of(_0, _1), ['Person' = _0, 'Book' = _1]).
result(2, complete, 2).
answer(2, ['Person' = isaacNewton, 'Book' = book2016]).
why(2, ['Person' = isaacNewton, 'Book' = book2016], [subject_of(isaacNewton, book2016)]).
answer(2, ['Person' = albertEinstein, 'Book' = book2016]).
why(2, ['Person' = albertEinstein, 'Book' = book2016], [subject_of(albertEinstein, book2016)]).
query(3, subject(_0, _1), ['Book' = _0, 'Topic' = _1]).
result(3, complete, 1).
answer(3, ['Book' = book2016, 'Topic' = quantumTheory]).
why(3, ['Book' = book2016, 'Topic' = quantumTheory], [subject(book2016, quantumTheory)]).
query(4, recommended_for(_0, _1), ['Book' = _0, 'Reader' = _1]).
result(4, complete, 1).
answer(4, ['Book' = book2016, 'Reader' = curiousPhysicsReaderEn]).
why(4,
    ['Book' = book2016, 'Reader' = curiousPhysicsReaderEn],
    [recommended_for(book2016, curiousPhysicsReaderEn)]).

clause(1, author(book2016, jamesWeatherall), true).
clause(2, in_language(book2016, en), true).
clause(5, about(book2016, quantumFieldTheory), true).
clause(9, about(book2016, isaacNewton), true).
clause(10, about(book2016, albertEinstein), true).
clause(12, person(isaacNewton), true).
clause(13, person(albertEinstein), true).
clause(14, made(var('Person'), var('Book')), author(var('Book'), var('Person'))).
clause(15,
       subject_of(var('Person'), var('Book')),
       (about(var('Book'), var('Person')), person(var('Person')))).
clause(16, subject(var('Book'), quantumTheory), about(var('Book'), quantumFieldTheory)).
clause(18,
       recommended_for(var('Book'), curiousPhysicsReaderEn),
       (subject(var('Book'), quantumTheory), in_language(var('Book'), en))).

step(made(jamesWeatherall, book2016),
     rule(14),
     ['Person' = jamesWeatherall, 'Book' = book2016],
     [author(book2016, jamesWeatherall)]).
step(author(book2016, jamesWeatherall), fact(1), [], []).
step(subject_of(isaacNewton, book2016),
     rule(15),
     ['Person' = isaacNewton, 'Book' = book2016],
     [about(book2016, isaacNewton), person(isaacNewton)]).
step(about(book2016, isaacNewton), fact(9), [], []).
step(person(isaacNewton), fact(12), [], []).
step(subject_of(albertEinstein, book2016),
     rule(15),
     ['Person' = albertEinstein, 'Book' = book2016],
     [about(book2016, albertEinstein), person(albertEinstein)]).
step(about(book2016, albertEinstein), fact(10), [], []).
step(person(albertEinstein), fact(13), [], []).
step(subject(book2016, quantumTheory),
     rule(16),
     ['Book' = book2016],
     [about(book2016, quantumFieldTheory)]).
step(about(book2016, quantumFieldTheory), fact(5), [], []).
step(recommended_for(book2016, curiousPhysicsReaderEn),
     rule(18),
     ['Book' = book2016],
     [subject(book2016, quantumTheory), in_language(book2016, en)]).
step(in_language(book2016, en), fact(2), [], []).
