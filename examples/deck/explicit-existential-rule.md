# A universally quantified rule with fresh mothers

[explicit-existential-rule.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/explicit-existential-rule.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/explicit-existential-rule.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/explicit-existential-rule.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/explicit-existential-rule.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=explicit-existential-rule)

---

## The question

A rule says that each human has some mother, and Tom is a human. Explicit N3
quantifiers distinguish the universally bound person from a fresh existential
witness in the conclusion.

**What mother relationship follows when Tom is known to be human?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The only human.
:tom a :Human .

{
    :x a :Human
} => {
    @forSome :y .
    :x :hasMother :y
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:tom :hasMother _:__q2_55b9a087b9c101d5 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :tom :hasMother _:__q2_55b9a087b9c101d5 . }
  pe:rule 1;
  pe:binding [ pe:var "__q1"; pe:value :tom ];
  pe:uses { :tom a :Human . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 2 steps, 1 verified, 1 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Witness integrity checks the introduction and use of unnamed individuals.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `unsatisfied`.

---

## Try it

```sh
eyeron examples/explicit-existential-rule.n3
eyeron -p examples/explicit-existential-rule.n3
eyeron -c examples/explicit-existential-rule.n3
```

---

## Takeaway

Explicit quantifiers distinguish every human from some mother for that human.
