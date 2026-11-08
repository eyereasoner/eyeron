# Finding a route through a river-crossing model

[wolf-goat-cabbage.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/wolf-goat-cabbage.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/wolf-goat-cabbage.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/wolf-goat-cabbage.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/wolf-goat-cabbage.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=wolf-goat-cabbage)

---

## The question

State lists describe which bank holds the traveler, wolf, goat, and cabbage.
N3 rules derive safe transitions under the stated conditions and use a
priority queue to find a least-cost route.

**Which least-cost safe route solves the stated river-crossing model?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:e :change :w .

# A (person, wolf, goat, cabbage) state is safe unless the goat is left
# alone with the wolf, or alone with the cabbage, on a side without the
# person.
{
    ?p a :Side .
    ?w1 a :Side .
    ?g a :Side .
    ?c a :Side .
    ?SCOPE log:notIncludes {
        ?w1 log:equalTo ?g .
        ?p log:notEqualTo ?w1
    } .
    ?SCOPE log:notIncludes {
        ?g log:equalTo ?c .
        ?p log:notEqualTo ?g
    } .
} => {
    (?p ?w1 ?g ?c) :isSafe true
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
(:w :w :w :w) :isSafe true .
(:w :w :w :e) :isSafe true .
:test :solution ((:w :w :w :w) (:e :w :e :w) (:w :w :e :w) (:e :e :e :w) (:w :e :w :w) (:e :e :w :e) (:w :e :w :e) (:e :e :e :e)) .
:test :solution ((:w :w :w :w) (:e :w :e :w) (:w :w :e :w) (:e :w :e :e) (:w :w :w :e) (:e :e :w :e) (:w :e :w :e) (:e :e :e :e)) .
:test :moves 7 .
(:w :w :e :w) :isSafe true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ (:w :w :w :w) :isSafe true . }
  pe:rule 1;
  pe:binding
    [ pe:var "SCOPE"; pe:value {
        <http://example.org/a> <http://example.org/b> <http://example.org/c> .
    } ],
    [ pe:var "c"; pe:value :w ],
    [ pe:var "g"; pe:value :w ],
    [ pe:var "p"; pe:value :w ],
    [ pe:var "w1"; pe:value :w ];
  pe:uses
    { :w a :Side . },
    { :w a :Side . },
    { :w a :Side . },
    { :w a :Side . },
    {
        {
            <http://example.org/a> <http://example.org/b> <http://example.org/c> .
        } log:notIncludes {
            :w log:equalTo :w .
            :w log:notEqualTo :w .
…
            :w log:equalTo :w .
            :w log:notEqualTo :w .
        } .
    }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 190 steps, 167 verified, 23 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 88; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 102; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 29; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 80; pe:failed 0 ];
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
eyeron examples/wolf-goat-cabbage.n3
eyeron -p examples/wolf-goat-cabbage.n3
eyeron -c examples/wolf-goat-cabbage.n3
```

---

## Takeaway

State constraints and queue-based route search jointly determine the crossing
plan.
