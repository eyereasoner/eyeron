# Pythagorean Theorem

*Six right triangles, each missing a side, solved with arithmetic built-ins.*

[pythagorean-theorem.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/pythagorean-theorem.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/pythagorean-theorem.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/pythagorean-theorem.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/pythagorean-theorem.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=pythagorean-theorem)

---

## The question

In a right triangle with legs a and b and hypotenuse c, a² + b² = c². Know
any two sides and you can compute the third. We give Eyeron six triangles,
four missing the hypotenuse and two missing a leg.

**Can Eyeron fill in each missing side, and show the arithmetic it did?**

---

## What we tell Eyeron

The triangles are plain data, each with two of its sides:

```n3
:T1 a :RightTriangle ;
    :a 3 ;
    :b 4 .
…
:T5 a :RightTriangle ;
    :c 10 ;
    :b 6 .
```

The `;` repeats the subject, so `:T1` has a type, an `:a` and a `:b`.

One rule per missing side. The hypotenuse rule:

```n3
{
    ?t a :RightTriangle ;
        :a ?a ;
        :b ?b .
    (?a 2) math:exponentiation ?a2 .
    (?b 2) math:exponentiation ?b2 .
    (?a2 ?b2) math:sum ?sum .
    (?sum 0.5) math:exponentiation ?c .
} => {
    ?t :answer [ a :Hypotenuse ; :value ?c ] ;
        :why [ :a2 ?a2 ; :b2 ?b2 ; :sumSquares ?sum ] ;
        :status "solve-c" .
} .
```

`math:exponentiation` and `math:sum` are *built-ins*: statements Eyeron
computes instead of looking up. `(3 2) math:exponentiation ?a2` makes `?a2`
equal 9; raising to the power 0.5 takes the square root. The brackets `[ … ]`
in the conclusion are *blank nodes*: a new, unnamed answer object for each
triangle. The two leg rules do the same with `math:difference`.

---

## What Eyeron concludes

The queries ask for each answer and each status:

```n3
:T1 :status "solve-c" .
:T4 :status "solve-b" .
:T5 :status "solve-a" .
:T6 :status "solve-c" .
```

and the answers themselves, such as:

```n3
:T6 :answer _:b1_2e18166e780d32c4 .
_:b1_2e18166e780d32c4 a :Hypotenuse .
_:b1_2e18166e780d32c4 :value 6.5 .
```

The values are 5, 13, 17 and 6.5 for the hypotenuses, 12 for T4's leg b and
8 for T5's leg a. The `_:b1_…` labels name blank nodes; they change between
runs. The `:why` explanations are derived too, but the queries don't ask for
them.

---

## The proof: arithmetic you can redo

```n3
{ :T6 :answer _:b1_2e18166e780d32c4 . }
  pe:rule 1;
…
  pe:uses
    { :T6 a :RightTriangle . },
    { :T6 :a 2.5 . },
    { :T6 :b 6 . },
    { (2.5 2) math:exponentiation 6.25 . },
    { (6 2) math:exponentiation 36 . },
    { (6.25 36) math:sum 42.25 . },
    { (42.25 0.5) math:exponentiation 6.5 . }.
…
{ (6.25 36) math:sum 42.25 . }
  pe:builtin math:sum.
```

Each answer cites its rule, the triangle's facts, and every calculation as a
`pe:builtin` step. The proof has 66 steps: 26 rule steps, 18 facts and 22
calculations.

---

## Checked, with obligations

```n3
# checked with obligations: 66 steps, 46 verified, 20 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 22; pe:failed 0 ];
pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 20; pe:failed 0 ];
pe:kind "unsatisfied";
```

- **C1–C4, C7**: every rule step matches its rule, nothing is circular, every
  premise is justified and relevant.
- **C5 re-decision**: the checker recomputed all 22 calculations itself.
- **C8 witness integrity**: each of the 20 answer statements about a new
  blank node really belongs to the rule firing that created it.
- **C6** and **C10**: no evidence contradicts an assumption, and the queries
  were answered as asked.

The 20 trusted steps are the 20 statements about new answer objects. Making
up a new object assumes that no existing fact already gave this triangle an
answer; that **unsatisfied** obligation is stated, not proved. Hence
**checked with obligations**.

---

## Try it

```sh
eyeron examples/pythagorean-theorem.n3      # the answer
eyeron -p examples/pythagorean-theorem.n3   # with its proof
eyeron -c examples/pythagorean-theorem.n3   # the proof, checked
```

Add a triangle `:T7 a :RightTriangle ; :a 20 ; :b 21 .` and run again: it
gets a hypotenuse with value 29 and status `"solve-c"`.

---

## Takeaway

Built-ins let rules calculate, and the proof keeps every calculation, so a
checker can redo the sums instead of trusting them.
