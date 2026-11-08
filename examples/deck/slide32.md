# Slide 32

*Ghent is a city, every city is a human community, so Ghent is one too.*

[slide32.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/slide32.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/slide32.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/slide32.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/slide32.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=slide32)

---

## The question

A small teaching example, numbered after the slide it was made for. Ghent is
a city, and every city is a human community.

**What is Ghent, and can we choose what Eyeron prints?**

---

## What we tell Eyeron

```n3
:Ghent a :City .

{
    ?x a :City .
} => {
    ?x a :HumanCommunity .
} .
```

The fact reads *"Ghent is a city"*. The rule reads *"whatever is a city is a
human community"*: `?x` can stand for anything.

Then a query:

```n3
{
    ?S a ?C .
} log:query {
    ?S a ?C .
} .
```

`log:query` decides what is printed. For every way the left side matches,
the right side is written out. Here both sides are the same pattern, so the
output is every type statement Eyeron knows, whether given or derived.

---

## What Eyeron concludes

```n3
:Ghent a :City .
:Ghent a :HumanCommunity .
```

Without the query Eyeron would print only what it derived. With it, the
given fact `:Ghent a :City` is part of the answer too.

---

## The proof, step by step

```n3
{ :Ghent a :HumanCommunity . }
  pe:rule 1;
  pe:binding [ pe:var "x"; pe:value :Ghent ];
  pe:uses { :Ghent a :City . }.

{ :Ghent a :City . }
  pe:fact "slide32.n3".
```

1. *Ghent is a human community*, by rule 1 with `x` standing for Ghent.
2. *Ghent is a city*, a fact of `slide32.n3`. This step also supports the
   second answer directly.

---

## Checked: what the report says

```n3
# checked: 2 steps, 2 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4; pe:failed 0 ].
```

- **C1 resolution**: both steps are what they cite.
- **C2 well-foundedness**, **C3 justification**, **C4 coverage** and **C7
  relevance**: the steps form a proper tree, every premise and answer is
  covered, and nothing is padding.
- **C10 call fidelity**: both answers really are matches of the query's
  pattern, so the printed output is what the query asked for.

No calculation, negation or invented individual is involved, so the other
conditions examined nothing. The verdict is **checked**.

---

## Try it

```sh
eyeron examples/slide32.n3      # the answer
eyeron -p examples/slide32.n3   # the answer with its proof
eyeron -c examples/slide32.n3   # the proof, checked
```

Add `:Paris a :City .` and run again: Paris is printed both as a city and as a
human community.

---

## Takeaway

One rule turns a fact into a new one, and a query chooses which statements,
given or derived, make up the answer.
