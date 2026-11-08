# Controlling a tank with integer levels

[integer-first-control-tank-level.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/integer-first-control-tank-level.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/integer-first-control-tank-level.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/integer-first-control-tank-level.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/integer-first-control-tank-level.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=integer-first-control-tank-level)

---

## The question

A sampled tank controller operates on water levels in millimeters. N3
arithmetic rules derive bounded state traces for low, high, and nominal
starting levels and check the control behavior.

**Do the finite level traces meet the controller's stated bounds?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Parameters
:controller a :SampledTankController ;
    :setpoint 20 ;
    :outflow 2 ;
    :maxStep 8 .

# Initial condition
{
    ?trial a :ClosedLoopTrial ;
        :initialLevel ?level0 .
} => {
    ?trial :levelAt (0 ?level0) .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:result :holdBand (:trialHigh 5 true) .
:result :holdBand (:trialHigh 6 true) .
:result :holdBand (:trialHigh 7 true) .
:result :holdBand (:trialLow 5 true) .
:result :trace (:trialNominal 7 20 2 0) .
:result :trace (:trialNominal 8 20 2 0) .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :result :trace (:trialLow 0 12 4 8) . }
  pe:rule
    {
        {
            ?trial :levelAt (?k ?level) .
            ?trial :valveAt (?k ?valve) .
            ?trial :errorAt (?k ?error) .
        } => {
            :result :trace (?trial ?k ?level ?valve ?error) .
        } .
    };
  pe:binding
    [ pe:var "error"; pe:value 8 ],
    [ pe:var "k"; pe:value 0 ],
    [ pe:var "level"; pe:value 12 ],
    [ pe:var "trial"; pe:value :trialLow ],
    [ pe:var "valve"; pe:value 4 ];
  pe:uses
    { :trialLow :levelAt (0 12) . },
    { :trialLow :valveAt (0 4) . },
    { :trialLow :errorAt (0 8) . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 282 steps, 282 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 182; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 100; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1020; pe:failed 0 ].
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
eyeron examples/integer-first-control-tank-level.n3
eyeron -p examples/integer-first-control-tank-level.n3
eyeron -c examples/integer-first-control-tank-level.n3
```

---

## Takeaway

Integer levels make each sampled control decision explicit and reproducible.
