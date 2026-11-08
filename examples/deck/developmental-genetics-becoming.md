# Following a cell's developmental lineage

[developmental-genetics-becoming.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/developmental-genetics-becoming.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/developmental-genetics-becoming.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/developmental-genetics-becoming.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/developmental-genetics-becoming.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=developmental-genetics-becoming)

---

## The question

A cell inherits gene markers and responds to developmental signals. N3 rules
select regulatory programs and derive successive cell states that can support
later transitions.

**Which later cell states follow from inherited markers and signals?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# CATEGORIES
:CellState a :Category .

# RULE 1
# A NEW CELL STATE INHERITS EXPRESSED MARKERS
{
    ?later :derivesFrom ?earlier .
    ?earlier :expresses ?marker .
} => {
    ?later :inheritsMarker ?marker .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:s2 :considers :proneuralProgram .
:s2 :targetsMarker :NeuroD1 .
:s3 :preservesMarker :Pax6 .
:s3 :expresses :Pax6 .
:s3 :considers :neuronalMaturationProgram .
:s3 :targetsMarker :Tubb3 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :s2 :considers :proneuralProgram . }
  pe:rule 2;
  pe:binding
    [ pe:var "cell"; pe:value :s2 ],
    [ pe:var "program"; pe:value :proneuralProgram ],
    [ pe:var "signal"; pe:value :neurogenicSignal ];
  pe:uses
    { :s2 :receives :neurogenicSignal . },
    { :neurogenicSignal :suggests :proneuralProgram . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 47 steps, 47 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 47; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 30; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/developmental-genetics-becoming.n3
eyeron -p examples/developmental-genetics-becoming.n3
eyeron -c examples/developmental-genetics-becoming.n3
```

---

## Takeaway

A developmental transition depends on the supplied regulatory conditions and
the previous state.
