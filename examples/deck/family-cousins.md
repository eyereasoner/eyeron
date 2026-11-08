# Family cousins

*Counting generations and following branches to find the cousins.*

[family-cousins.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/family-cousins.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/family-cousins.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/family-cousins.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/family-cousins.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=family-cousins)

---

## The question

Adam has two children, Bob and Carol. Their children are first cousins of
each other, and their grandchildren are second cousins. Brothers and sisters,
though, are not cousins.

**Given only who is whose parent, and which branch of the family each
grandchild belongs to, who are the cousins?**

---

## What we tell Eyeron

The family tree, using a comma to give one subject several objects:

```n3
:Adam :parentOf :Bob, :Carol .
:Bob :parentOf :Dave, :Eve .
:Carol :parentOf :Frank, :Grace .
:Dave :parentOf :Heidi .
:Eve :parentOf :Ivan .
:Frank :parentOf :Judy .
```

Adam's grandchildren are labelled with their branch, and the two branches are
declared different:

```n3
:Dave :branch :b .
:Eve :branch :b .
:Frank :branch :c .
:Grace :branch :c .
…
:b :differentFrom :c .
:c :differentFrom :b .
```

Adam is generation 0. The rule `{} => { … }` has no conditions, so it always
fires. Each child is one generation after its parent, computed with the
built-in `math:sum`:

```n3
{} => {
    :Adam :generation 0
} .
…
{
    ?P :parentOf ?C .
    ?P :generation ?G .
    (?G 1) math:sum ?G1 .
} => {
    ?C :generation ?G1 .
} .
```

A further rule passes the branch label down from parent to child. Finally:
two people are cousins when they are in the same generation and in different
branches.

```n3
{
    ?X :generation ?G .
    ?Y :generation ?G .
    ?X :branch ?BX .
    ?Y :branch ?BY .
    ?BX :differentFrom ?BY .
} => {
    ?X :cousin ?Y .
} .
```

---

## What Eyeron concludes

Everyone gets a generation number, the great-grandchildren inherit a branch,
and the cousins come out in both directions:

```n3
:Adam :generation 0 .
:Heidi :generation 3 .
:Judy :branch :c .
:Dave :cousin :Frank .
:Eve :cousin :Grace .
:Heidi :cousin :Judy .
:Ivan :cousin :Judy .
…
```

Dave and Eve are in the same branch, so they are siblings, not cousins.
Generation 3 gives second cousins: Heidi and Ivan (branch b) with Judy
(branch c). In all, 12 cousin statements.

---

## The proof, step by step

```n3
{ :Heidi :cousin :Judy . }
  pe:rule 4;
  pe:binding
    [ pe:var "BX"; pe:value :b ],
    [ pe:var "BY"; pe:value :c ],
    [ pe:var "G"; pe:value 3 ],
    [ pe:var "X"; pe:value :Heidi ],
    [ pe:var "Y"; pe:value :Judy ];
  pe:uses
    { :Heidi :generation 3 . },
    { :Judy :generation 3 . },
    { :Heidi :branch :b . },
    { :Judy :branch :c . },
    { :b :differentFrom :c . }.
```

Heidi's generation number in turn comes from Dave's, by rule 2, and so on up
to Adam, whose step simply cites the rule with no conditions:

```n3
{ :Adam :generation 0 . }
  pe:rule 1.
```

The whole proof has 43 steps: 15 facts, 25 rule applications and 3 sums.

---

## Checked: what the report says

```n3
# checked: 43 steps, 43 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
```

- **C1 resolution**: the 40 fact and rule steps match the file and the rules.
- **C5 re-decision**: the checker added 0 + 1, 1 + 1 and 2 + 1 again itself.
- **C2**, **C3**, **C4**, **C7** and **C10**: no circular steps, every step
  backed, everything accounted for and relevant, and every condition checked
  as written.

The verdict is **checked**.

---

## Try it

```sh
eyeron examples/family-cousins.n3
eyeron -c examples/family-cousins.n3
```

Add `:Grace :parentOf :Ken .` and run again: Ken is generation 3 in branch c,
and becomes a second cousin of Heidi and of Ivan.

---

## Takeaway

Two small pieces of bookkeeping, a generation number and a branch label, are
enough for one rule to tell cousins from siblings, and the proof shows the
path behind each pair.
