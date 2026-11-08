# What a barley seed lineage can do

[act-barley-seed-lineage.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/act-barley-seed-lineage.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/act-barley-seed-lineage.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/act-barley-seed-lineage.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/act-barley-seed-lineage.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=act-barley-seed-lineage)

---

## The question

A barley lineage needs hereditary information, repair, protection, and
variation. N3 rules derive the possible life-cycle tasks and explain which
missing conditions block the contrast lineages.

**Which lineages can complete the seed life cycle, and which conditions are missing?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:case a arc:Case ;
    arc:question "Can a barley seed lineage achieve accurate self-reproduction, dormancy, development, and adaptive persistence under no-design laws — and what exactly can't happen when key ingredients are missing?" .

# 3. CAN rules — what a lineage can do
# If hereditary information is digital and no-design laws
# hold, accurate genome copying is possible in principle.
{
    :world :obeys :NoDesignLaws .
    ?Genome a :Replicator ;
        :storedIn ?Medium .
    ?Medium a :DigitalInformationMedium .
} => {
    ?Genome :can :GenomeCopyUnderNoDesignLaws .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
:mainGenome :can :GenomeCopyUnderNoDesignLaws .
:fragileGenome :can :GenomeCopyUnderNoDesignLaws .
:staticLine :cannot :EvolvableLineage .
:mainLine a :EvolvableLineage .
:coatlessGenome :can :GenomeCopyUnderNoDesignLaws .
:staticGenome :can :GenomeCopyUnderNoDesignLaws .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :mainGenome :can :GenomeCopyUnderNoDesignLaws . }
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
eyeron examples/act-barley-seed-lineage.n3
eyeron -p examples/act-barley-seed-lineage.n3
eyeron -c examples/act-barley-seed-lineage.n3
```

---

## Takeaway

A possible task depends on all its enabling conditions; a missing condition
explains a blocked lineage.
