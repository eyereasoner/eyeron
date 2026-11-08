# Property Paths

*Grandparents and parents, found by walking links forwards and backwards.*

[property-paths.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/property-paths.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/property-paths.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/property-paths.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/property-paths.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=property-paths)

---

## The question

A family tree stores only "parent of" links: a is the parent of b, and b is
the parent of c. Two other questions come up all the time: who is whose
grandparent, and who has which parent? Query languages such as SPARQL answer
them with *property paths*: follow a link twice, or follow it backwards.

**Can two plain rules do the same, with a proof?**

---

## What we tell Eyeron

```n3
:a :parentOf :b .
:b :parentOf :c .
```

The family chain: two statements, each a subject, a link and an object.

```n3
{
    ?x :parentOf ?y .
    ?y :parentOf ?z
} => {
    ?x :grandparentOf ?z
} .
```

A *sequence*: if x is a parent of y, and y a parent of z, then x is a
grandparent of z. The shared variable `?y` is what joins the two links.

```n3
{
    ?x :parentOf ?y
} => {
    ?y :hasParent ?x
} .
```

An *inverse*: the same link read from the other end.

---

## What Eyeron concludes

```n3
:a :grandparentOf :c .
:b :hasParent :a .
:c :hasParent :b .
```

One grandparent (only a has a grandchild) and two has-parent links, one for
each parent fact. The given facts are not repeated.

---

## The proof, step by step

```n3
{ :a :grandparentOf :c . }
  pe:rule 1;
  pe:binding
    [ pe:var "x"; pe:value :a ],
    [ pe:var "y"; pe:value :b ],
    [ pe:var "z"; pe:value :c ];
  pe:uses
    { :a :parentOf :b . },
    { :b :parentOf :c . }.
…
{ :c :hasParent :b . }
  pe:rule 2;
```

Each conclusion names the rule that produced it, what its variables stood for,
and the statements it used. The grandparent step uses both parent facts; each
has-parent step uses one. Five steps in all: three rule steps and the two
facts.

---

## Checked: what the report says

```n3
# checked: 5 steps, 5 verified, 0 trusted
pe:verdict pe:checked;
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
pe:condition [ pe:id "C7"; pe:name "relevance"; pe:checked 8; pe:failed 0 ];
```

- **C1 resolution**: every step is what it cites: a fact of the file, or the
  rule with the stated values filled in.
- **C2 well-foundedness, C3 justification, C4 coverage**: no step leans on
  itself, every premise has its own step, and every answer is covered.
- **C7 relevance**: everything in the proof serves an answer.
- **C10 call fidelity**: the three answers are the ones the program asked for.

Nothing was taken on trust, so the verdict is **checked**.

---

## Try it

```sh
eyeron examples/property-paths.n3      # the answer
eyeron -p examples/property-paths.n3   # with its proof
eyeron -c examples/property-paths.n3   # the proof, checked
```

Add `:c :parentOf :d .` and run again: b becomes the grandparent of d, and d
gets a parent.

---

## Takeaway

Property paths are not a separate feature here: a shared variable chains
links, and swapping subject and object reverses them, each step with a proof.
