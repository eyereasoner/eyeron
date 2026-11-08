# Annotated Statements

*Giving a statement a name, so we can say who made it and when.*

[annotation.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/annotation.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/annotation.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/annotation.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/annotation.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=annotation)

---

## The question

The statement *a's name is "Alice"* was made by Bob and recorded on 7 July
2021. To say that, the statement needs a name of its own. The same
information also arrives as RDF in a separate TriG file, a format for sets of
named graphs.

**Given both sources, what do we know about the named statement?**

---

## What we tell Eyeron

```n3
:a :name "Alice" .
:t log:nameOf {
    :a :name "Alice" .
} .

:t :statedBy :bob .
:t :recorded "2021-07-07"^^xsd:date .
```

The statement, and then `:t log:nameOf { … }`: *t is the name of this
statement*. The braces hold a **quoted graph**, a statement used as a value.
With a name, the statement can be annotated: t was stated by Bob and recorded
on a date.

The companion file `input/annotation.trig` says much the same in TriG:

```n3
:a :name "Alice" .
:t :statedBy :bob .
:t :recorded "2021-07-07" .

:t {
  :a :name "Alice" .
}
```

`:t { … }` is a **named graph**: Eyeron reads it as `:t log:nameOf { … }`.
Note that the date here is a plain string, without the `xsd:date` type.

```n3
{
    :t log:nameOf ?Statement ;
        :statedBy ?Author ;
        :recorded ?Date .
} log:query {
    :t log:nameOf ?Statement ;
        :statedBy ?Author ;
        :recorded ?Date .
} .
```

A `log:query` selects what to print: the statement t names, its author and
its recording date.

---

## What Eyeron concludes

```n3
:t log:nameOf {
    :a :name "Alice" .
} .

:t :statedBy :bob .
:t :recorded "2021-07-07"^^xsd:date .
:t :recorded "2021-07-07" .
```

The named graph from the TriG file and the `log:nameOf` statement in the N3
file are the same statement, so it appears once. The two dates are different
values, a typed date and a plain string, so the query answers with both.

---

## The proof, step by step

```n3
{ :t :statedBy :bob . }
  pe:fact "annotation.n3".

{ :t :recorded "2021-07-07"^^xsd:date . }
  pe:fact "annotation.n3".

{ :t :recorded "2021-07-07" . }
  pe:fact "<unknown>".
```

Four steps, all facts: the answers are selected directly from what was given,
with no rule in between. The plain-string date is cited as coming from
`"<unknown>"`: it is in the TriG companion, and the proof does not name that
file.

---

## Checked: what the report says

```n3
# checked: 4 steps, 4 verified, 0 trusted
pe:source "examples/annotation.n3";
pe:source "examples/input/annotation.trig";
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 4; pe:failed 0 ].
```

The check reads both files as the source program.

- **C1 resolution**: each of the four facts is found in the sources.
- **C10 call fidelity**: each printed line is backed by an application of
  the query, not merely shaped like its conclusion.
- C2–C4 and C7 confirm the proof is complete and has nothing unneeded.

Verdict: **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/annotation.n3 examples/input/annotation.trig      # the answer
eyeron -p examples/annotation.n3 examples/input/annotation.trig   # the answer with its proof
eyeron -c examples/annotation.n3 examples/input/annotation.trig   # the proof, checked
```

Run it without the TriG file, `eyeron examples/annotation.n3`: the
plain-string date disappears and only the typed one is left.

---

## Takeaway

Naming a statement turns it into something you can describe, and the same
named statement can arrive as N3 or as TriG; differences in how values are
written, such as a typed versus a plain date, show up in the answers.
