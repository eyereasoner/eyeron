# Deriving a shared observation and flow view

*A sensor reading in local words, restated in shared ones.*

[knowledge-engineering-alignment-flow.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/knowledge-engineering-alignment-flow.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/knowledge-engineering-alignment-flow.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/knowledge-engineering-alignment-flow.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/knowledge-engineering-alignment-flow.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=knowledge-engineering-alignment-flow)

---

## The question

A team on a station platform sends temperature readings. They use their own
words: a *local observation*, *observed by*, *temperature Celsius*. The rest
of the organisation uses a shared vocabulary for sensor data, the W3C SOSA
ontology. Rewriting every message by hand, or writing one converter per
team, does not scale.

**If we only state how the local words relate to the shared ones, can a few
generic rules restate the message in shared terms, and hook it into a data
flow?**

---

## What we tell Eyeron

First the mapping, one line per local word:

```n3
:LocalObservation rdfs:subClassOf sosa:Observation .
:TemperatureProbe rdfs:subClassOf sosa:Sensor .
:observedBy rdfs:subPropertyOf sosa:madeBySensor .
:observedAt rdfs:subPropertyOf sosa:resultTime .
:temperatureCelsius rdfs:subPropertyOf sosa:hasSimpleResult .
:observedFeature owl:equivalentProperty sosa:hasFeatureOfInterest .
:inFlow rdfs:subPropertyOf fpv:hasFlowStep .
```

*Every local observation is a SOSA observation; "observed by" is a special
case of "made by sensor"*, and so on. Then the message, still in local terms:

```n3
:msg1 a :LocalObservation ;
    :observedBy :probe7 ;
    :observedAt "2026-06-17T12:34:56Z"^^xsd:dateTime ;
    :temperatureCelsius 18.6 ;
    :observedFeature :platformB ;
    :inFlow :ingestStep .
```

The semicolons repeat the subject: this is six statements about `:msg1`.

---

## The generic rules

The rules never name a local word. They only know what *subclass*,
*subproperty* and *equivalent property* mean:

```n3
{
    ?subject ?property ?object .
    ?property rdfs:subPropertyOf ?superProperty .
} => {
    ?subject ?superProperty ?object .
} .
```

Here the property itself is a variable, so one rule handles every mapped
property. Two more rules record, for each mapped property, that a streaming
runtime could simply copy it (`fpv:runtimeRule fpv:copyToTarget`). The last
rule joins three shared-vocabulary facts into a flow view:

```n3
{
    ?message a sosa:Observation ;
        fpv:hasFlowStep ?step ;
        sosa:madeBySensor ?sensor .
} => {
    ?step fpv:emits ?message ;
        fpv:trustedBy ?sensor .
} .
```

---

## What Eyeron concludes

The message, now in shared terms:

```n3
:msg1 a sosa:Observation .
:probe7 a sosa:Sensor .
:msg1 sosa:madeBySensor :probe7 .
:msg1 sosa:resultTime "2026-06-17T12:34:56Z"^^xsd:dateTime .
:msg1 sosa:hasSimpleResult 18.6 .
:msg1 sosa:hasFeatureOfInterest :platformB .
:msg1 fpv:hasFlowStep :ingestStep .
```

The plan for a runtime, one pair per mapped property, for example:

```n3
:observedBy fpv:runtimeRule fpv:copyToTarget .
:observedBy fpv:targetPredicate sosa:madeBySensor .
```

And the flow view:

```n3
:ingestStep fpv:emits :msg1 .
:ingestStep fpv:trustedBy :probe7 .
```

---

## The proof: from local words to the flow

The flow conclusion rests on three translated facts, each with its own step:

```n3
{ :ingestStep fpv:trustedBy :probe7 . }
  pe:rule 7;
  …
  pe:uses
    { :msg1 a sosa:Observation . },
    { :msg1 fpv:hasFlowStep :ingestStep . },
    { :msg1 sosa:madeBySensor :probe7 . }.
…
{ :msg1 sosa:madeBySensor :probe7 . }
  pe:rule 2;
  …
  pe:uses
    { :msg1 :observedBy :probe7 . },
    { :observedBy rdfs:subPropertyOf sosa:madeBySensor . }.
```

So *the ingest step is trusted by probe 7* traces back, step by step, to the
team's own statement *msg1 is observed by probe 7* and one line of mapping.

---

## Checked: what the report says

```n3
# checked: 33 steps, 33 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 33; pe:failed 0 ];
pe:condition [ pe:id "C4"; pe:name "coverage"; pe:checked 49; pe:failed 0 ];
pe:condition [ pe:id "C7"; pe:name "relevance"; pe:checked 52; pe:failed 0 ];
```

- **C1 resolution**: all 33 steps are given facts or real instances of the
  rules they cite.
- **C2, C3**: no step depends on itself, and each is justified.
- **C4 coverage**: each of the 49 premises used is backed by a step.
- **C7 relevance**: every step serves one of the 19 answers; **C10** checks
  each premise as it was called.

There is no calculation, negation or invented individual, so C5, C6, C8 and
C9 had nothing to examine. The verdict is **checked**.

---

## Try it

```sh
eyeron examples/knowledge-engineering-alignment-flow.n3      # the answers
eyeron -p examples/knowledge-engineering-alignment-flow.n3   # with the proof
eyeron -c examples/knowledge-engineering-alignment-flow.n3   # the proof, checked
```

Add a second message in local terms:

```text
:msg2 a :LocalObservation ;
    :observedBy :probe9 ;
    :inFlow :ingestStep .
```

Eyeron translates it with the same rules and concludes
`:ingestStep fpv:emits :msg2` and `:ingestStep fpv:trustedBy :probe9`. Note
that nothing says probe 9 is a temperature probe: the flow rule trusts
whatever sensor made the message, which a real policy may want to tighten.

---

## Takeaway

Mapping local words to a shared vocabulary once, and reasoning with generic
rules, translates every message the same way, with a proof that leads back
to the original words.
