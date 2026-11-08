# Building routes between cities

*Which towns can drive to Nantes, when every road is one way?*

[road-paths.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/road-paths.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/road-paths.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/road-paths.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/road-paths.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=road-paths)

---

## The question

A small map of French cities has ten roads, each one way: from Paris to
Orléans, Chartres and Amiens, from Chartres to Le Mans, from Le Mans to
Angers, from Angers to Nantes, and so on. Some trips need several roads in a
row.

**From which cities can you reach Nantes?**

---

## What we tell Eyeron

The roads are plain facts:

```n3
:paris :oneway :orleans .
:paris :oneway :chartres .
…
:chartres :oneway :lemans .
:lemans :oneway :angers .
:lemans :oneway :tours .
:angers :oneway :nantes .
```

Two rules say what a path is:

```n3
{
    ?A :oneway ?B .
} => {
    ?A :path ?B .
} .

{
    ?A :path ?B .
    ?B :path ?C .
} => {
    ?A :path ?C .
} .
```

A road is a path, and two paths end to end make a path. Together they give
the *transitive closure*: every city you can reach in any number of steps.

Finally a query picks out what we want to see:

```n3
{
    ?A :path :nantes .
} log:query {
    ?A :path :nantes .
} .
```

`log:query` means: print the right side for every way the left side
matches, and print nothing else. Eyeron computes many more paths (Paris to
Tours, Orléans to Blois, …), but only paths to Nantes are reported.

The program also has a rule that restates a path to Nantes as itself; it
adds nothing, and the proof never needs it.

---

## What Eyeron concludes

```n3
:angers :path :nantes .
:lemans :path :nantes .
:chartres :path :nantes .
:paris :path :nantes .
```

Four cities. Amiens, Orléans, Blois, Bourges and Tours have no road leading
on towards Nantes, so they do not appear.

---

## The proof: one road at a time

Each answer is built up from roads. Chartres, for example, reaches Nantes
through Le Mans and Angers:

```n3
{ :chartres :path :nantes . }
  pe:rule 2;
  pe:binding
    [ pe:var "A"; pe:value :chartres ],
    [ pe:var "B"; pe:value :angers ],
    [ pe:var "C"; pe:value :nantes ];
  pe:uses
    { :chartres :path :angers . },
    { :angers :path :nantes . }.
```

Rule 2 glues *Chartres to Angers* and *Angers to Nantes* together. The first
of those is again rule 2 (Chartres to Le Mans, Le Mans to Angers), and so on
down to rule 1 steps that turn a single road into a path, and fact steps that
point at the road in `road-paths.n3`:

```n3
{ :angers :oneway :nantes . }
  pe:fact "road-paths.n3".
```

Steps are shared: *Angers to Nantes* is proved once and used by every city
whose route passes through Angers. The whole proof has 14 steps for the four
answers.

---

## Checked: what the report says

```n3
# checked: 14 steps, 14 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 14; pe:failed 0 ];
pe:condition [ pe:id "C4"; pe:name "coverage"; pe:checked 24; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 30; pe:failed 0 ].
```

- **C1 resolution**: each of the 14 steps really is rule 1, rule 2 or a fact
  with the recorded bindings.
- **C2 well-foundedness**: no path is used to prove itself, even though the
  path rule is recursive.
- **C3 justification** and **C4 coverage**: every road cited is in the
  source, and every premise of a rule step has a step of its own.
- **C7 relevance**: nothing in the proof is padding.
- **C10 call fidelity**: the premises were checked as the rules and the
  query actually ask them.

There is no calculation, negation or invented individual, so the other
conditions examine nothing. 14 of 14 steps verified: **checked**. The
verdict covers these four answers; it does not claim there are no others.

---

## Try it

```sh
eyeron examples/road-paths.n3
eyeron -p examples/road-paths.n3
eyeron -c examples/road-paths.n3
```

Add a road `:tours :oneway :nantes .` and run again: Tours, Blois and Orléans
now reach Nantes too, seven cities in all.

---

## Takeaway

Two short rules turn a list of roads into every possible route, and the proof
spells out each route road by road.
