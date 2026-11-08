# Auditing a school-placement route

[school-placement-audit.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/school-placement-audit.n3) · [input](https://github.com/eyereasoner/eyeron/blob/main/examples/input/school-placement-audit.trig) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/school-placement-audit.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/school-placement-audit.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/school-placement-audit.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=school-placement-audit)

---

## The question

Sample students, schools, walking distances, and policy limits describe a
placement problem. N3 rules compare the supplied provisional and audited
choices and flag excessive walking or a mismatch. They report the supplied
audit results rather than computing routes or school assignments.

**Which supplied assignments exceed the walking limit or differ from the audited choice?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The companion input supplies provisional and audited choices.
# Flag a recorded walking distance above the policy limit.
{
    ?Student :provisional ?Provisional ;
        :auditedBest ?Audited ;
        :walkingMeters ?Walk .
    :Policy :maxWalkingMeters ?MaxWalking .
    ?Walk math:greaterThan ?MaxWalking .
} => {
    ?Student :auditFlag :walkingLimitExceeded .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The companion input supplies additional facts; load it
together with the rules in the commands below.

---

## What Eyeron concludes

An excerpt of the saved text report:

```text
audit result : fail
children affected by straight-line rule : Ada, Björn, Davi
largest hidden detour : Ada, 3000 m
recommended assignments : Ada -> Lindholmen; Björn -> Backa; Clara -> Haga; Davi -> Haga
explanation requested : yes
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Ada :auditFlag :walkingLimitExceeded . }
  pe:rule 1;
  pe:binding
    [ pe:var "Audited"; pe:value :Lindholmen ],
    [ pe:var "MaxWalking"; pe:value 2500 ],
    [ pe:var "Provisional"; pe:value :Centrum ],
    [ pe:var "Student"; pe:value :Ada ],
    [ pe:var "Walk"; pe:value 3600 ];
  pe:uses
    { :Ada :provisional :Centrum . },
    { :Ada :auditedBest :Lindholmen . },
    { :Ada :walkingMeters 3600 . },
    { :Policy :maxWalkingMeters 2500 . },
    { 3600 math:greaterThan 2500 . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 34 steps, 34 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 25; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 9; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 12; pe:failed 0 ].
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
eyeron examples/school-placement-audit.n3 examples/input/school-placement-audit.trig
eyeron -p examples/school-placement-audit.n3 examples/input/school-placement-audit.trig
eyeron -c examples/school-placement-audit.n3 examples/input/school-placement-audit.trig
```

---

## Takeaway

These rules flag and report supplied audit records; they do not calculate the
underlying routes.
