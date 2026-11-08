# Quadratic Equations

*Six equations, three kinds of answer, one discriminant to tell them apart.*

[quadratic-equation.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/quadratic-equation.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/quadratic-equation.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/quadratic-equation.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/quadratic-equation.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=quadratic-equation)

---

## The question

A quadratic equation ax² + bx + c = 0 has the roots (−b ± √D) / 2a, where
D = b² − 4ac is the *discriminant*. Its sign decides the kind of answer:
positive gives two real roots, zero one double root, negative two complex
roots that mirror each other.

**Given six equations, can Eyeron pick the right case for each and compute
its roots?**

---

## What we tell Eyeron

Each equation is a resource with its three coefficients:

```n3
:Q1 a :Quadratic ;
    :a 1 ;
    :b -3 ;
    :c 2 .
```

That is x² − 3x + 2 = 0. There are six such equations, chosen to exercise
every case.

Three rules share the same opening: compute D with the `math:` built-ins,
which Eyeron evaluates rather than looks up. Then each rule tests the sign
of D. The two-real-roots rule, for instance:

```n3
    (?b2 ?fourac) math:difference ?D .
    ?D math:greaterThan 0 .
…
    (?D 0.5) math:exponentiation ?sqrtD .
    (?negB ?sqrtD) math:sum ?numPlus .
    (?negB ?sqrtD) math:difference ?numMinus .
    (?numPlus ?den) math:quotient ?x1 .
    (?numMinus ?den) math:quotient ?x2 .
} => {
    ?q :answer [ a :RealRoot ; :value ?x1 ], [ a :RealRoot ; :value ?x2 ] ;
        :why [ :sqrtDiscriminant ?sqrtD ] ;
        :status "two-real-roots" .
} .
```

A square root is the power 0.5. Each `[ … ]` is a *blank node*, a new
unnamed object, one per root. The other two rules test `math:equalTo 0` and
`math:lessThan 0`; the complex one gives each root a `:real` and an `:imag`
part.

---

## What Eyeron concludes

```n3
:Q1 :status "two-real-roots" .
:Q2 :status "double-root" .
:Q5 :status "complex-roots" .
```

And the roots themselves, for example the double root of x² + 2x + 1:

```n3
:Q2 :answer _:b5_b95bd459e1a915dd .
_:b5_b95bd459e1a915dd a :RealRoot .
_:b5_b95bd459e1a915dd :value -1 .
_:b5_b95bd459e1a915dd :multiplicity 2 .
```

and the two complex roots of x² + 1, i and −i:

```n3
_:b7_a3eb4bac570718ce :real 0 .
_:b7_a3eb4bac570718ce :imag "1"^^xsd:decimal .
…
_:b8_a3eb4bac570718ce :imag -1 .
```

A square root comes back as a decimal, so some values print as
`"1"^^xsd:decimal` rather than `1`. The blank node labels change between
runs.

---

## The proof: every sum on record

```n3
{ :Q5 :answer _:b8_a3eb4bac570718ce . }
  pe:rule 4;
…
  pe:uses
…
    { (0 4) math:difference -4 . },
    { -4 math:lessThan 0 . },
…
    { (4 0.5) math:exponentiation "2"^^xsd:decimal . },
…
    { ("2"^^xsd:decimal 2) math:quotient "1"^^xsd:decimal . },
    { "1"^^xsd:decimal math:negation -1 . }.
```

Each answer statement cites its rule (rule 4 is the complex branch) and every
calculation on the way: D = −4, the test that it is below zero, √4 = 2, and
the imaginary parts ±1. The proof has 123 steps: 42 rule steps, 24 facts and
57 calculations.

---

## Checked, with obligations

```n3
# checked with obligations: 123 steps, 87 verified, 36 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 57; pe:failed 0 ];
pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 36; pe:failed 0 ];
pe:kind "unsatisfied";
```

- **C1–C4, C7**: each rule step matches its rule, nothing is circular, every
  premise is justified, covered and relevant.
- **C5 re-decision**: the checker redid all 57 calculations and comparisons.
- **C6, C8**: each statement about a new root node belongs to the rule firing
  that created it, and nothing in the proof contradicts that.
- **C10 call fidelity**: both queries were answered as asked.

The 36 trusted steps are the statements about the new root nodes. Creating a
new object assumes no fact already provided one; that **unsatisfied**
obligation is listed for each, so the verdict is **checked with
obligations**.

---

## Try it

```sh
eyeron examples/quadratic-equation.n3      # the answer
eyeron -p examples/quadratic-equation.n3   # with its proof
eyeron -c examples/quadratic-equation.n3   # the proof, checked
```

Add `:Q7 a :Quadratic ; :a 1 ; :b -5 ; :c 6 .` (x² − 5x + 6) and run again:
it gets the status `"two-real-roots"`, with roots 3 and 2.

---

## Takeaway

One shared calculation and three guarded rules turn a school formula into
case analysis, and the proof keeps every intermediate number for a checker
to redo.
