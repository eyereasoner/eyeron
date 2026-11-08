# Fibonacci

*Rabbits, sunflowers, and a rule that calls itself twice.*

[fibonacci.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/fibonacci.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/fibonacci.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/fibonacci.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/fibonacci.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=fibonacci)

---

## The question

The Fibonacci sequence starts 0, 1, and each number after that is the sum of
the two before it: 0, 1, 1, 2, 3, 5, 8, 13, … Leonardo of Pisa described it
in 1202 with a puzzle about breeding rabbits.

**What is the thirtieth Fibonacci number, and can every addition behind it
be checked?**

---

## What we tell Eyeron

Two starting values, written as *backward* rules: `{ … } <= true` means the
statement holds without conditions. `(0)` is a list with one element, the
position in the sequence.

```n3
{
    (0) :fib 0
} <= true .

{
    (1) :fib 1
} <= true .
```

For any position `n` above 1, look up the two previous numbers and add them:

```n3
{
    (?n) :fib ?f
} <= {
    ?n math:greaterThan 1 .
    (?n 1) math:difference ?previous .
    (?n 2) math:difference ?earlier .
    (?previous) :fib ?a .
    (?earlier) :fib ?b .
    (?a ?b) math:sum ?f .
} .
```

`math:greaterThan`, `math:difference` and `math:sum` are built-ins: Eyeron
computes them. The rule asks for `:fib` again, so it recurses down to the two
starting values. A forward rule asks the question:

```n3
{
    (30) :fib ?value
} => {
    :query :fib ?value
} .
```

---

## What Eyeron concludes

```n3
:query :fib 832040 .
```

---

## The proof, step by step

```n3
{ (30) :fib 832040 . }
  pe:rule 3;
  pe:binding
    [ pe:var "a"; pe:value 514229 ],
    [ pe:var "b"; pe:value 317811 ],
    [ pe:var "earlier"; pe:value 28 ],
    [ pe:var "f"; pe:value 832040 ],
    [ pe:var "n"; pe:value 30 ],
    [ pe:var "previous"; pe:value 29 ];
  pe:uses
    { 30 math:greaterThan 1 . },
    { (30 1) math:difference 29 . },
    { (30 2) math:difference 28 . },
…
```

The 30th number is the 29th (514229) plus the 28th (317811). Written out as a
tree, a naive recursion would repeat the same values over and over, but the
proof gives each value one step and lets later steps refer to it. So it has
just 148 steps: 32 rule applications and 116 calculations. It ends with the
starting values, which cite their rule and nothing else:

```n3
{ (1) :fib 1 . }
  pe:rule 2.
```

---

## Checked: what the report says

```n3
# checked: 148 steps, 148 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 116; pe:failed 0 ];
```

- **C5 re-decision**: the checker redid all 116 comparisons, subtractions and
  additions itself.
- **C1 resolution**: the 32 rule steps match their rules.
- **C2 well-foundedness**: the recursion really ends: no step depends on
  itself.
- **C3**, **C4**, **C7** and **C10**: each step is backed, everything used is
  accounted for and relevant, and conditions were checked as written.

The verdict is **checked**.

---

## Try it

```sh
eyeron examples/fibonacci.n3
eyeron -c examples/fibonacci.n3
```

Change `(30)` in the last rule into `(90)` and run again: Eyeron stops and
reports that reasoning is incomplete, because the recursion is deeper than
its default limit of 32 nested backward calls. Run it with
`eyeron --max-backward-depth 100` and it answers 2880067194370816120,
exactly: integers in N3 do not overflow or round.

---

## Takeaway

A recursive definition reads like the mathematics, and the proof records
each number once, so even a long calculation stays small enough to check.
