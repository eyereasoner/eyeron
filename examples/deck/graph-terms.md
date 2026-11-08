# Activating statements from a quoted graph

*Bob says things. A rule decides to believe him.*

[graph-terms.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/graph-terms.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/graph-terms.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/graph-terms.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/graph-terms.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=graph-terms)

---

## The question

Alice likes pasta. Bob says that Alice likes pizza and pasta, and that
*someone* likes both pizza and pasta. What Bob says is only reported speech:
it is stored, not believed.

**If we decide to trust Bob, what follows, including about the unnamed
person?**

---

## What we tell Eyeron

```n3
:alice :likes :pasta .
:bob :says {
    :alice :likes :pizza, :pasta
} .
:bob :says {
    _:x :likes :pizza .
    _:x :likes :pasta
} .
```

Braces make a *quoted graph*: a set of statements used as a single value.
`:pizza, :pasta` is shorthand for two statements with the same subject and
predicate. `_:x` is a *blank node*, a name for "someone" that does not say
who.

```n3
{
    ?x :likes :pasta
} => {
    ?x :likes :spaghetti
} .

{
    :bob :says ?x
} => ?x .
```

The first rule: whoever likes pasta likes spaghetti. The second is the
interesting one: its conclusion is not a pattern in braces but the variable
`?x` itself. Whatever graph Bob says, that graph becomes true.

The program ends with a third rule, the unquoting rule written out by hand for
Bob's statement about Alice. It adds nothing new: delete it and the output
is the same.

---

## What Eyeron concludes

```n3
:alice :likes :spaghetti .
:alice :likes :pizza .
_:x :likes :pizza .
_:x :likes :pasta .
_:x :likes :spaghetti .
```

Alice likes pizza because Bob said so; she likes spaghetti because she likes
pasta. The unnamed person's tastes are now facts, and the spaghetti rule
applies to them too.

---

## The proof, step by step

```n3
{ :alice :likes :pizza . }
  pe:rule 2;
  pe:binding
    [ pe:var "x"; pe:value {
        :alice :likes :pizza .
        :alice :likes :pasta .
    } ];
  pe:uses
    {
        :bob :says {
            :alice :likes :pizza .
            :alice :likes :pasta .
        } .
    }.
```

The variable `x` is bound to a whole graph. Then:

```n3
{ _:x :likes :spaghetti . }
  pe:rule 1;
  pe:binding [ pe:var "x"; pe:value _:x ];
  pe:uses { _:x :likes :pasta . }.
```

The spaghetti step builds on a statement that rule 2 took out of a quote.
There are 8 steps in all: 5 rule steps and 3 facts.

---

## Checked: what the report says

```n3
# checked: 8 steps, 8 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 8; pe:failed 0 ];
pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 2; pe:failed 0 ];
```

- **C1 resolution**: each of the 8 steps matches the rule or fact it cites.
- **C2–C4**: no circular steps, the facts are in the program, every premise
  has a step.
- **C7 relevance**: nothing in the proof is padding.
- **C8 witness integrity**: twice, the blank node `_:x` came out of a quoted
  graph into the conclusions; the checker confirmed it is the blank node of
  Bob's quote and not a name made up along the way.
- **C10 call fidelity**: the answers were checked as asked.

---

## Try it

```sh
eyeron examples/graph-terms.n3
eyeron -p examples/graph-terms.n3
```

Add `:bob :says { :carol :likes :pasta } .` and run again: Carol likes pasta
and, by rule 1, spaghetti.

---

## Takeaway

A quoted graph is data until a rule says to believe it. The rule `{ :bob :says
?x } => ?x` is a one-line trust policy, and the proof shows every conclusion
that depends on it.
