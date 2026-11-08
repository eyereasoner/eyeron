# Classifying an unnamed monkey

[monkey.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/monkey.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/monkey.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/monkey.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/monkey.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=monkey)

---

## The question

Bobo's type is an unnamed node that is itself classified as a monkey. An N3
rule derives an animal classification for that node, and another rule checks
the combined evidence. It shows how a blank node, written [ ... ], takes part
in rules like any named resource; note that the rules classify Bobo's type,
not Bobo.

**What can be classified when Bobo's type is itself an unnamed monkey?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:Bobo a [ a :Monkey ] .

# Every monkey is an animal.
{
    ?X a :Monkey
} => {
    ?X a :Animal
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
_:b1 a :Animal .
:test :is true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ _:b1 a :Animal . }
  pe:rule 1;
  pe:binding [ pe:var "X"; pe:value _:b1 ];
  pe:uses { _:b1 a :Monkey . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 3 steps, 3 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/monkey.n3
eyeron -p examples/monkey.n3
eyeron -c examples/monkey.n3
```

---

## Takeaway

A blank node can be matched by rules; here the classified node is Bobo's type.
