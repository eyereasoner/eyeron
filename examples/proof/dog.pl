% Prolog result format 4
query(1, must_have(_0, _1), ['Person' = _0, 'License' = _1]).
result(1, complete, 1).
answer(1, ['Person' = alice, 'License' = dogLicense]).
why(1, ['Person' = alice, 'License' = dogLicense], [must_have(alice, dogLicense)]).
query(2, dog_count(_0, _1), ['Person' = _0, 'Count' = _1]).
result(2, complete, 2).
answer(2, ['Person' = alice, 'Count' = 5]).
why(2, ['Person' = alice, 'Count' = 5], [dog_count(alice, 5)]).
answer(2, ['Person' = bob, 'Count' = 2]).
why(2, ['Person' = bob, 'Count' = 2], [dog_count(bob, 2)]).

clause(1, has_dog(alice, dog1), true).
clause(2, has_dog(alice, dog2), true).
clause(3, has_dog(alice, dog3), true).
clause(4, has_dog(alice, dog4), true).
clause(5, has_dog(alice, dog5), true).
clause(6, has_dog(bob, dog6), true).
clause(7, has_dog(bob, dog7), true).
clause(8,
       dog_count(var('Person'), var('Count')),
       (has_dog(var('Person'), anonymous(1)),
        findall(var('Dog'), has_dog(var('Person'), var('Dog')), var('Bag1')),
        sort(var('Bag1'), var('Dogs')),
        length(var('Dogs'), var('Count')))).
clause(9,
       must_have(var('Person'), dogLicense),
       (dog_count(var('Person'), var('Count')), var('Count') > 4)).

step(must_have(alice, dogLicense),
     rule(9),
     ['Person' = alice, 'Count' = 5],
     [dog_count(alice, 5), 5 > 4]).
step(dog_count(alice, 5),
     rule(8),
     ['Person' = alice,
      'Count' = 5,
      'Dog' = _0,
      'Bag1' = [dog1, dog2, dog3, dog4, dog5],
      'Dogs' = [dog1, dog2, dog3, dog4, dog5]],
     [has_dog(alice, dog1),
      findall(_1, has_dog(alice, _1), [dog1, dog2, dog3, dog4, dog5]),
      sort([dog1, dog2, dog3, dog4, dog5], [dog1, dog2, dog3, dog4, dog5]),
      length([dog1, dog2, dog3, dog4, dog5], 5)]).
step(has_dog(alice, dog1), fact(1), [], []).
step(findall(_0, has_dog(alice, _0), [dog1, dog2, dog3, dog4, dog5]),
     collected,
     [],
     [has_dog(alice, dog1),
      has_dog(alice, dog2),
      has_dog(alice, dog3),
      has_dog(alice, dog4),
      has_dog(alice, dog5)]).
step(has_dog(alice, dog2), fact(2), [], []).
step(has_dog(alice, dog3), fact(3), [], []).
step(has_dog(alice, dog4), fact(4), [], []).
step(has_dog(alice, dog5), fact(5), [], []).
step(sort([dog1, dog2, dog3, dog4, dog5], [dog1, dog2, dog3, dog4, dog5]), builtin, [], []).
step(length([dog1, dog2, dog3, dog4, dog5], 5), builtin, [], []).
step(5 > 4, builtin, [], []).
step(dog_count(bob, 2),
     rule(8),
     ['Person' = bob, 'Count' = 2, 'Dog' = _0, 'Bag1' = [dog6, dog7], 'Dogs' = [dog6, dog7]],
     [has_dog(bob, dog6),
      findall(_1, has_dog(bob, _1), [dog6, dog7]),
      sort([dog6, dog7], [dog6, dog7]),
      length([dog6, dog7], 2)]).
step(has_dog(bob, dog6), fact(6), [], []).
step(findall(_0, has_dog(bob, _0), [dog6, dog7]),
     collected,
     [],
     [has_dog(bob, dog6), has_dog(bob, dog7)]).
step(has_dog(bob, dog7), fact(7), [], []).
step(sort([dog6, dog7], [dog6, dog7]), builtin, [], []).
step(length([dog6, dog7], 2), builtin, [], []).
