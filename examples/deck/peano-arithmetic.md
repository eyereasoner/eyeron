# Calculating with successor terms

[peano-arithmetic.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/peano-arithmetic.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/peano-arithmetic.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/peano-arithmetic.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/peano-arithmetic.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=peano-arithmetic)

---

## The question

Natural numbers are represented by zero and nested successor lists. Recursive
backward N3 rules implement addition, multiplication, and factorial,
calculating a small expression structurally.

**What do structural addition, multiplication and factorial derive for the sample expression?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The names two and three are variables: 1*1 gives one, adding two gives
# three, and its factorial is six. The output retains the successor structure.
{
    ((:s :zero) (:s :zero)) :peanoMultiply ?two .
    (?two (:s (:s :zero))) :peanoAdd ?three .
    ?three :factorialValue ?result .
} => {
    :test :three ?three ;
        :result ?result
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
:test :three (:s (:s (:s :zero))) .
:test :result (:s (:s (:s (:s (:s (:s :zero)))))) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :test :three (:s (:s (:s :zero))) . }
  pe:rule 8;
  pe:binding
    [ pe:var "result"; pe:value (:s (:s (:s (:s (:s (:s :zero)))))) ],
    [ pe:var "three"; pe:value (:s (:s (:s :zero))) ],
    [ pe:var "two"; pe:value (:s :zero) ];
  pe:uses
    { ((:s :zero) (:s :zero)) :peanoMultiply (:s :zero) . },
    { ((:s :zero) (:s (:s :zero))) :peanoAdd (:s (:s (:s :zero))) . },
    { (:s (:s (:s :zero))) :factorialValue (:s (:s (:s (:s (:s (:s :zero)))))) . }.
```

`pe:rule 8` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 24 steps, 24 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 24; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 24; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/peano-arithmetic.n3
eyeron -p examples/peano-arithmetic.n3
eyeron -c examples/peano-arithmetic.n3
```

---

## Takeaway

Nested successor lists allow arithmetic to be defined by matching and
recursion.
