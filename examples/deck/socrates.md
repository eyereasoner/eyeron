# Socrates

*The oldest example in logic, with the reasoning written down and checked.*

[socrates.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/socrates.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/socrates.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/socrates.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/socrates.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=socrates)

---

## The question

Socrates is human. Every human is mortal. Anyone can see what follows, but a
computer should not just announce it: it should be able to show its reasoning,
so that someone else can check it.

**Is Socrates mortal, and can Eyeron show why?**

---

## What we tell Eyeron

```n3
:Socrates a :Human .
:Human rdfs:subClassOf :Mortal .

{
    ?S a ?A .
    ?A rdfs:subClassOf ?B .
} => {
    ?S a ?B .
} .
```

Each line ending in ` .` is a statement: a subject, a predicate and an object.
`:Socrates a :Human` reads *"Socrates is a human"*; `a` is short for "has
type". `:Human rdfs:subClassOf :Mortal` reads *"every human is a mortal"*,
using the RDF Schema word for a subclass.

`{ … } => { … }` is a rule: whenever the statements on the left hold, Eyeron
concludes the ones on the right. Names starting with `?` are variables that
can stand for anything, so the rule reads: *if S is an A, and every A is a B,
then S is a B.*

---

## What Eyeron concludes

```n3
:Socrates a :Mortal .
```

Nobody typed this statement in: the rule produced it. Eyeron prints what it
derived, so the two facts we gave are not repeated.

---

## The proof, step by step

`eyeron -p` writes down how it reached the answer. The proof is N3 too:

```n3
:Socrates a :Mortal .

{ :Socrates a :Mortal . }
  pe:rule 1;
  pe:binding
    [ pe:var "A"; pe:value :Human ],
    [ pe:var "B"; pe:value :Mortal ],
    [ pe:var "S"; pe:value :Socrates ];
  pe:uses
    { :Socrates a :Human . },
    { :Human rdfs:subClassOf :Mortal . }.

{ :Socrates a :Human . }
  pe:fact "socrates.n3".

{ :Human rdfs:subClassOf :Mortal . }
  pe:fact "socrates.n3".
```

It starts with the claim, then gives one step per statement it relies on:

1. *Socrates is mortal*, by rule 1 of the program, with `S` standing for
   Socrates, `A` for Human and `B` for Mortal, using the two statements below.
2. *Socrates is human*: a fact given in `socrates.n3`.
3. *Every human is a mortal*: a fact given in `socrates.n3`.

---

## Checked: what the report says

A proof is only worth something if someone else can check it. `eyeron -c`
generates the proof and checks it; `--check-proof` checks a saved one. The
checker never reasons by itself: it re-performs each recorded step against the
program. The report is N3 as well, and starts with its verdict:

```n3
# checked: 3 steps, 3 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C2"; pe:name "well-foundedness"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C7"; pe:name "relevance"; pe:checked 4; pe:failed 0 ];
```

- **C1 resolution**: each of the 3 steps really is what it cites. Putting
  Socrates, Human and Mortal into rule 1 gives exactly step 1.
- **C2 well-foundedness**: no step depends on itself, even indirectly.
- **C7 relevance**: the claim and all 3 steps serve the answer; nothing is
  padding.

The other conditions examined nothing here: there is no calculation to
recompute, no negation to settle and no invented individual to verify. All 3
steps were verified and none was taken on trust, so the verdict is
**checked**. It confirms the answer; it does not claim there are no others.

---

## Try it

```sh
eyeron examples/socrates.n3      # the answer
eyeron -p examples/socrates.n3   # the answer with its proof
eyeron -c examples/socrates.n3   # the proof, checked
```

Or open it in the [playground](https://eyereasoner.github.io/eyeron/playground#example=socrates).
Add `:Plato a :Human .` and run again: Plato becomes mortal too, with a proof
of his own. Then add `:Mortal rdfs:subClassOf :Living .`: the same rule, used
twice in a row, now concludes that both are living.

---

## Takeaway

A conclusion you can follow step by step, and that a machine has checked, is
one you can explain, question and build on — not just believe.
