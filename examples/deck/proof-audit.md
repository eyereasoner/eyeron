# Following the evidence in an N3 proof

[proof-audit.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/proof-audit.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/proof-audit.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/proof-audit.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/proof-audit.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/proof-audit.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=proof-audit)

---

## The question

A companion proof records how Socrates' mortality was derived. N3 rules follow
proof dependencies, identify supporting source facts, and inspect the bindings
used by rule applications.

**Which source facts and bindings support the recorded mortality derivation?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Load the companion proof as data. Copy direct dependencies, then follow
# their transitive closure to find indirect dependencies.
{
    ?step pe:uses ?dep
} => {
    ?step pa:dependsOn ?dep
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The companion input supplies additional facts; load it
together with the rules in the commands below.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
pa:test pa:root {
    :Socrates a :Mortal .
} .
pa:test pa:answerApplied ("A" :Human) .
pa:test pa:support {
    :Socrates a :Human .
} .
pa:test pa:support {
    :Human rdfs:subClassOf :Mortal .
} .
pa:test pa:answerApplied ("B" :Mortal) .
pa:test pa:answerApplied ("S" :Socrates) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ pa:test pa:answerApplied ("A" :Human) . }
  pe:rule 9;
  pe:binding
    [ pe:var "bindingNode"; pe:value _:b1 ],
    [ pe:var "name"; pe:value "A" ],
    [ pe:var "root"; pe:value {
        :Socrates a :Mortal .
    } ],
    [ pe:var "value"; pe:value :Human ];
  pe:uses
    {
        {
            :Socrates a :Mortal .
        } pe:binding _:b1 .
    },
    { _:b1 pe:var "A" . },
    { _:b1 pe:value :Human . },
    {
        pa:test pa:root {
            :Socrates a :Mortal .
        } .
    }.
```

`pe:rule 9` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 30 steps, 30 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 30; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 16; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/proof-audit.n3 examples/input/proof-audit.n3
eyeron -p examples/proof-audit.n3 examples/input/proof-audit.n3
eyeron -c examples/proof-audit.n3 examples/input/proof-audit.n3
```

---

## Takeaway

A proof can be read as ordinary data and queried for its dependency structure.
