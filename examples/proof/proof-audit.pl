query_dependency(instance_of(socrates, human)).
query_dependency(subclass_of(human, mortal)).
support(instance_of(socrates, human)).
support(subclass_of(human, mortal)).
answer_applied(instance_of(socrates, mortal), 'Individual', socrates).
answer_applied(instance_of(socrates, mortal), 'Superclass', mortal).
answer_applied(instance_of(socrates, mortal), 'Class', human).

clause(5,
       step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
       true).
clause(6, step(instance_of(socrates, human), fact(1), [], []), true).
clause(7, step(subclass_of(human, mortal), fact(2), [], []), true).
clause(8, member(var('X'), [var('X')|anonymous(1)]), true).
clause(9, member(var('X'), [anonymous(1)|var('Rest')]), member(var('X'), var('Rest'))).
clause(10,
       depends_on(var('Conclusion'), var('Used')),
       (step(var('Conclusion'), anonymous(1), anonymous(2), var('Uses')),
        member(var('Used'), var('Uses')))).
clause(12,
       source_fact(var('Fact')),
       step(var('Fact'), fact(anonymous(1)), anonymous(2), anonymous(3))).
clause(14,
       supporting_fact(var('Conclusion'), var('Fact')),
       (depends_on(var('Conclusion'), var('Fact')), source_fact(var('Fact')))).
clause(15,
       root(var('Conclusion')),
       step(var('Conclusion'), rule(anonymous(1)), anonymous(2), anonymous(3))).
clause(16,
       applied(var('Conclusion'), var('Name'), var('Value')),
       (step(var('Conclusion'), rule(anonymous(1)), var('Bindings'), anonymous(2)),
        member(var('Name') = var('Value'), var('Bindings')))).
clause(17,
       query_dependency(var('Ancestor')),
       (root(var('Root')), depends_on(var('Root'), var('Ancestor')))).
clause(18, support(var('Fact')), (root(var('Root')), supporting_fact(var('Root'), var('Fact')))).
clause(19,
       answer_applied(var('Conclusion'), var('Name'), var('Value')),
       (root(var('Conclusion')), applied(var('Conclusion'), var('Name'), var('Value')))).

step(query_dependency(instance_of(socrates, human)),
     rule(17),
     ['Ancestor' = instance_of(socrates, human), 'Root' = instance_of(socrates, mortal)],
     [root(instance_of(socrates, mortal)),
      depends_on(instance_of(socrates, mortal), instance_of(socrates, human))]).
step(root(instance_of(socrates, mortal)),
     rule(15),
     ['Conclusion' = instance_of(socrates, mortal)],
     [step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)])]).
step(step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
     fact(5),
     [],
     []).
step(depends_on(instance_of(socrates, mortal), instance_of(socrates, human)),
     rule(10),
     ['Conclusion' = instance_of(socrates, mortal),
      'Used' = instance_of(socrates, human),
      'Uses' = [instance_of(socrates, human), subclass_of(human, mortal)]],
     [step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
      member(instance_of(socrates, human), [instance_of(socrates, human), subclass_of(human, mortal)])]).
step(member(instance_of(socrates, human), [instance_of(socrates, human), subclass_of(human, mortal)]),
     fact(8),
     ['X' = instance_of(socrates, human)],
     []).
step(query_dependency(subclass_of(human, mortal)),
     rule(17),
     ['Ancestor' = subclass_of(human, mortal), 'Root' = instance_of(socrates, mortal)],
     [root(instance_of(socrates, mortal)),
      depends_on(instance_of(socrates, mortal), subclass_of(human, mortal))]).
step(depends_on(instance_of(socrates, mortal), subclass_of(human, mortal)),
     rule(10),
     ['Conclusion' = instance_of(socrates, mortal),
      'Used' = subclass_of(human, mortal),
      'Uses' = [instance_of(socrates, human), subclass_of(human, mortal)]],
     [step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
      member(subclass_of(human, mortal), [instance_of(socrates, human), subclass_of(human, mortal)])]).
step(member(subclass_of(human, mortal), [instance_of(socrates, human), subclass_of(human, mortal)]),
     rule(9),
     ['X' = subclass_of(human, mortal), 'Rest' = [subclass_of(human, mortal)]],
     [member(subclass_of(human, mortal), [subclass_of(human, mortal)])]).
step(member(subclass_of(human, mortal), [subclass_of(human, mortal)]),
     fact(8),
     ['X' = subclass_of(human, mortal)],
     []).
step(support(instance_of(socrates, human)),
     rule(18),
     ['Fact' = instance_of(socrates, human), 'Root' = instance_of(socrates, mortal)],
     [root(instance_of(socrates, mortal)),
      supporting_fact(instance_of(socrates, mortal), instance_of(socrates, human))]).
step(supporting_fact(instance_of(socrates, mortal), instance_of(socrates, human)),
     rule(14),
     ['Conclusion' = instance_of(socrates, mortal), 'Fact' = instance_of(socrates, human)],
     [depends_on(instance_of(socrates, mortal), instance_of(socrates, human)),
      source_fact(instance_of(socrates, human))]).
step(source_fact(instance_of(socrates, human)),
     rule(12),
     ['Fact' = instance_of(socrates, human)],
     [step(instance_of(socrates, human), fact(1), [], [])]).
step(step(instance_of(socrates, human), fact(1), [], []), fact(6), [], []).
step(support(subclass_of(human, mortal)),
     rule(18),
     ['Fact' = subclass_of(human, mortal), 'Root' = instance_of(socrates, mortal)],
     [root(instance_of(socrates, mortal)),
      supporting_fact(instance_of(socrates, mortal), subclass_of(human, mortal))]).
step(supporting_fact(instance_of(socrates, mortal), subclass_of(human, mortal)),
     rule(14),
     ['Conclusion' = instance_of(socrates, mortal), 'Fact' = subclass_of(human, mortal)],
     [depends_on(instance_of(socrates, mortal), subclass_of(human, mortal)),
      source_fact(subclass_of(human, mortal))]).
step(source_fact(subclass_of(human, mortal)),
     rule(12),
     ['Fact' = subclass_of(human, mortal)],
     [step(subclass_of(human, mortal), fact(2), [], [])]).
step(step(subclass_of(human, mortal), fact(2), [], []), fact(7), [], []).
step(answer_applied(instance_of(socrates, mortal), 'Individual', socrates),
     rule(19),
     ['Conclusion' = instance_of(socrates, mortal), 'Name' = 'Individual', 'Value' = socrates],
     [root(instance_of(socrates, mortal)),
      applied(instance_of(socrates, mortal), 'Individual', socrates)]).
step(applied(instance_of(socrates, mortal), 'Individual', socrates),
     rule(16),
     ['Conclusion' = instance_of(socrates, mortal),
      'Name' = 'Individual',
      'Value' = socrates,
      'Bindings' = ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]],
     [step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
      member('Individual' = socrates, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human])]).
step(member('Individual' = socrates, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]),
     fact(8),
     ['X' = ('Individual' = socrates)],
     []).
step(answer_applied(instance_of(socrates, mortal), 'Superclass', mortal),
     rule(19),
     ['Conclusion' = instance_of(socrates, mortal), 'Name' = 'Superclass', 'Value' = mortal],
     [root(instance_of(socrates, mortal)),
      applied(instance_of(socrates, mortal), 'Superclass', mortal)]).
step(applied(instance_of(socrates, mortal), 'Superclass', mortal),
     rule(16),
     ['Conclusion' = instance_of(socrates, mortal),
      'Name' = 'Superclass',
      'Value' = mortal,
      'Bindings' = ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]],
     [step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
      member('Superclass' = mortal, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human])]).
step(member('Superclass' = mortal, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]),
     rule(9),
     ['X' = ('Superclass' = mortal), 'Rest' = ['Superclass' = mortal, 'Class' = human]],
     [member('Superclass' = mortal, ['Superclass' = mortal, 'Class' = human])]).
step(member('Superclass' = mortal, ['Superclass' = mortal, 'Class' = human]),
     fact(8),
     ['X' = ('Superclass' = mortal)],
     []).
step(answer_applied(instance_of(socrates, mortal), 'Class', human),
     rule(19),
     ['Conclusion' = instance_of(socrates, mortal), 'Name' = 'Class', 'Value' = human],
     [root(instance_of(socrates, mortal)),
      applied(instance_of(socrates, mortal), 'Class', human)]).
step(applied(instance_of(socrates, mortal), 'Class', human),
     rule(16),
     ['Conclusion' = instance_of(socrates, mortal),
      'Name' = 'Class',
      'Value' = human,
      'Bindings' = ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]],
     [step(instance_of(socrates, mortal), rule(3), ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human], [instance_of(socrates, human), subclass_of(human, mortal)]),
      member('Class' = human, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human])]).
step(member('Class' = human, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]),
     rule(9),
     ['X' = ('Class' = human), 'Rest' = ['Superclass' = mortal, 'Class' = human]],
     [member('Class' = human, ['Superclass' = mortal, 'Class' = human])]).
step(member('Class' = human, ['Superclass' = mortal, 'Class' = human]),
     rule(9),
     ['X' = ('Class' = human), 'Rest' = ['Class' = human]],
     [member('Class' = human, ['Class' = human])]).
step(member('Class' = human, ['Class' = human]), fact(8), ['X' = ('Class' = human)], []).
