# Selecting which stored rule to activate

[quoted-head-unquote-select.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/quoted-head-unquote-select.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/quoted-head-unquote-select.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/quoted-head-unquote-select.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/quoted-head-unquote-select.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=quoted-head-unquote-select)

---

## The question

Class metadata links cats and dogs to quoted rule documents. An N3 rule
selects a document from an observed class and uses its graph value as a
conclusion to activate the stored rule.

**Which stored rule does the observed class activate?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Metadata chooses which stored rule applies for a given class
:Cat :activates :ruleCat .

# Two rules stored as data
:ruleCat :formula {
    {
        ?X a :Cat
    } => {
        ?X a :Animal
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
    :c a :Cat .
} => {
    :c a :Animal .
} .
:c a :Animal .
:test :is true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :c a :Cat . }
  pe:fact "quoted-head-unquote-select.n3".
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 6 steps, 6 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 3; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/quoted-head-unquote-select.n3
eyeron -p examples/quoted-head-unquote-select.n3
eyeron -c examples/quoted-head-unquote-select.n3
```

---

## Takeaway

Selecting a quoted document controls which rule becomes available for
inference.
