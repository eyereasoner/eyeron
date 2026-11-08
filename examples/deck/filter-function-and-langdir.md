# Filtering numbers and matching directed text

[filter-function-and-langdir.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/filter-function-and-langdir.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/filter-function-and-langdir.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/filter-function-and-langdir.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/filter-function-and-langdir.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=filter-function-and-langdir)

---

## The question

One rule selects a negative number; another recognizes a French literal marked
left-to-right. The example shows numeric conditions and exact matching of a
language-and-direction-tagged literal.

**Which number is negative, and does the greeting retain its language and direction?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The samples include a negative value and a literal with language and direction.
:n1 :value -3.5 .

# Only n1 passes the numeric test; n2 is positive.
{
    ?x :value ?v .
    ?v math:lessThan 0
} => {
    ?x :negative true
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:n1 :negative true .
:msg :languageDirection "ltr" .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :n1 :negative true . }
  pe:rule 1;
  pe:binding
    [ pe:var "v"; pe:value -3.5 ],
    [ pe:var "x"; pe:value :n1 ];
  pe:uses
    { :n1 :value -3.5 . },
    { -3.5 math:lessThan 0 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 6 steps, 6 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/filter-function-and-langdir.n3
eyeron -p examples/filter-function-and-langdir.n3
eyeron -c examples/filter-function-and-langdir.n3
```

---

## Takeaway

Numeric conditions and complete literal matching operate on different kinds of
evidence.
