# An entanglement witness for a mediator

[act-gravity-mediator-witness.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/act-gravity-mediator-witness.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/act-gravity-mediator-witness.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/act-gravity-mediator-witness.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/act-gravity-mediator-witness.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=act-gravity-mediator-witness)

---

## The question

Two quantum sensors can interact only through gravity. If they become
entangled anyway, and locality holds, then gravity cannot be purely classical:
this is the argument of Marletto and Vedral for testing quantum gravity in the
lab. Eyeron applies it to two experiment runs: one that passed the
entanglement witness, so its mediator is non-classical, and a contrast run
with a purely classical mediator, which cannot support that conclusion. It
shows plain forward rules chaining conclusions, and log:query choosing what to
report.

**Which experiment supports the conclusion that its mediator is non-classical?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:case a arc:Case ;
    arc:question "If two quantum sensors become entangled only through a gravitational mediator, while locality and interoperability hold, what can be concluded, and what can't a purely classical mediator model do?" .

# CAN rules — what becomes possible in the positive witness run
# Under locality and no direct coupling, interaction is mediated only through M.
{
    ?R a :ExperimentRun ;
        :assumes :Locality ;
        :directCouplingStatus :NoDirectCoupling ;
        :usesMediator ?M .
} => {
    ?R :interactionPath :MediatorOnlyPath .
    ?R :pathMediator ?M .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:run :can :SupportMediatorOnlyEntanglementWitness .
:contrastRun :cannot :SupportMediatorOnlyEntanglementWitness .
:run :supportsConclusion :GravityMediatorNonClassical .
:run :rulesOut :PurelyClassicalMediatorModel .
:classicalGravityMediator :cannot :MediateEntanglementUnderWitnessConditions .
:contrastRun :cannot :SupportMediatorNonClassicalConclusion .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :run :can :SupportMediatorOnlyEntanglementWitness . }
  pe:rule 4;
  pe:binding
    [ pe:var "M"; pe:value :gravityMediator ],
    [ pe:var "R"; pe:value :run ];
  pe:uses
    { :run a :ExperimentRun . },
    { :run :assumes :Locality . },
    { :run :assumes :Interoperability . },
    { :run :interactionPath :MediatorOnlyPath . },
    { :run :usesMediator :gravityMediator . },
    { :run :observed :EntanglementWitnessPassed . }.
```

`pe:rule 4` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 23 steps, 23 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 23; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 62; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/act-gravity-mediator-witness.n3
eyeron -p examples/act-gravity-mediator-witness.n3
eyeron -c examples/act-gravity-mediator-witness.n3
```

---

## References

[Source reference 1](https://arxiv.org/abs/1707.06036)

---

## Takeaway

The mediator conclusion follows under the stated locality and witness
assumptions; the example does not perform the experiment.
