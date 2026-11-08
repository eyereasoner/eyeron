# Finding a least-cost route

[dijkstra.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/dijkstra.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/dijkstra.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/dijkstra.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/dijkstra.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=dijkstra)

---

## The question

Weighted links connect several locations. Backward N3 rules implement a
priority queue with lists to find a shortest route and its total cost.

**Which route has the least total link cost?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Nonnegative edge costs; the next rule makes every connection two-way.
(:a :b) :edge 4 .

{
    (?A ?B) :edge ?C .
} => {
    (?B ?A) :edge ?C .
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
(:b :a) :edge 4 .
(:c :a) :edge 2 .
(:a :f) :path ((:a :c :d :e :f) 15) .
(:a :f) :path ((:a :c :d :f) 16) .
(:c :b) :edge 1 .
(:d :b) :edge 5 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ (:b :a) :edge 4 . }
  pe:rule 1;
  pe:binding
    [ pe:var "A"; pe:value :a ],
    [ pe:var "B"; pe:value :b ],
    [ pe:var "C"; pe:value 4 ];
  pe:uses { (:a :b) :edge 4 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 344 steps, 246 verified, 98 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 137; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 207; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 98; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 128; pe:failed 0 ];
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
eyeron examples/dijkstra.n3
eyeron -p examples/dijkstra.n3
eyeron -c examples/dijkstra.n3
```

---

## Takeaway

A priority queue processes cheaper partial routes before more expensive ones.
