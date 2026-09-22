% Prolog example: dog. Companion to dog.n3/.srl (dog-license.n3/.pl/.srl
% is a separate, differently-named porting of the same underlying
% eyeling/examples/dog.n3 source; both base names get their own trio per
% this project's naming-mismatch convention).
%
% The licensing threshold uses a collection of distinct dog identities, not a
% collection of constant values that would collapse under set semantics.

has_dog(alice, dog1).
has_dog(alice, dog2).
has_dog(alice, dog3).
has_dog(alice, dog4).
has_dog(alice, dog5).
has_dog(bob, dog6).
has_dog(bob, dog7).

dog_count(Person, Count) :-
    has_dog(Person, _),
    findall(Dog, has_dog(Person, Dog), Bag1),
    sort(Bag1, Dogs),
    length(Dogs, Count).

must_have(Person, dogLicense) :-
    dog_count(Person, Count),
    Count > 4.

?- must_have(Person, License).
?- dog_count(Person, Count).
