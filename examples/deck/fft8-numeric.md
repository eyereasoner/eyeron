# A numerical Fourier transform with eight samples

[fft8-numeric.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/fft8-numeric.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/fft8-numeric.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/fft8-numeric.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/fft8-numeric.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=fft8-numeric)

---

## The question

The sequence zero through seven is transformed using stored roots of unity.
Backward N3 rules combine complex pairs to derive the eight-point frequency
spectrum.

**What eight-point spectrum follows from the sample sequence?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# 8th roots of unity: W8^k = exp(-2*pi*i*k/8)
# represented as (re im)
0 :w8 (1.0 0.0) .

# Complex arithmetic on explicit pairs (re im)
# (a+bi) + (c+di) = (a+c) + (b+d)i
{
    ((?ar ?ai) (?br ?bi)) :cAdd (?cr ?ci) .
} <= {
    (?ar ?br) math:sum ?cr .
    (?ai ?bi) math:sum ?ci .
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
:result :fft (("28"^^xsd:decimal "0"^^xsd:decimal) ("-4"^^xsd:decimal "9.65685424949238"^^xsd:decimal) ("-4"^^xsd:decimal "4"^^xsd:decimal) ("-4"^^xsd:decimal "1.6568542494923806"^^xsd:decimal) ("-4"^^xsd:decimal "0"^^xsd:decimal) ("-4"^^xsd:decimal "-1.6568542494923806"^^xsd:decimal) ("-4"^^xsd:decimal "-4"^^xsd:decimal) ("-4"^^xsd:decimal "-9.65685424949238"^^xsd:decimal)) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :fft (("28"^^xsd:decimal "0"^^xsd:decimal) ("-4"^^xsd:decimal 9.65685424949238) ("-4"^^xsd:decimal "4"^^xsd:decimal) ("-4"^^xsd:decimal 1.6568542494923806) ("-4"^^xsd:decimal "0"^^xsd:decimal) ("-4"^^xsd:decimal -1.6568542494923806) ("-4"^^xsd:decimal "-4"^^xsd:decimal) ("-4"^^xsd:decimal -9.65685424949238)) . }
  pe:rule
    {
        {
            (0 1 2 3 4 5 6 7) :fft8 ?out .
        } => {
            :result :fft ?out .
        } .
    };
  pe:binding [ pe:var "out"; pe:value (("28"^^xsd:decimal "0"^^xsd:decimal) ("-4"^^xsd:decimal 9.65685424949238) ("-4"^^xsd:decimal "4"^^xsd:decimal) ("-4"^^xsd:decimal 1.6568542494923806) ("-4"^^xsd:decimal "0"^^xsd:decimal) ("-4"^^xsd:decimal -1.6568542494923806) ("-4"^^xsd:decimal "-4"^^xsd:decimal) ("-4"^^xsd:decimal -9.65685424949238)) ];
  pe:uses { (0 1 2 3 4 5 6 7) :fft8 (("28"^^xsd:decimal "0"^^xsd:decimal) ("-4"^^xsd:decimal 9.65685424949238) ("-4"^^xsd:decimal "4"^^xsd:decimal) ("-4"^^xsd:decimal 1.6568542494923806) ("-4"^^xsd:decimal "0"^^xsd:decimal) ("-4"^^xsd:decimal -1.6568542494923806) ("-4"^^xsd:decimal "-4"^^xsd:decimal) ("-4"^^xsd:decimal -9.65685424949238)) . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 174 steps, 174 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 82; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 92; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 413; pe:failed 0 ].
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
eyeron examples/fft8-numeric.n3
eyeron -p examples/fft8-numeric.n3
eyeron -c examples/fft8-numeric.n3
```

---

## Takeaway

A Fourier transform can be built from recursive list operations and complex
arithmetic.
