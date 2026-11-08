# Has Value

*Being Belgian means having Belgian citizenship, and the other way round.*

[owl-has-value.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-has-value.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-has-value.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-has-value.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-has-value.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-has-value)

---

## The question

OWL can define a class by a fixed value of a property. An `owl:hasValue`
restriction says: the members of this class are exactly the things whose
`:citizenship` is `:Belgium`.

We know Alice is Belgian, and we know Bob's citizenship is Belgium.

**What is Alice's citizenship, and is Bob Belgian?**

---

## What we tell Eyeron

```n3
:Belgian owl:onProperty :citizenship ;
    owl:hasValue :Belgium .
:alice a :Belgian .
:bob :citizenship :Belgium .
```

Two rules read the restriction in both directions. A member has the value:

```n3
{
    ?C owl:hasValue ?V .
    ?C owl:onProperty ?P .
    ?U a ?C
} => {
    ?U ?P ?V
} .
```

and anything with the value is a member:

```n3
{
    ?C owl:hasValue ?V .
    ?C owl:onProperty ?P .
    ?U ?P ?V
} => {
    ?U a ?C
} .
```

The conclusion `?U ?P ?V` has a variable in the predicate position: the
property is looked up from the restriction, not written into the rule.

A third rule relates restrictions on subproperties (none are declared here,
so it does not fire), and a fourth is an inference fuse ending in `false`,
which would stop the run if a member had a value stated to differ from the
fixed one.

---

## What Eyeron concludes

```n3
:alice :citizenship :Belgium .
:bob a :Belgian .
```

One conclusion from each direction.

---

## The proof, step by step

```n3
{ :alice :citizenship :Belgium . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value :Belgian ],
    [ pe:var "P"; pe:value :citizenship ],
    [ pe:var "U"; pe:value :alice ],
    [ pe:var "V"; pe:value :Belgium ];
  pe:uses
    { :Belgian owl:hasValue :Belgium . },
    { :Belgian owl:onProperty :citizenship . },
    { :alice a :Belgian . }.
```

Alice's citizenship comes from rule 1; Bob's membership comes from rule 2,
with the same restriction facts and `:bob :citizenship :Belgium` as the
third premise. The proof has 6 steps: 2 rule steps and 4 given facts.

---

## Checked: what the report says

```n3
# checked: 6 steps, 6 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 6; pe:failed 0 ];
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 1; pe:failed 0 ];
```

- **C1 resolution** through **C4 coverage**: each step re-performs its rule
  or states a given fact, without cycles, and all 8 premises and claims
  resolve.
- **C6 boundary consistency** checked the program's fuse against the
  proof's facts: they do not trip it.
- **C7 relevance** and **C10 call fidelity**: every step serves a claim,
  and both rule steps make only their rule's calls.

The verdict is **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/owl-has-value.n3      # the conclusions
eyeron -p examples/owl-has-value.n3   # with the proof
eyeron -c examples/owl-has-value.n3   # the proof, checked
```

Add `:carol a :Belgian .` and Carol gets Belgian citizenship as well.

---

## Takeaway

A fixed-value restriction works both ways: membership gives the value, and
the value gives membership.
