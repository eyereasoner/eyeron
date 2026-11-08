# Constructing a patched graph

[patch.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/patch.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/patch.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/patch.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/patch.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=patch)

---

## The question

A source graph is paired with delete and insert graphs. N3 rules collect
source statements that survive deletion and combine them with the insertions
to derive a new graph value.

**Which source statements survive deletion, and what graph results after insertion?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:patch1 :source {
    :alice a :Person ;
        :age 30 ;
        :status :OldStatus ;
        :email "alice@example.org" .
…
        :alice :age 31 ;
            :status :ActiveStatus ;
            :verified true .
    } .

{
    :patch1 :source ?G ;
        :delete ?Del ;
        :insert ?Ins .

    # Collect exactly the triples from ?G that are NOT included in the delete graph term ?Del
    (
        {
            ?S ?P ?O .
        }
        {
            ?S ?P ?O .
            ?Del log:notIncludes {
                ?S ?P ?O .
            } .
        }
        ?keptTriples
    ) log:collectAllIn ?G .

…
    (?keptGraph ?Ins) log:conjunction ?patched .
} => {
    :patch1 :result ?patched .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The ellipsis omits part of the source; the linked file
contains the full program.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:patch1 :result {
    :alice a :Person .
    :bob a :Person .
    :alice :age 31 .
    :alice :status :ActiveStatus .
    :alice :verified true .
} .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
@prefix : <http://example.org/> .
@prefix log: <http://www.w3.org/2000/10/swap/log#> .
@prefix pe: <https://eyereasoner.github.io/pe#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

:patch1 :result {
    :alice a :Person .
    :bob a :Person .
    :alice :age 31 .
    :alice :status :ActiveStatus .
    :alice :verified true .
} .

{
  :patch1 :result {
      :alice a :Person .
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 7 steps, 7 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ].
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
eyeron examples/patch.n3
eyeron -p examples/patch.n3
eyeron -c examples/patch.n3
```

---

## Takeaway

A graph patch constructs a new value from explicit source, delete and insert
graphs.
