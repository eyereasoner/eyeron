# Connecting named constants to number families

[transcendental-names-and-families.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/transcendental-names-and-families.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/transcendental-names-and-families.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/transcendental-names-and-families.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/transcendental-names-and-families.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=transcendental-names-and-families)

---

## The question

A small catalog names constants and describes mathematical families. N3 rules
apply the supplied theorem and membership implications to derive family
classifications and related number properties.

**Which named constants connect to the modeled number families?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Kinds / tags
:Algebraic a :Kind .

# Subfamily closure
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
:report :family :AlgorithmicRandomNumbers .
:report :family :AllTranscendentals .
:report :unknown :eulerMascheroniGamma .
:report :unknown :piPowE .
:report :family :DigitExpansionTranscendentals .
:report :family :EllipticPeriodConstants .
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
# checked: 205 steps, 205 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 205; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 81; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 644; pe:failed 0 ].
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
eyeron examples/transcendental-names-and-families.n3
eyeron -p examples/transcendental-names-and-families.n3
eyeron -c examples/transcendental-names-and-families.n3
```

---

## Takeaway

The derivations follow explicit family memberships and theorem implications.
