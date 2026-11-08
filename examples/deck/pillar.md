# Resolving mutually recursive relations

[pillar.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/pillar.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/pillar.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/pillar.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/pillar.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=pillar)

---

## The question

A post points to a pillar, and two backward rules express the relation in
opposite directions. A forward N3 rule asks what the pillar points to and
records the supported answer.

**What does the pillar point to under the mutually recursive definitions?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# This given fact anchors the mutually recursive definitions.
:Post :to :Pillar .

# The forward question reports Post, supported by the given link.
{
    :Pillar :to ?What
} => {
    :result :is ?What
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
:result :is :Post .
:test :is true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :is :Post . }
  pe:rule 3;
  pe:binding [ pe:var "What"; pe:value :Post ];
  pe:uses { :Pillar :to :Post . }.
```

`pe:rule 3` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 4 steps, 4 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 3; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/pillar.n3
eyeron -p examples/pillar.n3
eyeron -c examples/pillar.n3
```

---

## Takeaway

The given Post link anchors the answer; the recursive rules alone would
provide no evidence.
