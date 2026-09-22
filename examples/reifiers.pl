% Prolog example: reifiers.
reifies(claim1, triple(alice, says, hello)).
source(claim1, chat).
reifies(claim2, triple(bob, says, hi)).
source(claim2, email).
statement_source(Speaker, Source) :-
    reifies(Claim, triple(Speaker, says, Object)),
    source(Claim, Source).
?- statement_source(Speaker, Source).
?- reifies(Claim, Statement).
