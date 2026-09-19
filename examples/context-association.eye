# Project the triples consumed by the original rule, preserving graph scope and
# the distinct blank nodes. Prefix-qualified predicates become named symbols.
# This checks linked metadata; it does not verify signatures or their validity.

quad(bob, foaf_name, "Bob", blank(g0)).
quad(blank(g0), sec_proof, blank(dataSignature), blank(g1)).
quad(blank(signature1), rdf_type, DataIntegrityProof, blank(g1)).
quad(blank(signature1), sec_cryptosuite, "ecdsa-rdfc-2019", blank(g1)).
quad(blank(signature1), sec_issuer, iri("https://university.example/issuers/14"), blank(g1)).
quad(blank(signature1), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), blank(g1)).
quad(blank(g1), sec_proof, blank(signature2), blank(g3)).
quad(blank(signature2), rdf_type, DataIntegrityProof, blank(g3)).
quad(blank(signature2), sec_proofPurpose, "assertionMethod", blank(g3)).

association(bob, ?dataGraph, ?signatureGraph, ?metadataGraph, "ecdsa-rdfc-2019", ?issuer) if
    quad(bob, foaf_name, "Bob", ?dataGraph),
    quad(?dataGraph, sec_proof, ?dataSignature, ?signatureGraph),
    quad(?proof, rdf_type, DataIntegrityProof, ?signatureGraph),
    quad(?proof, sec_cryptosuite, "ecdsa-rdfc-2019", ?signatureGraph),
    quad(?proof, sec_issuer, ?issuer, ?signatureGraph),
    ?issuer = iri("https://university.example/issuers/14"),
    quad(?proof, sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), ?signatureGraph),
    quad(?signatureGraph, sec_proof, ?metadataSignature, ?metadataGraph),
    quad(?metadataProof, rdf_type, DataIntegrityProof, ?metadataGraph),
    quad(?metadataProof, sec_proofPurpose, "assertionMethod", ?metadataGraph).

ask association(?subject, ?dataGraph, ?signatureGraph, ?metadataGraph, ?cryptosuite, ?issuer).
# Data from a different graph must not silently join this graph.
ask quad(bob, foaf_name, "Bob", blank(g1)).
