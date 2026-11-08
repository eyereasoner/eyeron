# Solving the five-house riddle

[zebra.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/zebra.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/zebra.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/zebra.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/zebra.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=zebra)

---

## The question

House positions connect nationalities, colors, drinks, pets, and smoking
brands. N3 rules combine the puzzle's constraints to derive the complete
arrangement and identify who owns the fish.

**Which five-house arrangement satisfies the clues, and who owns the fish?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Present the five houses in their left-to-right order.
{
    :solution :positions (?Colours ?Nationalities ?Pets ?Drinks ?Cigars) .
    (1 2 3 4 5) list:member ?Position .
    ?Colours list:member (?Position ?Colour) .
    ?Nationalities list:member (?Position ?Nationality) .
    ?Pets list:member (?Position ?Pet) .
    ?Drinks list:member (?Position ?Drink) .
    ?Cigars list:member (?Position ?Cigar) .
} => {
    :solution :house (?Position ?Colour ?Nationality ?Pet ?Drink ?Cigar) .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:german :eats :fish .
:solution :house (1 :yellow :norwegian :cats :water :dunhill) .
:solution :house (2 :blue :dane :horse :tea :blends) .
:solution :house (3 :red :brit :birds :milk :pallmall) .
:solution :house (4 :green :german :fish :coffee :prince) .
:solution :house (5 :white :swede :dogs :beer :bluemasters) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :german :eats :fish . }
  pe:rule 1;
  pe:binding
    [ pe:var "Beer"; pe:value 5 ],
    [ pe:var "Birds"; pe:value 3 ],
    [ pe:var "Blends"; pe:value 2 ],
    [ pe:var "CatDelta"; pe:value 1 ],
    [ pe:var "Cats"; pe:value 1 ],
    [ pe:var "Dane"; pe:value 2 ],
    [ pe:var "Fish"; pe:value 4 ],
    [ pe:var "German"; pe:value 4 ],
    [ pe:var "Green"; pe:value 4 ],
    [ pe:var "Horse"; pe:value 2 ],
    [ pe:var "HorseDelta"; pe:value 1 ],
    [ pe:var "Owner"; pe:value :german ],
    [ pe:var "Red"; pe:value 3 ],
    [ pe:var "Swede"; pe:value 5 ],
    [ pe:var "Water"; pe:value 1 ],
    [ pe:var "WaterDelta"; pe:value 1 ],
    [ pe:var "White"; pe:value 5 ],
    [ pe:var "Yellow"; pe:value 1 ];
…
    { 4 log:notEqualTo 5 . },
    { 4 log:notEqualTo 3 . },
    { 4 log:notEqualTo 1 . },
    { ((1 :norwegian) (3 :brit) (5 :swede) (2 :dane) (4 :german)) list:member (4 :german) . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 61 steps, 61 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 7; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 54; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 188; pe:failed 0 ].
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
eyeron examples/zebra.n3
eyeron -p examples/zebra.n3
eyeron -c examples/zebra.n3
```

---

## Takeaway

The result is the arrangement supported by this version of the puzzle's
explicit constraints.
