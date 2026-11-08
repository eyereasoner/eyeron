# Deriving an entailment from a triple term

[triple-terms.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/triple-terms.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/triple-terms.trig) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/triple-terms.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/triple-terms.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/triple-terms.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=triple-terms)

---

## The question

A companion RDF input records a device report as a reified triple term. N3
rules combine that report with an action requirement and return a derived
needs-action triple term.

**Which action follows from the reified device report in the companion input?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Deriving an entailment from a triple term
#
# A companion RDF input records a device report as a reified triple term.
# N3 rules combine that report with an action requirement and return a
# derived needs-action triple term.

VERSION "1.2"
@prefix : <https://eyereasoner.github.io/eyeling/examples/triple_terms#> .

# Read the required device evidence from the companion input before
# producing the derived action graph.
{
    ?observation rdf:reifies {
        ?device :reports ?condition .
    } .
    ?condition :requires ?action .
} => {
    ?observation :entails {
        ?device :needs ?action .
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
@prefix : <https://eyereasoner.github.io/eyeling/examples/triple_terms#> .
:observation :entails <<( :sensor :needs :inspection )>> .
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
{ :overheating :requires :inspection . }
  pe:fact "<unknown>".
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 5 steps, 5 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 8; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/triple-terms.n3 examples/input/triple-terms.trig
eyeron -p examples/triple-terms.n3 examples/input/triple-terms.trig
eyeron -c examples/triple-terms.n3 examples/input/triple-terms.trig
```

---

## Takeaway

A triple term can carry a derived action while retaining the statement as a
value.
