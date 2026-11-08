# Testing a finite sample of a Dedekind cut

[sqrt2-dedekind.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/sqrt2-dedekind.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/sqrt2-dedekind.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/sqrt2-dedekind.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/sqrt2-dedekind.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=sqrt2-dedekind)

---

## The question

A list supplies rational sample values around the square root of two. N3
arithmetic rules classify the samples using negativity and square comparisons,
illustrating a finite view of the cut.

**Which of the supplied rational samples lie below the modeled cut?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:000_md_title log:outputString "# sqrt2-dedekind\n\n## Source files\n\n- [N3 rules](../sqrt2-dedekind.n3)\n\n" .

# Helper: compute squares for sample values (for printing/tests)
{
    :QSample :values ?qs .
    ?q list:in ?qs .
    (?q ?q) math:product ?q2 .
} => {
    :QSample :square (?q ?q2) .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

An excerpt of the saved text report:

```text
q=-2  q^2=4  => LEFT (q<0 OR q^2<2)
q=-1  q^2=1  => LEFT (q<0 OR q^2<2)
q=-0.5  q^2=0.25  => LEFT (q<0 OR q^2<2)
q=-0.1  q^2=0.010000000000000002  => LEFT (q<0 OR q^2<2)
q=0  q^2=0  => LEFT (q<0 OR q^2<2)
q=0.5  q^2=0.25  => LEFT (q<0 OR q^2<2)
q=1  q^2=1  => LEFT (q<0 OR q^2<2)
q=1.3  q^2=1.6900000000000002  => LEFT (q<0 OR q^2<2)
q=1.4  q^2=1.9599999999999997  => LEFT (q<0 OR q^2<2)
q=1.41  q^2=1.9880999999999998  => LEFT (q<0 OR q^2<2)
q=1.414  q^2=1.9993959999999997  => LEFT (q<0 OR q^2<2)
q=1.4142  q^2=1.9999616399999998  => LEFT (q<0 OR q^2<2)
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :QSample :square (-2 4) . }
  pe:rule 1;
  pe:binding
    [ pe:var "q"; pe:value -2 ],
    [ pe:var "q2"; pe:value 4 ],
    [ pe:var "qs"; pe:value (-2 -1 -0.5 -0.1 0 0.5 1 1.3 1.4 1.41 1.414 1.4142 1.4143 1.42 1.5 2) ];
  pe:uses
    { :QSample :values (-2 -1 -0.5 -0.1 0 0.5 1 1.3 1.4 1.41 1.414 1.4142 1.4143 1.42 1.5 2) . },
    { -2 list:in (-2 -1 -0.5 -0.1 0 0.5 1 1.3 1.4 1.41 1.414 1.4142 1.4143 1.42 1.5 2) . },
    { (-2 -2) math:product 4 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 264 steps, 264 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 105; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 159; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 104; pe:failed 0 ].
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
eyeron examples/sqrt2-dedekind.n3
eyeron -p examples/sqrt2-dedekind.n3
eyeron -c examples/sqrt2-dedekind.n3
```

---

## Takeaway

Finite sample classification illustrates a cut without enumerating all
rational numbers.
