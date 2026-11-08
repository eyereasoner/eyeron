# Propagating metadata on quoted graphs

[quoted-probability.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/quoted-probability.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/quoted-probability.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/quoted-probability.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/quoted-probability.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=quoted-probability)

---

## The question

Quoted graphs carry interpretation and probability information. N3 rules match
those terms and combine the supplied inverse or subclass- style relations to
derive further annotated statements.

**Which further statements inherit the supplied interpretation and probability metadata?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# test cases
{
    :x :p :y .
} :s :o .

# Annotations of inverse props are copied over since "inverse" is a hard/simple logical relation
{
    {
        ?x ?p ?y .
    } ?s ?o .
    ?p owl:inverseOf ?q .
} => {
    {
        ?y ?q ?x .
    } ?s ?o .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

This is an excerpt of the saved conclusions.

```n3
{
    :x :p :z .
} owlstar:hasInterpretation owlstar:SubClassOfSomeValuesFrom .
{
    :x :r :z .
} :probability 0.49840000000000007 .
{
    :z :q :x .
} owlstar:hasInterpretation owlstar:SubClassOfSomeValuesFrom .
{
    :x :r :x .
} :probability 0.7921 .
{
    :y :q :x .
} :s :o .
{
    :y :q :x .
} owlstar:hasInterpretation owlstar:SubClassOfSomeValuesFrom .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :p owl:inverseOf :q . }
  pe:fact "quoted-probability.n3".
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 18 steps, 18 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 16; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 2; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 8; pe:failed 0 ].
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
eyeron examples/quoted-probability.n3
eyeron -p examples/quoted-probability.n3
eyeron -c examples/quoted-probability.n3
```

---

## References

[Source reference 1](https://github.com/w3c/rdf-star/issues/200)

---

## Takeaway

Rules can relate quoted statements while keeping their metadata attached.
