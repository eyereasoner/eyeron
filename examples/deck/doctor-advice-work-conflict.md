# Resolving conflicting work advice

[doctor-advice-work-conflict.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/doctor-advice-work-conflict.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/doctor-advice-work-conflict.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/doctor-advice-work-conflict.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/doctor-advice-work-conflict.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=doctor-advice-work-conflict)

---

## The question

A doctor's advice and a sickness policy can disagree about a work request. N3
rules calculate a quoted policy's consequences, inspect the conflict, and
apply the example's explicit resolution strategy.

**How does the stated strategy resolve the conflicting work advice?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# 2) Lift request facts out of the closure (small, deterministic output)
{
    :kb :hasFormula ?F .
    ?F log:conclusion ?C .
    ?C log:includes {
        ?req a :Request ;
            :agent ?who ;
            :job ?job ;
            :location ?loc .
    } .
} => {
    ?req :agent ?who ;
        :job ?job ;
        :location ?loc .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:Request_Jos_Prog_Home :agent :Jos .
:Request_Jos_Prog_Home :job :ProgrammingWork .
:Request_Jos_Prog_Home :effectiveDecision :Permit .
:Jos :workDecision :RemoteWorkOnly .
:Request_Jos_Prog_Home :location :Home .
:Request_Jos_Prog_Office :agent :Jos .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Request_Jos_Prog_Home :agent :Jos . }
  pe:rule 1;
  pe:binding
    [ pe:var "C"; pe:value {
        :Jos a :Person .
        :Jos :has :Flu .
        :Flu :typeOf :Disease .
        :Home a :Location .
        :Office a :Location .
        :ProgrammingWork rdfs:subClassOf :Work .
        :Request_Jos_Prog_Home a :Request .
        :Request_Jos_Prog_Home :agent :Jos .
        :Request_Jos_Prog_Home :job :ProgrammingWork .
        :Request_Jos_Prog_Home :location :Home .
        :Request_Jos_Prog_Office a :Request .
        :Request_Jos_Prog_Office :agent :Jos .
        :Request_Jos_Prog_Office :job :ProgrammingWork .
        :Request_Jos_Prog_Office :location :Office .
        :Doctor :says {
            :Jos :canDo :ProgrammingWork .
        } .
…
            :Request_Jos_Prog_Home :job :ProgrammingWork .
            :Request_Jos_Prog_Home :location :Home .
        } .
    }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof. The ellipsis leaves out part of this step.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 25 steps, 21 verified, 4 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 12; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 13; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 11; pe:failed 0 ];
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
eyeron examples/doctor-advice-work-conflict.n3
eyeron -p examples/doctor-advice-work-conflict.n3
eyeron -c examples/doctor-advice-work-conflict.n3
```

---

## Takeaway

Detecting a policy conflict and resolving it require explicit rules for both
tasks.
