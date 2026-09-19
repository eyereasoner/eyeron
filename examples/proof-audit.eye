# Run with proof facts from another Eyelang invocation:
# node bin/eyelang.js examples/proof/socrates.eye examples/proof-audit.eye
# Tests and the example generator supply that document automatically.

member(?x, [?x | ?_]).
member(?x, [?_ | ?rest]) if member(?x, ?rest).

# Positive premises and completed collections both carry proof references.
parent_proof(?id, ?parent) if
    proof(?id, ?_, ?_, ?premises), member(uses(?parent, ?_), ?premises).
parent_proof(?id, ?parent) if
    proof(?id, ?_, ?_, ?premises),
    member(collected(?_, ?_, ?_, ?parents, complete), ?premises),
    member(?parent, ?parents).

depends_on(?id, ?parent) if parent_proof(?id, ?parent).
depends_on(?id, ?ancestor) if parent_proof(?id, ?parent), depends_on(?parent, ?ancestor).

# Format 2 uses stable rule numbers without physical line coordinates. The
# second clause keeps format 1 proof documents readable.
source_fact(?id, ?fact) if proof(?id, ?fact, rule(?_), []).
source_fact(?id, ?fact) if proof(?id, ?fact, rule(?_, ?_), []).
supporting_fact(?id, ?fact) if source_fact(?id, ?fact).
supporting_fact(?id, ?fact) if depends_on(?id, ?ancestor), source_fact(?ancestor, ?fact).

support(?query, ?fact) if why(?query, ?_, ?proof), supporting_fact(?proof, ?fact).
applied(?proof, ?name, ?value) if
    substitution(?proof, ?bindings), member(binding(?name, ?value), ?bindings).
query_dependency(?query, ?ancestor) if
    why(?query, ?_, ?root), depends_on(?root, ?ancestor).
answer_rule_proof(?query, ?proof) if
    why(?query, ?_, ?root),
    proof(?root, ?_, query, ?premises),
    member(uses(?proof, ?_), ?premises).
answer_applied(?query, ?proof, ?name, ?value) if
    answer_rule_proof(?query, ?proof), applied(?proof, ?name, ?value).

ask query_dependency(1, ?ancestor).
ask support(1, ?fact).
ask answer_applied(1, ?proof, ?name, ?value).
