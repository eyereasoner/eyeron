# Max Cardinality

*At most one child, two names: Bob and Robert must be the same child.*

[owl-max-cardinality.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-max-cardinality.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-max-cardinality.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-max-cardinality.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-max-cardinality.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-max-cardinality)

---

## The question

OWL can limit how many values a property has for members of a class. Here
`:OnlyChildParent` is a class whose members have at most one `:child`
(`owl:maxCardinality 1`).

Alice is such a parent, and two children are recorded for her: `:bob` and
`:robert`. OWL does not assume that different names mean different things.

**What follows from the limit?**

---

## What we tell Eyeron

```n3
:OnlyChildParent owl:maxCardinality 1 ;
    owl:onProperty :child .
:alice a :OnlyChildParent ;
    :child :bob, :robert .
```

The rule: under a maximum of one, any two values of the property are the
same thing.

```n3
{
    ?C owl:maxCardinality 1 .
    ?C owl:onProperty ?P .
    ?U a ?C .
    ?U ?P ?Y .
    ?U ?P ?Z
} => {
    ?Y owl:sameAs ?Z
} .
```

Two more rules are inference fuses, ending in `false`. One rejects any value
at all under a maximum of zero; the other rejects two values stated to be
`owl:differentFrom` each other under a maximum of one:

```n3
{
    ?C owl:maxCardinality 1 .
    ?C owl:onProperty ?P .
    ?X ?P ?Y .
    ?X ?P ?Z .
    ?X a ?C .
    ?Z owl:differentFrom ?Y
} => false .
```

---

## What Eyeron concludes

```n3
:bob owl:sameAs :robert .
:robert owl:sameAs :bob .
:bob owl:sameAs :bob .
:robert owl:sameAs :robert .
```

Bob and Robert are one child. Each name is also the same as itself, since
`?Y` and `?Z` may match the same value.

---

## The proof, step by step

```n3
{ :bob owl:sameAs :bob . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value :OnlyChildParent ],
    [ pe:var "P"; pe:value :child ],
    [ pe:var "U"; pe:value :alice ],
    [ pe:var "Y"; pe:value :bob ],
    [ pe:var "Z"; pe:value :bob ];
  pe:uses
    { :OnlyChildParent owl:maxCardinality 1 . },
    { :OnlyChildParent owl:onProperty :child . },
    { :alice a :OnlyChildParent . },
    { :alice :child :bob . },
    { :alice :child :bob . }.
```

The step for `:bob owl:sameAs :robert` is the same with `Z` as Robert and
`:alice :child :robert` as the last premise. The proof has 9 steps: 4 rule
steps and 5 given facts.

---

## Checked: what the report says

```n3
# checked: 9 steps, 9 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C4"; pe:name "coverage"; pe:checked 24; pe:failed 0 ];
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 2; pe:failed 0 ];
```

- **C1 resolution** through **C4 coverage**: each step re-performs rule 1
  or states a given fact, without cycles, and all 24 premises and claims
  resolve.
- **C6 boundary consistency** tested both fuses against the proof's facts:
  neither is tripped.
- **C7 relevance** and **C10 call fidelity**: every step serves a claim,
  and each rule step makes only its rule's calls.

The verdict is **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/owl-max-cardinality.n3      # the conclusions
eyeron -p examples/owl-max-cardinality.n3   # with the proof
eyeron -c examples/owl-max-cardinality.n3   # the proof, checked
```

Add `:bob owl:differentFrom :robert .`: the limit and the data now
disagree, the second fuse fires, and Eyeron exits with code 65.

---

## Takeaway

A cardinality limit does not reject extra names; it merges them, unless the
data insists they differ.
