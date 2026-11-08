# Checking Euler's identity from an exact phase

[euler-identity.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/euler-identity.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/euler-identity.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/euler-identity.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/euler-identity.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=euler-identity)

---

## The question

The phase at pi is represented by its exact complex pair. N3 arithmetic rules
add one to that pair and derive a zero result, checking the supplied
representation of Euler's identity.

**Does adding one to the supplied exact phase pair give zero?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Parameters
:EulerIdentity a :ExactComplexEquation ;
    :name "Euler identity" ;
    :formula "exp(i*pi) + 1 = 0" ;
    :usesPhase :phasePi .

# 1) Construct exp(i*pi) exactly as (-1, 0)
{
    (0 1) math:difference ?minusOne .
} => {
    :phasePi :exact (?minusOne 0) .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:result :phasePi (-1 0) .
:result :lhsPlusOne (0 0) .
:result :rhsZero (0 0) .
:result :phaseModSq 1 .
:result :phaseModSqIsOne true .
:result :identityHolds true .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :phasePi (-1 0) . }
  pe:rule
    {
        {
            :phasePi :exact (?re ?im) .
            :EulerIdentity :lhsExact (?sumRe ?sumIm) .
            :EulerIdentity :rhsExact (?rhsRe ?rhsIm) .
            :phasePi :modSq ?modSq .
            :phasePi :modSqIsOne ?modOk .
            :EulerIdentity :holds ?ok .
        } => {
            :result :phasePi (?re ?im) .
            :result :lhsPlusOne (?sumRe ?sumIm) .
            :result :rhsZero (?rhsRe ?rhsIm) .
            :result :phaseModSq ?modSq .
            :result :phaseModSqIsOne ?modOk .
            :result :identityHolds ?ok .
        } .
    };
  pe:binding
    [ pe:var "im"; pe:value 0 ],
…
    { :EulerIdentity :rhsExact (0 0) . },
    { :phasePi :modSq 1 . },
    { :phasePi :modSqIsOne true . },
    { :EulerIdentity :holds true . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 21 steps, 21 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 14; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 7; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 77; pe:failed 0 ].
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
eyeron examples/euler-identity.n3
eyeron -p examples/euler-identity.n3
eyeron -c examples/euler-identity.n3
```

---

## Takeaway

The rules check the encoded phase value; they do not derive that value from a
transcendental series.
