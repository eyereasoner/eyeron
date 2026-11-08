# Applying a scoped shopping insight

[delfour-scanner.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/delfour-scanner.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/delfour-scanner.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/delfour-scanner.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/delfour-scanner.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=delfour-scanner)

---

## The question

A scanner receives a low-sugar insight with limits on its use. N3 rules apply
the insight to the sample shopping context and derive the supported
recommendation information.

**Can the scanner apply the received insight in this shopping context?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:me need:needsLowSugar true .

# 1) Expiry guard: mark an Insight as ex:Expired if expiresAt < now
# (Provide "now" using the helper triple shown below in SAMPLE INPUT.)
{
    ?ins a ins:Insight ;
        ins:expiresAt ?exp .
    [ ] ex:now ?now .
    ?exp math:lessThan ?now .
} => {
    ?ins a ex:Expired .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
_:sk_2 a ex:Allowed .
_:sk_2 ex:target _:sk_0 .
_:a_1544a30569ede393 act:request req:r1 .
_:a_1544a30569ede393 act:outcome "Allowed" .
req:r1 a ex:Allowed .
req:r1 ex:target _:sk_0 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ _:sk_2 a ex:Allowed . }
  pe:rule 2;
  pe:binding
    [ pe:var "ins"; pe:value _:sk_0 ],
    [ pe:var "pol"; pe:value _:sk_1 ],
    [ pe:var "req"; pe:value _:sk_2 ];
  pe:uses
    { _:sk_1 a odrl:Policy . },
    { _:sk_1 odrl:permission _:sk_2 . },
    { _:sk_2 odrl:action odrl:use . },
    { _:sk_2 odrl:target _:sk_0 . },
    { _:sk_2 odrl:constraint _:sk_3 . },
    { _:sk_3 odrl:leftOperand odrl:purpose . },
    { _:sk_3 odrl:operator odrl:eq . },
    { _:sk_3 odrl:rightOperand vocab:shopping_assist . },
    { _:sk_0 a ins:Insight . },
    { _:sk_2 odrl:action odrl:use . },
    { _:sk_2 odrl:constraint _:sk_3 . },
    { _:sk_3 odrl:leftOperand odrl:purpose . },
    { _:sk_3 odrl:rightOperand vocab:shopping_assist . }.
```

`pe:rule 2` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 41 steps, 33 verified, 8 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 38; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 8; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 15; pe:failed 0 ];
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
eyeron examples/delfour-scanner.n3
eyeron -p examples/delfour-scanner.n3
eyeron -c examples/delfour-scanner.n3
```

---

## Takeaway

An insight's audience, purpose and scope are part of the conditions for using
it.
