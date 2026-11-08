# Comparing illustrative epidemic decisions

[epidemic-policy.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/epidemic-policy.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/epidemic-policy.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/epidemic-policy.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/epidemic-policy.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=epidemic-policy)

---

## The question

A toy model assigns outbreak and conditional infection probabilities to
preventive decisions. N3 arithmetic rules combine the supplied probabilities
and policy quantities to derive decision comparisons.

**How do the sample preventive decisions compare under the toy probability model?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# 1. Domain model (unchanged)
:outbreak a prob:Event ;
    prob:probability "0.10"^^xsd:decimal .

{
    :outbreak log:equals false
} => {
    :infect log:equals false
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:answer :text "Optimal decisions (MEU):\n  - vaccinate: 1\n  - mask: 0\n\nMaximum expected utility: -3.00" .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :answer :text "Optimal decisions (MEU):\n  - vaccinate: 1\n  - mask: 0\n\nMaximum expected utility: -3.00" . }
  pe:rule
    {
        {
            ?P a dec:OptimalPolicy .
            ?P :vaccinate ?V .
            ?P :mask ?M .
            ?P util:expectedUtility ?EU .
            ("Optimal decisions (MEU):\n  - vaccinate: " ?V "\n  - mask: " ?M "\n\nMaximum expected utility: " ?EU) string:concatenation ?Msg .
        } => {
            :answer :text ?Msg .
        } .
    };
  pe:binding
    [ pe:var "EU"; pe:value -3.00 ],
    [ pe:var "M"; pe:value 0 ],
    [ pe:var "Msg"; pe:value "Optimal decisions (MEU):\n  - vaccinate: 1\n  - mask: 0\n\nMaximum expected utility: -3.00" ],
    [ pe:var "P"; pe:value :pol_vacc_nomask ],
    [ pe:var "V"; pe:value 1 ];
  pe:uses
    { :pol_vacc_nomask a dec:OptimalPolicy . },
    { :pol_vacc_nomask :vaccinate 1 . },
    { :pol_vacc_nomask :mask 0 . },
    { :pol_vacc_nomask util:expectedUtility -3.00 . },
    { ("Optimal decisions (MEU):\n  - vaccinate: " 1 "\n  - mask: " 0 "\n\nMaximum expected utility: " -3.00) string:concatenation "Optimal decisions (MEU):\n  - vaccinate: 1\n  - mask: 0\n\nMaximum expected utility: -3.00" . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 7 steps, 7 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 1; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 11; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Search closure checks the supplied evidence for current-scope tests.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/epidemic-policy.n3
eyeron -p examples/epidemic-policy.n3
eyeron -c examples/epidemic-policy.n3
```

---

## Takeaway

A decision comparison depends on the supplied probabilities and policy
quantities.
