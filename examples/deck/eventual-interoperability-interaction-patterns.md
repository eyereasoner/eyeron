# Adding mappings for a concrete interaction

[eventual-interoperability-interaction-patterns.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/eventual-interoperability-interaction-patterns.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/eventual-interoperability-interaction-patterns.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/eventual-interoperability-interaction-patterns.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/eventual-interoperability-interaction-patterns.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=eventual-interoperability-interaction-patterns)

---

## The question

A local course model gains vocabulary mappings when another application needs
a shared view. N3 rules derive the interaction-specific representation while
keeping the source facts available.

**Which mappings let another application use the local course information?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# 1) Producer data (rich, local semantics)
my:Course_KG a my:Course ;
    my:courseCode "KG-101" ;
    my:title "Knowledge Graphs" .

# 5) Generic “eventual interoperability” engine
# - pick the active alignment for the interaction pattern
# - apply vocabulary-level alignments
# Pick the active alignment for a pattern from its family
{
    ?pat a :InteractionPattern ;
        :enabled true ;
        :usesAlignmentFamily ?fam .
    ?fam :hasMember ?al .
    ?al :active true .
} => {
    ?pat :usesAlignment ?al .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:RosterExportToPartnerA :usesAlignment :Align_A_v2 .
:RosterExportToPartnerB :usesAlignment :Align_B_v1 .
:PartnerA_Report sh:conforms true .
:PartnerB_Report sh:conforms true .
my:Student_A a a:Student .
my:Student_A :alignedBy :RosterExportToPartnerA .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :RosterExportToPartnerA :usesAlignment :Align_A_v2 . }
  pe:rule 1;
  pe:binding
    [ pe:var "al"; pe:value :Align_A_v2 ],
    [ pe:var "fam"; pe:value :AlignFamily_PartnerA ],
    [ pe:var "pat"; pe:value :RosterExportToPartnerA ];
  pe:uses
    { :RosterExportToPartnerA a :InteractionPattern . },
    { :RosterExportToPartnerA :enabled true . },
    { :RosterExportToPartnerA :usesAlignmentFamily :AlignFamily_PartnerA . },
    { :AlignFamily_PartnerA :hasMember :Align_A_v2 . },
    { :Align_A_v2 :active true . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 87 steps, 85 verified, 2 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 73; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 14; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 41; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `collected`.

---

## Try it

```sh
eyeron examples/eventual-interoperability-interaction-patterns.n3
eyeron -p examples/eventual-interoperability-interaction-patterns.n3
eyeron -c examples/eventual-interoperability-interaction-patterns.n3
```

---

## References

[Source reference 1](https://pietercolpaert.be/interoperability/2026/01/08/eventual-interoperability)

---

## Takeaway

Interaction-specific mappings can supply a shared view while retaining the
original facts.
