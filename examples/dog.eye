# Eyelang example: dog. Companion to dog.n3/.srl (dog-license.n3/.eye/.srl
# is a separate, differently-named porting of the same underlying
# eyeling/examples/dog.n3 source; both base names get their own trio per
# this project's naming-mismatch convention).
#
# The licensing threshold uses a collection of distinct dog identities, not a
# collection of constant values that would collapse under set semantics.

has_dog(alice, dog1).
has_dog(alice, dog2).
has_dog(alice, dog3).
has_dog(alice, dog4).
has_dog(alice, dog5).
has_dog(bob, dog6).
has_dog(bob, dog7).

dog_count(?person, ?count) if
    has_dog(?person, ?_),
    collect ?dogs = ?dog where { has_dog(?person, ?dog) }, let ?count = count(?dogs).

must_have(?person, dogLicense) if dog_count(?person, ?count), ?count > 4.

ask must_have(?person, ?license).
ask dog_count(?person, ?count).
