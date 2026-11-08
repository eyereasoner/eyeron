# Comparing candidate group inverses

*Two inverses of the same element? Associativity says they are one.*

[group-inverse-uniqueness.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/group-inverse-uniqueness.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/group-inverse-uniqueness.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/group-inverse-uniqueness.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/group-inverse-uniqueness.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=group-inverse-uniqueness)

---

## The question

In a *group* (numbers under addition, rotations of a square, …) every
element x has an inverse: something that multiplied with x gives the identity
e. A first lesson in group theory is that the inverse is unique.

Here x has two declared inverses, named i and j.

**Can Eyeron show that i and j are the same, step by step?**

---

## What we tell Eyeron

The group laws are rules over `:mul` facts, where `(?a ?b) :mul ?c` reads
*"a times b is c"*. Identity and inverses produce products:

```n3
{
    ?a :inG true .
} => {
    (:e ?a) :mul ?a .
} .
…
{
    ?x :inG true .
    ?y :inG true .
    ?y :inverseOf ?x .
} => {
    (?x ?y) :mul :e .
    (?y ?x) :mul :e .
} .
```

Associativity says that grouping does not matter, so whatever `(a·b)·c` and
`a·(b·c)` turned out to be, they are the same:

```n3
{
    (?a ?b) :mul ?ab .
    (?ab ?c) :mul ?left .
    (?b ?c) :mul ?bc .
    (?a ?bc) :mul ?right .
} => {
    (?left ?right) :sameTerm true .
} .
```

The data is tiny: four elements and two inverse claims.

```n3
:i :inverseOf :x .
:j :inverseOf :x .
```

A `log:query` asks for the cases where two *differently named* inverses
are the same; `log:notEqualTo` is a built-in test that two names differ.

---

## What Eyeron concludes

```n3
:result :sameInverse (:x :i :j) .
:result :sameInverse (:x :j :i) .
```

---

## The proof, step by step

The heart of the proof is a single associativity step:

```n3
{ (:i :j) :sameTerm true . }
  pe:rule 1;
  pe:binding
    [ pe:var "a"; pe:value :j ],
    [ pe:var "ab"; pe:value :e ],
    [ pe:var "b"; pe:value :x ],
    [ pe:var "bc"; pe:value :e ],
    [ pe:var "c"; pe:value :i ],
    [ pe:var "left"; pe:value :i ],
    [ pe:var "right"; pe:value :j ];
  pe:uses
    { (:j :x) :mul :e . },
    { (:e :i) :mul :i . },
    { (:x :i) :mul :e . },
    { (:j :e) :mul :j . }.
```

Read it as the textbook does: (j·x)·i = e·i = i, and j·(x·i) = j·e = j.
Both groupings must agree, so i = j. Each of the four products is its own
step, from the identity or inverse rule, resting on the membership and
inverse facts. 21 steps in all.

---

## Checked: what the report says

```n3
# checked: 21 steps, 21 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 19; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
```

- **C1 resolution**: 14 rule steps and 5 facts match the program.
- **C5 re-decision**: the two `log:notEqualTo` tests were recomputed.
- **C2–C4, C7, C10**: no circularity, every premise covered, nothing
  irrelevant, and the query answered as asked.

The verdict is **checked**.

---

## Try it

```sh
eyeron examples/group-inverse-uniqueness.n3
eyeron -p examples/group-inverse-uniqueness.n3
```

---

## Takeaway

Uniqueness of inverses is one associativity step away from the definitions,
and the proof shows exactly that step with all four products it needs.
