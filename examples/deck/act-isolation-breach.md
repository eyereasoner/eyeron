# Sharing an isolation-breach alert

[act-isolation-breach.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/act-isolation-breach.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/act-isolation-breach.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/act-isolation-breach.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/act-isolation-breach.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=act-isolation-breach)

---

## The question

A laboratory must distribute an alert across beacons, controllers, pagers, and
an incident board. N3 rules compose the permitted tasks and contrast ordinary
copying with restrictions on a quantum provenance seal.

**Which devices can pass on the alert, and what prevents copying its quantum seal?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:case a arc:Case ;
    arc:question "Can an isolation-breach token be prepared, permuted, copied, measured, and audited across unlike classical media, and what exactly can't be done with the quantum provenance seal?" .

# If both directions of a permutation are possible, reversible computation is possible.
{
    [
        a :PossibleTask ;
        :kind :Permute ;
        :on ?M ;
        :variable ?V ;
        :fromState ?X ;
        :toState ?Y
    ] .
    [
        a :PossibleTask ;
        :kind :Permute ;
        :on ?M ;
        :variable ?V ;
        :fromState ?Y ;
        :toState ?X
    ] .
} => {
…
        :on ?M ;
        :variable ?V
    ] .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match. The ellipsis omits part of the source; the linked file
contains the full program.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:doorBeacon :can :PrepareInformationStates .
:doorBeacon :can :LocalPermutation .
:SerialNetwork a :PossibleTask .
:ParallelNetwork a :PossibleTask .
:doorBeacon :can :LocalClone .
:containmentPLC :can :PrepareInformationStates .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :doorBeacon :can :PrepareInformationStates . }
  pe:rule 1;
  pe:binding
    [ pe:var "M"; pe:value :doorBeacon ],
    [ pe:var "O"; pe:value :BreachRed ],
    [ pe:var "V"; pe:value :BreachBit ],
    [ pe:var "Z"; pe:value :SafeGreen ];
  pe:uses
    { :doorBeacon a :InformationMedium . },
    { :doorBeacon :encodes :BreachBit . },
    { :doorBeacon :zeroState :SafeGreen . },
    { :doorBeacon :oneState :BreachRed . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked with obligations: 140 steps, 51 verified, 89 trusted
    pe:verdict pe:checkedWithObligations;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 140; pe:failed 0 ];
    pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 89; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 686; pe:failed 0 ];
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
eyeron examples/act-isolation-breach.n3
eyeron -p examples/act-isolation-breach.n3
eyeron -c examples/act-isolation-breach.n3
```

---

## Takeaway

Delivering classical information and copying a quantum attribute are different
tasks in this model.
