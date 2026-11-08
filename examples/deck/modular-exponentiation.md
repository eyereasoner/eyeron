# Calculating powers modulo an integer

*Seven to the power of a billion, without ever writing that number down.*

[modular-exponentiation.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/modular-exponentiation.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/modular-exponentiation.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/modular-exponentiation.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/modular-exponentiation.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=modular-exponentiation)

---

## The question

Cryptography constantly needs the remainder of a huge power: b to the power
e, divided by m. Computing b^e first is hopeless when e is a billion; the
number would have hundreds of millions of digits. The trick is to square
repeatedly and keep only remainders along the way.

**What are 7^13 mod 97 and 7^1000000000 mod 1000003?**

---

## What we tell Eyeron

`(b e m) :modPow r` means *b^e mod m = r*. Four backward rules (written `<=`,
"this holds if") define it. Backward rules are used when a goal is asked,
like a function call.

```n3
{
    (?b 0 ?m) :modPow ?r
} <= {
    ?m math:greaterThan 0 .
    (1 ?m) math:remainder ?r
} .
```

The base cases: exponent 0 gives 1, exponent 1 gives b, each reduced mod m.
For a larger even exponent, square the base and halve the exponent:

```n3
    (?e 2) math:remainder 0 .
    (?b ?b) math:product ?bb .
    (?bb ?m) math:remainder ?squared .
    (?e 2) math:integerQuotient ?half .
    (?squared ?half ?m) :modPow ?r .
```

For an odd exponent, do the same with e − 1 and multiply one extra b back in.
The rule calls `:modPow` again, so the definition is recursive.

The questions are two forward rules:

```n3
{
    (7 13 97) :modPow ?r
} => {
    :test :smallCheck ?r
} .
```

---

## What Eyeron concludes

```n3
:test :smallCheck 38 .
:test :largeCase 453343 .
```

Integers in Eyeron are exact, however large the intermediate products get, so
both answers are exact.

---

## The proof, step by step

The proof has 235 steps: 36 rule steps and 199 arithmetic steps. The top of
the small case:

```n3
{ (7 13 97) :modPow 38 . }
  pe:rule 4;
…
  pe:uses
    { 97 math:greaterThan 0 . },
    { 13 math:greaterThan 1 . },
    { (13 2) math:remainder 1 . },
    { (7 7) math:product 49 . },
    { (49 97) math:remainder 49 . },
    { (13 1) math:difference 12 . },
    { (12 2) math:integerQuotient 6 . },
    { (49 6 97) :modPow 47 . },
    { (7 47) math:product 329 . },
    { (329 97) math:remainder 38 . }.
```

*13 is odd, so 7^13 = 7 × 49^6; 49^6 mod 97 is 47 (proved further down),
7 × 47 = 329, and 329 mod 97 = 38.* The large case needs about 30 such
halvings to get from a billion down to 1.

---

## Checked: what the report says

```n3
# checked: 235 steps, 235 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 36; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 199; pe:failed 0 ];
```

- **C5 re-decision**: the checker redoes all 199 products, remainders,
  quotients and comparisons, so no intermediate value can be wrong.
- **C1 resolution**: each of the 36 rule steps matches one of the four
  `:modPow` rules or a question rule.
- **C2 well-foundedness**: the recursion bottoms out; no step depends on
  itself.
- **C3, C4, C7, C10**: everything is justified, covered and relevant, and
  each recursive call was checked as made.

All 235 steps verified; nothing trusted.

---

## Try it

```sh
eyeron examples/modular-exponentiation.n3
eyeron -c examples/modular-exponentiation.n3
```

Change the small question to `(2 10 1000) :modPow ?r`. Eyeron answers
`:test :smallCheck 24 .`, since 2^10 = 1024.

---

## Takeaway

A few recursive rules and exact integers turn a calculation that is
impossible done naively into a short, fully checked derivation.
