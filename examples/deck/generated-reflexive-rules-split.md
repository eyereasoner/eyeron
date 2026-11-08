# Generating reflexive rules in separate steps

[generated-reflexive-rules-split.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/generated-reflexive-rules-split.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/generated-reflexive-rules-split.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/generated-reflexive-rules-split.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/generated-reflexive-rules-split.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=generated-reflexive-rules-split)

---

## The question

A property is marked reflexive. Two N3 rules separately generate backward
rules for self-links at either end of an existing relation, illustrating rules
produced as conclusions.

**Which self-link definitions are generated separately for the two endpoints?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Mark p reflexive; the output contains generated rules, not an enumeration
# of every self-link they could answer.
:p a :Reflexive .

# Generate a backward self-link rule for the subject of an existing link.
{
    ?p a :Reflexive
} => {
    {
        ?x ?p ?x
    } <= {
        ?x ?p ?y
    } .
} .

# A separate generator supplies the corresponding rule for the object.
{
    ?p a :Reflexive
} => {
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
  pe:fact "generated-reflexive-rules-split.n3".
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
eyeron examples/generated-reflexive-rules-split.n3
eyeron -p examples/generated-reflexive-rules-split.n3
eyeron -c examples/generated-reflexive-rules-split.n3
```

---

## Takeaway

A forward conclusion can add backward rules that answer later questions.
