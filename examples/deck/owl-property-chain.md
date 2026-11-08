# Deriving grandparents from a property chain

[owl-property-chain.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-property-chain.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-property-chain.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-property-chain.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-property-chain.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-property-chain)

---

## The question

Grandparent is declared as a chain of two parent links
(owl:propertyChainAxiom). A forward rule starts each chain with its first
property, and two backward rules (<=) follow the rest of the chain, one link
per list item. In a family of four generations Eyeron derives the two
grandparent links.

**Which grandparent links follow from two successive parent links?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The chain declaration, and four generations
:grandparent owl:propertyChainAxiom (:parent :parent) .

# Inference rules
# Take the first link of a declared chain, then follow the rest of it; the
# start and the end of the whole chain are related by the chain's property.
{
    ?P owl:propertyChainAxiom ?L .
    ?L list:firstRest (?First ?Rest) .
    ?S ?First ?Middle .
    (?Rest ?Middle) :followChain ?O
} => {
    ?S ?P ?O
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:alice :grandparent :carol .
:bob :grandparent :dave .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :alice :grandparent :carol . }
  pe:rule 1;
  pe:binding
    [ pe:var "First"; pe:value :parent ],
    [ pe:var "L"; pe:value (:parent :parent) ],
    [ pe:var "Middle"; pe:value :bob ],
    [ pe:var "O"; pe:value :carol ],
    [ pe:var "P"; pe:value :grandparent ],
    [ pe:var "Rest"; pe:value (:parent) ],
    [ pe:var "S"; pe:value :alice ];
  pe:uses
    { :grandparent owl:propertyChainAxiom (:parent :parent) . },
    { (:parent :parent) list:firstRest (:parent (:parent)) . },
    { :alice :parent :bob . },
    { ((:parent) :bob) :followChain :carol . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 12 steps, 12 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 10; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 6; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/owl-property-chain.n3
eyeron -p examples/owl-property-chain.n3
eyeron -c examples/owl-property-chain.n3
```

---

## Takeaway

Backward list traversal makes the length and order of the declared property
chain explicit.
