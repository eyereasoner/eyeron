# Connecting statements to their sources

[reification-and-annotations.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/reification-and-annotations.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/reification-and-annotations.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/reification-and-annotations.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/reification-and-annotations.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=reification-and-annotations)

---

## The question

Alice's statement is asserted and separately described by a claim node, while
Bob's statement is quoted. N3 rules inspect the claim graphs and metadata to
derive statement-source relationships.

**Which speaker is linked to which statement source?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Alice's statement is asserted separately from its claim record.
:alice :says :hello .

# For each claim, match its quoted speaker and copy the source.
# The result records provenance without asserting the quoted statement.
{
    ?claim :statement {
        ?speaker :says ?object
    } .
    ?claim :source ?source
} => {
    ?speaker :statementSource ?source
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:alice :statementSource :chat .
:bob :statementSource :email .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :alice :statementSource :chat . }
  pe:rule 1;
  pe:binding
    [ pe:var "claim"; pe:value _:b1 ],
    [ pe:var "object"; pe:value :hello ],
    [ pe:var "source"; pe:value :chat ],
    [ pe:var "speaker"; pe:value :alice ];
  pe:uses
    {
        _:b1 :statement {
            :alice :says :hello .
        } .
    },
    { _:b1 :source :chat . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 6 steps, 6 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 6; pe:failed 0 ];
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
eyeron examples/reification-and-annotations.n3
eyeron -p examples/reification-and-annotations.n3
eyeron -c examples/reification-and-annotations.n3
```

---

## Takeaway

Provenance can be inspected for asserted and merely quoted statements alike.
