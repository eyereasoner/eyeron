% Project the triples consumed by the original rule, preserving graph scope and
% the distinct blank nodes. Prefix-qualified predicates become named symbols.
% This checks linked metadata; it does not verify signatures or their validity.

quad(bob, foaf_name, "Bob", blank(g0)).
quad(blank(g0), sec_proof, blank(dataSignature), blank(g1)).
quad(blank(signature1), rdf_type, 'DataIntegrityProof', blank(g1)).
quad(blank(signature1), sec_cryptosuite, "ecdsa-rdfc-2019", blank(g1)).
quad(blank(signature1), sec_issuer, iri("https://university.example/issuers/14"), blank(g1)).
quad(blank(signature1), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), blank(g1)).
quad(blank(g1), sec_proof, blank(signature2), blank(g3)).
quad(blank(signature2), rdf_type, 'DataIntegrityProof', blank(g3)).
quad(blank(signature2), sec_proofPurpose, "assertionMethod", blank(g3)).

association(bob, DataGraph, SignatureGraph, MetadataGraph, "ecdsa-rdfc-2019", Issuer) :-
    quad(bob, foaf_name, "Bob", DataGraph),
    quad(DataGraph, sec_proof, DataSignature, SignatureGraph),
    quad(Proof, rdf_type, 'DataIntegrityProof', SignatureGraph),
    quad(Proof, sec_cryptosuite, "ecdsa-rdfc-2019", SignatureGraph),
    quad(Proof, sec_issuer, Issuer, SignatureGraph),
    Issuer = iri("https://university.example/issuers/14"),
    quad(Proof, sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), SignatureGraph),
    quad(SignatureGraph, sec_proof, MetadataSignature, MetadataGraph),
    quad(MetadataProof, rdf_type, 'DataIntegrityProof', MetadataGraph),
    quad(MetadataProof, sec_proofPurpose, "assertionMethod", MetadataGraph).

?- association(Subject, DataGraph, SignatureGraph, MetadataGraph, Cryptosuite, Issuer).

% Data from a different graph must not silently join this graph.
?- quad(bob, foaf_name, "Bob", blank(g1)).
