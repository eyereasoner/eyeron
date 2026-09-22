% Prolog result format 4
query(1,
      association(_0, _1, _2, _3, _4, _5),
      ['Subject' = _0,
       'DataGraph' = _1,
       'SignatureGraph' = _2,
       'MetadataGraph' = _3,
       'Cryptosuite' = _4,
       'Issuer' = _5]).
result(1, complete, 1).
answer(1,
       ['Subject' = bob,
        'DataGraph' = blank(g0),
        'SignatureGraph' = blank(g1),
        'MetadataGraph' = blank(g3),
        'Cryptosuite' = "ecdsa-rdfc-2019",
        'Issuer' = iri("https://university.example/issuers/14")]).
why(1,
    ['Subject' = bob,
     'DataGraph' = blank(g0),
     'SignatureGraph' = blank(g1),
     'MetadataGraph' = blank(g3),
     'Cryptosuite' = "ecdsa-rdfc-2019",
     'Issuer' = iri("https://university.example/issuers/14")],
    [association(bob, blank(g0), blank(g1), blank(g3), "ecdsa-rdfc-2019", iri("https://university.example/issuers/14"))]).
query(2, quad(bob, foaf_name, "Bob", blank(g1)), []).
result(2, complete, 0).

clause(1, quad(bob, foaf_name, "Bob", blank(g0)), true).
clause(2, quad(blank(g0), sec_proof, blank(dataSignature), blank(g1)), true).
clause(3, quad(blank(signature1), rdf_type, 'DataIntegrityProof', blank(g1)), true).
clause(4, quad(blank(signature1), sec_cryptosuite, "ecdsa-rdfc-2019", blank(g1)), true).
clause(5,
       quad(blank(signature1), sec_issuer, iri("https://university.example/issuers/14"), blank(g1)),
       true).
clause(6,
       quad(blank(signature1), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), blank(g1)),
       true).
clause(7, quad(blank(g1), sec_proof, blank(signature2), blank(g3)), true).
clause(8, quad(blank(signature2), rdf_type, 'DataIntegrityProof', blank(g3)), true).
clause(9, quad(blank(signature2), sec_proofPurpose, "assertionMethod", blank(g3)), true).
clause(10,
       association(bob, var('DataGraph'), var('SignatureGraph'), var('MetadataGraph'), "ecdsa-rdfc-2019", var('Issuer')),
       (quad(bob, foaf_name, "Bob", var('DataGraph')),
        quad(var('DataGraph'), sec_proof, var('DataSignature'), var('SignatureGraph')),
        quad(var('Proof'), rdf_type, 'DataIntegrityProof', var('SignatureGraph')),
        quad(var('Proof'), sec_cryptosuite, "ecdsa-rdfc-2019", var('SignatureGraph')),
        quad(var('Proof'), sec_issuer, var('Issuer'), var('SignatureGraph')),
        var('Issuer') = iri("https://university.example/issuers/14"),
        quad(var('Proof'), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), var('SignatureGraph')),
        quad(var('SignatureGraph'), sec_proof, var('MetadataSignature'), var('MetadataGraph')),
        quad(var('MetadataProof'), rdf_type, 'DataIntegrityProof', var('MetadataGraph')),
        quad(var('MetadataProof'), sec_proofPurpose, "assertionMethod", var('MetadataGraph')))).

step(association(bob, blank(g0), blank(g1), blank(g3), "ecdsa-rdfc-2019", iri("https://university.example/issuers/14")),
     rule(10),
     ['DataGraph' = blank(g0),
      'SignatureGraph' = blank(g1),
      'MetadataGraph' = blank(g3),
      'Issuer' = iri("https://university.example/issuers/14"),
      'DataSignature' = blank(dataSignature),
      'Proof' = blank(signature1),
      'MetadataSignature' = blank(signature2),
      'MetadataProof' = blank(signature2)],
     [quad(bob, foaf_name, "Bob", blank(g0)),
      quad(blank(g0), sec_proof, blank(dataSignature), blank(g1)),
      quad(blank(signature1), rdf_type, 'DataIntegrityProof', blank(g1)),
      quad(blank(signature1), sec_cryptosuite, "ecdsa-rdfc-2019", blank(g1)),
      quad(blank(signature1), sec_issuer, iri("https://university.example/issuers/14"), blank(g1)),
      iri("https://university.example/issuers/14") = iri("https://university.example/issuers/14"),
      quad(blank(signature1), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), blank(g1)),
      quad(blank(g1), sec_proof, blank(signature2), blank(g3)),
      quad(blank(signature2), rdf_type, 'DataIntegrityProof', blank(g3)),
      quad(blank(signature2), sec_proofPurpose, "assertionMethod", blank(g3))]).
step(quad(bob, foaf_name, "Bob", blank(g0)), fact(1), [], []).
step(quad(blank(g0), sec_proof, blank(dataSignature), blank(g1)), fact(2), [], []).
step(quad(blank(signature1), rdf_type, 'DataIntegrityProof', blank(g1)), fact(3), [], []).
step(quad(blank(signature1), sec_cryptosuite, "ecdsa-rdfc-2019", blank(g1)), fact(4), [], []).
step(quad(blank(signature1), sec_issuer, iri("https://university.example/issuers/14"), blank(g1)),
     fact(5),
     [],
     []).
step(iri("https://university.example/issuers/14") = iri("https://university.example/issuers/14"),
     builtin,
     [],
     []).
step(quad(blank(signature1), sec_validUntil, typed("2025-04-03T00:00:00.000Z", iri("http://www.w3.org/2001/XMLSchema#dateTime")), blank(g1)),
     fact(6),
     [],
     []).
step(quad(blank(g1), sec_proof, blank(signature2), blank(g3)), fact(7), [], []).
step(quad(blank(signature2), rdf_type, 'DataIntegrityProof', blank(g3)), fact(8), [], []).
step(quad(blank(signature2), sec_proofPurpose, "assertionMethod", blank(g3)), fact(9), [], []).
