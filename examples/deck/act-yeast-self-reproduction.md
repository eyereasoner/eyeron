# What a yeast culture needs to reproduce

*Two yeast lineages, alike in every way but one: how their genes are stored.*

[act-yeast-self-reproduction.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/act-yeast-self-reproduction.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/act-yeast-self-reproduction.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/act-yeast-self-reproduction.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/act-yeast-self-reproduction.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=act-yeast-self-reproduction)

---

## The question

How can something copy itself accurately, generation after generation, when
the laws of physics contain no design for it? Chiara Marletto's *constructor
theory of life* argues that it needs hereditary information stored
*digitally*, in discrete symbols, as DNA does.

This example models that argument with a yeast starter culture, and a
contrast culture that is identical except that its genome sits in a
non-digital, analogue store.

**What can the starter culture do, and what exactly can the contrast culture
not do?**

---

## What we tell Eyeron

Shared assumptions, then the two lineages:

```n3
:world :obeys :NoDesignLaws .

:dnaRegister a :DigitalInformationMedium .
:analogRegister a :NonDigitalInformationMedium .
…
:starterGenome a :Replicator ;
    :accuracy :High ;
    :variant :RespireFast ;
    :storedIn :dnaRegister .
…
:contrastGenome a :Replicator ;
    :accuracy :High ;
    :variant :RespireFast ;
    :storedIn :analogRegister .
```

Each cell has a genome (the *replicator*) and the machinery that copies and
feeds it (the *vehicle*). A nutrient bath, a source of mutations and a
fermenter that favours fast respiration complete the world.

The rules chain possibilities. A digital medium supports replication; a
genome stored in one can be copied accurately; and then:

```n3
{
    ?Cell :hasReplicator ?Genome .
    ?Genome :can :AccurateGenomeCopyUnderNoDesignLaws .
    ?Cell :can :AccurateReplicationArchitecture .
    :nutrientBath a :RawMaterialSupply .
} => {
    ?Cell a :SelfReproducer .
    ?Cell :can :SelfReproduce .
    :SelfReproduction a :PossibleTask .
} .
```

*Accurate copying, the right architecture and raw materials make
self-reproduction possible.* Add variation and selection, and a natural
selection lineage becomes possible too.

A second chain states impossibilities, starting from the analogue store:

```n3
{
    :world :obeys :NoDesignLaws .
    ?Genome a :Replicator ;
        :storedIn ?Medium .
    ?Medium a :NonDigitalInformationMedium .
} => {
    ?Genome :cannot :AccurateGenomeCopyUnderNoDesignLaws .
} .
```

"Cannot" here is a positive conclusion of the model, not a failure to prove
"can". Two `log:query` rules print only the `:can` and `:cannot` statements.

---

## What Eyeron concludes

```n3
:dnaRegister :can :SupportReplicationUnderNoDesignLaws .
:starterGenome :can :AccurateGenomeCopyUnderNoDesignLaws .
:starterCell :can :SelfReproduce .
:starterCell :can :NaturalSelectionLineage .
…
:contrastCell :can :AccurateReplicationArchitecture .
:contrastGenome :cannot :AccurateGenomeCopyUnderNoDesignLaws .
:contrastCell :cannot :AccurateSelfReproduction .
:contrastCell :cannot :NaturalSelectionLineage .
```

Eleven statements in all. The starter culture can reproduce itself and
evolve by natural selection. The contrast culture has the same machinery,
`:AccurateReplicationArchitecture`, and can vary, yet it cannot copy its
genome accurately, so it cannot reproduce accurately or sustain the same
natural selection story. The single difference in storage decides it.

Some conclusions are derived but not printed, such as
`:starterGenome :selectedIn :fermenter` and the `:PossibleTask` labels: no
query asks for them.

---

## The proof, step by step

The proof has 29 steps. Self-reproduction of the starter cell rests on four
premises:

```n3
{ :starterCell :can :SelfReproduce . }
  pe:rule 4;
  pe:binding
    [ pe:var "Cell"; pe:value :starterCell ],
    [ pe:var "Genome"; pe:value :starterGenome ];
  pe:uses
    { :starterCell :hasReplicator :starterGenome . },
    { :starterGenome :can :AccurateGenomeCopyUnderNoDesignLaws . },
    { :starterCell :can :AccurateReplicationArchitecture . },
    { :nutrientBath a :RawMaterialSupply . }.
```

The contrast culture's impossibility starts from its analogue store:

```n3
{ :contrastGenome :cannot :AccurateGenomeCopyUnderNoDesignLaws . }
  pe:rule 8;
  pe:binding
    [ pe:var "Genome"; pe:value :contrastGenome ],
    [ pe:var "Medium"; pe:value :analogRegister ];
  pe:uses
    { :world :obeys :NoDesignLaws . },
    { :contrastGenome a :Replicator . },
    { :contrastGenome :storedIn :analogRegister . },
    { :analogRegister a :NonDigitalInformationMedium . }.
```

Two more rule steps carry it to `:cannot :NaturalSelectionLineage`.

---

## Checked: what the report says

```n3
# checked: 29 steps, 29 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 29; pe:failed 0 ];
pe:condition [ pe:id "C7"; pe:name "relevance"; pe:checked 40; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 54; pe:failed 0 ].
```

- **C1 resolution**, **C2 well-foundedness**, **C3 justification**,
  **C4 coverage**: every step matches its rule or fact, no step depends on
  itself, every premise is proved or given.
- **C7 relevance**: every step serves an answer, and each answer is one a
  query asks for.
- **C10 call fidelity**: each printed answer has a real query application
  behind it.

There are no built-ins, negations or invented individuals, so the remaining
conditions examined nothing. 29 of 29 steps verified: **checked**.

---

## Try it

```sh
eyeron examples/act-yeast-self-reproduction.n3      # the answer
eyeron -p examples/act-yeast-self-reproduction.n3   # with its proof
eyeron -c examples/act-yeast-self-reproduction.n3   # the proof, checked
```

Change the contrast genome's `:storedIn :analogRegister` to
`:storedIn :dnaRegister` and run again: every `:cannot` disappears, and the
contrast cell, like the starter, can self-reproduce and sustain a natural
selection lineage.

---

## Takeaway

One property, digital or analogue storage, separates a lineage that can
evolve from one that cannot, and the proof traces that difference through
every conclusion that depends on it.
