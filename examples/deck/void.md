# Connecting a physics book to its topics

[void.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/void.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/void.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/void.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/void.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=void)

---

## The question

A small knowledge graph describes a book about the physics of empty space. N3
rules derive classifications and topic relationships from the supplied
bibliographic and subject facts.

**Which topics and classifications follow from the book's description?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Facts
ex:book2016 a schema:Book, bibo:Book ;
    dct:title "Void: The Strange Physics of Nothing"@en ;
    schema:name "Void: The Strange Physics of Nothing"@en ;
    schema:author ex:jamesWeatherall ;
…
    schema:about ex:vacuum, ex:spaceTime, ex:quantumFieldTheory, ex:generalRelativity,
    ex:cosmologicalConstant, ex:casimirEffect, ex:isaacNewton, ex:albertEinstein ;
    schema:genre "popular science", "physics", "philosophy of physics" ;
    schema:description "An exploration of what modern physics says about 'nothing'—empty space, vacuum structure, and why the void is physically rich."@en .

# Rules (N3 implications)
# 1) Invert author -> made
{
    ?book schema:author ?person .
} => {
    ?person foaf:made ?book .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The ellipsis omits part of the source; the linked file
contains the full program.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
ex:jamesWeatherall foaf:made ex:book2016 .
ex:book2016 dct:subject ex:quantumTheory .
ex:albertEinstein schema:subjectOf ex:book2016 .
ex:book2016 ex:recommendedFor ex:curiousPhysicsReaderEn .
ex:book2016 schema:about ex:darkEnergy .
ex:isaacNewton schema:subjectOf ex:book2016 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ ex:jamesWeatherall foaf:made ex:book2016 . }
  pe:rule 1;
  pe:binding
    [ pe:var "book"; pe:value ex:book2016 ],
    [ pe:var "person"; pe:value ex:jamesWeatherall ];
  pe:uses { ex:book2016 schema:author ex:jamesWeatherall . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 14 steps, 14 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 14; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 6; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/void.n3
eyeron -p examples/void.n3
eyeron -c examples/void.n3
```

---

## Takeaway

Bibliographic reasoning relates the supplied metadata without establishing the
book's physics claims.
