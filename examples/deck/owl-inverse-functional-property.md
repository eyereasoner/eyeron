# Inverse Functional Property

*One account, one owner: two names that share it belong to one person.*

[owl-inverse-functional-property.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-inverse-functional-property.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-inverse-functional-property.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-inverse-functional-property.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-inverse-functional-property.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-inverse-functional-property)

---

## The question

Some values identify their owner: an e-mail address, a passport number, an
account. In OWL such a property is an `owl:InverseFunctionalProperty`: one
value can belong to at most one subject.

Both `:alice` and `:aliceAlias` have the account `:shared`.

**What does that tell us about the two names?**

---

## What we tell Eyeron

```n3
:account a owl:InverseFunctionalProperty .
:alice :account :shared .
:aliceAlias :account :shared .
```

The rule: two subjects with the same value of an inverse functional property
are the same thing.

```n3
{
    ?P a owl:InverseFunctionalProperty .
    ?X ?P ?O .
    ?Y ?P ?O
} => {
    ?X owl:sameAs ?Y
} .
```

A second rule ends in `false`: an inference fuse that stops the run if two
such subjects were also stated to be `owl:differentFrom` each other.

---

## What Eyeron concludes

```n3
:alice owl:sameAs :aliceAlias .
:aliceAlias owl:sameAs :alice .
:alice owl:sameAs :alice .
:aliceAlias owl:sameAs :aliceAlias .
```

The first two answer the question. The last two appear because `?X` and
`?Y` may match the same subject: the rule never asks them to differ.

---

## The proof, step by step

Even the self-identity has a proof, with Alice's one fact used twice:

```n3
{ :alice owl:sameAs :alice . }
  pe:rule 1;
  pe:binding
    [ pe:var "O"; pe:value :shared ],
    [ pe:var "P"; pe:value :account ],
    [ pe:var "X"; pe:value :alice ],
    [ pe:var "Y"; pe:value :alice ];
  pe:uses
    { :account a owl:InverseFunctionalProperty . },
    { :alice :account :shared . },
    { :alice :account :shared . }.
```

The step for `:alice owl:sameAs :aliceAlias` has the same shape, with
`:aliceAlias :account :shared` as its third premise. The proof has 7
steps: 4 rule steps and 3 given facts.

---

## Checked: what the report says

```n3
# checked: 7 steps, 7 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 1; pe:failed 0 ];
```

- **C1 resolution** through **C4 coverage**: each step re-performs rule 1
  or states a given fact, without cycles, and every premise resolves.
- **C6 boundary consistency** tested the fuse against the proof's facts:
  they do not trip it.
- **C7 relevance** and **C10 call fidelity**: every step serves a claim,
  and each rule step makes only its rule's calls.

The verdict is **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/owl-inverse-functional-property.n3      # the conclusions
eyeron -p examples/owl-inverse-functional-property.n3   # with the proof
eyeron -c examples/owl-inverse-functional-property.n3   # the proof, checked
```

Add `:alice owl:differentFrom :aliceAlias .`: the fuse fires, Eyeron
reports the contradiction and exits with code 65.

---

## Takeaway

An identifying value merges the names that carry it, and a fuse guards
against data that says they must stay apart.
