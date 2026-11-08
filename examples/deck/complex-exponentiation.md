# Raising complex numbers to powers

[complex-exponentiation.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/complex-exponentiation.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/complex-exponentiation.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/complex-exponentiation.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/complex-exponentiation.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=complex-exponentiation)

---

## The question

Complex numbers are represented as real and imaginary pairs. Backward N3 rules
combine polar conversion and arithmetic to calculate the requested complex
powers.

**What does the calculation give for e raised to i times pi, plus one?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Evaluate e^(i*pi), then add one; rounding can leave a tiny residual.
{
    ((2.718281828459045 0) (0 3.141592653589793)) complex:exponentiation (?A ?B) .
    ((?A ?B) (1 0)) complex:sum (?C ?D) .
} => {
    ((2.718281828459045 0) (0 3.141592653589793)) complex:exponentiation (?A ?B) .
    ((?A ?B) (1 0)) complex:sum (?C ?D) .
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
((2.718281828459045 0) (0 3.141592653589793)) complex:exponentiation ("-1"^^xsd:decimal 1.2246467991473532e-16) .
(("-1"^^xsd:decimal 1.2246467991473532e-16) (1 0)) complex:sum ("0"^^xsd:decimal 1.2246467991473532e-16) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ ((2.718281828459045 0) (0 3.141592653589793)) complex:exponentiation ("-1"^^xsd:decimal 1.2246467991473532e-16) . }
  pe:rule 2;
  pe:binding
    [ pe:var "A"; pe:value 2.718281828459045 ],
    [ pe:var "B"; pe:value 0 ],
    [ pe:var "C"; pe:value 0 ],
    [ pe:var "D"; pe:value 3.141592653589793 ],
    [ pe:var "E"; pe:value "-1"^^xsd:decimal ],
    [ pe:var "F"; pe:value 1.2246467991473532e-16 ],
    [ pe:var "R"; pe:value 2.718281828459045 ],
    [ pe:var "T"; pe:value "0"^^xsd:decimal ],
    [ pe:var "Z1"; pe:value "1"^^xsd:decimal ],
    [ pe:var "Z10"; pe:value 1.2246467991473532e-16 ],
    [ pe:var "Z2"; pe:value -3.141592653589793 ],
    [ pe:var "Z3"; pe:value "0"^^xsd:decimal ],
    [ pe:var "Z4"; pe:value "1"^^xsd:decimal ],
    [ pe:var "Z5"; pe:value 1 ],
    [ pe:var "Z6"; pe:value 3.141592653589793 ],
    [ pe:var "Z7"; pe:value "0"^^xsd:decimal ],
    [ pe:var "Z8"; pe:value 3.141592653589793 ],
    [ pe:var "Z9"; pe:value "-1"^^xsd:decimal ];
…
    { 3.141592653589793 math:cos "-1"^^xsd:decimal . },
    { ("1"^^xsd:decimal "1"^^xsd:decimal "-1"^^xsd:decimal) math:product "-1"^^xsd:decimal . },
    { 3.141592653589793 math:sin 1.2246467991473532e-16 . },
    { ("1"^^xsd:decimal "1"^^xsd:decimal 1.2246467991473532e-16) math:product 1.2246467991473532e-16 . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 28 steps, 28 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 24; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 32; pe:failed 0 ].
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
eyeron examples/complex-exponentiation.n3
eyeron -p examples/complex-exponentiation.n3
eyeron -c examples/complex-exponentiation.n3
```

---

## Takeaway

Complex pairs and polar arithmetic express the calculation, with a small
numerical rounding residual.
