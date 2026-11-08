# Arithmetic with complex pairs

[complex.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/complex.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/complex.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/complex.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/complex.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=complex)

---

## The question

Complex numbers are stored as pairs of real and imaginary components. Backward
N3 rules implement the supplied complex arithmetic relations and calculate the
example answers.

**How can ordinary rules calculate with real and imaginary pairs?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Evaluate six sample complex functions and collect the results in one graph.
{
    ((-1 0) (0.5 0)) complex:exponentiation ?C1 .
    ((2.718281828459045 0) (0 3.141592653589793)) complex:exponentiation ?C2 .
    ((0 1) (0 1)) complex:exponentiation ?C3 .
    ((2.718281828459045 0) (-1.57079632679 0)) complex:exponentiation ?C4 .
    (2 0) complex:asin ?C5 .
    (2 0) complex:acos ?C6 .
} => {
    :test :is {
        ((-1 0) (0.5 0)) complex:exponentiation ?C1 .
        ((2.718281828459045 0) (0 3.141592653589793)) complex:exponentiation ?C2 .
        ((0 1) (0 1)) complex:exponentiation ?C3 .
        ((2.718281828459045 0) (-1.57079632679 0)) complex:exponentiation ?C4 .
        (2 0) complex:asin ?C5 .
        (2 0) complex:acos ?C6 .
    } .
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
:test :is {
    ((-1 0) (0.5 0)) complex:exponentiation ("6.123233995736766e-17"^^xsd:double "1"^^xsd:decimal) .
    ((2.718281828459045 0) (0 3.141592653589793)) complex:exponentiation ("-1"^^xsd:decimal "1.2246467991473532e-16"^^xsd:double) .
    ((0 1) (0 1)) complex:exponentiation ("0.20787957635076193"^^xsd:decimal "0"^^xsd:decimal) .
    ((2.718281828459045 0) (-1.57079632679 0)) complex:exponentiation ("0.20787957635177984"^^xsd:decimal "0"^^xsd:decimal) .
    (2 0) complex:asin ("1.5707963267948966"^^xsd:decimal "1.3169578969248166"^^xsd:decimal) .
    (2 0) complex:acos ("0"^^xsd:decimal "-1.3169578969248166"^^xsd:decimal) .
} .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ ((-1 0) (0.5 0)) complex:exponentiation (6.123233995736766e-17 "1"^^xsd:decimal) . }
  pe:rule 1;
  pe:binding
    [ pe:var "A"; pe:value -1 ],
    [ pe:var "B"; pe:value 0 ],
    [ pe:var "C"; pe:value 0.5 ],
    [ pe:var "D"; pe:value 0 ],
    [ pe:var "E"; pe:value 6.123233995736766e-17 ],
    [ pe:var "F"; pe:value "1"^^xsd:decimal ],
    [ pe:var "R"; pe:value "1"^^xsd:decimal ],
    [ pe:var "T"; pe:value 3.141592653589793 ],
    [ pe:var "Z1"; pe:value "1"^^xsd:decimal ],
    [ pe:var "Z10"; pe:value "1"^^xsd:decimal ],
    [ pe:var "Z2"; pe:value 0 ],
    [ pe:var "Z3"; pe:value "0"^^xsd:decimal ],
    [ pe:var "Z4"; pe:value "1"^^xsd:decimal ],
    [ pe:var "Z5"; pe:value 0 ],
    [ pe:var "Z6"; pe:value 0 ],
    [ pe:var "Z7"; pe:value 1.5707963267948966 ],
    [ pe:var "Z8"; pe:value 1.5707963267948966 ],
    [ pe:var "Z9"; pe:value 6.123233995736766e-17 ];
…
    { 1.5707963267948966 math:cos 6.123233995736766e-17 . },
    { ("1"^^xsd:decimal "1"^^xsd:decimal 6.123233995736766e-17) math:product 6.123233995736766e-17 . },
    { 1.5707963267948966 math:sin "1"^^xsd:decimal . },
    { ("1"^^xsd:decimal "1"^^xsd:decimal "1"^^xsd:decimal) math:product "1"^^xsd:decimal . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 89 steps, 89 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 13; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 76; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 13; pe:failed 0 ].
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
eyeron examples/complex.n3
eyeron -p examples/complex.n3
eyeron -c examples/complex.n3
```

---

## References

[Source reference 1](https://en.wikipedia.org/wiki/Complex_number)

---

## Takeaway

Complex arithmetic is defined by rules over pairs rather than a special
complex term type.
