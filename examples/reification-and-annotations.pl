% Explicit relational expansion of the same RDF-shaped data and join.
% Alice's statement is asserted and annotated. Bob's is only reified:
% describing his statement must not assert it. claim1 is a local blank-node ID.
% This represents parsed values; it is not an RDF concrete-syntax parser.

statement(alice, says, hello).
reifies(blank(claim1), triple(alice, says, hello)).
source(blank(claim1), chat).
certainty(blank(claim1), 0.9).
reifies(bobClaim, triple(bob, says, hi)).
source(bobClaim, email).

statement_source(Speaker, Source) :-
    reifies(Claim, triple(Speaker, says, Object)),
    source(Claim, Source).

?- statement_source(Speaker, Source).
?- statement(bob, says, hi).
?- certainty(blank(claim1), Certainty).
