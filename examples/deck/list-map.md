# Mapping a property over list members

*Gathering everyone's values for one property, in order.*

[list-map.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/list-map.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/list-map.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/list-map.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/list-map.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=list-map)

---

## The question

Suppose you have a list of people and want all their phone numbers, in the
order of the list. Some have one number, some several, some none.

**Does `list:map` gather all values of one property for a list of subjects,
in order, including the awkward cases?**

---

## What we tell Eyeron

Three subjects have values for `:p1`; `:s3` has two, and `:s4` has none:

```n3
:s1 :p1 :o1 .
:s2 :p1 :o2 .
:s3 :p1 :o3, :o4 .
```

The comma in the last line repeats subject and predicate: it states two
triples. Then four tests, each a rule whose only premise is a `list:map`
call. Its subject is a pair: a list of subjects and a property; its object is
the list of values:

```n3
{
    ((:s1 :s2) :p1) list:map (:o1 :o2)
} => {
    :test1 :is true
} .
…
    ((:s1 :s2 :s3) :p1) list:map (:o1 :o2 :o3 :o4)
…
    ((:s4) :p1) list:map ()
…
    ((:s1) :p2) list:map ()
```

The last two expect the empty list `()`: a subject with no value, and a
property nobody has.

---

## What Eyeron concludes

```n3
:test1 :is true .
:test2 :is true .
:test3 :is true .
:test4 :is true .
```

All four tests pass.

---

## The proof: one built-in call per test

```n3
{ :test2 :is true . }
  pe:rule 2;
  pe:uses { ((:s1 :s2 :s3) :p1) list:map (:o1 :o2 :o3 :o4) . }.

{ ((:s1 :s2 :s3) :p1) list:map (:o1 :o2 :o3 :o4) . }
  pe:builtin list:map.
```

Each test is one rule step that uses one `list:map` result. The proof does
not list the `:p1` facts that `list:map` looked at.

---

## Checked: what the report says

```n3
# checked with obligations: 8 steps, 4 verified, 4 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 4; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 4; pe:failed 0 ];
pe:kind "impure built-in";
```

The four rule steps are verified (**C1**, plus C2, C3, C4, C7 and C10). The
four `list:map` steps are a different matter. `list:map` does not compute
from its arguments alone: it reads the graph Eyeron had built when it ran.
That makes it an *impure* built-in. The checker re-examines the steps (**C5**)
but cannot recreate that graph from the proof, so each `list:map` result
becomes an obligation of kind `impure built-in`, taken on trust.

The verdict is **checked with obligations**: the reasoning around the four
results is verified, and the results themselves rest on the graph at run
time.

---

## Try it

```sh
eyeron examples/list-map.n3      # the answers
eyeron -p examples/list-map.n3   # with the proof
eyeron -c examples/list-map.n3   # the proof, checked
```

Add `:s4 :p1 :o5 .` to the data and run again: test 3 no longer passes,
because `:s4` now has a value, and Eyeron concludes only tests 1, 2 and 4.

---

## Takeaway

`list:map` gathers values in list order, with several or none per subject;
because it reads the graph, a checker can verify everything around it but
must take its results on trust.
