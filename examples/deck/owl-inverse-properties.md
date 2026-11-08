# Inverse Properties

*If Alice is Bob's parent, Bob is Alice's child.*

[owl-inverse-properties.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/owl-inverse-properties.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/owl-inverse-properties.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/owl-inverse-properties.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/owl-inverse-properties.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=owl-inverse-properties)

---

## The question

Many relationships come in pairs that read the same link from opposite
ends: parent of and child of, employs and works for. OWL calls such a pair
`owl:inverseOf`.

Alice is the parent of Bob. Carol is the child of Dave.

**What do these links look like read from the other end?**

---

## What we tell Eyeron

```n3
:parentOf owl:inverseOf :childOf .
:alice :parentOf :bob .
:carol :childOf :dave .
```

The first rule turns a statement around, swapping subject and object and
using the inverse property:

```n3
{
    ?P owl:inverseOf ?Q .
    ?S ?P ?O
} => {
    ?O ?Q ?S
} .
```

The property is a variable here (`?S ?P ?O`), so the rule works for any
declared pair. A second rule does the same starting from `?Q`, and a third
says that being inverses is symmetric:

```n3
{
    ?P owl:inverseOf ?Q
} => {
    ?Q owl:inverseOf ?P
} .
```

---

## What Eyeron concludes

```n3
:bob :childOf :alice .
:dave :parentOf :carol .
:childOf owl:inverseOf :parentOf .
```

Each link now exists in both directions, and so does the declaration.

---

## The proof, step by step

```n3
{ :bob :childOf :alice . }
  pe:rule 1;
  pe:binding
    [ pe:var "O"; pe:value :bob ],
    [ pe:var "P"; pe:value :parentOf ],
    [ pe:var "Q"; pe:value :childOf ],
    [ pe:var "S"; pe:value :alice ];
  pe:uses
    { :parentOf owl:inverseOf :childOf . },
    { :alice :parentOf :bob . }.

{ :parentOf owl:inverseOf :childOf . }
  pe:fact "owl-inverse-properties.n3".
```

Rule 1 with `P` as parent-of and `Q` as child-of. The proof has 6 steps:
one rule step for each of the 3 conclusions, and the 3 given facts.

---

## Checked: what the report says

```n3
# checked: 6 steps, 6 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 6; pe:failed 0 ];
pe:condition [ pe:id "C7"; pe:name "relevance"; pe:checked 9; pe:failed 0 ];
```

- **C1 resolution**, **C2 well-foundedness**, **C3 justification** and
  **C4 coverage**: each step is what it cites, there are no cycles, and
  every premise and claim resolves.
- **C7 relevance**: all 6 steps and 3 claims serve the answer.
- **C10 call fidelity**: the 3 rule steps make only their rules' calls.

Nothing is computed, assumed or invented, so the other conditions had
nothing to examine. The verdict is **checked**.

---

## Try it

```sh
eyeron examples/owl-inverse-properties.n3      # the conclusions
eyeron -p examples/owl-inverse-properties.n3   # with the proof
eyeron -c examples/owl-inverse-properties.n3   # the proof, checked
```

Add `:erin :parentOf :alice .` and Eyeron also concludes
`:alice :childOf :erin .`

---

## Takeaway

One declaration lets every link be read from both ends, with a checked
reason for each reversed statement.
