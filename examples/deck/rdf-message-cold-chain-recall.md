# RDF Message Cold Chain Recall

[rdf-message-cold-chain-recall.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rdf-message-cold-chain-recall.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/rdf-message-cold-chain-recall.trig) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rdf-message-cold-chain-recall.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rdf-message-cold-chain-recall.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rdf-message-cold-chain-recall.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rdf-message-cold-chain-recall)

This deck follows a cold-chain stream where the cost of a wrong conclusion is concrete: either release a shipment or quarantine it. The [rules](../rdf-message-cold-chain-recall.n3) replay the LDES [message log input](../input/rdf-message-cold-chain-recall.trig), the [golden output](../output/rdf-message-cold-chain-recall.md) records the repaired decision.

---

## The question

A cold-chain monitor receives a long telemetry stream for a medicine batch.

Most readings are old and already materialized.  The consumer has a checkpoint, so reloading and rechecking the whole stream would be wasteful.  But the new tail is not clean: one message says the batch remained in range, while another says it crossed the temperature limit.

The example shows why streaming RDF reasoning needs three things together:

1. message boundaries, so the rules know which facts arrived together;
2. LDES sequence metadata, so the consumer resumes after a checkpoint;
3. a repair policy, so contradictory tail evidence is fixed before an operational decision is emitted.

## The story

`batchA` is moving through a cold-chain route.

The stream contains forty-eight telemetry observations.  The first forty-two were already processed in an earlier synchronization run:

```turtle
:telemetryStream :lastCommittedSequence 42 .
```

That leaves only messages `43..48` for the current incremental repair window.

## The contradiction

The new tail contains both kinds of evidence:

```turtle
:obs-043 :temperatureTenthC 45 .   # 4.5°C, within range
:obs-047 :temperatureTenthC 118 .  # 11.8°C, over the 8.0°C limit
```

Flattening the tail would make the batch look both safe and unsafe.

## The repair

The repair policy is intentionally simple and auditable: for recall decisions, a calibrated cold-chain logger wins over lower-priority telemetry.

```turtle
:obs-047 :source "calibrated-cold-chain-logger" ;
  :priority 5 ;
  :calibrationClass :calibratedLogger .
```

Because that repaired reading is over the limit, the materialized decision is:

> quarantine batchA, notify QA, and hold shipment

## Why this is a good streaming case

The example is not about proving that one temperature number is bigger than another.

It is about the shape of the pipeline:

- the stream can keep growing;
- the consumer can resume from a bookmark;
- old messages do not need to be reprocessed;
- the inconsistent new tail is repaired locally;
- the final output is based on the repaired state, not on the raw noisy merge.

## Replay the input

```bash
eyeron -r examples/rdf-message-cold-chain-recall.n3 \
  examples/input/rdf-message-cold-chain-recall.trig
```

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Parser replay gives us an ordered RDF Message stream.  Keep this visible in
# the derived data so the report can say how many messages were processed.
{
    ?Stream a eymsg:RDFMessageStream ;
        eymsg:envelope ?Envelope .
    ?Envelope a eymsg:MessageEnvelope ;
        eymsg:offset ?Offset .
} => {
    ?Envelope :messageOffset ?Offset ;
        :messageBoundaryExplicit true .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The companion input supplies additional facts; load it
together with the rules in the commands below.

---

## What Eyeron concludes

An excerpt of the saved text report:

```text
Cold-chain recall reasoning accepted: 49 RDF Message envelopes contained 48 append-only telemetry members. The consumer checkpoint was sequence 42, so 42 committed history members were skipped and only 6 newly emitted members entered the repair window. The tail window has 6 members and says batchA is both within range and over the 8.0°C limit. The repair keeps the calibrated logger evidence at sequence 47 from calibrated-cold-chain-logger with priority 5, resolves the repaired temperature to 11.8°C, and materializes the decision: quarantine batchA, notify QA, and hold shipment.
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ <urn:eyeron:rdf-message-stream:1:envelope:1> :messageOffset 0 . }
  pe:rule 1;
  pe:binding
    [ pe:var "Envelope"; pe:value <urn:eyeron:rdf-message-stream:1:envelope:1> ],
    [ pe:var "Offset"; pe:value 0 ],
    [ pe:var "Stream"; pe:value <urn:eyeron:rdf-message-stream:1> ];
  pe:uses
    { <urn:eyeron:rdf-message-stream:1> a eymsg:RDFMessageStream . },
    { <urn:eyeron:rdf-message-stream:1> eymsg:envelope <urn:eyeron:rdf-message-stream:1:envelope:1> . },
    { <urn:eyeron:rdf-message-stream:1:envelope:1> a eymsg:MessageEnvelope . },
    { <urn:eyeron:rdf-message-stream:1:envelope:1> eymsg:offset 0 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 1035 steps, 1031 verified, 4 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 918; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 117; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 671; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `collected`.

---

## Try it

```sh
eyeron -r examples/rdf-message-cold-chain-recall.n3 examples/input/rdf-message-cold-chain-recall.trig
eyeron -p -r examples/rdf-message-cold-chain-recall.n3 examples/input/rdf-message-cold-chain-recall.trig
eyeron -c -r examples/rdf-message-cold-chain-recall.n3 examples/input/rdf-message-cold-chain-recall.trig
```

---

## Takeaway

The example filters replayed messages by sequence and applies a stated
priority policy before deriving the recall result.
