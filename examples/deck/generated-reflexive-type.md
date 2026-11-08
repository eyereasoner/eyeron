# Generating self-links from a class

[generated-reflexive-type.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/generated-reflexive-type.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/generated-reflexive-type.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/generated-reflexive-type.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/generated-reflexive-type.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=generated-reflexive-type)

---

## The question

A reflexive property is associated with the class Human. N3 rules generate a
backward definition that gives each member of that class a self-link.

**What rule gives Human members a self-link through the chosen property?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Enable the rule for like and Human; Socrates supplies a class member.
:like a :Reflexive ;
    :range-include :Human .

# Capture the property and its associated class in a new backward rule.
# The rule can answer a self-link question for any member of that class.
{
    ?p a :Reflexive .
    ?p :range-include ?C
} => {
    {
        ?x ?p ?x
    } <= {
        ?x a ?C
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
    ?x :like ?x .
} <= {
    ?x a :Human .
} .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :like a :Reflexive . }
  pe:fact "generated-reflexive-type.n3".
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 3 steps, 3 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/generated-reflexive-type.n3
eyeron -p examples/generated-reflexive-type.n3
eyeron -c examples/generated-reflexive-type.n3
```

---

## Takeaway

A generated definition can be specialized to a property and a class.
