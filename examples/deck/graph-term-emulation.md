# Inspecting quoted graph terms

[graph-term-emulation.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/graph-term-emulation.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/graph-term-emulation.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/graph-term-emulation.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/graph-term-emulation.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=graph-term-emulation)

---

## The question

Quoted graphs serve as values that rules can inspect. The N3 example matches
their internal statements and derives results while keeping the quoted
evidence distinct from asserted facts.

**Which graphs describe social links, and whom do they mention?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# The contents of these graph values are quoted data, not asserted facts.
:g1 :graphTerm {
    :alice :knows :bob .
    :bob :knows :carol
} .

# A quoted knows statement is enough to classify its containing graph.
{
    ?g :graphTerm ?formula .
    ?formula log:includes {
        ?s :knows ?o
    }
} => {
    ?g a :SocialGraphTerm
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:g1 a :SocialGraphTerm .
:g1 :mentions :alice .
:g1 :mentions :carol .
:g2 :mentions :tea .
:g1 :mentions :bob .
:g2 :mentions :alice .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :g1 a :SocialGraphTerm . }
  pe:rule 1;
  pe:binding
    [ pe:var "formula"; pe:value {
        :alice :knows :bob .
        :bob :knows :carol .
    } ],
    [ pe:var "g"; pe:value :g1 ],
    [ pe:var "o"; pe:value :bob ],
    [ pe:var "s"; pe:value :alice ];
  pe:uses
    {
        :g1 :graphTerm {
            :alice :knows :bob .
            :bob :knows :carol .
        } .
    },
    {
        {
            :alice :knows :bob .
            :bob :knows :carol .
        } log:includes {
            :alice :knows :bob .
        } .
    }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 11 steps, 11 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 8; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 6; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Re-decision recomputes the recorded built-in operations.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/graph-term-emulation.n3
eyeron -p examples/graph-term-emulation.n3
eyeron -c examples/graph-term-emulation.n3
```

---

## Takeaway

Inspecting a quoted graph can derive facts about it without asserting its
contents.
