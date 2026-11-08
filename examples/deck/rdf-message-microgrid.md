# Coordinating a microgrid from RDF messages

[rdf-message-microgrid.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rdf-message-microgrid.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/rdf-message-microgrid.trig) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rdf-message-microgrid.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rdf-message-microgrid.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rdf-message-microgrid.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rdf-message-microgrid)

---

## The question

An RDF Message Log supplies separate microgrid observations and control
evidence. N3 rules inspect the message payloads and derive the modeled
energy-management decisions with their supporting checks.

**Which microgrid decisions follow from the separate message payloads?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Every envelope in the replay view is an explicit parser-recognized boundary.
{
    ?Stream a eymsg:RDFMessageStream ;
        eymsg:envelope ?Message .
    ?Message a eymsg:MessageEnvelope ;
        eymsg:offset ?Offset .
} => {
    ?Message :boundaryExplicit true .
    ?Stream :replayContains ?Message .
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
Storm clinic microgrid accepted: 5 parser-replayed RDF Messages were processed atomically. Critical care needs 620 W, current battery plus solar gives 800 W, and deferring the EV chargers frees 600 W, so the protected budget is 1400 W. The reasoned action is to keep the oxygen concentrator and vaccine fridge online, while deferring EV charging.
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ <urn:eyeron:rdf-message-stream:1:envelope:1> :boundaryExplicit true . }
  pe:rule 1;
  pe:binding
    [ pe:var "Message"; pe:value <urn:eyeron:rdf-message-stream:1:envelope:1> ],
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
# checked: 67 steps, 67 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 58; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 29; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron -r examples/rdf-message-microgrid.n3 examples/input/rdf-message-microgrid.trig
eyeron -p -r examples/rdf-message-microgrid.n3 examples/input/rdf-message-microgrid.trig
eyeron -c -r examples/rdf-message-microgrid.n3 examples/input/rdf-message-microgrid.trig
```

---

## Takeaway

Message identity and payload boundaries are part of the evidence for each
decision.
