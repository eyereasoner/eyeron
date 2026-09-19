# Eyelang result format 2
query(1, [call(association(?v0, ?v1, ?v2, ?v3, ?v4, ?v5))], [binding("subject", ?v0), binding("dataGraph", ?v1), binding("signatureGraph", ?v2), binding("metadataGraph", ?v3), binding("cryptosuite", ?v4), binding("issuer", ?v5)]).
result(1, complete, 1).
answer(1, [binding("subject", bob), binding("dataGraph", blank(g0)), binding("signatureGraph", blank(g1)), binding("metadataGraph", blank(g3)), binding("cryptosuite", "ecdsa-rdfc-2019"), binding("issuer", iri("https://university.example/issuers/14"))]).
why(1, [binding("subject", bob), binding("dataGraph", blank(g0)), binding("signatureGraph", blank(g1)), binding("metadataGraph", blank(g3)), binding("cryptosuite", "ecdsa-rdfc-2019"), binding("issuer", iri("https://university.example/issuers/14"))], 11).
query(2, [call(quad(bob, foaf_name, "Bob", blank(g1)))], []).
result(2, complete, 0).
clause(1, quad(bob, foaf_name, "Bob", blank(g0)), []).
clause(2, quad(blank(g0), sec_proof, blank(dataSignature), blank(g1)), []).
clause(3, quad(blank(signature1), rdf_type, DataIntegrityProof, blank(g1)), []).
clause(4, quad(blank(signature1), sec_cryptosuite, "ecdsa-rdfc-2019", blank(g1)), []).
clause(5, quad(blank(signature1), sec_issuer, iri("https://university.example/issuers/14"), blank(g1)), []).
clause(6, quad(blank(signature1), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), blank(g1)), []).
clause(7, quad(blank(g1), sec_proof, blank(signature2), blank(g3)), []).
clause(8, quad(blank(signature2), rdf_type, DataIntegrityProof, blank(g3)), []).
clause(9, quad(blank(signature2), sec_proofPurpose, "assertionMethod", blank(g3)), []).
clause(10, association(bob, var("dataGraph"), var("signatureGraph"), var("metadataGraph"), "ecdsa-rdfc-2019", var("issuer")), [call(quad(bob, foaf_name, "Bob", var("dataGraph"))), call(quad(var("dataGraph"), sec_proof, var("dataSignature"), var("signatureGraph"))), call(quad(var("proof"), rdf_type, DataIntegrityProof, var("signatureGraph"))), call(quad(var("proof"), sec_cryptosuite, "ecdsa-rdfc-2019", var("signatureGraph"))), call(quad(var("proof"), sec_issuer, var("issuer"), var("signatureGraph"))), compare("=", var("issuer"), iri("https://university.example/issuers/14")), call(quad(var("proof"), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), var("signatureGraph"))), call(quad(var("signatureGraph"), sec_proof, var("metadataSignature"), var("metadataGraph"))), call(quad(var("metadataProof"), rdf_type, DataIntegrityProof, var("metadataGraph"))), call(quad(var("metadataProof"), sec_proofPurpose, "assertionMethod", var("metadataGraph")))]).
substitution(1, []).
proof(1, quad(bob, foaf_name, "Bob", blank(g0)), rule(1), []).
substitution(2, []).
proof(2, quad(blank(g0), sec_proof, blank(dataSignature), blank(g1)), rule(2), []).
substitution(3, []).
proof(3, quad(blank(signature1), rdf_type, DataIntegrityProof, blank(g1)), rule(3), []).
substitution(4, []).
proof(4, quad(blank(signature1), sec_cryptosuite, "ecdsa-rdfc-2019", blank(g1)), rule(4), []).
substitution(5, []).
proof(5, quad(blank(signature1), sec_issuer, iri("https://university.example/issuers/14"), blank(g1)), rule(5), []).
substitution(6, []).
proof(6, quad(blank(signature1), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), blank(g1)), rule(6), []).
substitution(7, []).
proof(7, quad(blank(g1), sec_proof, blank(signature2), blank(g3)), rule(7), []).
substitution(8, []).
proof(8, quad(blank(signature2), rdf_type, DataIntegrityProof, blank(g3)), rule(8), []).
substitution(9, []).
proof(9, quad(blank(signature2), sec_proofPurpose, "assertionMethod", blank(g3)), rule(9), []).
substitution(10, [binding("dataGraph", blank(g0)), binding("signatureGraph", blank(g1)), binding("metadataGraph", blank(g3)), binding("issuer", iri("https://university.example/issuers/14")), binding("dataSignature", blank(dataSignature)), binding("proof", blank(signature1)), binding("metadataSignature", blank(signature2)), binding("metadataProof", blank(signature2))]).
proof(10, association(bob, blank(g0), blank(g1), blank(g3), "ecdsa-rdfc-2019", iri("https://university.example/issuers/14")), rule(10), [uses(1, quad(bob, foaf_name, "Bob", blank(g0))), uses(2, quad(blank(g0), sec_proof, blank(dataSignature), blank(g1))), uses(3, quad(blank(signature1), rdf_type, DataIntegrityProof, blank(g1))), uses(4, quad(blank(signature1), sec_cryptosuite, "ecdsa-rdfc-2019", blank(g1))), uses(5, quad(blank(signature1), sec_issuer, iri("https://university.example/issuers/14"), blank(g1))), compared("=", iri("https://university.example/issuers/14"), iri("https://university.example/issuers/14")), uses(6, quad(blank(signature1), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), blank(g1))), uses(7, quad(blank(g1), sec_proof, blank(signature2), blank(g3))), uses(8, quad(blank(signature2), rdf_type, DataIntegrityProof, blank(g3))), uses(9, quad(blank(signature2), sec_proofPurpose, "assertionMethod", blank(g3)))]).
substitution(11, [binding("subject", bob), binding("dataGraph", blank(g0)), binding("signatureGraph", blank(g1)), binding("metadataGraph", blank(g3)), binding("cryptosuite", "ecdsa-rdfc-2019"), binding("issuer", iri("https://university.example/issuers/14"))]).
proof(11, solution([bob, blank(g0), blank(g1), blank(g3), "ecdsa-rdfc-2019", iri("https://university.example/issuers/14")]), query, [uses(10, association(bob, blank(g0), blank(g1), blank(g3), "ecdsa-rdfc-2019", iri("https://university.example/issuers/14")))]).
