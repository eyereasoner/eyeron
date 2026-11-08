# Unstratified Negation

*In unless out, out unless in: a cycle with no natural first step.*

[unstratified-negation.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/unstratified-negation.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/unstratified-negation.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/unstratified-negation.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/unstratified-negation.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=unstratified-negation)

---

## The question

Alice is a person. Two rules sort people:

- a person who is not known to be *out* is *in*;
- a person who is not known to be *in* is *out*.

Each rule waits on the *absence* of what the other one concludes. Logicians
call such a set of rules **unstratified**: there is no layering in which
every absence can be settled before it is used. Either answer, in or out, is
self-consistent; the rules alone do not pick one.

**What does Eyeron conclude, and how sure can a checker be?**

---

## What we tell Eyeron

```n3
:alice a :Person .

{
    ?x a :Person .
    ?SCOPE log:notIncludes {
        ?x a :Out
    } .
} => {
    ?x a :In
} .
```

`log:notIncludes` is a test for absence: the pattern in braces must not be
found. With a variable `?SCOPE` in front it is **scoped negation**: it asks
about the current graph, everything known so far. The second rule is the
same with `:In` and `:Out` swapped.

---

## What Eyeron concludes

```n3
:alice a :In .
```

Eyeron tried the first rule first. Alice was not known to be out, so she
became in. After that the second rule cannot fire: Alice is now known to be
in. No contradiction arises, so the run ends normally. Had the rules been
written the other way round, the answer could have been different: here the
order of the program decides.

---

## The proof, step by step

```n3
{ :alice a :In . }
  pe:rule 1;
…
  pe:uses
    { :alice a :Person . },
…
        } log:notIncludes {
            :alice a :Out .
        } .
…
  pe:builtin log:notIncludes.
```

The answer rests on a fact (Alice is a person) and on an absence: *the
graph does not include `:alice a :Out`*. The absence is a built-in step. In
the proof the scope is shown as a placeholder graph, not as the full current
graph.

---

## Checked: what the report says

```n3
# checked with obligations: 3 steps, 2 verified, 1 trusted
pe:verdict pe:checkedWithObligations;
pe:condition [ pe:id "C6"; pe:name "boundary consistency"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C9"; pe:name "search closure"; pe:checked 1; pe:failed 0 ];
pe:kind "absent";
```

The rule step and the fact step were verified (C1, C3). The absence is
another matter. To confirm that Alice is *not* out, the checker would need
to know every way `:Out` could be derived; but `:Out` depends on `:In` being
absent, which is what is being decided. The search certificate cannot close
that circle (C9), so the absence is not verified but kept as an
**obligation** of kind `absent`. C6 confirmed that nothing in the proof
itself contradicts it.

The verdict is **checked with obligations**: Alice is in, *provided* she is
not out. That is an honest summary of an unstratified program.

---

## Try it

```sh
eyeron examples/unstratified-negation.n3
eyeron -c examples/unstratified-negation.n3
```

Add `:bob a :Person .`: Bob is put in as well, by the same first rule.

---

## Takeaway

When two rules each wait on the other's absence, Eyeron still gives an
answer, and the checker says plainly which absence it had to take on trust.
