# Inspecting replayed RDF message boundaries

[rdf-messages.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rdf-messages.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/rdf-messages.trig) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rdf-messages.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rdf-messages.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rdf-messages.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rdf-messages)

---

## The question

An RDF Message Log supplies ordered messages and payload graphs. N3 rules
inspect the replay view to derive boundary, order, and payload information
without merging the messages into one graph.

**What ordering and payload facts are visible after replaying the message log?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Every parser-replayed envelope is an explicit message boundary.
{
    ?Stream a eymsg:RDFMessageStream ;
        eymsg:envelope ?Envelope .
    ?Envelope a eymsg:MessageEnvelope ;
        eymsg:offset ?Offset .
} => {
    ?Envelope :boundaryExplicit true .
    ?Stream :replayContains ?Envelope .
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
RDF Message Log accepted: 3 parser-replayed message boundaries are preserved. The middle message is an empty heartbeat, and the same source-local blank-node label is safely reused because Eyeron scopes blank nodes per message.
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ <urn:eyeron:rdf-message-stream:1:envelope:1> :boundaryExplicit true . }
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
# checked: 47 steps, 47 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 41; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 20; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Standalone RDF sample

The standalone RDF Message Log has two readings and an empty heartbeat.
It is a smaller syntax sample than the replay input used by these rules.

[rdf-messages.trig](https://github.com/eyereasoner/eyeron/blob/main/examples/rdf-messages.trig)

---

## Try it

```sh
eyeron -r examples/rdf-messages.n3 examples/input/rdf-messages.trig
eyeron -p -r examples/rdf-messages.n3 examples/input/rdf-messages.trig
eyeron -c -r examples/rdf-messages.n3 examples/input/rdf-messages.trig
```

---

## Takeaway

Replay exposes separate message boundaries rather than treating every payload
as one graph.
