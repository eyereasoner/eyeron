# Finding ten-link cycles in a graph

[basic-monadic.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/basic-monadic.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/basic-monadic.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/basic-monadic.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/basic-monadic.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=basic-monadic)

---

## The question

A fixed collection of triples supplies a graph-matching workload. A backward
N3 rule follows ten links of one property back to the starting node, and a
forward rule records each matching cycle.

**Which starting nodes close a ten-link cycle using one property?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:i30 :i12 :i33 .

# Ask for each supported cycle and report its bound starting point and property.
{
    :i42 :cycle ?C .
} => {
    :test :is {
        :i42 :cycle ?C .
    } .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:test :is {
    :i42 :cycle (:i9 :i9 :i9 :i9 :i9 :i9 :i9 :i9 :i9 :i9 :i9) .
} .
:test :is {
    :i42 :cycle (:i72 :i75 :i72 :i75 :i72 :i75 :i72 :i75 :i72 :i75 :i72) .
} .
:test :is {
    :i42 :cycle (:i81 :i81 :i81 :i81 :i81 :i81 :i81 :i81 :i81 :i81 :i81) .
} .
:test :is {
    :i42 :cycle (:i75 :i72 :i75 :i72 :i75 :i72 :i75 :i72 :i75 :i72 :i75) .
} .
:test :is {
    :i42 :cycle (:i87 :i87 :i87 :i87 :i87 :i87 :i87 :i87 :i87 :i87 :i87) .
} .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :i42 :cycle (:i9 :i9 :i9 :i9 :i9 :i9 :i9 :i9 :i9 :i9 :i9) . }
  pe:rule 1;
  pe:binding
    [ pe:var "D0"; pe:value :i9 ],
    [ pe:var "D1"; pe:value :i9 ],
    [ pe:var "D2"; pe:value :i9 ],
    [ pe:var "D3"; pe:value :i9 ],
    [ pe:var "D4"; pe:value :i9 ],
    [ pe:var "D5"; pe:value :i9 ],
    [ pe:var "D6"; pe:value :i9 ],
    [ pe:var "D7"; pe:value :i9 ],
    [ pe:var "D8"; pe:value :i9 ],
    [ pe:var "D9"; pe:value :i9 ];
  pe:uses
    { :i9 :i42 :i9 . },
    { :i9 :i42 :i9 . },
    { :i9 :i42 :i9 . },
    { :i9 :i42 :i9 . },
    { :i9 :i42 :i9 . },
    { :i9 :i42 :i9 . },
    { :i9 :i42 :i9 . },
    { :i9 :i42 :i9 . },
    { :i9 :i42 :i9 . },
    { :i9 :i42 :i9 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 15 steps, 15 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 15; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 10; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/basic-monadic.n3
eyeron -p examples/basic-monadic.n3
eyeron -c examples/basic-monadic.n3
```

---

## Takeaway

Repeated variables require the path to return to its own starting node.
