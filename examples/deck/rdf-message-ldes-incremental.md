# RDF Message LDES Incremental Repair

[rdf-message-ldes-incremental.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rdf-message-ldes-incremental.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/rdf-message-ldes-incremental.trig) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rdf-message-ldes-incremental.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rdf-message-ldes-incremental.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rdf-message-ldes-incremental.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rdf-message-ldes-incremental)

This deck walks through a stream that is large enough to make full recomputation unattractive. The [rules](../rdf-message-ldes-incremental.n3) consume the replayed LDES [message log input](../input/rdf-message-ldes-incremental.trig), the [golden output](../output/rdf-message-ldes-incremental.md) shows the incremental repair result.

---

## The question

A long-running stream should not force a reasoner to reload and re-check all past data every time a new event arrives.

This example shows the intended shape:

1. publish events as an append-only **LDES**;
2. serialize each emitted member as an **RDF Message**;
3. remember a sequence bookmark from the previous synchronization run;
4. reason only over the new tail;
5. repair a noisy inconsistency before materializing the operational result.

## The story

A building monitors a fire door, `doorA`.

The stream contains forty door observations.  Most are boring historical facts that were already processed.  The consumer has stored this checkpoint:

```turtle
:doorStream :lastCommittedSequence 34 .
```

So when the log is replayed, the reasoner can classify:

- sequences `1..34` as committed history;
- sequences `35..40` as newly emitted LDES members;
- the new tail as the current repair window.

## Why RDF Messages help

The input file is a real RDF Message Log:

```turtle
VERSION "1.2-messages"
...
MESSAGE
...
MESSAGE
...
```

Eyeron's `-r` mode preserves those message boundaries as `eymsg:` envelopes and payload graphs.  The rules inspect payloads with `log:includes`, so each member remains scoped to the message that emitted it.

## Why LDES helps

LDES contributes the stream shape:

```turtle
:doorStream a ldes:EventStream ;
  ldes:timestampPath :observedAt ;
  ldes:sequencePath :sequence ;
  tree:member :obs-040 .
```

The stream is append-only, and each member has a sequence number.  That sequence number is the incremental bookmark: a consumer that already committed `34` does not need to re-run the repair over members `1..34`.

LDES spec: <https://semiceu.github.io/LinkedDataEventStreams/releases/1.0.0-alpha/index.html>

## The inconsistency

The new tail contains contradictory evidence:

- the camera says `doorA` is `:open`;
- the latch says `doorA` is `:closed`;
- the safety controller also says `doorA` is `:closed`, with higher priority.

Raw materialization would say the same door is both open and closed.

## The repair

The preferred repair keeps the highest-priority tail assertion:

```turtle
:obs-040 :doorState :closed ;
  :priority 5 ;
  :source "safety-controller" .
```

The materialized action is therefore:

> keep the compartment sealed and continue monitoring

## Replay the input

```bash
eyeron -r examples/rdf-message-ldes-incremental.n3 \
  examples/input/rdf-message-ldes-incremental.trig
```

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Eyeron's RDF-message replay gives us a static, ordered view of a message log.
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
Incremental LDES reasoning accepted: 41 RDF Message envelopes contained 40 append-only LDES members. The consumer checkpoint was sequence 34, so 34 committed history members were skipped and only 6 newly emitted members entered the repair window. The tail window has 6 members, contains a raw open/closed inconsistency for doorA, repairs it by keeping the priority-5 member at sequence 40 from safety-controller, resolves the door state to closed, and materializes the action: keep the compartment sealed and continue monitoring.
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
# checked with obligations: 836 steps, 832 verified, 4 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 737; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 99; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 530; pe:failed 0 ];
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
eyeron -r examples/rdf-message-ldes-incremental.n3 examples/input/rdf-message-ldes-incremental.trig
eyeron -p -r examples/rdf-message-ldes-incremental.n3 examples/input/rdf-message-ldes-incremental.trig
eyeron -c -r examples/rdf-message-ldes-incremental.n3 examples/input/rdf-message-ldes-incremental.trig
```

---

## Takeaway

The checkpoint limits the evidence considered by the repair rules; the input
log is still replayed for this run.
