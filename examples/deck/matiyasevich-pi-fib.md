# Approximating pi with Fibonacci numbers

*Fifteen angles, each a little thinner than the last, add up to almost a quarter turn.*

[matiyasevich-pi-fib.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/matiyasevich-pi-fib.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/matiyasevich-pi-fib.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/matiyasevich-pi-fib.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/matiyasevich-pi-fib.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=matiyasevich-pi-fib)

---

## The question

The Fibonacci numbers go 0, 1, 1, 2, 3, 5, 8, 13, …, each the sum of the two
before it. A lovely identity links them to pi: the angles whose tangents are
1/2, 1/5, 1/13, 1/34, … (one over every other Fibonacci number, F3, F5, F7, …)
add up to exactly a quarter turn, pi/4.

**How close to pi do the first 15 of those angles get?**

---

## What we tell Eyeron

```n3
:run :ns (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) .
```

The term numbers, as an N3 list in parentheses. Term n uses F(2n+1).

```n3
# Determine which Fibonacci indices are needed: k = 2n+1
…
} => {
    :need :fibIndex ?k0 .
} .

# Close the needed set downward: if we need n, we also need n-1 and n-2
```

Rather than compute Fibonacci numbers forever, the program first works out
which ones it needs: F3, F5, …, F31, and everything below them.

```n3
{
    :need :fibIndex ?nF .
    ?nF math:greaterThan 1 .

    (?nF 1) math:difference ?n1F .
    (?nF 2) math:difference ?n2F .

    ?n1F :fib ?f1F .
    ?n2F :fib ?f2F .
    (?f1F ?f2F) math:sum ?fnF .
} => {
    ?nF :fib ?fnF .
} .
```

The Fibonacci rule itself, using arithmetic built-ins: subtract to find the
two earlier positions, add their values.

The final rule uses `log:collectAllIn` twice. It gathers every match of a
pattern into one list: once the rows `(n k F_k theta_n)`, once just the angles.
Then it sums the angles, multiplies by 4, and compares with pi computed as
`4 × atan(1)`:

```n3
    ?thetas math:sum ?sumAngles .
    (4 ?sumAngles) math:product ?piFromFibs .
…
    (?piFromFibs ?piRef) math:difference ?delta .
    ?delta math:absoluteValue ?absError .
```

---

## What Eyeron concludes

```n3
3 :fib 2 .
5 :fib 5 .
7 :fib 13 .
…
31 :fib 1346269 .
:result :piFromFibs "3.1415908173030225"^^xsd:decimal .
:result :piRef "3.141592653589793"^^xsd:decimal .
:result :absError "0.000001836286770640072"^^xsd:decimal .
```

Fifteen terms give pi to five decimal places; the error is about 1.8
millionths. The output also lists the rows, from `(1 3 2 0.4636…)` (the
angle for 1/2) down to the tiny angle for 1/1346269.

---

## The proof, step by step

The proof has 242 steps: 68 rule steps, 173 built-in calculations and one
fact. A typical Fibonacci step:

```n3
{ 5 :fib 5 . }
  pe:rule 5;
…
  pe:uses
    { :need :fibIndex 5 . },
    { 5 math:greaterThan 1 . },
    { (5 1) math:difference 4 . },
    { (5 2) math:difference 3 . },
    { 4 :fib 3 . },
    { 3 :fib 2 . },
    { (3 2) math:sum 5 . }.
```

*F5 is 5, because 5 is needed, 5 − 1 = 4 and 5 − 2 = 3, F4 is 3, F3 is 2 and
3 + 2 = 5.* The final result is a step of rule 6 that ends with the
calculations of pi:

```n3
    { (4 0.7853977043257556) math:product 3.1415908173030225 . },
    { 1 math:atan 0.7853981633974483 . },
    { (4 0.7853981633974483) math:product 3.141592653589793 . },
```

---

## Checked: with two obligations

```n3
# checked with obligations: 242 steps, 240 verified, 2 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 173; pe:failed 0 ];
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 2; pe:failed 0 ];
```

- **C5 re-decision**: the checker redoes all 173 calculations, every sum,
  product, division and arctangent.
- **C1, C2, C3, C4, C7, C10**: each rule step matches its rule, nothing is
  circular, everything is justified and relevant, and built-ins were checked
  as called.
- **C9 search closure** looked at both collections but could not settle them.
  They collect over `:fib`, a predicate the rules derive, and the order of a
  list built from derived facts is not something the proof's certificate can
  establish.

So the two `log:collectAllIn` steps are taken on trust, as obligations of kind
`collected`: the answer holds *provided* each list holds every matching row.
**C6 boundary consistency** did test both against the proof's own evidence
and found no row the lists left out. The verdict is therefore *checked with
obligations*, not plain *checked*.

---

## Try it

```sh
eyeron examples/matiyasevich-pi-fib.n3
eyeron -c examples/matiyasevich-pi-fib.n3
```

Shorten the list to `:run :ns (1 2 3 4 5) .`. With only five terms the
estimate drops to about 3.1138, an error near 0.028.

---

## Takeaway

Rules can compute only the numbers they need, and every calculation can be
re-checked; what a checker cannot redo, such as the completeness of a
collected list, is named as an obligation instead of hidden.
