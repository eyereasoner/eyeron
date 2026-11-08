# Returning rules as query answers

[quoted-rule-chain.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/quoted-rule-chain.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/quoted-rule-chain.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/quoted-rule-chain.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/quoted-rule-chain.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=quoted-rule-chain)

---

## The question

A small relation supplies bindings for two queries. Their N3 conclusions are
quoted implications, showing how a query can return a chain of rules as
structured output.

**Which implication chains are returned by the two queries?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:s :p :o .

{
    ?S :p :o .
} log:query {
    {
        ?S :p ?O .
    } => {
        ?S :q ?O .
    } .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
{
    :s :p ?O .
} => {
    :s :q ?O .
} .
{
    :s :q ?O .
} => {
    :s :r ?O .
} .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :s :p :o . }
  pe:fact "quoted-rule-chain.n3".
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 3 steps, 3 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 8; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/quoted-rule-chain.n3
eyeron -p examples/quoted-rule-chain.n3
eyeron -c examples/quoted-rule-chain.n3
```

---

## Takeaway

A query answer can be a structured rule rather than only a simple triple.
