# Multiplying by halving and doubling

[peasant-arithmetic.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/peasant-arithmetic.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/peasant-arithmetic.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/peasant-arithmetic.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/peasant-arithmetic.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=peasant-arithmetic)

---

## The question

Nonnegative sample operands are multiplied by repeatedly halving one and
doubling the other. Backward N3 rules split even and odd cases and accumulate
the product.

**How do halving and doubling produce the requested products?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
{
    ((3 0) (5 6) (238 13)) list:member (?X ?Y) .
    (?X ?Y) :product ?Result
} => {
    :arithmetic :product (?X ?Y ?Result)
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:arithmetic :product (3 0 0) .
:arithmetic :product (5 6 30) .
:arithmetic :power (238 13 7861409907565911395902147452928) .
:arithmetic :power (2 64 18446744073709551616) .
:arithmetic :product (238 13 3094) .
:arithmetic :power (3 0 1) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :arithmetic :product (3 0 0) . }
  pe:rule 7;
  pe:binding
    [ pe:var "Result"; pe:value 0 ],
    [ pe:var "X"; pe:value 3 ],
    [ pe:var "Y"; pe:value 0 ];
  pe:uses
    { ((3 0) (5 6) (238 13)) list:member (3 0) . },
    { (3 0) :product 0 . }.
```

`pe:rule 7` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 139 steps, 139 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 41; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 98; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 41; pe:failed 0 ].
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
eyeron examples/peasant-arithmetic.n3
eyeron -p examples/peasant-arithmetic.n3
eyeron -c examples/peasant-arithmetic.n3
```

---

## Takeaway

Even and odd cases reduce the multiplication to smaller nonnegative inputs.
