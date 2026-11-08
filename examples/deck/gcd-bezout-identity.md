# Calculating a greatest common divisor and Bezout coefficients

[gcd-bezout-identity.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/gcd-bezout-identity.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/gcd-bezout-identity.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/gcd-bezout-identity.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/gcd-bezout-identity.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=gcd-bezout-identity)

---

## The question

Integer pairs supply cases for the extended Euclidean algorithm. N3 arithmetic
rules derive a greatest common divisor and coefficients that express it as a
combination of the inputs. Queries return those answers.

**Which greatest common divisor and integer coefficients belong to each input pair?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# gcd(a,b) with Bézout:  a*s + b*t = gcd(a,b)
# Works for integers a,b (not both 0). Handles signs.
# Vocabulary
:Case a rdfs:Class .

# Sign flags (1 for ≥0, −1 for <0)
{
    ?N a :Case ;
        :a ?a .
    ?a math:notLessThan 0 .
} => {
    ?N :signA 1 .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:C3 :answer _:b1_90d7a32b314ac16d .
_:b1_90d7a32b314ac16d a :Answer .
:C1 :answer _:b1_8d818306dd2f73f8 .
:C5 :answer _:b1_468ea91e5921108b .
:C4 :answer _:b1_736eddac53fcfc25 .
:C6 :status "done" .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :C3 :answer _:b1_90d7a32b314ac16d . }
  pe:rule 8;
  pe:binding
    [ pe:var "N"; pe:value :C3 ],
    [ pe:var "r0"; pe:value 5 ],
    [ pe:var "s"; pe:value 0 ],
    [ pe:var "s0"; pe:value 0 ],
    [ pe:var "sa"; pe:value 1 ],
    [ pe:var "sb"; pe:value 1 ],
    [ pe:var "t"; pe:value 1 ],
    [ pe:var "t0"; pe:value 1 ],
    [ pe:var "w"; pe:value _:w2_3d4a74e44319c2c ];
  pe:uses
    { _:w2_3d4a74e44319c2c a :Work . },
    { _:w2_3d4a74e44319c2c :num :C3 . },
    { _:w2_3d4a74e44319c2c :r0 5 . },
    { _:w2_3d4a74e44319c2c :r1 0 . },
    { _:w2_3d4a74e44319c2c :s0 0 . },
    { _:w2_3d4a74e44319c2c :t0 1 . },
    { :C3 :signA 1 . },
    { :C3 :signB 1 . },
    { (0 1) math:product 0 . },
    { (1 1) math:product 1 . }.
```

`pe:rule 8` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 520 steps, 246 verified, 274 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 322; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 198; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 274; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4076; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Witness integrity checks the introduction and use of unnamed individuals.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `unsatisfied`.

---

## Try it

```sh
eyeron examples/gcd-bezout-identity.n3
eyeron -p examples/gcd-bezout-identity.n3
eyeron -c examples/gcd-bezout-identity.n3
```

---

## Takeaway

Bezout coefficients make the greatest-common-divisor calculation checkable by
substitution.
