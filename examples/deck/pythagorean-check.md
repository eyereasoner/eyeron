# Pythagorean Check

*Recognizing a² + b² = c² from names alone, without a single number.*

[pythagorean-check.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/pythagorean-check.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/pythagorean-check.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/pythagorean-check.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/pythagorean-check.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=pythagorean-check)

---

## The question

Pythagoras' theorem relates the sides of a right triangle: the square of a
plus the square of b equals the square of c. Here we know nothing about
lengths. We only know that a, b and c have squares, called a2, b2 and c2, and
that a2 and b2 add up to c2.

**Is that enough to say that a, b and c stand in Pythagoras' relation?**

---

## What we tell Eyeron

```n3
:a :Square :a2 .
:b :Square :b2 .
:c :Square :c2 .
(:a2 :b2) :Add :c2 .
```

`:Square` and `:Add` are just names we made up; Eyeron does no arithmetic
with them. `(:a2 :b2)` is a list, so the last line says "the pair a2, b2
adds up to c2".

```n3
{
    ?A :Square ?A2 .
    ?B :Square ?B2 .
    ?C :Square ?C2 .
    (?A2 ?B2) :Add ?C2 .
} => {
    (?A ?B ?C) :Pythagoras true .
} .
```

The rule looks for this pattern of four statements and, when it finds it,
concludes a statement about the list `(?A ?B ?C)`. The program also has a
rule that turns `(:a :b :c) :Pythagoras true` into itself, which adds
nothing, and a query that asks for that one statement.

---

## What Eyeron concludes

```n3
(:a :b :c) :Pythagoras true .
```

The pattern matched with A, B and C standing for a, b and c, in that order.

---

## The proof, step by step

```n3
{ (:a :b :c) :Pythagoras true . }
  pe:rule 1;
  pe:binding
    [ pe:var "A"; pe:value :a ],
…
  pe:uses
    { :a :Square :a2 . },
    { :b :Square :b2 . },
    { :c :Square :c2 . },
    { (:a2 :b2) :Add :c2 . }.

{ :a :Square :a2 . }
  pe:fact "pythagorean-check.n3".
```

One rule step, citing rule 1 with all six variables bound, and four fact
steps, one for each statement it used. The self-restating rule does not
appear: the answer does not need it.

---

## Checked: what the report says

```n3
# checked: 5 steps, 5 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 6; pe:failed 0 ].
```

- **C1 resolution**: the four facts are in the file, and rule 1 with the
  stated bindings gives exactly the answer.
- **C2, C3, C4, C7**: no circularity, every premise is justified, the answer
  is covered and nothing is superfluous.
- **C10 call fidelity**: the query's question is the one answered.

All 5 steps were verified, so the verdict is **checked**.

---

## Try it

```sh
eyeron examples/pythagorean-check.n3      # the answer
eyeron -p examples/pythagorean-check.n3   # with its proof
eyeron -c examples/pythagorean-check.n3   # the proof, checked
```

Change the last fact to `(:b2 :a2) :Add :c2 .` and the output is empty: the
pattern now matches only with A and B swapped, so the query for
`(:a :b :c)` finds nothing. Order in a list matters.

---

## Takeaway

Rules match patterns, not meanings: give Eyeron the shape of Pythagoras'
relation and it recognizes it, with a proof, even with no numbers in sight.
