% Prolog result format 3
query(1, instance_of(socrates, mortal), []).
result(1, complete, 1).
answer(1, []).
why(1, [], 6).
clause(1, instance_of(socrates, human), true).
clause(2, subclass_of(human, mortal), true).
clause(3, instance_of(var('Individual'), var('Superclass')), (instance_of(var('Individual'), var('Class')), subclass_of(var('Class'), var('Superclass')))).
substitution(1, []).
proof(1, instance_of(socrates, human), rule(1), []).
substitution(2, []).
proof(2, subclass_of(human, mortal), rule(2), []).
substitution(3, []).
proof(3, subclass_of(human, mortal), rule(2), []).
substitution(4, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]).
proof(4, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(2, subclass_of(human, mortal))]).
substitution(5, ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human]).
proof(5, instance_of(socrates, mortal), rule(3), [uses(1, instance_of(socrates, human)), uses(3, subclass_of(human, mortal))]).
substitution(6, []).
proof(6, solution([]), query, [uses(5, instance_of(socrates, mortal))]).
