% Prolog result format 3
query(1, association(_0, _1, _2, _3, _4, _5), ['Subject' = _0, 'DataGraph' = _1, 'SignatureGraph' = _2, 'MetadataGraph' = _3, 'Cryptosuite' = _4, 'Issuer' = _5]).
result(1, complete, 1).
answer(1, ['Subject' = bob, 'DataGraph' = blank(g0), 'SignatureGraph' = blank(g1), 'MetadataGraph' = blank(g3), 'Cryptosuite' = "ecdsa-rdfc-2019", 'Issuer' = iri("https://university.example/issuers/14")]).
why(1, ['Subject' = bob, 'DataGraph' = blank(g0), 'SignatureGraph' = blank(g1), 'MetadataGraph' = blank(g3), 'Cryptosuite' = "ecdsa-rdfc-2019", 'Issuer' = iri("https://university.example/issuers/14")], 11).
query(2, quad(bob, foaf_name, "Bob", blank(g1)), []).
result(2, complete, 0).
clause(1, quad(bob, foaf_name, "Bob", blank(g0)), true).
clause(2, quad(blank(g0), sec_proof, blank(dataSignature), blank(g1)), true).
clause(3, quad(blank(signature1), rdf_type, 'DataIntegrityProof', blank(g1)), true).
clause(4, quad(blank(signature1), sec_cryptosuite, "ecdsa-rdfc-2019", blank(g1)), true).
clause(5, quad(blank(signature1), sec_issuer, iri("https://university.example/issuers/14"), blank(g1)), true).
clause(6, quad(blank(signature1), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), blank(g1)), true).
clause(7, quad(blank(g1), sec_proof, blank(signature2), blank(g3)), true).
clause(8, quad(blank(signature2), rdf_type, 'DataIntegrityProof', blank(g3)), true).
clause(9, quad(blank(signature2), sec_proofPurpose, "assertionMethod", blank(g3)), true).
clause(10, association(bob, var('DataGraph'), var('SignatureGraph'), var('MetadataGraph'), "ecdsa-rdfc-2019", var('Issuer')), (quad(bob, foaf_name, "Bob", var('DataGraph')), quad(var('DataGraph'), sec_proof, var('DataSignature'), var('SignatureGraph')), quad(var('Proof'), rdf_type, 'DataIntegrityProof', var('SignatureGraph')), quad(var('Proof'), sec_cryptosuite, "ecdsa-rdfc-2019", var('SignatureGraph')), quad(var('Proof'), sec_issuer, var('Issuer'), var('SignatureGraph')), var('Issuer') = iri("https://university.example/issuers/14"), quad(var('Proof'), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), var('SignatureGraph')), quad(var('SignatureGraph'), sec_proof, var('MetadataSignature'), var('MetadataGraph')), quad(var('MetadataProof'), rdf_type, 'DataIntegrityProof', var('MetadataGraph')), quad(var('MetadataProof'), sec_proofPurpose, "assertionMethod", var('MetadataGraph')))).
substitution(1, []).
proof(1, quad(bob, foaf_name, "Bob", blank(g0)), rule(1), []).
substitution(2, []).
proof(2, quad(blank(g0), sec_proof, blank(dataSignature), blank(g1)), rule(2), []).
substitution(3, []).
proof(3, quad(blank(signature1), rdf_type, 'DataIntegrityProof', blank(g1)), rule(3), []).
substitution(4, []).
proof(4, quad(blank(signature1), sec_cryptosuite, "ecdsa-rdfc-2019", blank(g1)), rule(4), []).
substitution(5, []).
proof(5, quad(blank(signature1), sec_issuer, iri("https://university.example/issuers/14"), blank(g1)), rule(5), []).
substitution(6, []).
proof(6, quad(blank(signature1), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), blank(g1)), rule(6), []).
substitution(7, []).
proof(7, quad(blank(g1), sec_proof, blank(signature2), blank(g3)), rule(7), []).
substitution(8, []).
proof(8, quad(blank(signature2), rdf_type, 'DataIntegrityProof', blank(g3)), rule(8), []).
substitution(9, []).
proof(9, quad(blank(signature2), sec_proofPurpose, "assertionMethod", blank(g3)), rule(9), []).
substitution(10, ['DataGraph' = blank(g0), 'SignatureGraph' = blank(g1), 'MetadataGraph' = blank(g3), 'Issuer' = iri("https://university.example/issuers/14"), 'DataSignature' = blank(dataSignature), 'Proof' = blank(signature1), 'MetadataSignature' = blank(signature2), 'MetadataProof' = blank(signature2)]).
proof(10, association(bob, blank(g0), blank(g1), blank(g3), "ecdsa-rdfc-2019", iri("https://university.example/issuers/14")), rule(10), [uses(1, quad(bob, foaf_name, "Bob", blank(g0))), uses(2, quad(blank(g0), sec_proof, blank(dataSignature), blank(g1))), uses(3, quad(blank(signature1), rdf_type, 'DataIntegrityProof', blank(g1))), uses(4, quad(blank(signature1), sec_cryptosuite, "ecdsa-rdfc-2019", blank(g1))), uses(5, quad(blank(signature1), sec_issuer, iri("https://university.example/issuers/14"), blank(g1))), builtin(iri("https://university.example/issuers/14") = iri("https://university.example/issuers/14")), uses(6, quad(blank(signature1), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), blank(g1))), uses(7, quad(blank(g1), sec_proof, blank(signature2), blank(g3))), uses(8, quad(blank(signature2), rdf_type, 'DataIntegrityProof', blank(g3))), uses(9, quad(blank(signature2), sec_proofPurpose, "assertionMethod", blank(g3)))]).
substitution(11, ['Subject' = bob, 'DataGraph' = blank(g0), 'SignatureGraph' = blank(g1), 'MetadataGraph' = blank(g3), 'Cryptosuite' = "ecdsa-rdfc-2019", 'Issuer' = iri("https://university.example/issuers/14")]).
proof(11, solution([bob, blank(g0), blank(g1), blank(g3), "ecdsa-rdfc-2019", iri("https://university.example/issuers/14")]), query, [uses(10, association(bob, blank(g0), blank(g1), blank(g3), "ecdsa-rdfc-2019", iri("https://university.example/issuers/14")))]).
