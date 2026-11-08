# Checking list operations

*Eleven list built-ins, each with a test it must pass.*

[list-builtins-tests.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/list-builtins-tests.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/list-builtins-tests.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/list-builtins-tests.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/list-builtins-tests.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=list-builtins-tests)

---

## The question

N3 comes with a toolbox of *built-ins*: predicates that Eyeron computes
instead of looking up, such as the length of a list. Before you rely on a
tool, you try it on a case where you know the answer.

**Do the eleven list built-ins give the results we expect?**

---

## What we tell Eyeron

Every test has the same shape: a rule whose premise is one built-in call with
its expected result, and whose conclusion is a pass marker.

```n3
{
    ((1 2) (3 4)) list:append (1 2 3 4) .
} => {
    :ok_list_append_1 a :Pass .
} .
```

*Joining (1 2) and (3 4) gives (1 2 3 4).* If the built-in disagrees, the
premise fails and the marker is simply missing. The other ten premises:

```n3
(1 2 3 4) list:first 1 .
"cat" list:in ("dog" "penguin" "cat") .
("dog" "penguin" "cat") list:iterate (?index "cat") .
(1 2 3 4) list:last 4 .
(1 2 3 4) list:length 4 .
("dog" "penguin" "cat") list:member "cat" .
(("dog" "penguin" "cat") 2) list:memberAt "cat" .
(("dog" "penguin" "cat" "penguin") "penguin") list:remove ("dog" "cat") .
(1 2 3 4) list:rest (2 3 4) .
(1 2 3 4) list:firstRest (1 (2 3 4)) .
```

A few are worth reading twice. `list:in` is `list:member` the other way
round. `list:iterate` and `list:memberAt` count positions from 0, so "cat"
is at 2. `list:remove` removes every occurrence, both penguins.

---

## What Eyeron concludes

```n3
:ok_list_append_1 a :Pass .
:ok_list_first_1 a :Pass .
:ok_list_in_1 a :Pass .
:ok_list_iterate_1 a :Pass .
:ok_list_last_1 a :Pass .
:ok_list_length_1 a :Pass .
:ok_list_member_1 a :Pass .
:ok_list_memberAt_1 a :Pass .
:ok_list_remove_1 a :Pass .
:ok_list_rest_1 a :Pass .
:ok_list_firstRest_1 a :Pass .
```

All eleven tests pass.

---

## The proof: a built-in under every marker

```n3
{ :ok_list_append_1 a :Pass . }
  pe:rule 1;
  pe:uses { ((1 2) (3 4)) list:append (1 2 3 4) . }.

{ ((1 2) (3 4)) list:append (1 2 3 4) . }
  pe:builtin list:append.
```

The proof has 22 steps: for each marker, a rule step and the built-in result
it used. The built-in step says only *which* built-in produced the
statement; it leaves the checking to the checker.

---

## Checked: what the report says

```n3
# checked: 22 steps, 22 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 11; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 11; pe:failed 0 ];
```

- **C5 re-decision** is the heart of this example: the checker recomputes
  each of the 11 built-in results itself, so a proof that claimed, say, a
  length of 5 would be rejected.
- **C1 resolution**: the 11 rule steps match the rules they cite.
- **C2, C3, C4, C7, C10**: the steps are well-founded, justified, covered,
  relevant, and every premise holds as it was called.

Nothing was trusted: the verdict is **checked**.

---

## Try it

```sh
eyeron examples/list-builtins-tests.n3      # the pass markers
eyeron -p examples/list-builtins-tests.n3   # with the proof
eyeron -c examples/list-builtins-tests.n3   # the proof, checked
```

Change the length test to `(1 2 3 4) list:length 5 .` and run again: only ten
markers are concluded, and `:ok_list_length_1` is the missing one.

---

## Takeaway

Small tests with known answers show what each built-in does, and the checker
recomputes every built-in result rather than taking the proof's word for it.
