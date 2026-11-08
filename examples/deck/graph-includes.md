# Testing consequences within quoted graphs

[graph-includes.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/graph-includes.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/graph-includes.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/graph-includes.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/graph-includes.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=graph-includes)

---

## The question

Quoted graphs contain facts and explicitly quantified statements. N3 rules use
log:includes to test supported graph consequences while respecting universal
and existential scopes.

**Which quoted-graph consequences pass the inclusion tests?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
{
    {
        :s :p :o .
        :a :b :c
    } log:includes {
        :a :b :c
    }
} => {
    :subset :holds true
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:subset :holds true .
:existentialGeneralisation :holds true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :subset :holds true . }
  pe:rule 1;
  pe:uses
    {
        {
            :s :p :o .
            :a :b :c .
        } log:includes {
            :a :b :c .
        } .
    }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 4 steps, 4 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
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
eyeron examples/graph-includes.n3
eyeron -p examples/graph-includes.n3
eyeron -c examples/graph-includes.n3
```

---

## Takeaway

Graph inclusion must respect the quantifier scopes of the terms it matches.
