# Eyelang result format 2
query(1, [call(association(?v0, ?v1, ?v2, ?v3, ?v4, ?v5))], [binding("subject", ?v0), binding("dataGraph", ?v1), binding("signatureGraph", ?v2), binding("metadataGraph", ?v3), binding("cryptosuite", ?v4), binding("issuer", ?v5)]).
result(1, complete, 1).
answer(1, [binding("subject", bob), binding("dataGraph", blank(g0)), binding("signatureGraph", blank(g1)), binding("metadataGraph", blank(g3)), binding("cryptosuite", "ecdsa-rdfc-2019"), binding("issuer", iri("https://university.example/issuers/14"))]).
query(2, [call(quad(bob, foaf_name, "Bob", blank(g1)))], []).
result(2, complete, 0).
