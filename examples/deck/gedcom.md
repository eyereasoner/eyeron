# Deriving relationships from genealogy records

[gedcom.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/gedcom.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/gedcom.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/gedcom.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/gedcom.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=gedcom)

---

## The question

Family records identify spouses, children, and sex. N3 rules connect these
records to derive the requested genealogical relationships.

**Which family relationships follow from the supplied genealogy records?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
:Frans gc:spouseIn :dp ;
    gc:sex gc:Male .

{
    ?C gc:childIn ?F .
    ?P gc:spouseIn ?F
} => {
    ?C gc:parent ?P
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:Jos :testRelationship :Bart .
:Geert :testRelationship :Bart .
:Geert :testRelationship :Tom .
:Dirk :testRelationship :Tom .
:Dirk :testRelationship :Bart .
:Jos :testRelationship :Tom .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :Jos :testRelationship :Bart . }
  pe:rule
    {
        {
            ?A gc:mother ?M .
            ?M gc:daughter ?D .
            ?D gc:son ?S .
            ?S gc:uncle ?A .
        } => {
            ?A :testRelationship ?S .
        } .
    };
  pe:binding
    [ pe:var "A"; pe:value :Jos ],
    [ pe:var "D"; pe:value :Rita ],
    [ pe:var "M"; pe:value :Maria ],
    [ pe:var "S"; pe:value :Bart ];
  pe:uses
    { :Jos gc:mother :Maria . },
    { :Maria gc:daughter :Rita . },
    { :Rita gc:son :Bart . },
    { :Bart gc:uncle :Jos . }.
```

`pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 62 steps, 62 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 56; pe:failed 0 ];
    pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 6; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 144; pe:failed 0 ].
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
eyeron examples/gedcom.n3
eyeron -p examples/gedcom.n3
eyeron -c examples/gedcom.n3
```

---

## References

[Source reference 1](http://www.daml.org/2001/01/gedcom/gedcom-relations.xml)

[Source reference 2](http://www.w3.org/2000/10/swap/Examples.html)

---

## Takeaway

Shared record links let rules connect family members across a genealogy
dataset.
