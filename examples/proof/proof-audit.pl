% Prolog result format 4
query(1, query_dependency(1, _0), ['Ancestor' = _0]).
result(1, complete, 2).
answer(1, ['Ancestor' = instance_of(socrates, human)]).
why(1,
    ['Ancestor' = instance_of(socrates, human)],
    [query_dependency(1, instance_of(socrates, human))]).
answer(1, ['Ancestor' = subclass_of(human, mortal)]).
why(1,
    ['Ancestor' = subclass_of(human, mortal)],
    [query_dependency(1, subclass_of(human, mortal))]).
query(2, support(1, _0), ['Fact' = _0]).
result(2, complete, 2).
answer(2, ['Fact' = instance_of(socrates, human)]).
why(2, ['Fact' = instance_of(socrates, human)], [support(1, instance_of(socrates, human))]).
answer(2, ['Fact' = subclass_of(human, mortal)]).
why(2, ['Fact' = subclass_of(human, mortal)], [support(1, subclass_of(human, mortal))]).
query(3, answer_applied(1, _0, _1, _2), ['Conclusion' = _0, 'Name' = _1, 'Value' = _2]).
result(3, complete, 3).
answer(3,
       ['Conclusion' = instance_of(socrates, mortal), 'Name' = 'Individual', 'Value' = socrates]).
why(3,
    ['Conclusion' = instance_of(socrates, mortal), 'Name' = 'Individual', 'Value' = socrates],
    [answer_applied(1, instance_of(socrates, mortal), 'Individual', socrates)]).
answer(3,
       ['Conclusion' = instance_of(socrates, mortal), 'Name' = 'Superclass', 'Value' = mortal]).
why(3,
    ['Conclusion' = instance_of(socrates, mortal), 'Name' = 'Superclass', 'Value' = mortal],
    [answer_applied(1, instance_of(socrates, mortal), 'Superclass', mortal)]).
answer(3, ['Conclusion' = instance_of(socrates, mortal), 'Name' = 'Class', 'Value' = human]).
why(3,
    ['Conclusion' = instance_of(socrates, mortal), 'Name' = 'Class', 'Value' = human],
    [answer_applied(1, instance_of(socrates, mortal), 'Class', human)]).

clause(4, why(1, [], [instance_of(socrates, mortal)]), true).
clause(8,
       step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
       true).
clause(9, step(instance_of(socrates, human), fact(1), [], []), true).
clause(10, step(subclass_of(human, mortal), fact(2), [], []), true).
clause(11, member(var('X'), [var('X')|anonymous(1)]), true).
clause(12, member(var('X'), [anonymous(1)|var('Rest')]), member(var('X'), var('Rest'))).
clause(13,
       depends_on(var('Conclusion'), var('Used')),
       (step(var('Conclusion'), anonymous(1), anonymous(2), var('Uses')),
        member(var('Used'), var('Uses')))).
clause(15,
       source_fact(var('Fact')),
       step(var('Fact'), fact(anonymous(1)), anonymous(2), anonymous(3))).
clause(17,
       supporting_fact(var('Conclusion'), var('Fact')),
       (depends_on(var('Conclusion'), var('Fact')), source_fact(var('Fact')))).
clause(18,
       support(var('Query'), var('Fact')),
       (why(var('Query'), anonymous(1), var('Goals')),
        member(var('Goal'), var('Goals')),
        supporting_fact(var('Goal'), var('Fact')))).
clause(19,
       applied(var('Conclusion'), var('Name'), var('Value')),
       (step(var('Conclusion'), rule(anonymous(1)), var('Bindings'), anonymous(2)),
        member(var('Name') = var('Value'), var('Bindings')))).
clause(20,
       query_dependency(var('Query'), var('Ancestor')),
       (why(var('Query'), anonymous(1), var('Goals')),
        member(var('Goal'), var('Goals')),
        depends_on(var('Goal'), var('Ancestor')))).
clause(21,
       answer_applied(var('Query'), var('Conclusion'), var('Name'), var('Value')),
       (why(var('Query'), anonymous(1), var('Goals')),
        member(var('Conclusion'), var('Goals')),
        applied(var('Conclusion'), var('Name'), var('Value')))).

step(query_dependency(1, instance_of(socrates, human)),
     rule(20),
     ['Query' = 1,
      'Ancestor' = instance_of(socrates, human),
      'Goals' = [instance_of(socrates, mortal)],
      'Goal' = instance_of(socrates, mortal)],
     [why(1, [], [instance_of(socrates, mortal)]),
      member(instance_of(socrates, mortal), [instance_of(socrates, mortal)]),
      depends_on(instance_of(socrates, mortal), instance_of(socrates, human))]).
step(why(1, [], [instance_of(socrates, mortal)]), fact(4), [], []).
step(member(instance_of(socrates, mortal), [instance_of(socrates, mortal)]),
     fact(11),
     ['X' = instance_of(socrates, mortal)],
     []).
step(depends_on(instance_of(socrates, mortal), instance_of(socrates, human)),
     rule(13),
     ['Conclusion' = instance_of(socrates, mortal),
      'Used' = instance_of(socrates, human),
      'Uses' = [instance_of(socrates, human), subclass_of(human, mortal)]],
     [step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
      member(instance_of(socrates, human), [instance_of(socrates, human), subclass_of(human, mortal)])]).
step(step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
     fact(8),
     [],
     []).
step(member(instance_of(socrates, human), [instance_of(socrates, human), subclass_of(human, mortal)]),
     fact(11),
     ['X' = instance_of(socrates, human)],
     []).
step(query_dependency(1, subclass_of(human, mortal)),
     rule(20),
     ['Query' = 1,
      'Ancestor' = subclass_of(human, mortal),
      'Goals' = [instance_of(socrates, mortal)],
      'Goal' = instance_of(socrates, mortal)],
     [why(1, [], [instance_of(socrates, mortal)]),
      member(instance_of(socrates, mortal), [instance_of(socrates, mortal)]),
      depends_on(instance_of(socrates, mortal), subclass_of(human, mortal))]).
step(depends_on(instance_of(socrates, mortal), subclass_of(human, mortal)),
     rule(13),
     ['Conclusion' = instance_of(socrates, mortal),
      'Used' = subclass_of(human, mortal),
      'Uses' = [instance_of(socrates, human), subclass_of(human, mortal)]],
     [step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
      member(subclass_of(human, mortal), [instance_of(socrates, human), subclass_of(human, mortal)])]).
step(member(subclass_of(human, mortal), [instance_of(socrates, human), subclass_of(human, mortal)]),
     rule(12),
     ['X' = subclass_of(human, mortal), 'Rest' = [subclass_of(human, mortal)]],
     [member(subclass_of(human, mortal), [subclass_of(human, mortal)])]).
step(member(subclass_of(human, mortal), [subclass_of(human, mortal)]),
     fact(11),
     ['X' = subclass_of(human, mortal)],
     []).
step(support(1, instance_of(socrates, human)),
     rule(18),
     ['Query' = 1,
      'Fact' = instance_of(socrates, human),
      'Goals' = [instance_of(socrates, mortal)],
      'Goal' = instance_of(socrates, mortal)],
     [why(1, [], [instance_of(socrates, mortal)]),
      member(instance_of(socrates, mortal), [instance_of(socrates, mortal)]),
      supporting_fact(instance_of(socrates, mortal), instance_of(socrates, human))]).
step(supporting_fact(instance_of(socrates, mortal), instance_of(socrates, human)),
     rule(17),
     ['Conclusion' = instance_of(socrates, mortal), 'Fact' = instance_of(socrates, human)],
     [depends_on(instance_of(socrates, mortal), instance_of(socrates, human)),
      source_fact(instance_of(socrates, human))]).
step(source_fact(instance_of(socrates, human)),
     rule(15),
     ['Fact' = instance_of(socrates, human)],
     [step(instance_of(socrates, human), fact(1), [], [])]).
step(step(instance_of(socrates, human), fact(1), [], []), fact(9), [], []).
step(support(1, subclass_of(human, mortal)),
     rule(18),
     ['Query' = 1,
      'Fact' = subclass_of(human, mortal),
      'Goals' = [instance_of(socrates, mortal)],
      'Goal' = instance_of(socrates, mortal)],
     [why(1, [], [instance_of(socrates, mortal)]),
      member(instance_of(socrates, mortal), [instance_of(socrates, mortal)]),
      supporting_fact(instance_of(socrates, mortal), subclass_of(human, mortal))]).
step(supporting_fact(instance_of(socrates, mortal), subclass_of(human, mortal)),
     rule(17),
     ['Conclusion' = instance_of(socrates, mortal), 'Fact' = subclass_of(human, mortal)],
     [depends_on(instance_of(socrates, mortal), subclass_of(human, mortal)),
      source_fact(subclass_of(human, mortal))]).
step(source_fact(subclass_of(human, mortal)),
     rule(15),
     ['Fact' = subclass_of(human, mortal)],
     [step(subclass_of(human, mortal), fact(2), [], [])]).
step(step(subclass_of(human, mortal), fact(2), [], []), fact(10), [], []).
step(answer_applied(1, instance_of(socrates, mortal), 'Individual', socrates),
     rule(21),
     ['Query' = 1,
      'Conclusion' = instance_of(socrates, mortal),
      'Name' = 'Individual',
      'Value' = socrates,
      'Goals' = [instance_of(socrates, mortal)]],
     [why(1, [], [instance_of(socrates, mortal)]),
      member(instance_of(socrates, mortal), [instance_of(socrates, mortal)]),
      applied(instance_of(socrates, mortal), 'Individual', socrates)]).
step(applied(instance_of(socrates, mortal), 'Individual', socrates),
     rule(19),
     ['Conclusion' = instance_of(socrates, mortal),
      'Name' = 'Individual',
      'Value' = socrates,
      'Bindings' = ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]],
     [step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
      member('Individual' = socrates, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human])]).
step(member('Individual' = socrates, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]),
     fact(11),
     ['X' = ('Individual' = socrates)],
     []).
step(answer_applied(1, instance_of(socrates, mortal), 'Superclass', mortal),
     rule(21),
     ['Query' = 1,
      'Conclusion' = instance_of(socrates, mortal),
      'Name' = 'Superclass',
      'Value' = mortal,
      'Goals' = [instance_of(socrates, mortal)]],
     [why(1, [], [instance_of(socrates, mortal)]),
      member(instance_of(socrates, mortal), [instance_of(socrates, mortal)]),
      applied(instance_of(socrates, mortal), 'Superclass', mortal)]).
step(applied(instance_of(socrates, mortal), 'Superclass', mortal),
     rule(19),
     ['Conclusion' = instance_of(socrates, mortal),
      'Name' = 'Superclass',
      'Value' = mortal,
      'Bindings' = ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]],
     [step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
      member('Superclass' = mortal, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human])]).
step(member('Superclass' = mortal, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]),
     rule(12),
     ['X' = ('Superclass' = mortal), 'Rest' = ['Superclass' = mortal, 'Class' = human]],
     [member('Superclass' = mortal, ['Superclass' = mortal, 'Class' = human])]).
step(member('Superclass' = mortal, ['Superclass' = mortal, 'Class' = human]),
     fact(11),
     ['X' = ('Superclass' = mortal)],
     []).
step(answer_applied(1, instance_of(socrates, mortal), 'Class', human),
     rule(21),
     ['Query' = 1,
      'Conclusion' = instance_of(socrates, mortal),
      'Name' = 'Class',
      'Value' = human,
      'Goals' = [instance_of(socrates, mortal)]],
     [why(1, [], [instance_of(socrates, mortal)]),
      member(instance_of(socrates, mortal), [instance_of(socrates, mortal)]),
      applied(instance_of(socrates, mortal), 'Class', human)]).
step(applied(instance_of(socrates, mortal), 'Class', human),
     rule(19),
     ['Conclusion' = instance_of(socrates, mortal),
      'Name' = 'Class',
      'Value' = human,
      'Bindings' = ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]],
     [step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
      member('Class' = human, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human])]).
step(member('Class' = human, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]),
     rule(12),
     ['X' = ('Class' = human), 'Rest' = ['Superclass' = mortal, 'Class' = human]],
     [member('Class' = human, ['Superclass' = mortal, 'Class' = human])]).
step(member('Class' = human, ['Superclass' = mortal, 'Class' = human]),
     rule(12),
     ['X' = ('Class' = human), 'Rest' = ['Class' = human]],
     [member('Class' = human, ['Class' = human])]).
step(member('Class' = human, ['Class' = human]), fact(11), ['X' = ('Class' = human)], []).
