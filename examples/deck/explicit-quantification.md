# Explicit and implicit quantifiers

*When two quoted graphs use different variable names, are they the same graph?*

[explicit-quantification.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/explicit-quantification.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/explicit-quantification.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/explicit-quantification.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/explicit-quantification.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=explicit-quantification)

---

## The question

N3 lets you put a whole graph inside another statement, in braces, and talk
about it: who said it, where it came from, whether it is true. Such quoted
graphs can contain variables of two kinds. A *universal* stands for
"anything" (`?x`, or a name declared with `@forAll`); an *existential* stands
for "something" (`_:x`, or a name declared with `@forSome`).

The names themselves should not matter: "everyone loves someone" says the
same thing whether you call them `:x` and `:y` or `:person` and `:beloved`.

**Does Eyeron recognise a quoted graph written with different variable
names as the same graph?**

---

## What we tell Eyeron

Most of the file is a catalog of quoted graphs, each the value of a `:graph`
statement, showing the ways scopes can be arranged. One declares its
variables explicitly:

```n3
:explicitQuantifiers :graph {
    @forAll :x .
    @forSome :y .
    :x :loves :y
} .
```

Others nest one graph inside another, so that an outer variable is inherited
by the inner graph, or an inner `@forSome :x` shadows an outer `@forAll :x`:

```n3
:shadowedVariable :graph {
    @forAll :x .
    :bob :says {
        @forSome :x .
        :x :likes :pizza, :pasta
    } .
} .
```

Only one rule asks a question. It looks for the first graph again, but
written with the names `:person` and `:beloved`:

```n3
{
    :explicitQuantifiers :graph {
        @forAll :person .
        @forSome :beloved .
        :person :loves :beloved .
    }
} => {
    :quantifierRenaming :preservesGraphIdentity true
} .
```

Matching quoted graphs is not matching text: Eyeron may rename variables
that a graph binds itself, as long as it does so consistently, and a
universal must still meet a universal and an existential an existential.

---

## What Eyeron concludes

```n3
:quantifierRenaming :preservesGraphIdentity true .
```

The rule fired: the graph written with `:person` and `:beloved` is the same
graph as the one written with `:x` and `:y`. The rest of the catalog derives
nothing; it is there to be read, and is parsed with each variable in its
proper scope.

---

## The proof, step by step

```n3
{ :quantifierRenaming :preservesGraphIdentity true . }
  pe:rule 1;
  pe:uses
    {
        :explicitQuantifiers :graph {
            @forAll <urn:eyeron:quantified:5f5f713133> .
            <urn:eyeron:quantified:5f5f713133> :loves _:__q14 .
        } .
    }.
```

The proof has two steps. The conclusion comes from rule 1, using the
statement that `:explicitQuantifiers` has a certain graph. In the proof, the
quantified names are written as fresh internal names, and the existential
became a blank node, so no accidental clash with the program's own names can
happen. The second step says that this statement is a fact of the file:

```n3
pe:fact "explicit-quantification.n3".
```

---

## Checked: what the report says

```n3
# checked: 2 steps, 2 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C3"; pe:name "justification"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ].
```

- **C1 resolution**: the rule, applied to the quoted graph, gives exactly the
  claimed statement, and the fact really is in the file. Here that means the
  checker itself matched the two graphs up to a renaming of their variables.
- **C2 well-foundedness**, **C3 justification** and **C4 coverage**: no step
  depends on itself, each is backed by a rule or a fact, and everything used
  is accounted for.
- **C7 relevance**: every step serves the answer.
- **C10 call fidelity**: the rule's condition was checked as it is written.

Nothing was taken on trust, so the verdict is **checked**.

---

## Try it

```sh
eyeron examples/explicit-quantification.n3
eyeron -c examples/explicit-quantification.n3
```

In the rule, change `@forSome :beloved .` into `@forAll :beloved .` and run
again: nothing is concluded. Renaming is allowed, but turning "someone" into
"everyone" makes it a different graph.

---

## Takeaway

A quoted graph is identified by what it says, not by the names chosen for its
variables, and Eyeron keeps each variable in the scope it was declared in.
