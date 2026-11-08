# A numerical Fourier transform with 32 samples

[fft32-numeric.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/fft32-numeric.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/fft32-numeric.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/fft32-numeric.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/fft32-numeric.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=fft32-numeric)

---

## The question

Waveforms and stored roots of unity supply a finite signal-processing
calculation. N3 rules use real-imaginary pairs and list operations to derive
the 32-point frequency spectra.

**Which frequency components are calculated from the 32 samples?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# 32nd roots of unity: W32^k = exp(-2*pi*i*k/32)
# represented as (re im)
0 :w32 (1.0 0.0) .

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

This is an excerpt of the saved conclusions.

```n3
(0 0.83146961230254501 0.92387953251128696 0.195090322016129 -0.70710678118654702 -0.98078528040322999 -0.38268343236509 0.55557023301960196 1 0.55557023301960196 -0.38268343236509 -0.98078528040323099 -0.70710678118654802 0.195090322016127 0.92387953251128596 0.83146961230254601 0.000000000000001 -0.83146961230254501 -0.92387953251128696 -0.195090322016128 0.70710678118654802 0.98078528040322999 0.382683432365089 -0.55557023301960295 -1 -0.55557023301960395 0.38268343236508801 0.98078528040322999 0.70710678118654902 -0.195090322016127 -0.92387953251128596 -0.83146961230254601) :fft (("-2.9968028886505635e-15"^^xsd:double "0"^^xsd:decimal) ("2.7410764551198392e-15"^^xsd:double "-2.0320206323861304e-15"^^xsd:double) ("6.653803231410531e-15"^^xsd:double "-2.935201360539696e-15"^^xsd:double) ("-3.263161509486249e-15"^^xsd:double "5.895742328325398e-15"^^xsd:double) ("-3.118026263548378e-15"^^xsd:double "1.7057423285703395e-15"^^xsd:double) ("-8.327471962526034e-15"^^xsd:double "-16"^^xsd:decimal) ("-1.8187743254395905e-15"^^xsd:double "-8.649275785265081e-16"^^xsd:double) ("-7.698815671630478e-16"^^xsd:double "-5.907250600715114e-15"^^xsd:double) ("5.996003610813205e-15"^^xsd:double "9.992007221626409e-16"^^xsd:double) ("-1.046010004595602e-15"^^xsd:double "7.32799883525688e-17"^^xsd:double) ("-4.2047531300660247e-16"^^xsd:double "5.481556342888897e-16"^^xsd:double) ("3.4408920985006257e-15"^^xsd:double "0"^^xsd:decimal) ("1.1212233748978148e-15"^^xsd:double "-2.9265911575494193e-16"^^xsd:double) ("1.6825725784634528e-15"^^xsd:double "-8.40438346133828e-16"^^xsd:double) ("-4.145535929643375e-16"^^xsd:double "-1.522118147724299e-15"^^xsd:double) ("1.3184849660375944e-15"^^xsd:double "-1.5590910214806506e-15"^^xsd:double) ("2.998401444325282e-15"^^xsd:double "0"^^xsd:decimal) ("9.36240855879889e-16"^^xsd:double "1.5259059172126727e-15"^^xsd:double) ("-4.145535929643375e-16"^^xsd:double "1.5221181477242987e-15"^^xsd:double) ("2.151339929186374e-15"^^xsd:double "1.2096850292756035e-15"^^xsd:double) ("1.1212233748978148e-15"^^xsd:double "2.926591157549422e-16"^^xsd:double) ("5.543122344752187e-16"^^xsd:double "0"^^xsd:decimal) ("-4.2047531300660207e-16"^^xsd:double "-5.481556342888898e-16"^^xsd:double) ("-5.348202489988052e-16"^^xsd:double "8.574383478270009e-16"^^xsd:double) ("5.996003610813205e-15"^^xsd:double "-9.992007221626409e-16"^^xsd:double) ("-1.3022367882033748e-15"^^xsd:double "5.761905245021641e-15"^^xsd:double) ("-1.8187743254395905e-15"^^xsd:double "8.649275785265076e-16"^^xsd:double) ("-1.3434497875801754e-14"^^xsd:double "16"^^xsd:decimal) ("-3.118026263548378e-15"^^xsd:double "-1.7057423285703398e-15"^^xsd:double) ("-3.2384833686133903e-15"^^xsd:double "-6.2649890114671735e-15"^^xsd:double) ("6.653803231410531e-15"^^xsd:double "2.935201360539697e-15"^^xsd:double) ("3.0916442077252603e-15"^^xsd:double "1.2798327561680123e-15"^^xsd:double)) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
…
  pe:rule
    {
        {
            ?in a :WaveForm .
            ?in :fft32 ?out .
        } => {
            ?in :fft ?out .
        } .
    };
  pe:binding
    [ pe:var "in"; pe:value (1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1) ],
…
  pe:uses
    { (1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1) a :WaveForm . },
…
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 1813 steps, 1813 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 733; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1080; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 3646; pe:failed 0 ].
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
eyeron examples/fft32-numeric.n3
eyeron -p examples/fft32-numeric.n3
eyeron -c examples/fft32-numeric.n3
```

---

## Takeaway

Stored roots of unity and complex-pair arithmetic make the finite transform
explicit.
