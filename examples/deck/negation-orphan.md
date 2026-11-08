# Finding people with no recorded parent

[negation-orphan.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/negation-orphan.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/negation-orphan.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/negation-orphan.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/negation-orphan.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=negation-orphan)

---

## The question

Two people are known, but only one has a child-of link. An N3 rule uses scoped
negation as failure to label the person with no parent recorded in this graph.

**Who has no recorded parent in this scope?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Alice has a recorded parent; Bob has none in this dataset.
:alice a :Person .

# Bind the person before testing absence. Orphan means no childOf link
# was found here; it does not establish a real-world family circumstance.
{
    ?x a :Person .
    ?SCOPE log:notIncludes {
        ?x :childOf ?y
    } .
} => {
    ?x a :Orphan
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:bob a :Orphan .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :bob a :Orphan . }
  pe:rule 1;
  pe:binding
    [ pe:var "SCOPE"; pe:value {
        <http://example.org/a> <http://example.org/b> <http://example.org/c> .
    } ],
    [ pe:var "x"; pe:value :bob ];
  pe:uses
    { :bob a :Person . },
    {
        {
            <http://example.org/a> <http://example.org/b> <http://example.org/c> .
        } log:notIncludes {
            :bob :childOf ?y .
        } .
    }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 3 steps, 3 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ].
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
eyeron examples/negation-orphan.n3
eyeron -p examples/negation-orphan.n3
eyeron -c examples/negation-orphan.n3
```

---

## Takeaway

An absence-based label describes the available dataset rather than proving a
real-world absence.
