# Converting between an IRI and its text

*The name of a thing, and the thing the name points to.*

[log-uri.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/log-uri.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/log-uri.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/log-uri.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/log-uri.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=log-uri)

---

## The question

In N3, `<https://www.w3.org>` is a resource: something on the web, named by an
IRI. `"https://www.w3.org"` is just a string of characters. Sometimes a
program needs to go from one to the other.

**Given the resource, what is its text, and given the text, which resource
does it name?**

---

## What we tell Eyeron

```n3
{
    <https://www.w3.org> log:uri ?s .
    ?r log:uri "https://www.w3.org" .
} => {
    :uriString :is ?s .
    :uriResource :is ?r .
} .
```

There are no facts at all: only one rule. `log:uri` is a built-in that
relates a resource to the string of its IRI. It works in both directions. In
the first line the resource is known and `?s` receives the string; in the
second the string is known and `?r` receives the resource.

---

## What Eyeron concludes

```n3
:uriString :is "https://www.w3.org" .
:uriResource :is <https://www.w3.org> .
```

The first is a string in quotes; the second is the resource itself, in angle
brackets.

---

## The proof, step by step

```n3
{ :uriString :is "https://www.w3.org" . }
  pe:rule 1;
  pe:binding
    [ pe:var "r"; pe:value <https://www.w3.org> ],
    [ pe:var "s"; pe:value "https://www.w3.org" ];
  pe:uses
    { <https://www.w3.org> log:uri "https://www.w3.org" . },
    { <https://www.w3.org> log:uri "https://www.w3.org" . }.

{ <https://www.w3.org> log:uri "https://www.w3.org" . }
  pe:builtin log:uri.
```

Once the variables are filled in, both lines of the rule become the very same
statement, so the proof records one built-in step and uses it twice. The
second conclusion has a step of its own with the same bindings.

---

## Checked: what the report says

```n3
# checked: 3 steps, 3 verified, 0 trusted
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
```

- **C5 re-decision**: the checker recomputes `log:uri` itself and confirms the
  string and the resource belong together.
- **C1 resolution**: both rule steps match rule 1 with the recorded bindings.
- **C2, C3, C4, C7, C10**: no cycles, every step justified and covered,
  nothing irrelevant, and both built-in calls checked as the rule made them.

All 3 steps were verified; nothing was trusted.

---

## Try it

```sh
eyeron examples/log-uri.n3
eyeron -c examples/log-uri.n3
```

Replace both addresses with another one, such as `https://example.org/`, and
the two conclusions follow it.

---

## Takeaway

`log:uri` turns an IRI into text and text back into an IRI, and a checker can
redo that conversion to confirm it.
