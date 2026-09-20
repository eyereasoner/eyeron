# Eyelang example: schema-foaf-mapping.
# Companion to schema-foaf-mapping.n3/.srl: a small schema.org-to-FOAF
# vocabulary mapping (Person, name, givenName, familyName), as ordinary
# relations.
schema_person(alice).
schema_name(alice, "Alice Example").
schema_given_name(alice, "Alice").
schema_family_name(alice, "Example").

foaf_person(?p) if schema_person(?p).
foaf_name(?p, ?name) if schema_name(?p, ?name).
foaf_given_name(?p, ?given) if schema_given_name(?p, ?given).
foaf_family_name(?p, ?family) if schema_family_name(?p, ?family).

ask foaf_person(?p).
ask foaf_name(?p, ?name).
ask foaf_given_name(?p, ?given).
ask foaf_family_name(?p, ?family).
