# Constructing consequences from finite data

*A small organisation: ancestors, access rights, and people who do not exist yet.*

[kronecker.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/kronecker.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/kronecker.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/kronecker.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/kronecker.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=kronecker)

---

## The question

Alice, Bob and Carol are three generations of one family. Alice and Bob are
in Team A, which is part of organisation X; Carol is in X directly. X owns
two projects: Bob manages the first, the second still needs a manager.

**Who is an adult, who descends from whom, who may read which project, and
can the rules fill the gaps — a manager for project 2, a supervisor for each
manager — without running forever?**

---

## What we tell Eyeron

The data, for example:

```n3
ex:Alice a ex:Person ;
    ex:age "29"^^xsd:integer ;
    ex:memberOf ex:TeamA ;
    ex:parent ex:Bob .
…
ex:Proj2 a ex:Project ;
    ex:ownedBy ex:OrgX ;
    ex:needsManager true .
```

Then rules. Some are plain: anyone over 17 is an adult (`math:greaterThan` is
a built-in comparison); members of a team are members of its organisation;
members of an organisation can read its projects. Ancestry is recursive:

```n3
{
    ?x ex:parent ?y .
    ?y ex:ancestor ?z
} => {
    ?x ex:ancestor ?z
} .
```

---

## Rules that create someone

Square brackets in a conclusion stand for *something* not named, a blank
node. This rule says project 2 has a manager, a person with the role
"AutoManager", without saying who:

```n3
{
    ?proj a ex:Project ;
        ex:needsManager true .
} => {
    ?proj ex:hasManager [
        a ex:Person ;
        ex:role "AutoManager"
    ] .
} .
```

Another gives every manager a new supervisor, and a third records a *reason*
for each read access. A rule that invents a new individual every time it
fires could run forever. Eyeron instead names each invented individual by a
Skolem term, fixed by the rule and the values it fired with, so firing again
for the same project reuses the same manager. Supervisors are not made
managers, so the chain stops after one level.

The last statement, `log:query`, asks for every statement of the final
graph, so the output repeats the data as well.

---

## What Eyeron concludes

Among the many statements printed:

```n3
ex:Alice a ex:Adult .
ex:Alice ex:ancestor ex:Carol .
ex:Alice ex:canRead ex:Proj2 .
ex:Carol ex:canRead ex:Proj1 .
ex:Proj2 ex:hasManager _:sk_6 .
_:sk_6 ex:role "AutoManager" .
ex:Bob ex:hasSupervisor [
  a ex:Person ;
  ex:role "Supervisor" ;
  ex:supervises ex:Bob
] .
```

Alice's grandmother Carol is her ancestor through Bob. Carol can read project
1 though she is in no team: she is a member of X directly. Project 2 now has
an AutoManager, `_:sk_6`, who in turn has a supervisor of their own.

---

## The proof: invented people, with their origin

The proof names the invented manager by a label and says which rule firing
created it:

```n3
{ ex:Proj2 ex:hasManager _:b2_4f7da57dfb42d02e . }
  pe:rule 7;
  pe:binding [ pe:var "proj"; pe:value ex:Proj2 ];
  pe:uses
    { ex:Proj2 a ex:Project . },
    { ex:Proj2 ex:needsManager true . }.
```

Ordinary conclusions look like the Socrates proof: a rule, its bindings, and
the statements it used. In all, the proof has 72 steps: 20 facts, 49 rule
steps and 3 comparisons.

---

## Checked: what the report says

```n3
# checked with obligations: 72 steps, 37 verified, 35 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 3; pe:failed 0 ];
pe:condition [ pe:id "C8"; pe:name "witness integrity"; pe:checked 35; pe:failed 0 ];
pe:kind "unsatisfied";
```

- **C1–C4, C7, C10**: every fact and rule step matches the program and
  serves an answer.
- **C5 re-decision**: the three age comparisons are recomputed.
- **C8 witness integrity**: each of the 35 statements about an invented
  individual (the 6 reasons, the AutoManager and the 2 supervisors) uses the
  right label for the rule firing that introduced it.
- **C6** finds no evidence in the proof against what was assumed.

The 35 trusted steps are those same statements, each with an obligation of
kind `unsatisfied`. A rule like *project 2 has some manager* only adds a new
one if nothing already satisfied it. That *nothing* is about the whole
graph, which the proof does not list, so the checker records it as an
assumption. The verdict, **checked with obligations**, says exactly that.

---

## Try it

```sh
eyeron examples/kronecker.n3      # the whole graph
eyeron -p examples/kronecker.n3   # with the proof
eyeron -c examples/kronecker.n3   # the proof, checked
```

Remove `ex:needsManager true` from project 2 (and the `;` before it): the
AutoManager and its supervisor disappear, and the report drops to
\`64 steps, 36 verified, 28 trusted\`: the 7 statements about those two
were 7 of the trusted steps.

---

## Takeaway

Rules can create new individuals and still stop, because each one is named
by where it came from; the checker verifies those names, and is open about
assuming that no existing individual already filled the role.
