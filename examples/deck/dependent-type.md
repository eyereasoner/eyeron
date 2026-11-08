# Relating terms to dependent types

[dependent-type.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/dependent-type.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/dependent-type.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/dependent-type.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/dependent-type.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=dependent-type)

---

## The question

A small type model connects professions, qualified terms, and type judgments.
N3 rules derive the judgments supported by those facts, showing types
represented as ordinary linked data.

**Which type judgments follow from the profession and qualification facts?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# 0.  Core universe and meta-predicates
:Type a log:Class .

# convenience inverse
# 3.  (Dependent) type constructor   Good : Profession → Type
# For every *profession* P, create the dependent type  GoodP
{
    ?P :kind ex:Profession .
} => {
    [ a :Type ; :goodOf ?P ] .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
ex:alice :hasType _:b2_c61da8ff03e55a86 .
_:b2_c61da8ff03e55a86 a :Type .
_:b3_4d0ffe581bfcf4e3 a :Type .
_:b3_4d0ffe581bfcf4e3 :goodOf ex:Physician .
_:b2_c61da8ff03e55a86 :goodOf ex:Cobbler .
ex:bob :hasType _:b3_4d0ffe581bfcf4e3 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ ex:alice :hasType _:b2_c61da8ff03e55a86 . }
  pe:rule 2;
  pe:binding
    [ pe:var "shoe"; pe:value <http://example.org/ex#shoe₁> ],
    [ pe:var "x"; pe:value ex:alice ];
  pe:uses
    { ex:alice :hasType ex:Cobbler . },
    { ex:alice :produces <http://example.org/ex#shoe₁> . },
    { <http://example.org/ex#shoe₁> :quality ex:Excellent . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 12 steps, 6 verified, 6 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 12; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 6; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Witness integrity checks the introduction and use of unnamed individuals.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `unsatisfied`.

---

## Try it

```sh
eyeron examples/dependent-type.n3
eyeron -p examples/dependent-type.n3
eyeron -c examples/dependent-type.n3
```

---

## Takeaway

Types and their qualifying terms can be represented and related as ordinary
data.
