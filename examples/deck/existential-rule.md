# Creating a witness for each person

*"Every human is something": a rule that invents an individual each time it fires.*

[existential-rule.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/existential-rule.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/existential-rule.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/existential-rule.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/existential-rule.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=existential-rule)

---

## The question

Some rules say that *something* exists without naming it: every person has a
mother, every order has an invoice. A reasoner that applies such a rule has to
introduce a new, nameless individual to stand for that something. Socrates
and Plato are both humans, and the rule says each human *is* something.

**What does Eyeron conclude, and what does the checker have to take on
trust?**

---

## What we tell Eyeron

```n3
:Socrates a :Human .
:Plato a :Human .

{
    ?S a :Human .
} => {
    ?S :is _:B .
} .
```

`_:B` is a *blank node*: a name for "some individual" that is not a real
name. In a rule's conclusion it means *there exists* such an individual, and
each time the rule fires, Eyeron invents a fresh one.

---

## What Eyeron concludes

```n3
:Socrates :is _:B_cc4af1c6e5dee2d9 .
:Plato :is _:B_fdbbebf585f6a129 .
```

Two different blank nodes: Socrates and Plato are each something, but
nothing says it is the same thing. The long labels are generated; only their
being different matters.

---

## The proof, step by step

The proof has four steps, two per person:

```n3
{ :Socrates :is _:B_cc4af1c6e5dee2d9 . }
  pe:rule 1;
  pe:binding [ pe:var "S"; pe:value :Socrates ];
  pe:uses { :Socrates a :Human . }.

{ :Socrates a :Human . }
  pe:fact "existential-rule.n3".
```

The binding records only `S`. The blank node is not a variable of the rule
that a value was chosen for; it is the witness this firing introduced.

---

## Checked: what the report says

```n3
# checked with obligations: 4 steps, 2 verified, 2 trusted
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 2; pe:failed 0 ];
pe:kind "unsatisfied";
```

- **C1–C4**, **C7** and **C10**: each step matches its rule or fact, and the
  steps are well-founded and serve the answers.
- **C8 witness integrity**: each invented individual is fresh. It appears
  nowhere in the program or the premises, and the two firings do not share
  one.
- **C6 boundary consistency**: nothing in the proof shows that Socrates or
  Plato already *was* something.

The two rule steps are trusted, with an `unsatisfied` obligation each. A
rule that invents an individual fires only when no known fact already
satisfies its conclusion; if `:Socrates :is :Wise` were known, no new
individual would be needed. The proof does not record everything the run
knew, so the checker cannot confirm that nothing did, and it says so. The
verdict is **checked with obligations**: the answers follow from the program
if those two assumptions hold.

---

## Try it

```sh
eyeron examples/existential-rule.n3      # the answer
eyeron -p examples/existential-rule.n3   # the answer with its proof
eyeron -c examples/existential-rule.n3   # the proof, checked
```

Add `:Plato :is :Wise .` and run again: Plato already is something, so only
Socrates gets an invented individual.

---

## Takeaway

Inventing an individual is a real step in a proof: the checker verifies that
it is fresh, and openly lists what it cannot verify.
