# An examiner who holds a diploma

[examiner-diploma.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/examiner-diploma.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/examiner-diploma.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/examiner-diploma.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/examiner-diploma.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=examiner-diploma)

---

## The question

Wittgenstein participates in the philosophy course that Russell and
Wittgenstein both teach. A teacher who is not a student is an examiner, every
examiner is a person with some diploma, and every course with a participant
needs some examiner who is a person with a diploma. Once Russell's diploma is
introduced, Russell is that examiner, so eyeron introduces no fresh examiner,
gives Russell one diploma, and counts exactly one examiner. The example shows
that a rule completing an existing individual takes precedence over an
existential that would introduce a new one.

**Can an existing teacher satisfy the need for an examiner with a diploma?**

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
:russell :has _:x_f83503b81d199c51 .
_:x_f83503b81d199c51 a :Diploma .
:philosophy :numberOfExaminers 1 .
:russell a :Person .
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
# checked with obligations: 11 steps, 8 verified, 3 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 8; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 6; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Witness integrity checks the introduction and use of unnamed individuals.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `collected`,
`unsatisfied`.

---

## Try it

```sh
eyeron examples/examiner-diploma.n3
eyeron -p examples/examiner-diploma.n3
eyeron -c examples/examiner-diploma.n3
```

---

## Takeaway

Completing the known examiner's evidence can avoid introducing a second
examiner.
