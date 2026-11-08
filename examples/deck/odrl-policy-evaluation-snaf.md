# Evaluating policy conflicts within a graph

[odrl-policy-evaluation-snaf.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/odrl-policy-evaluation-snaf.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/odrl-policy-evaluation-snaf.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/odrl-policy-evaluation-snaf.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/odrl-policy-evaluation-snaf.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=odrl-policy-evaluation-snaf)

---

## The question

Quoted policy sets describe permissions, prohibitions, and conflict
strategies. N3 rules compute each graph's consequences and use scoped presence
and absence tests to derive access decisions.

**How do the supplied conflict strategies change the access decisions?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# 2) Pull a few “queryable” facts out of the closure
{
    :kb :hasFormula ?F .
    ?F log:conclusion ?C .
    ?C log:includes {
        ?req :policy ?ps .
        ?ps odrl:conflict ?strategy .
    } .
} => {
    ?req :conflictStrategy ?strategy .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:Req_Alice_Print_Research_Prohibit :conflictStrategy odrl:prohibit .
:Req_Alice_Print_Research_Perm :conflictStrategy odrl:perm .
:Req_Alice_Print_Research_Invalid :effectiveDecision :VoidPolicy .
:Req_Alice_Print_Research_Invalid :needsReview true .
:Req_Alice_Print_Research_Invalid :conflictStrategy odrl:invalid .
:Req_Bob_Read :conflictStrategy odrl:prohibit .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Req_Alice_Print_Research_Prohibit :conflictStrategy odrl:prohibit . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value {
        :Report a odrl:Asset .
        :Alice a odrl:Party .
        :Bob a odrl:Party .
        :PS_Prohibit a odrl:Set .
        :PS_Prohibit odrl:conflict odrl:prohibit .
        :PS_Perm a odrl:Set .
        :PS_Perm odrl:conflict odrl:perm .
        :PS_Invalid a odrl:Set .
        :PS_Invalid odrl:conflict odrl:invalid .
        :PS_Prohibit odrl:permission _:b1 .
        _:b1 odrl:target :Report .
        _:b1 odrl:action odrl:print .
        _:b1 odrl:assignee :Alice .
        _:b1 odrl:constraint _:b2 .
        _:b2 odrl:leftOperand odrl:purpose .
        _:b2 odrl:operator odrl:eq .
        _:b2 odrl:rightOperand :Research .
…
            :Req_Alice_Print_Research_Prohibit :policy :PS_Prohibit .
            :PS_Prohibit odrl:conflict odrl:prohibit .
        } .
    }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 47 steps, 36 verified, 11 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 20; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 27; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 19; pe:failed 0 ];
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked with obligations**. The result is conditional on the
outstanding obligations listed in the full report; the excerpt does not
discharge them. The report records these obligation kinds: `impure built-in`.

---

## Try it

```sh
eyeron examples/odrl-policy-evaluation-snaf.n3
eyeron -p examples/odrl-policy-evaluation-snaf.n3
eyeron -c examples/odrl-policy-evaluation-snaf.n3
```

---

## Takeaway

Scoped tests keep each policy's permission and prohibition evidence together.
