# Reasoning from a companion RDF dataset

[rdf-dataset.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rdf-dataset.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/rdf-dataset.trig) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rdf-dataset.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rdf-dataset.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rdf-dataset.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rdf-dataset)

---

## The question

A companion dataset describes sensor conditions and required actions. N3 rules
derive a work-order entailment and an audit graph, showing RDF input used as
evidence in N3 reasoning.

**Which work-order and audit conclusions follow from the companion sensor dataset?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Reasoning from a companion RDF dataset
#
# A companion dataset describes sensor conditions and required actions. N3
# rules derive a work-order entailment and an audit graph, showing RDF
# input used as evidence in N3 reasoning.

VERSION "1.2"
@prefix : <https://eyereasoner.github.io/eyeling/examples/rdf-dataset#> .

# Read the required device evidence from the companion input before
# producing the derived action graph.
{
    :sensor :reports ?condition .
    ?condition :requires ?action .
    :maintenanceSystem :trusted true .
} => {
    :workOrder :entails {
        :sensor :needs ?action .
    } .
    :audit log:nameOf {
        :workOrder :basedOn :factoryDataset .
        :workOrder :checkedBy :maintenanceSystem .
    } .
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
VERSION "1.2"
@prefix : <https://eyereasoner.github.io/eyeling/examples/rdf-dataset#> .
:workOrder :entails <<( :sensor :needs :inspection )>> .
```

---

The displayed text also comes from a fixed `log:outputString` template in
the source. It is a supplied sample, rather than text formatted from the
bindings of the entailment query. The proof records the derived entailment
and that separate display query.

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :sensor :reports :overheating . }
  pe:fact "<unknown>".
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 6 steps, 6 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 9; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/rdf-dataset.n3 examples/input/rdf-dataset.trig
eyeron -p examples/rdf-dataset.n3 examples/input/rdf-dataset.trig
eyeron -c examples/rdf-dataset.n3 examples/input/rdf-dataset.trig
```

---

## Takeaway

RDF data can supply evidence to N3 rules while graph values retain the audit
structure.
