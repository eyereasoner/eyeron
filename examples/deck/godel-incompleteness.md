# Connecting a book to its mathematical topics

[godel-incompleteness.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/godel-incompleteness.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/godel-incompleteness.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/godel-incompleteness.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/godel-incompleteness.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=godel-incompleteness)

---

## The question

A small knowledge graph describes a book about Godel's incompleteness work. N3
rules derive linked classifications and topic relationships from its
bibliographic facts.

**Which classifications and topic links follow from the book description?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Facts
ex:book2005 a schema:Book, bibo:Book ;
    dct:title "Incompleteness: The Proof and Paradox of Kurt Gödel"@en ;
    schema:name "Incompleteness: The Proof and Paradox of Kurt Gödel"@en ;
    schema:author ex:rebeccaGoldstein ;
…
    schema:about ex:kurtGodel, ex:godelIncompletenessTheorems, ex:hilbertsProgram,
    ex:platonismInMath ;
    schema:genre "biography", "mathematics", "philosophy of mathematics" ;
    schema:description "A biographical and intellectual portrait of Gödel, explaining the incompleteness theorems and their philosophical context."@en .

# Rules (N3 implications)
# 1) Invert author → made
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
ex:rebeccaGoldstein foaf:made ex:book2005 .
ex:kurtGodel schema:subjectOf ex:book2005 .
ex:book2005 dct:subject ex:mathematicalLogic .
ex:book2005 ex:recommendedFor ex:logicLearnerEn .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ ex:rebeccaGoldstein foaf:made ex:book2005 . }
  pe:rule 1;
  pe:binding
    [ pe:var "book"; pe:value ex:book2005 ],
    [ pe:var "person"; pe:value ex:rebeccaGoldstein ];
  pe:uses { ex:book2005 schema:author ex:rebeccaGoldstein . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 9 steps, 9 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/godel-incompleteness.n3
eyeron -p examples/godel-incompleteness.n3
eyeron -c examples/godel-incompleteness.n3
```

---

## Takeaway

Reasoning over a book's subject metadata does not prove its mathematical
subject matter.
