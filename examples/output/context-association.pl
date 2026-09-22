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
query(2, quad(bob, foaf_name, "Bob", blank(g1)), []).
result(2, complete, 0).
