# Recognizing equality shorthand

*`=` is shorthand: a rule written with the long form still matches it.*

[equals-same-as.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/equals-same-as.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/equals-same-as.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/equals-same-as.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/equals-same-as.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=equals-same-as)

---

## The question

Sometimes two names refer to the same thing: a person under two
identifiers, or a city under its local and its English name. The Web
Ontology Language (OWL) has a word for this, `owl:sameAs`, and N3 has a
one-character shorthand for it, `=`.

**Is `:X = :Y` really the same statement as `:X owl:sameAs :Y`?**

---

## What we tell Eyeron

```n3
:X = :Y .

{
    :X owl:sameAs :Y
} => {
    :test :is true
} .
```

The fact uses the shorthand. The rule's condition spells out the long form.
If the two are the same statement, the rule fires.

---

## What Eyeron concludes

```n3
:test :is true .
```

The rule fired, so Eyeron read `=` as `owl:sameAs`. Eyeron does not
otherwise reason with equality here: it does not, for example, copy
statements about `:X` over to `:Y`. It only recognizes the statement.

---

## The proof, step by step

```n3
{ :test :is true . }
  pe:rule 1;
  pe:uses { :X owl:sameAs :Y . }.

{ :X owl:sameAs :Y . }
  pe:fact "equals-same-as.n3".
```

Two steps: the test result by rule 1, using a fact of the program. The proof
writes that fact in its long form, `owl:sameAs`, which is how Eyeron
stored it.

---

## Checked: what the report says

```n3
# checked: 2 steps, 2 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
```

- **C1 resolution**: rule 1 with this premise gives the test result, and
  `:X owl:sameAs :Y` is a fact of the source, because the checker reads the
  source's `=` the same way.
- **C2–C4**, **C7** and **C10**: the two steps are well-founded, justified,
  cover the answer and serve it, and the condition was matched as recorded.

Nothing is taken on trust: the verdict is **checked**.

---

## Try it

```sh
eyeron examples/equals-same-as.n3      # the answer
eyeron -p examples/equals-same-as.n3   # the answer with its proof
eyeron -c examples/equals-same-as.n3   # the proof, checked
```

Change the fact to `:X = :Z .` and run again: the rule asks about `:Y`,
so nothing is concluded.

---

## Takeaway

`=` and `owl:sameAs` are one statement in two spellings, and rules,
proofs and the checker all treat them that way.
