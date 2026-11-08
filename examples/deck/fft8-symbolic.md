# Building a symbolic Fourier transform

[fft8-symbolic.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/fft8-symbolic.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/fft8-symbolic.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/fft8-symbolic.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/fft8-symbolic.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=fft8-symbolic)

---

## The question

An eight-item sequence is expanded into a radix-two Fourier expression.
Backward N3 rules build nested list terms for additions, multiplications, and
symbolic roots of unity.

**Which expression represents the eight-point Fourier transform?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Symbolic expression encoding
#
# sample i -> (:leaf i)
# omega^p -> (:twiddle :omega p)
# omega^p * expr -> (:mul (:twiddle :omega p) expr)
# a + b -> (:add a b)
# Base case
# A list of length 1 is turned into a leaf node.
{
    ((?i) ?root ?p ?n) :fftExpr (:leaf ?i) .
} <= {} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:result :fft ((:add (:add (:add (:leaf 0) (:mul (:twiddle :omega 0) (:leaf 4))) (:mul (:twiddle :omega 0) (:add (:leaf 2) (:mul (:twiddle :omega 0) (:leaf 6))))) (:mul (:twiddle :omega 0) (:add (:add (:leaf 1) (:mul (:twiddle :omega 0) (:leaf 5))) (:mul (:twiddle :omega 0) (:add (:leaf 3) (:mul (:twiddle :omega 0) (:leaf 7))))))) (:add (:add (:add (:leaf 0) (:mul (:twiddle :omega 4) (:leaf 4))) (:mul (:twiddle :omega 2) (:add (:leaf 2) (:mul (:twiddle :omega 4) (:leaf 6))))) (:mul (:twiddle :omega 1) (:add (:add (:leaf 1) (:mul (:twiddle :omega 4) (:leaf 5))) (:mul (:twiddle :omega 2) (:add (:leaf 3) (:mul (:twiddle :omega 4) (:leaf 7))))))) (:add (:add (:add (:leaf 0) (:mul (:twiddle :omega 0) (:leaf 4))) (:mul (:twiddle :omega 4) (:add (:leaf 2) (:mul (:twiddle :omega 0) (:leaf 6))))) (:mul (:twiddle :omega 2) (:add (:add (:leaf 1) (:mul (:twiddle :omega 0) (:leaf 5))) (:mul (:twiddle :omega 4) (:add (:leaf 3) (:mul (:twiddle :omega 0) (:leaf 7))))))) (:add (:add (:add (:leaf 0) (:mul (:twiddle :omega 4) (:leaf 4))) (:mul (:twiddle :omega 6) (:add (:leaf 2) (:mul (:twiddle :omega 4) (:leaf 6))))) (:mul (:twiddle :omega 3) (:add (:add (:leaf 1) (:mul (:twiddle :omega 4) (:leaf 5))) (:mul (:twiddle :omega 6) (:add (:leaf 3) (:mul (:twiddle :omega 4) (:leaf 7))))))) (:add (:add (:add (:leaf 0) (:mul (:twiddle :omega 0) (:leaf 4))) (:mul (:twiddle :omega 0) (:add (:leaf 2) (:mul (:twiddle :omega 0) (:leaf 6))))) (:mul (:twiddle :omega 4) (:add (:add (:leaf 1) (:mul (:twiddle :omega 0) (:leaf 5))) (:mul (:twiddle :omega 0) (:add (:leaf 3) (:mul (:twiddle :omega 0) (:leaf 7))))))) (:add (:add (:add (:leaf 0) (:mul (:twiddle :omega 4) (:leaf 4))) (:mul (:twiddle :omega 2) (:add (:leaf 2) (:mul (:twiddle :omega 4) (:leaf 6))))) (:mul (:twiddle :omega 5) (:add (:add (:leaf 1) (:mul (:twiddle :omega 4) (:leaf 5))) (:mul (:twiddle :omega 2) (:add (:leaf 3) (:mul (:twiddle :omega 4) (:leaf 7))))))) (:add (:add (:add (:leaf 0) (:mul (:twiddle :omega 0) (:leaf 4))) (:mul (:twiddle :omega 4) (:add (:leaf 2) (:mul (:twiddle :omega 0) (:leaf 6))))) (:mul (:twiddle :omega 6) (:add (:add (:leaf 1) (:mul (:twiddle :omega 0) (:leaf 5))) (:mul (:twiddle :omega 4) (:add (:leaf 3) (:mul (:twiddle :omega 0) (:leaf 7))))))) (:add (:add (:add (:leaf 0) (:mul (:twiddle :omega 4) (:leaf 4))) (:mul (:twiddle :omega 6) (:add (:leaf 2) (:mul (:twiddle :omega 4) (:leaf 6))))) (:mul (:twiddle :omega 7) (:add (:add (:leaf 1) (:mul (:twiddle :omega 4) (:leaf 5))) (:mul (:twiddle :omega 6) (:add (:leaf 3) (:mul (:twiddle :omega 4) (:leaf 7)))))))) .
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
            (0 1 2 3 4 5 6 7) :fft8 ?out .
        } => {
            :result :fft ?out .
        } .
    };
…
…
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 50 steps, 50 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 34; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 16; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 141; pe:failed 0 ].
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
eyeron examples/fft8-symbolic.n3
eyeron -p examples/fft8-symbolic.n3
eyeron -c examples/fft8-symbolic.n3
```

---

## Takeaway

Symbolic roots and arithmetic nodes preserve the structure of the transform
instead of evaluating every coefficient.
