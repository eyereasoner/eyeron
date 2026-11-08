# Generating a rule for a named copy

[generated-skolem-rule.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/generated-skolem-rule.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/generated-skolem-rule.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/generated-skolem-rule.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/generated-skolem-rule.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=generated-skolem-rule)

---

## The question

A source has a value and a named copy. An N3 rule generates a backward rule
that exposes the source's value through the copy, showing a bound name carried
into a new rule.

**How can a named copy expose the source's value?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The copy already has a supplied IRI; this rule does not invent its name.
:s :value 1 .

# Any subject whose value can be found is classified as a Success.
{
    ?s :value ?value
} => {
    ?s a :Success
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
:s a :Success .
{
    skolem:bn_5 :value ?value .
} <= {
    :s :value ?value .
} .
skolem:bn_5 a :Success .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :s a :Success . }
  pe:rule 1;
  pe:binding
    [ pe:var "s"; pe:value :s ],
    [ pe:var "value"; pe:value 1 ];
  pe:uses { :s :value 1 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 6 steps, 6 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/generated-skolem-rule.n3
eyeron -p examples/generated-skolem-rule.n3
eyeron -c examples/generated-skolem-rule.n3
```

---

## Takeaway

A captured copy name carries a link to the source into a newly generated rule.
