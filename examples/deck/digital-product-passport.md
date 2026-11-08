# Computing product-passport indicators

[digital-product-passport.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/digital-product-passport.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/digital-product-passport.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/digital-product-passport.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/digital-product-passport.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=digital-product-passport)

---

## The question

A product passport records organizations, materials, and environmental
quantities. N3 rules derive indicators and a readable summary; mass is in
grams and footprint values are in grams of CO2 equivalent.

**Which environmental indicators follow from this product passport?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:000_md_title log:outputString "# digital-product-passport\n\n## Source files\n\n- [N3 rules](../digital-product-passport.n3)\n\n" .

# Attach totals to the product
{
    ?P :componentList ?L .
    ?L :sumMassG ?mTot .
    ?L :sumRecycledG ?rTot .
} => {
    ?P :totalMassG ?mTot .
    ?P :recycledMassG ?rTot .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. A backward rule, `{ … } <= { … }`, supplies an answer
when its left-hand goal is called.

---

## What Eyeron concludes

An excerpt of the saved text report:

```text
ACME X1000 SN123 | recycled=13% | lifecycle=52500 gCO2e | CRM=true | hint=http://example.org/dpp#repairFriendly
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :ACME-X1000-SN123 :circularityHint :repairFriendly . }
  pe:rule 8;
  pe:binding
    [ pe:var "B"; pe:value :BatteryPack-01 ],
    [ pe:var "Doc"; pe:value :Doc-SpareParts ],
    [ pe:var "P"; pe:value :ACME-X1000-SN123 ],
    [ pe:var "Passport"; pe:value :Passport-ACME-X1000-SN123 ];
  pe:uses
    { :ACME-X1000-SN123 :hasComponent :BatteryPack-01 . },
    { :BatteryPack-01 :componentType :Battery . },
    { :BatteryPack-01 :replaceable true . },
    { :Passport-ACME-X1000-SN123 :describesProduct :ACME-X1000-SN123 . },
    { :Passport-ACME-X1000-SN123 :hasDocument :Doc-SpareParts . },
    { :Doc-SpareParts :docType :SparePartsCatalog . }.
```

`pe:rule 8` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 49 steps, 49 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 35; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 14; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 15; pe:failed 0 ].
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
eyeron examples/digital-product-passport.n3
eyeron -p examples/digital-product-passport.n3
eyeron -c examples/digital-product-passport.n3
```

---

## Takeaway

Explicit units and component quantities make the arithmetic behind a passport
indicator visible.
