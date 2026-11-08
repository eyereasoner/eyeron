# Auditing a quoted theory's rules

*Rules that read other rules, without running them.*

[meta-rule-audit.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/meta-rule-audit.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/meta-rule-audit.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/meta-rule-audit.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/meta-rule-audit.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=meta-rule-audit)

---

## The question

Someone hands you a small theory: a few rules and facts. Before trusting it,
you want an overview. Which rules work forwards (`=>`, "from these facts,
conclude that"), which only backwards (`<=`, "to show this, establish that"),
and which are written both ways? And which rules would actually fire on the
theory's own facts?

**Can Eyeron audit a theory by treating its rules as data?**

---

## What we tell Eyeron

The theory is a *quoted graph*: N3 in braces, attached to the document `<>`.
Nothing inside the braces is asserted or run; it is only described.

```n3
<> :theory {
…
    # Forward-only rule
    {
        ?P :parentOf ?Q .
    } => {
        ?Q :childOf ?P .
    } .

    # Backward-only rule
    {
        ?P :worksFor ?Org .
    } <= {
        ?Org :employs ?P .
    } .
…
} .
```

It also has a subclass rule written both ways, and four facts.

The audit rules look inside with `log:includes` (the quoted graph contains
this pattern) and `log:notIncludes` (it does not). A rule is itself a
statement: `=>` is short for `log:implies` and `<=` for `log:impliedBy`.

```n3
{
    ?W :theory ?F .
    ?F log:includes {
        ?B log:implies ?H
    } .
    ?F log:notIncludes {
        ?H log:impliedBy ?B
    } .
} => {
    ?B :ruleStatus :ForwardOnly .
    ?B :ruleHead ?H .
} .
```

*A forward rule with body B and head H, with no backward twin, is
forward-only.* Further rules find the bidirectional and backward-only rules,
and the bodies that the theory's own facts satisfy (`?F log:includes ?B`).

---

## What Eyeron concludes

```n3
{
    ?P :parentOf ?Q .
} :ruleStatus :ForwardOnly .
{
    ?Org :employs ?P .
} :ruleStatus :BackwardOnly .
{
    ?X a ?C .
    ?C rdfs:subClassOf ?D .
} :ruleStatus :Bidirectional .
```

Each rule body is the subject of a statement about it. For the active bodies
Eyeron reports the matched instance, with the variables filled in:

```n3
{
    :alice :parentOf :bob .
} :activeAs :ForwardBody .
{
    :acme :employs :carol .
} :activeAs :BackwardBody .
```

The theory's rules themselves never ran: `:bob :childOf :alice` is nowhere
in the output.

---

## The proof, step by step

The proof has 24 steps: 10 rule steps, 13 built-in tests and 1 fact (the
theory). Because every step quotes the whole theory, it is long. The key test
for the forward-only rule ends like this:

```n3
      :alice :parentOf :bob .
      :acme :employs :carol .
  } log:notIncludes {
      {
          ?Q :childOf ?P .
      } <= {
          ?P :parentOf ?Q .
      } .
  } .
}
  pe:builtin log:notIncludes.
```

*The theory does not contain the backward version of the parent rule.*

---

## Checked: what the report says

```n3
# checked: 24 steps, 24 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 13; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 0; pe:failed 0 ];
```

- **C5 re-decision**: all 11 `log:includes` and 2 `log:notIncludes` tests
  are decided again. They look inside a quoted graph, which is written out in
  full in the proof, so the checker can settle them completely.
- That is why nothing is trusted: a "not included" over a *quoted* graph needs
  no search certificate (C9 examined nothing), unlike one over the current
  graph of everything derived.
- **C1, C2, C3, C4, C7, C10**: the rule steps match their rules, nothing is
  circular, every step is justified, covered and relevant, and the tests were
  checked as the rules called them.

---

## Try it

```sh
eyeron examples/meta-rule-audit.n3
eyeron -c examples/meta-rule-audit.n3
```

Delete the fact `:acme :employs :carol .` from the theory. The audit of rule
kinds stays the same, but the backward-only body is no longer active: only
the subclass body remains as `:BackwardBody`.

---

## Takeaway

In N3, rules are statements too, so other rules can inspect them; and a test
over a quoted graph is fully checkable, because the graph is right there in
the proof.
