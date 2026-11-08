# The Takeuchi Function

*A famously tangled recursion, computed by rules that only ask for what they need.*

[takeuchi.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/takeuchi.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/takeuchi.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/takeuchi.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/takeuchi.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=takeuchi)

---

## The question

The Takeuchi function, named after Ikuo Takeuchi, is defined in one line:

- if x ≤ y, then tak(x, y, z) = z;
- otherwise tak(x, y, z) = tak(tak(x−1, y, z), tak(y−1, z, x), tak(z−1, x, y)).

The definition is tiny, but the calls nest inside each other so deeply that it
has long served as a benchmark for recursion.

**What is tak(34, 13, 8)?** And can rules that only ever add facts compute a
function that calls itself, without trying every possible call?

---

## What we tell Eyeron

A call is written as a list `(X Y Z)`. Two kinds of facts are derived about
it: `:needTak true` (this call must be computed) and `:tak` (its result). We
start with one needed call:

```n3
(34 13 8) :needTak true .
```

When a needed call has x > y, its three inner calls become needed:

```n3
{
    (?X ?Y ?Z) :needTak true .
    ?X math:greaterThan ?Y .
    (?X 1) math:difference ?X1 .
    (?Y 1) math:difference ?Y1 .
    (?Z 1) math:difference ?Z1 .
} => {
    (?X1 ?Y ?Z) :needTak true .
    (?Y1 ?Z ?X) :needTak true .
    (?Z1 ?X ?Y) :needTak true .
} .
```

`math:greaterThan` and `math:difference` are built-ins: Eyeron computes them.
`(?X 1) math:difference ?X1` makes `?X1` equal to X − 1.

The base case answers a call with x ≤ y directly:

```n3
{
    (?X ?Y ?Z) :needTak true .
    ?X math:notGreaterThan ?Y .
} => {
    (?X ?Y ?Z) :tak ?Z .
} .
```

Two more rules finish the recursive case: once the three inner results A1,
A2, A3 are known, the outer call (A1 A2 A3) becomes needed, and once that has
a result A, it is also the result of tak(x, y, z):

```n3
    (?A1 ?A2 ?A3) :tak ?A .
} => {
    (?X ?Y ?Z) :tak ?A .
} .
```

---

## How the rules work

This is **tabling**: each call is computed once and its result stored as a
fact, so a call that turns up again is answered from the table. And the
`:needTak` facts keep the work demand-driven: no result is computed for a
call nobody needs.

---

## What Eyeron concludes

The output lists every needed call and every result, several hundred facts.
It ends with the answer:

```n3
(7 34 13) :tak 13 .
…
(33 13 8) :tak 9 .
(34 13 8) :tak 13 .
```

**tak(34, 13, 8) = 13.**

---

## The proof: over a thousand steps

The proof is large (about 17,000 lines), because every derived fact gets its
own step. The final step is rule 4 putting the pieces together:

```n3
{ (34 13 8) :tak 13 . }
  pe:rule 4;
  pe:binding
    [ pe:var "A"; pe:value 13 ],
    [ pe:var "A1"; pe:value 9 ],
    [ pe:var "A2"; pe:value 12 ],
    [ pe:var "A3"; pe:value 13 ],
…
  pe:uses
    { (34 13 8) :needTak true . },
    { 34 math:greaterThan 13 . },
    { (34 1) math:difference 33 . },
    { (33 13 8) :tak 9 . },
    { (13 1) math:difference 12 . },
    { (12 8 34) :tak 12 . },
    { (8 1) math:difference 7 . },
    { (7 34 13) :tak 13 . },
    { (9 12 13) :tak 13 . }.
```

That reads: tak(33, 13, 8) = 9, tak(12, 8, 34) = 12 and tak(7, 34, 13) = 13,
so tak(34, 13, 8) = tak(9, 12, 13), which is 13. A base-case step looks like
this:

```n3
{ (7 34 13) :tak 13 . }
  pe:rule 2;
…
  pe:uses
    { (7 34 13) :needTak true . },
    { 7 math:notGreaterThan 34 . }.
```

---

## Checked: what the report says

```n3
# checked: 1234 steps, 1234 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 1004; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 230; pe:failed 0 ];
```

The 1234 steps are 1003 rule steps, 230 built-in steps and the one seed fact.
**C1 resolution** confirms every rule step really is an instance of its rule;
**C2 well-foundedness** that no result depends on itself, however tangled the
recursion; **C3** and **C4** that every premise is justified and accounted
for. **C5 re-decision** recomputes all 230 comparisons and subtractions.
**C7 relevance** and **C10 call fidelity** examined the rest. Nothing is
taken on trust.

---

## Try it

```sh
eyeron examples/takeuchi.n3
eyeron -c examples/takeuchi.n3
```

Change the seed to `(18 12 6) :needTak true .`, the classic benchmark call:
Eyeron derives `(18 12 6) :tak 7 .`

---

## Takeaway

Rules that only add facts can still run a deep recursion, when they record
which calls are needed and remember every result, and the whole computation
comes with a proof that can be checked.
