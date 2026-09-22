% Prolog result format 4
query(1, made(_0, _1), ['Person' = _0, 'Book' = _1]).
result(1, complete, 1).
answer(1, ['Person' = jamesWeatherall, 'Book' = book2016]).
query(2, subject_of(_0, _1), ['Person' = _0, 'Book' = _1]).
result(2, complete, 2).
answer(2, ['Person' = isaacNewton, 'Book' = book2016]).
answer(2, ['Person' = albertEinstein, 'Book' = book2016]).
query(3, subject(_0, _1), ['Book' = _0, 'Topic' = _1]).
result(3, complete, 1).
answer(3, ['Book' = book2016, 'Topic' = quantumTheory]).
query(4, recommended_for(_0, _1), ['Book' = _0, 'Reader' = _1]).
result(4, complete, 1).
answer(4, ['Book' = book2016, 'Reader' = curiousPhysicsReaderEn]).
