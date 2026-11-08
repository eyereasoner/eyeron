# Deriving a shopping insight on a phone

[delfour-phone.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/delfour-phone.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/delfour-phone.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/delfour-phone.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/delfour-phone.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=delfour-phone)

---

## The question

A household health condition and a scanner-use context support a low- sugar
shopping need. N3 rules derive a limited insight and its device, event, and
validity information.

**What limited shopping insight can the phone derive from its private context?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:me health:householdCondition health:Diabetes .

# 1) Desensitization: private health -> neutral need
# (kept on device; only the neutral need leaves the POD)
{
    ?p health:householdCondition health:Diabetes .
} => {
    ?p need:needsLowSugar true .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:me need:needsLowSugar true .
_:ins_3b8612157ed1ad3c a ins:Insight .
_:b7_a3a8310003b7487f odrl:operator odrl:eq .
_:b7_a3a8310003b7487f odrl:rightOperand "2025-10-04T18:51:53Z"^^xsd:dateTime .
_:ins_3b8612157ed1ad3c ins:metric "sugar_g_per_serving" .
_:ins_3b8612157ed1ad3c ins:threshold 10.0 .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :me need:needsLowSugar true . }
  pe:rule 1;
  pe:binding [ pe:var "p"; pe:value :me ];
  pe:uses { :me health:householdCondition health:Diabetes . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 44 steps, 7 verified, 37 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 44; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 43; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 38; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Witness integrity checks the introduction and use of unnamed individuals.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `unsatisfied`.

---

## Try it

```sh
eyeron examples/delfour-phone.n3
eyeron -p examples/delfour-phone.n3
eyeron -c examples/delfour-phone.n3
```

---

## Takeaway

A local need can be expressed with use and validity limits instead of
transmitting the underlying health fact.
