# Activating a quoted rule

[quoted-head-unquote.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/quoted-head-unquote.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/quoted-head-unquote.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/quoted-head-unquote.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/quoted-head-unquote.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=quoted-head-unquote)

---

## The question

A fact stores a graph containing a cat-to-animal rule. An N3 rule uses that
graph value directly as its conclusion, allowing the stored rule to classify
the sample cat.

**Can the stored cat-to-animal rule classify the supplied cat?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Once the rule is active, this cat can be classified as an animal.
:c a :Cat .

# Store a cat-to-animal rule inside a quoted graph.
:a :b {
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
    ?X a :Cat .
} => {
    ?X a :Animal .
} .
:c a :Animal .
:test :is true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :c a :Animal . }
  pe:rule
    {
        {
            ?X a :Cat .
        } => {
            ?X a :Animal .
        } .
    };
  pe:binding [ pe:var "X"; pe:value :c ];
  pe:uses { :c a :Cat . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 5 steps, 5 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
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
eyeron examples/quoted-head-unquote.n3
eyeron -p examples/quoted-head-unquote.n3
eyeron -c examples/quoted-head-unquote.n3
```

---

## Takeaway

A graph used as a rule conclusion can activate the rule stored inside it.
