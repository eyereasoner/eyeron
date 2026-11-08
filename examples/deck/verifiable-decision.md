# A decision with reasons you can check

How Eyeron makes a decision, records its reasons, and lets another program inspect what it depends on.

This deck follows two examples: [the decision](../verifiable-decision.n3) and [the audit](../verifiable-decision-audit.n3).

---

## The story: a request for research data

Dr Okafor asks to use a dataset called **cohort B** for secondary research.

The example supplies three supporting assertions:

- an ethics approval covers the requested dataset and purpose;
- the consent assertion covers that dataset and purpose, with status `dpv:ConsentGiven`;
- a registry records the dataset as de-identified.

These are inputs to a small demonstration policy, not a complete assessment of research law or privacy.

---

## Shared words for the same story

The examples use established vocabularies wherever they fit:

| Vocabulary | What it describes here |
| --- | --- |
| **ODRL** — Open Digital Rights Language | The request, proposed use, granted agreement, and permissions to use evidence |
| **DPV** — Data Privacy Vocabulary | Scientific research, consent and its status, safeguards, and the audit |
| **PROV** — provenance vocabulary | Which documents supplied assertions and how conclusions depend on them |

The N3 rules explain how these descriptions lead to a decision. Using a vocabulary does not evaluate the policy by itself.

References: [ODRL](https://www.w3.org/TR/odrl-model/), [DPV](https://w3id.org/dpv/2.3), and [PROV](https://www.w3.org/TR/prov-o/).

---

## What it takes to say yes

The ODRL Request proposes a use of the data. It grants no permission by itself.

The example derives a separate ODRL Agreement only when all three conditions hold:

```text
Ethics approval covers this data and purpose ─┐
Given consent covers this data and purpose ──┼──→ Agreement grants the use
Dataset has a de-identification measure ─────┘
```

Eyeron applies written rules to the supplied facts.

For this request, it derives:

```n3
:agreement-42 a odrl:Agreement ;
  odrl:permission :research-use-42 .
:request-42 dpv:hasOutcome :agreement-42 .
```

Read that as: “Under these rules and assertions, the hospital grants Dr Okafor the proposed use of cohort B.”

The purpose constraint uses `odrl:purpose` as its operand and `dpv:ScientificResearch` as its value. De-identification is a recorded safeguard, not proof of anonymity.

---

## A yes with a trail of reasons

An answer alone leaves an important question open:

> How did you reach it?

Eyeron can write a **proof**: a record of the facts and rule applications supporting its conclusions.

For example, the consent check connects the request with matching consent:

```text
The proposed use concerns cohort B and scientific research.
The consent assertion covers cohort B and scientific research.
Its recorded status is ConsentGiven.
                   ↓
The proposed use has this consent as its legal basis.
```

The final permit depends on this check and the other two conditions.

---

## Another check can inspect the reasoning

From the repository root, generate a proof and check it against the source program:

```bash
eyeron -p examples/verifiable-decision.n3 > /tmp/decision.why.n3

eyeron --check-proof /tmp/decision.why.n3 \
  examples/verifiable-decision.n3
```

The report is N3: the checked answers, then a `pe:Check` resource with each condition, obligation and failure. Its first line gives the verdict:

```n3
# checked: 30 steps, 30 verified, 0 trusted
```

Those are 21 source facts and nine derived steps, produced by four rules.

The checker checks the recorded steps, their support, and their dependencies. It does not search for a replacement explanation.

“0 trusted” means no step justifications were accepted without verification. The source assertions are still assumed.

---

## A correct chain still starts somewhere

The proof can show that the permit follows from a consent assertion.

It cannot establish, by itself, that the consent record is accurate or authentic.

That leads to a second question:

> Whose assertions does this decision depend on, and do we accept those authorities?

This is what the audit example explores.

---

## Four sources behind the decision

The audit supplies an explicit mapping between assertions and documents:

| Document | What it vouches for in the example |
| --- | --- |
| Intake record | Who made the request, which dataset, and which purpose |
| Ethics record | The approval and the dataset and purpose it covers |
| Consent record | The consent's dataset, purpose, and given status |
| Registry record | The dataset's de-identification status |

Its ODRL evidence policy permits the auditor to use those four records. The example interprets these permissions as its accepted evidence sources.

These mappings are supplied as data. They are not digital signatures.

---

## The proof becomes input to the audit

Eyeron's proof is written in N3, the same language the audit rules can read.

The proof records links meaning “this conclusion uses that premise.”

The audit follows those links:

```text
Agreement
  → supporting checks
    → source assertions
      → documents that vouch for them
```

It then checks whether its ODRL policy permits this auditor to use each identified document as evidence.

This lets a second program ask questions about the grounds for a decision.

---

## Run the audit on the proof you generated

```bash
eyeron examples/verifiable-decision-audit.n3 \
  /tmp/decision.why.n3
```

The result identifies four supporting documents:

```n3
:audit dpv:hasJustification doc:intake .
:audit dpv:hasJustification doc:ethics .
:audit dpv:hasJustification doc:consent .
:audit dpv:hasJustification doc:registry .
```

Here, `dpv:hasJustification` identifies the supporting documents found by the audit. `prov:hadPrimarySource` supplies the assertion-to-document mappings.

The bundled [audit input](../input/verifiable-decision-audit.n3) is a saved copy of the decision proof that `eyeron -p examples/verifiable-decision.n3` writes, so the example can also run without generating a new one. The test suite keeps that copy equal to the current proof.

---

## What if we stop accepting one source?

In a copy of the audit program, remove this permission link from the quoted evidence policy:

```n3
:trust-policy odrl:permission :use-registry .
```

The decision still depends on the registry's assertion.

When the audit finds no permission for this auditor to use the registry record, an **inference fuse** fires: Eyeron stops and reports the violated rule and its matching evidence, with exit status **65**.

This does not change the original permit's derivation. It shows that the audit's acceptance policy rejects one of its supporting sources.

A surrounding application must decide what to do with that result.

---

## What this small demonstration leaves open

The current audit catches an identified authority missing from its trust policy. It does not reject a source assertion whose attribution is missing entirely. A complete acceptance check needs that additional coverage check.

It also does not authenticate issuers, check whether evidence has expired, or establish legal compliance.

The audit itself can produce a proof, but some operations in Eyeron's checker remain explicit **trust obligations**: assumptions whose truth the checker does not verify. Always read the report.

See the [proof-checking contract](../../SPEC.md#9-proofs-and-verification) for the precise boundary.

---

## Why this matters when a decision travels

Imagine another organisation receives the permit.

Given the proof and the relevant source program, it can check whether the recorded reasoning supports that decision. Given authority mappings and its own trust policy, it can also inspect whose assertions are involved.

It still needs to assess those sources and whether the rules apply to its intended use.

The examples define two local predicates: `:holdsApproval` links a researcher to an accepted ethics approval, and `:says` holds a quoted policy graph. Engine-specific terms describe proof steps and graph operations.

The two examples make three questions visible:

1. **Decision:** does the request meet the supplied rules?
2. **Proof:** do the recorded steps support the answer?
3. **Audit:** which sources does the answer rely on, and are they acceptable to us?
