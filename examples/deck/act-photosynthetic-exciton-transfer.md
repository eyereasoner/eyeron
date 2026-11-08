# Delivering a photosynthetic excitation

[act-photosynthetic-exciton-transfer.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/act-photosynthetic-exciton-transfer.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/act-photosynthetic-exciton-transfer.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/act-photosynthetic-exciton-transfer.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/act-photosynthetic-exciton-transfer.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=act-photosynthetic-exciton-transfer)

---

## The question

A model antenna must deliver excitation to a reaction center before it is
lost. N3 rules compare the stated transfer conditions and derive which
configurations can perform that task.

**Which modeled antenna configurations can deliver excitation before it is lost?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:case a arc:Case ;
    arc:question "Can a tuned photosynthetic antenna deliver excitation efficiently to a reaction center by short-lived quantum-assisted transfer, while a detuned contrast complex cannot?" .

# CAN rules — what becomes possible
# Strong excitonic coupling plus some delocalization makes
# coherent pathway sampling possible.
{
    ?C a :LightHarvestingComplex ;
        :excitonCoupling :Strong ;
        :stateDelocalization :Present .
} => {
    ?C :can :CoherentPathwaySampling .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:tunedAntenna :can :CoherentPathwaySampling .
:tunedAntenna :can :VibronicallyAssistedTransfer .
:detunedAntenna :cannot :EfficientExcitonTransfer .
:detunedAntenna :cannot :DeliverExcitationToReactionCenter .
:tunedAntenna :can :ShortLivedQuantumAssistance .
:tunedAntenna :can :EfficientExcitonTransfer .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :tunedAntenna :can :CoherentPathwaySampling . }
  pe:rule 1;
  pe:binding [ pe:var "C"; pe:value :tunedAntenna ];
  pe:uses
    { :tunedAntenna a :LightHarvestingComplex . },
    { :tunedAntenna :excitonCoupling :Strong . },
    { :tunedAntenna :stateDelocalization :Present . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 25 steps, 25 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 25; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 47; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/act-photosynthetic-exciton-transfer.n3
eyeron -p examples/act-photosynthetic-exciton-transfer.n3
eyeron -c examples/act-photosynthetic-exciton-transfer.n3
```

---

## Takeaway

A transfer judgment can be traced to the supplied timing and compatibility
conditions.
