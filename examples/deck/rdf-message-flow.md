# RDF Message Logs in Eyeron — from stream to reasoning

[rdf-message-flow.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rdf-message-flow.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/rdf-message-flow.trig) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rdf-message-flow.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rdf-message-flow.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rdf-message-flow.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rdf-message-flow)

This deck reads alongside the [rules](../rdf-message-flow.n3) and the replayed [message log input](../input/rdf-message-flow.trig): the [golden output](../output/rdf-message-flow.md) shows what Eyeron derives once `-r` has exposed the RDF Message envelopes and payload graphs.

The goal is to show, in plain language, how Eyeron can now read an RDF Message Log directly instead of asking the example data to describe its own message envelopes by hand.

---

## The question

Many real systems do not receive one big dataset.

They receive a stream of small updates:

- a sensor reading,
- a command,
- a status heartbeat,
- an alert,
- another sensor reading.

Each update matters as a separate communication event.

If we simply merge everything into one graph, we lose the order and the boundary between messages.

---

## A message is a sealed packet

Think of an RDF Message as a sealed packet of RDF data.

Inside the packet there may be triples or named graphs.

Outside the packet there is the stream order: first message, second message, third message, and so on.

The important idea is:

> The reasoner should know when one message ends and the next one begins.

---

## What an RDF Message Log adds

An RDF Message Log is a replayable record of a message stream.

Instead of saying “subscribe to this live channel”, the file says:

> Here are the messages that arrived, in order.

That makes it useful for examples, tests, audits, debugging, reproducible reasoning, and explanations.

---

## The new syntax in the input file

The input begins with:

```trig
VERSION "1.2-messages"
```

That tells Eyeron:

> This file contains message boundaries.

Then each boundary is written as:

```trig
MESSAGE
```

So the file can look like this:

```trig
# message 1 data
:temperatureFlow :highThreshold 26 .
_:obs sosa:hasSimpleResult 21 .

MESSAGE

# message 2 data
_:obs sosa:hasSimpleResult 22 .

MESSAGE

# message 3: empty heartbeat
MESSAGE

# message 4 data
_:obs sosa:hasSimpleResult 28 .
```

---

## What Eyeron does internally

Eyeron does not treat `MESSAGE` as an ordinary RDF term.

It handles it before normal N3 reasoning starts.

Internally, Eyeron turns the log into a replay view:

- one stream resource,
- one envelope per message,
- an offset for each envelope,
- a link to the next envelope,
- a payload graph for each non-empty message,
- and an explicit marker for empty messages.

The rules then reason over that replay view.

---

## Why this is better than hand-written envelopes

Before this change, the example input had to describe the stream manually:

- message `:m001`,
- message `:m002`,
- payload graph `in:payload001`,
- next message links,
- payload kind markers,
- offsets.

That worked, but it made the example bulky.

It also mixed two concerns:

1. the message-log machinery, and
2. the domain logic of routing temperature observations.

Now Eyeron handles the message-log machinery.

The N3 file can focus on the logic.

---

## What the temperature-flow example does

The example models a small stream processor.

Messages move through these stages:

1. ingest,
2. validate,
3. interpret,
4. route,
5. sink.

The stream contains temperature readings and one empty heartbeat.

The rules route normal readings to an archive sink and high readings to an alert sink.

---

## The empty heartbeat matters

One message in the example contains no RDF triples.

That is not an error.

It represents a heartbeat:

> “The stream is still alive, even though there is no new observation payload.”

Eyeron still creates an envelope for it.

That means the empty message keeps its place in the ordered replay.

---

## Blank nodes stay message-local

The input deliberately reuses the same blank-node label in several messages:

```trig
_:obs sosa:hasSimpleResult 21 .

MESSAGE

_:obs sosa:hasSimpleResult 22 .
```

That does not mean both messages talk about the same blank node.

In a message log, blank-node labels are scoped to the message.

Eyeron rewrites them internally so each message gets its own blank nodes.

---

## How the N3 rules see the replay

The N3 rules do not see `MESSAGE` directly.

They see Eyeron’s replay vocabulary, `eymsg:`.

For example, a rule can ask:

```n3
?Stream a eymsg:RDFMessageStream;
  eymsg:firstEnvelope ?Envelope.
```

Another rule can inspect a payload:

```n3
?Envelope eymsg:payloadGraph ?Payload.
?Payload log:nameOf ?PayloadContext.
?PayloadContext log:includes {
  ?Observation sosa:hasSimpleResult ?Result.
}.
```

That keeps each message payload inside its own context.

---

## Back pressure in one sentence

The example releases only the first envelope at the start.

Each envelope must reach the sink before the next envelope is released.

That gives a simple form of ordered replay or back pressure:

> process this message, then release the next one.

---

## What the final answer says

When the example succeeds, Eyeron reports that five parser-replayed envelopes moved through the flow.

With a threshold of 26:

- 21 is archived,
- 22 is archived,
- the empty heartbeat is accepted,
- 28 becomes an alert,
- 29 becomes an alert.

The important part is not only the routing result.

The important part is that the result was derived while preserving message boundaries.

---

## Why a wide audience should care

This pattern is useful wherever data arrives over time:

- sensors,
- event logs,
- audit trails,
- clinical systems,
- energy systems,
- pub/sub channels,
- digital twins,
- provenance streams.

You can replay the stream, reason over each message atomically, and explain what happened without flattening the whole history into one graph.

---

## Why the message boundaries matter

`MESSAGE` is the boundary.

Eyeron turns those boundaries into ordered replay envelopes.

The N3 rules consume the replay and focus on the domain logic.

That makes the example shorter, clearer, and closer to how a real pub/sub channel would be processed.

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Eyeron's parser-level replay exposes the first envelope; that starts the
# consumer-visible flow. Later envelopes are released only by the sink rule.
{
    ?Stream a eymsg:RDFMessageStream ;
        eymsg:firstEnvelope ?Envelope .
} => {
    ?Envelope :atStage :ingest .
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
Continuous RDF Message flow accepted: 5 ordered parser-replayed message envelopes moved through the ingest → validate → interpret → route → sink pipeline. The threshold was 26, so results 21 and 22 were archived, the empty heartbeat kept the stream alive, and results 28 and 29 were emitted as alerts.
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ <urn:eyeron:rdf-message-stream:1:envelope:1> :atStage :ingest . }
  pe:rule 1;
  pe:binding
    [ pe:var "Envelope"; pe:value <urn:eyeron:rdf-message-stream:1:envelope:1> ],
    [ pe:var "Stream"; pe:value <urn:eyeron:rdf-message-stream:1> ];
  pe:uses
    { <urn:eyeron:rdf-message-stream:1> a eymsg:RDFMessageStream . },
    { <urn:eyeron:rdf-message-stream:1> eymsg:firstEnvelope <urn:eyeron:rdf-message-stream:1:envelope:1> . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 98 steps, 98 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 87; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 11; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 57; pe:failed 0 ].
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
eyeron -r examples/rdf-message-flow.n3 examples/input/rdf-message-flow.trig
eyeron -p -r examples/rdf-message-flow.n3 examples/input/rdf-message-flow.trig
eyeron -c -r examples/rdf-message-flow.n3 examples/input/rdf-message-flow.trig
```

---

## Takeaway

RDF Message replay exposes ordering and boundaries that the rules can inspect.
