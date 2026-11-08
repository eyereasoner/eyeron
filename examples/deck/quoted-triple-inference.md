# Carrying metadata across a symmetric triple

[quoted-triple-inference.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/quoted-triple-inference.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/quoted-triple-inference.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/quoted-triple-inference.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/quoted-triple-inference.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=quoted-triple-inference)

---

## The question

A marriage relation is declared symmetric and also appears as an annotated
quoted graph. N3 rules derive the reversed fact and the matching reversed
quoted graph with its metadata.

**Which reversed marriage fact and dated graph follow from symmetry?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The example supplies both an asserted marriage and a quoted one with a date.
:marriedTo a :SymetricRelation .

# Reverse an asserted relationship when its property is declared symmetric.
{
    ?p a :SymetricRelation .
    ?s ?p ?o
} => {
    ?o ?p ?s
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:TEST :PASS 3 .
:bob :marriedTo :alice .
:TEST :PASS 1 .
:TEST :PASS 2 .
{
    :bob :marriedTo :alice .
} :since "1999" .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :bob :marriedTo :alice . }
  pe:rule 1;
  pe:binding
    [ pe:var "o"; pe:value :bob ],
    [ pe:var "p"; pe:value :marriedTo ],
    [ pe:var "s"; pe:value :alice ];
  pe:uses
    { :marriedTo a :SymetricRelation . },
    { :alice :marriedTo :bob . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 8 steps, 8 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 8; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 5; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/quoted-triple-inference.n3
eyeron -p examples/quoted-triple-inference.n3
eyeron -c examples/quoted-triple-inference.n3
```

---

## Takeaway

Metadata propagation is an explicit rule, not an automatic consequence of
quotation.
