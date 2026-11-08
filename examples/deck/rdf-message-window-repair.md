# RDF Message window repair — fixing an open/closed door conflict

[rdf-message-window-repair.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rdf-message-window-repair.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/rdf-message-window-repair.trig) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rdf-message-window-repair.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rdf-message-window-repair.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rdf-message-window-repair.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rdf-message-window-repair)

This deck follows a small RDF Message window where one door is reported both open and closed. The [rules](../rdf-message-window-repair.n3) inspect the replayed [message log input](../input/rdf-message-window-repair.trig), the [golden output](../output/rdf-message-window-repair.md) shows the repaired conclusion.

The goal is to show how Eyeron can reason over a replayed RDF Message Log, keep message boundaries visible, detect an inconsistency in a sliding window, and materialize a repaired conclusion instead of blindly merging contradictory facts.

---

## The question

A building automation system receives RDF messages about a fire door.

The messages arrive from different devices:

- a corridor camera,
- a hallway latch sensor,
- and a safety controller.

Most of the time they agree. But in the example, the current message window says both of these things:

```text
doorA is open
doorA is closed
```

That is the inconsistency the example is meant to fix.

---

## Why ordinary merging is not enough

If all messages are merged into one graph, the system sees both facts at once.

For safety automation, that is not a useful final state. The system needs a current operational conclusion, such as:

```text
mark the fire compartment as sealed
```

or:

```text
send a technician to inspect and close the fire door
```

The example therefore separates two steps:

1. detect the raw conflict,
2. repair it before producing the final action.

---

## The message log

The input file is a real RDF Message Log:

```trig
VERSION "1.2-messages"
```

Each `MESSAGE` delimiter separates one communication event from the next.

Eyeron parses those delimiters before ordinary reasoning starts and exposes a replay model with `eymsg:` terms:

- one stream,
- one envelope per message,
- ordered envelope links,
- offsets,
- and one payload graph per non-empty message.

The rules reason over that replay model rather than pretending the stream was one big static graph.

---

## The five messages

The log has five messages.

Message 1 is policy and vocabulary:

- the sliding ABox window has size 3,
- the repair policy prefers higher-priority evidence,
- `:open` and `:closed` map to operational action text.

Messages 2 to 5 are door-state assertions.

---

## The sliding windows

The previous window contains messages 2, 3, and 4.

The current window contains messages 3, 4, and 5.

So when the window advances:

- message 2 expires,
- messages 3 and 4 are retained,
- message 5 enters.

This is the small stream-reasoning shape the example demonstrates.

---

## The inconsistency

In the current window:

- message 3 says `doorA` is `:open`,
- message 4 says `doorA` is `:closed`,
- message 5 also says `doorA` is `:closed`.

The raw materialized window therefore contains an open/closed contradiction.

The example records this explicitly as:

```n3
:currentWindow :rawConflict :doorOpenAndClosed .
```

---

## The repair policy

The repair policy is deliberately simple:

> If two current-window assertions conflict, keep the one with the higher priority.

The camera and latch readings have priority 1.

The safety-controller reading has priority 3.

So the repaired state is:

```text
doorA is closed
```

The lower-priority conflicting open assertion is still visible as rejected evidence; it is not silently erased.

---

## The final materialization

After repair, the rules derive the final action from the repaired state, not from the inconsistent raw window.

For this data, the final action is:

```text
mark the fire compartment as sealed
```

That conclusion is only produced after the example has shown all of these things:

- the RDF Message Log was replayed,
- the sliding windows were constructed,
- the raw open/closed conflict was detected,
- the preferred repair selected the higher-priority assertion,
- and the repaired state was materialized.

---

## What this example is useful for

This is a compact pattern for stream-style reasoning with noisy inputs.

It shows that RDF messages can be used as more than a transport format: their boundaries become part of the evidence.

That makes it possible to explain conclusions in terms of:

- which message arrived,
- which window it belonged to,
- whether it expired, was retained, or entered,
- whether it conflicted with another message,
- and why one assertion was preferred over another.

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Eyeron's parser-level replay gives a static view of the message log: an
# ordered list, explicit offsets, and next-envelope links.
{
    ?Stream a eymsg:RDFMessageStream ;
        eymsg:envelope ?Message .
    ?Message a eymsg:MessageEnvelope ;
        eymsg:offset ?Offset .
} => {
    ?Message :boundaryExplicit true .
    ?Message :offset ?Offset .
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
Sliding-window RDF Message repair accepted: 5 parser-replayed messages produced two overlapping 3-message ABox windows. The current window retained two envelopes from the previous window, expired one old door reading, and added one new safety-controller reading. Its raw graph-level materialization was inconsistent because doorA was both open and closed. The preferred repair kept the priority-3 assertion from safety-controller, resolved the door state to closed, and materialized the action: mark the fire compartment as sealed.
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
# checked: 104 steps, 104 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 95; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 63; pe:failed 0 ].
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
eyeron -r examples/rdf-message-window-repair.n3 examples/input/rdf-message-window-repair.trig
eyeron -p -r examples/rdf-message-window-repair.n3 examples/input/rdf-message-window-repair.trig
eyeron -c -r examples/rdf-message-window-repair.n3 examples/input/rdf-message-window-repair.trig
```

---

## Takeaway

A stated repair policy selects the evidence used by the final action rules.
