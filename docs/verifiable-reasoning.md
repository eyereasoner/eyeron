# Verifiable reasoning

A reasoner that only tells you the answer asks to be trusted. Eyeron can
instead hand over the answer, a proof of it written in the same language,
and a way to check that proof without running the reasoner again. The two
`verifiable-decision` examples walk that loop end to end.

The point is not that proofs are a debugging aid. A proof is a list of
exactly what a conclusion stands on, written as ordinary N3, which means a
second program can be written *about* it — and can refuse a conclusion whose
grounds do not hold up.

## The decision

[`examples/verifiable-decision.n3`](../examples/verifiable-decision.n3)
permits a research-data request when three separate authorities have each
said their piece: an ethics committee, the cohort's consent record, and the
de-identification registry. No single rule decides it.

```bash
eyeron examples/verifiable-decision.n3
```

```
:request-42 :hasConsent true .
:request-42 :meetsPrivacyBar true .
:request-42 :hasEthicsCover true .
:request-42 :decision :permit .
```

## The proof

```bash
eyeron -p examples/verifiable-decision.n3 > proof.n3
```

Every step is an ordinary triple whose subject is the quoted claim:

```n3
{ :request-42 :hasConsent true . }
  pe:rule 2;
  pe:binding
    [ pe:var "ds"; pe:value :cohort-b ],
    [ pe:var "p"; pe:value :secondaryResearch ],
    [ pe:var "r"; pe:value :request-42 ];
  pe:uses
    { :request-42 :asksFor :cohort-b . },
    { :request-42 :purpose :secondaryResearch . },
    { :cohort-b :consentCovers :secondaryResearch . }.

{ :request-42 :asksFor :cohort-b . }
  pe:fact "verifiable-decision.n3".
```

A step carries exactly one justification: `pe:rule` for a rule the engine
applied, or `pe:fact` for something the source asserted. There is no nesting
and no traversal to write — the steps are already facts in a graph.

## The check

```bash
eyeron --check-proof proof.n3 examples/verifiable-decision.n3
```

```
checked: 11 steps
  7 fact
  4 rule
```

This does not reason. It re-performs the steps the document records and
confirms each one follows, against the program as written.
[`proof-checking.md`](proof-checking.md) is the normative account of what it
means for a proof to be valid, so a second implementation can be written
against it rather than against eyeron.

## Reasoning about the proof

[`examples/verifiable-decision-audit.n3`](../examples/verifiable-decision-audit.n3)
reads that proof back in and asks what the permit rests on. It follows
`pe:uses` to the ground, maps each source assertion to the authority that
put its name to it, and reports the documents the decision actually stands
on:

```bash
eyeron examples/verifiable-decision-audit.n3 \
       examples/input/verifiable-decision-audit.n3
```

```
:audit :standsOn doc:intake .
:audit :standsOn doc:consent .
:audit :standsOn doc:registry .
:audit :standsOn doc:ethics .
```

The trust policy is itself a quoted graph, so "not trusted" is a question
asked of it by name:

```n3
{ :audit :vouchedBy ?doc.
  :policy :says ?trusted.
  ?trusted log:notIncludes { :policy :trusts ?doc }.
} => false.
```

That rule is an [inference fuse](n3.md): a conclusion the program forbids.
Drop `doc:ethics` from the policy and the run stops rather than answering,
naming the document and the policy it was weighed against, and leaving with
`EX_DATAERR` (65):

```
# Inference fuse triggered.
# Fired rule:
#   {
#     :audit :vouchedBy ?doc .
#     :policy :says ?trusted .
#     ?trusted log:notIncludes {
#       :policy :trusts ?doc .
#   } .
#   } => false .
# Matched instance:
#   {
#     :audit :vouchedBy doc:ethics .
#     ...
```

The audit is a derivation like any other, so `-p` writes a proof of it too.
The checking is no more to be taken on trust than the decision was.

## What this needs from the language

Nothing outside N3. The proof is N3 because a quoted graph is a term, so a
claim can be the subject of a statement about it. The policy is N3 because a
graph can be named and asked what it contains. The constraint is N3 because
a rule may conclude `false`. One syntax carries the data, the rules, the
justification, and the policy about the justification — which is why the
audit needs no proof format, no traversal API, and no second language.
