# Applying a blocking policy before eligibility

[policy.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/policy.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/policy.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/policy.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/policy.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=policy)

---

## The question

People can be blocked directly or through a flagged classification. N3 rules
derive the blocking consequences and use a scoped absence test to identify the
remaining eligible people.

**Who remains eligible after the flagged person's blocking consequence is derived?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Alice is already blocked; Carol is flagged; Bob has neither classification.
:alice a :Person .

# Settle the positive blocking consequences before absence is considered.
{
    ?x a :Flagged
} => {
    ?x a :Blocked
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:carol a :Blocked .
:bob a :Eligible .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :carol a :Blocked . }
  pe:rule 1;
  pe:binding [ pe:var "x"; pe:value :carol ];
  pe:uses { :carol a :Flagged . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 5 steps, 5 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/policy.n3
eyeron -p examples/policy.n3
eyeron -c examples/policy.n3
```

---

## Takeaway

Absence must be tested after the positive rules that can establish the
excluded condition.
