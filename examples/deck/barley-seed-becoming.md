# Following a barley seed's life cycle

[barley-seed-becoming.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/barley-seed-becoming.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/barley-seed-becoming.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/barley-seed-becoming.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/barley-seed-becoming.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=barley-seed-becoming)

---

## The question

A lineage moves from dormancy through germination and growth to the next seed.
N3 rules derive supported transitions and show how missing hereditary or
protective conditions interrupt the cycle.

**Which seed lineages can advance through every modeled life stage?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:case a arc:Case ;
    arc:question "Can a barley seed lineage become a self-renewing and adaptively persistent cycle under no-design laws — and what blocks that becoming when digital heredity, repair, protected dormancy, or variation are missing?" .

# 3. CAN-BECOME rules — viable transformations
# Under no-design laws, digital hereditary information can be copied accurately.
{
    :world :obeys :NoDesignLaws .
    ?Genome a :Replicator ;
        :storedIn ?Medium .
    ?Medium a :DigitalInformationMedium .
} => {
    ?Genome :canBecome :AccuratelyCopiedGenome .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:mainGenome :canBecome :AccuratelyCopiedGenome .
:fragileGenome :canBecome :AccuratelyCopiedGenome .
:staticLine :cannotBecome :EvolvableBecoming .
:mainLine a :EvolvableBecoming .
:coatlessGenome :canBecome :AccuratelyCopiedGenome .
:staticGenome :canBecome :AccuratelyCopiedGenome .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :mainGenome :canBecome :AccuratelyCopiedGenome . }
  pe:rule 1;
  pe:binding
    [ pe:var "Genome"; pe:value :mainGenome ],
    [ pe:var "Medium"; pe:value :dnaRegister ];
  pe:uses
    { :world :obeys :NoDesignLaws . },
    { :mainGenome a :Replicator . },
    { :mainGenome :storedIn :dnaRegister . },
    { :dnaRegister a :DigitalInformationMedium . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 143 steps, 143 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 143; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 267; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/barley-seed-becoming.n3
eyeron -p examples/barley-seed-becoming.n3
eyeron -c examples/barley-seed-becoming.n3
```

---

## Takeaway

Each new state carries the conditions needed to support the next transition.
