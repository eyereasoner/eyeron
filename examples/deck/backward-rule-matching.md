# Backward Rule Calls

*One backward rule, asked the same question in four different shapes.*

[backward-rule-matching.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/backward-rule-matching.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/backward-rule-matching.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/backward-rule-matching.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/backward-rule-matching.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=backward-rule-matching)

---

## The question

A question can leave some things open. "Who is related to whom?", "Is a
related to c?", "What is a related to?" and "What is related to c?" are four
shapes of the same question. A reasoner that answers questions with backward
rules has to handle all of them.

**Does a backward rule answer its question in every shape?** This is a small
test, so each shape that works prints a passing mark.

---

## What we tell Eyeron

```n3
:a :b :c .

{
    ?s :B ?o
} <= {
    ?s :b ?o
} .
```

One fact, *a b c*, and a **backward rule** (`<=`: conclusion above,
condition below) that makes every `:b` statement also hold as a `:B`
statement. Backward rules are consulted only when a question is asked.

```n3
{
    ?s :B ?o
} => {
    :TEST :PASS 1.1
} .
…
{
    :a :B ?o
} => {
    :TEST :PASS 1.3
} .
```

Four forward rules each ask a `:B` question. Test 1.1 leaves both ends open,
1.2 asks `:a :B :c` with both given, 1.3 leaves the object open and 1.4 the
subject. Names starting with `?` are variables.

---

## What Eyeron concludes

```n3
:TEST :PASS 1.1 .
:TEST :PASS 1.2 .
:TEST :PASS 1.3 .
:TEST :PASS 1.4 .
```

All four shapes reach the backward rule and are answered with *a B c*.

---

## The proof, step by step

```n3
{ :TEST :PASS 1.1 . }
  pe:rule 2;
  pe:binding
    [ pe:var "o"; pe:value :c ],
    [ pe:var "s"; pe:value :a ];
  pe:uses { :a :B :c . }.

{ :a :B :c . }
  pe:rule 1;
  pe:binding
    [ pe:var "o"; pe:value :c ],
    [ pe:var "s"; pe:value :a ];
  pe:uses { :a :b :c . }.
…
{ :TEST :PASS 1.2 . }
  pe:rule 3;
  pe:uses { :a :B :c . }.
```

Six steps. The statement *a B c* is proved once, by rule 1 (the backward
rule) from the fact *a b c*, and all four tests use it. The bindings show
what each shape filled in: test 1.1 bound both `s` and `o`, test 1.2 bound
nothing because it had no variables, and tests 1.3 and 1.4 bound one each.

---

## Checked: what the report says

```n3
# checked: 6 steps, 6 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 6; pe:failed 0 ];
pe:condition [ pe:id "C4"; pe:name "coverage"; pe:checked 9; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 5; pe:failed 0 ].
```

- **C1 resolution**: each of the five rule steps re-performs its rule with
  the recorded bindings, and the fact is in the file.
- **C4 coverage**: every statement a step uses, and every claimed answer,
  is backed by a step; the one shared step for *a B c* covers all four uses.
- **C10 call fidelity**: the calls each rule step uses are the ones its rule
  makes.
- C2, C3 and C7 confirm the shape: no loops, well-formed steps, nothing
  unneeded.

Verdict: **checked**, with nothing taken on trust.

---

## Try it

```sh
eyeron examples/backward-rule-matching.n3      # the answer
eyeron -p examples/backward-rule-matching.n3   # the answer with its proof
eyeron -c examples/backward-rule-matching.n3   # the proof, checked
```

Change the fact to `:a :b :d .` and run again. Only tests 1.1 and 1.3 pass:
they leave the object open, while 1.2 and 1.4 insist on `:c`.

---

## Takeaway

A backward rule answers whatever shape of question it is asked, filling in
the open parts; the proof's bindings show exactly what was filled in.
