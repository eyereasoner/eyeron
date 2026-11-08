# Reading a contact and a member list

*An unnamed contact and an ordered list, both easy to follow with rules.*

[collections-and-blank-nodes.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/collections-and-blank-nodes.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/collections-and-blank-nodes.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/collections-and-blank-nodes.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/collections-and-blank-nodes.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=collections-and-blank-nodes)

---

## The question

Alice knows someone called Bob, but the data gives that contact no global
name, only a description. A team has an ordered list of members.

**Can rules find the contact's name, and the team's first member?**

---

## What we tell Eyeron

```n3
:alice :knows [ :name "Bob" ; :tag "friend" ] .
:team :members (:alice :bob :carol) .
```

`[ … ]` is a blank node with its description inside: *"Alice knows
something whose name is Bob and whose tag is friend."* `( … )` is a list,
which keeps its order.

```n3
{
    ?person :knows ?node .
    ?node :name ?name
} => {
    ?person :knowsNamed ?name
} .

{
    :team :members ?members .
    ?members list:firstRest (?first ?rest)
} => {
    :team :firstMember ?first
} .
```

The first rule walks two steps: from a person to a contact, and from the
contact to its name. The variable `?node` happily matches a blank node. The
second rule uses the built-in `list:firstRest`, which splits a list into its
first member and the list of the others.

---

## What Eyeron concludes

```n3
:alice :knowsNamed "Bob" .
:team :firstMember :alice .
```

---

## The proof, step by step

The blank node appears in the proof under a label, `_:b1`, that stands for
the same node in each step:

```n3
{ :alice :knowsNamed "Bob" . }
  pe:rule 1;
  pe:binding
    [ pe:var "name"; pe:value "Bob" ],
    [ pe:var "node"; pe:value _:b1 ],
    [ pe:var "person"; pe:value :alice ];
  pe:uses
    { :alice :knows _:b1 . },
    { _:b1 :name "Bob" . }.
```

The list split is recorded as a built-in step:

```n3
{ (:alice :bob :carol) list:firstRest (:alice (:bob :carol)) . }
  pe:builtin list:firstRest.
```

---

## Checked: what the report says

```n3
# checked: 6 steps, 6 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 5; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 2; pe:failed 0 ].
```

- **C1 resolution**: two rule steps and three facts check against the
  program, the blank node included.
- **C5 re-decision**: the checker splits the list again and gets `:alice`
  and `(:bob :carol)`.
- **C10 call fidelity**: the built-in steps are the calls the rules make.

All 6 steps are verified; the verdict is **checked**.

---

## Try it

```sh
eyeron examples/collections-and-blank-nodes.n3
eyeron -c examples/collections-and-blank-nodes.n3
```

Reorder the team as `(:carol :alice :bob)` and the first member becomes
`:carol`: a list keeps the order it was written in.

---

## Takeaway

Unnamed nodes and ordered lists are ordinary data for rules: variables match
blank nodes, and built-ins take lists apart.
