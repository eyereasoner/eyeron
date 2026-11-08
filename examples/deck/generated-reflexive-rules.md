# Generating a pair of reflexive rules

[generated-reflexive-rules.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/generated-reflexive-rules.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/generated-reflexive-rules.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/generated-reflexive-rules.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/generated-reflexive-rules.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=generated-reflexive-rules)

---

## The question

A property is marked reflexive. One N3 rule generates two backward rules that
can answer self-link questions for the endpoints of that property.

**Which two self-link rules follow from declaring a property reflexive?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# This declaration enables the generator for p.
:p a :Reflexive .

# For each reflexive property, generate two backward rules: one for each
# endpoint of an existing link. The inner variables belong to those rules.
{
    ?p a :Reflexive
} => {
    {
        ?x ?p ?x
    } <= {
        ?x ?p ?y
    } .
    {
        ?y ?p ?y
    } <= {
        ?x ?p ?y
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
{
    ?x :p ?x .
} <= {
    ?x :p ?y .
} .
{
    ?y :p ?y .
} <= {
    ?x :p ?y .
} .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :p a :Reflexive . }
  pe:fact "generated-reflexive-rules.n3".
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 3 steps, 3 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/generated-reflexive-rules.n3
eyeron -p examples/generated-reflexive-rules.n3
eyeron -c examples/generated-reflexive-rules.n3
```

---

## Takeaway

Generated rules capture the chosen property while retaining their own local
variables.
