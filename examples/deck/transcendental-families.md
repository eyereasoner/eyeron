# Classifying symbolic families of numbers

[transcendental-families.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/transcendental-families.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/transcendental-families.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/transcendental-families.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/transcendental-families.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=transcendental-families)

---

## The question

Named expressions and encoded mathematical implications describe number
families. N3 rules derive the classifications and consequences supported by
those declarations, retaining links to the applied theorem facts.

**Which symbolic families satisfy the encoded theorem conditions?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Kinds / tags
:Algebraic a :Kind .

# Family propagation (taxonomy)
{
    ?X :inFamily ?F .
    ?F :subFamilyOf ?G .
} => {
    ?X :inFamily ?G .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:report :family :AlgebraicClosureFamily .
:report :family :AllTranscendentals .
:report :unknown :prod_e_pi .
:report :unknown :sum_e_pi .
:report :family :ComputableTranscendentals .
:report :family :GelfondSchneiderNumbers .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :report :family :AllTranscendentals . }
  pe:rule
    {
        {
            ?F a :Family .
        } => {
            :report :family ?F .
        } .
    };
  pe:binding [ pe:var "F"; pe:value :AllTranscendentals ];
  pe:uses { :AllTranscendentals a :Family . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 260 steps, 260 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 260; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 78; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 798; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Witness integrity checks the introduction and use of unnamed individuals.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/transcendental-families.n3
eyeron -p examples/transcendental-families.n3
eyeron -c examples/transcendental-families.n3
```

---

## Takeaway

The reasoning applies stated theorem implications rather than discovering new
transcendence proofs.
