# If, Then

*The smallest rule there is: one fact, one rule, one conclusion.*

[if-then.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/if-then.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/if-then.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/if-then.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/if-then.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=if-then)

---

## The question

Socrates is a man, and every man is mortal. This is about as small as a
reasoning task gets, which makes it a good place to see what a rule is and
what Eyeron writes down when it uses one.

**Is Socrates mortal?**

---

## What we tell Eyeron

```n3
:socrates a :Man .

{
    ?x a :Man
} => {
    ?x a :Mortal
} .
```

The first line is a fact: *socrates is a Man* (`a` is short for "has type").
The second statement is a rule written as `{ if } => { then }`. The `?x` is a
variable: the rule holds for anything that can stand in its place. So it reads
*whatever is a man is mortal*.

---

## What Eyeron concludes

```n3
:socrates a :Mortal .
```

The rule matched the one fact, with `?x` standing for `:socrates`, and
produced a new statement. Eyeron prints only what it derived, not the fact it
was given.

---

## The proof, step by step

```n3
{ :socrates a :Mortal . }
  pe:rule 1;
  pe:binding [ pe:var "x"; pe:value :socrates ];
  pe:uses { :socrates a :Man . }.

{ :socrates a :Man . }
  pe:fact "if-then.n3".
```

Two steps: the conclusion comes from rule 1 with `x` set to `:socrates`,
and it uses one statement, which is a fact given in `if-then.n3`.

---

## Checked: what the report says

```n3
# checked: 2 steps, 2 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C2"; pe:name "well-foundedness"; pe:checked 2; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 1; pe:failed 0 ].
```

The checker re-did both steps against the program (C1): putting `:socrates`
into rule 1 really gives the conclusion, and the fact really is in the file.
No step leans on itself (C2), and the answer is the one the program asked for
(C10). Nothing needed to be taken on trust: there is no arithmetic, no
negation and no invented individual here.

---

## Try it

```sh
eyeron examples/if-then.n3
eyeron -p examples/if-then.n3
eyeron -c examples/if-then.n3
```

Add `:plato a :Man .` and run again: Plato is concluded mortal as well, by
the same rule.

---

## Takeaway

A rule is a pattern with variables; when facts fill the pattern, the
conclusion follows, and the proof records exactly which values filled it.
