% Prolog result format 4
query(1, query_dependency(1, _0), ['Ancestor' = _0]).
result(1, complete, 2).
answer(1, ['Ancestor' = instance_of(socrates, human)]).
answer(1, ['Ancestor' = subclass_of(human, mortal)]).
query(2, support(1, _0), ['Fact' = _0]).
result(2, complete, 2).
answer(2, ['Fact' = instance_of(socrates, human)]).
answer(2, ['Fact' = subclass_of(human, mortal)]).
query(3, answer_applied(1, _0, _1, _2), ['Conclusion' = _0, 'Name' = _1, 'Value' = _2]).
result(3, complete, 3).
answer(3,
       ['Conclusion' = instance_of(socrates, mortal), 'Name' = 'Individual', 'Value' = socrates]).
answer(3,
       ['Conclusion' = instance_of(socrates, mortal), 'Name' = 'Superclass', 'Value' = mortal]).
answer(3, ['Conclusion' = instance_of(socrates, mortal), 'Name' = 'Class', 'Value' = human]).
