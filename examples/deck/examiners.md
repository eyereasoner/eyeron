# Counting a course's examiners

[examiners.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/examiners.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/examiners.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/examiners.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/examiners.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=examiners)

---

## The question

Wittgenstein participates in the philosophy course that Russell and
Wittgenstein both teach. Participants are students, and a teacher who is not a
student is an examiner. Every course with a participant also needs some
examiner, so that rule's conclusion has a blank node. Russell already
satisfies it, so eyeron introduces no fresh examiner and counts exactly one.
The example shows scoped negation, an existential that is introduced only when
no known fact satisfies it, and a count over the result.

**How many examiners are needed once the eligible teacher is recognized?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Facts
:philosophy :teacher :russell .

# Participants are students.
{
    ?course :participant ?person .
} => {
    ?person a :Student .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:wittgenstein a :Student .
:philosophy :examiner :russell .
:philosophy :numberOfExaminers 1 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :wittgenstein a :Student . }
  pe:rule 1;
  pe:binding
    [ pe:var "course"; pe:value :philosophy ],
    [ pe:var "person"; pe:value :wittgenstein ];
  pe:uses { :philosophy :participant :wittgenstein . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 8 steps, 7 verified, 1 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 3; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `collected`.

---

## Try it

```sh
eyeron examples/examiners.n3
eyeron -p examples/examiners.n3
eyeron -c examples/examiners.n3
```

---

## References

[Source reference 1](https://arxiv.org/abs/2607.28778)

---

## Takeaway

An existential requirement can already be satisfied by an individual present
in the data.
