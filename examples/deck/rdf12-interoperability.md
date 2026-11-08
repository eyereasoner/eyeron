# Combining literals and quoted statement evidence

[rdf12-interoperability.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/rdf12-interoperability.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/rdf12-interoperability.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/rdf12-interoperability.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/rdf12-interoperability.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=rdf12-interoperability)

---

## The question

The sample data contains typed strings, language and direction tags, and a
quoted statement with a source. N3 rules derive display and provenance facts
from these representations.

**Which display and provenance facts preserve the literal and graph information?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# These literals retain datatype, language and writing-direction information.
:alice :name "Alice"^^xsd:string .

# Copy the whole label, retaining its language tag.
{
    ?person :label ?label
} => {
    ?person :displayName ?label
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:test :namedPerson :alice .
:test :namedText "Alice"^^xsd:string .
:test :knowsSubject :alice .
:test :knowsObject :bob .
:alice :displayName "Bonjour"@fr .
:test :title "HTML و CSS"@ar--rtl .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :test :namedPerson :alice . }
  pe:rule 2;
  pe:binding
    [ pe:var "person"; pe:value :alice ],
    [ pe:var "text"; pe:value "Alice"^^xsd:string ];
  pe:uses { :alice :name "Alice"^^xsd:string . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 12 steps, 12 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 12; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 7; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Standalone RDF sample

The standalone N-Quads sample shows the literal and reified-statement
representations directly, including the named graph holding the title and claim.

[rdf12-interoperability.nq](https://github.com/eyereasoner/eyeron/blob/main/examples/rdf12-interoperability.nq)

---

## Try it

```sh
eyeron examples/rdf12-interoperability.n3
eyeron -p examples/rdf12-interoperability.n3
eyeron -c examples/rdf12-interoperability.n3
```

---

## Takeaway

Passing a literal or quoted graph through a rule need not discard its
structure.
