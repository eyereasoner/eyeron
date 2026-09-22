% Prolog example: schema-foaf-mapping.
% Companion to schema-foaf-mapping.n3/.srl: a small schema.org-to-FOAF
% vocabulary mapping (Person, name, givenName, familyName), as ordinary
% relations.
schema_person(alice).
schema_name(alice, "Alice Example").
schema_given_name(alice, "Alice").
schema_family_name(alice, "Example").

foaf_person(P) :-
    schema_person(P).
foaf_name(P, Name) :-
    schema_name(P, Name).
foaf_given_name(P, Given) :-
    schema_given_name(P, Given).
foaf_family_name(P, Family) :-
    schema_family_name(P, Family).

?- foaf_person(P).
?- foaf_name(P, Name).
?- foaf_given_name(P, Given).
?- foaf_family_name(P, Family).
