# Connecting trusted claims and their provenance

[n3-speaks-for-itself.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/n3-speaks-for-itself.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/n3-speaks-for-itself.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/n3-speaks-for-itself.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/n3-speaks-for-itself.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=n3-speaks-for-itself)

---

## The question

Several quoted documents describe people and relationships. N3 rules accept
claims from trusted documents, derive consequences across them, and retain
links to the supporting quoted evidence.

**Which accepted claims connect the trusted documents?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Policy: which documents we trust
:policy :trusts <https://alice.example/profile.n3> .

# Import rule: trusted quotes become facts
#
# IMPORTANT:
# Do NOT derive provenance facts that *store* formula terms (like {..} :from ?Doc)
# in the forward-chaining store, because formula terms in rule heads may be
# generated as fresh nodes each time and can prevent fixpoint termination.
#
# We still *output* provenance later via log:query, computed directly from quotes.
{
    :policy :trusts ?Doc .
    ?Doc :says ?F .
    ?F log:includes {
        ?S ?P ?O .
    } .
} => {
    ?S ?P ?O .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

An excerpt of the saved text report:

```text
@prefix : <https://example.org/n3-speaks#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix id: <https://example.org/id/> .
:report :aliceReaches id:bob .
:report :aliceReaches id:carol .
:report :aliceReaches id:dave .
:report :believes {
    id:alice foaf:knows id:bob .
} .
:report :believes {
    id:alice foaf:name "Alice" .
} .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :report :trusts <https://alice.example/profile.n3> . }
  pe:rule
    {
        {
            :policy :trusts ?Doc .
        } => {
            :report :trusts ?Doc .
        } .
    };
  pe:binding [ pe:var "Doc"; pe:value <https://alice.example/profile.n3> ];
  pe:uses { :policy :trusts <https://alice.example/profile.n3> . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 41 steps, 41 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 34; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 7; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 132; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/n3-speaks-for-itself.n3
eyeron -p examples/n3-speaks-for-itself.n3
eyeron -c examples/n3-speaks-for-itself.n3
```

---

## Takeaway

Quoted documents can provide both derived relationships and links to their
supporting evidence.
