# Library records from RDF messages

*Pulling titles, subjects and types out of a library catalogue, one message at a time.*

[alma-rdf-messages.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/alma-rdf-messages.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=alma-rdf-messages)

---

## The question

Ghent University Library publishes its catalogue as open data: its
records, as one long log of RDF messages, more than 9 GB in all. Each
message carries one record in MARC, the decades-old format libraries use,
written as nested lists: field 245 holds the title, 650 the subjects, and so
on.

**Can a handful of N3 rules turn each record into plain statements — this
book has this title, this subject, this type — while reading the log one
message at a time?**

---

## What we tell Eyeron

A record arrives as a list of fields. Each field is itself a list: a tag, two
indicators, then subfield codes and values in pairs:

```text
(("FMT" " " " " "_" "BK") ("001" " " " " "_" "9936831849109161") ("245" "0" "0" "a" "Young's Market Company, LLC SWOT Analysis"))
```

Helper rules, written backwards with `<=`, take such lists apart. `marc:id`
turns the 001 field into a web address for the record:

```n3
{
    ?Record marc:id ?Result
} <= {
    ?Record list:member ?F001 .
    (?F001 0) list:memberAt "001" .
    (?F001 4) list:memberAt ?ID .
    ("http://lib.ugent.be/record/" ?ID) string:concatenation ?IRI_ID .
    ?Result log:uri ?IRI_ID .
} .
```

*Find a field whose position 0 is "001", take the value at position 4, glue
it after the library's address, and treat the text as an IRI.* `list:member`,
`list:memberAt`, `string:concatenation` and `log:uri` are built-ins that
Eyeron computes. `marc:map` works the same way to pick out the value of a
field with a given tag and subfield code.

The extraction rules are forward rules, one per kind of statement. This one
makes titles:

```n3
{
    ?Envelope eymsg:payloadGraph ?Payload .
    ?Payload log:nameOf ?PayloadContext .
    ?PayloadContext log:includes {
        ?X :record ?Record .
    } .
    ?Record marc:id ?ID .
    (?Record "245" "a") marc:map ?Val .
} => {
    ?ID :title ?Val .
} .
```

With `--stream-messages`, Eyeron reads one message at a time and describes
it with an envelope whose `eymsg:payloadGraph` is the message's content.
`log:includes` looks inside that content, in curly braces, for a record. The
rules for subjects (650) and types (920) differ only in the tag and the
predicate.

The program also defines helpers it does not use here (`marc:join`,
`marc:subf`, `marc:field`, `marc:ctrl`), built with `log:collectAllIn` and
recursion over lists, ready for further extraction rules.

---

## What Eyeron concludes

The full log is not part of the repository, so there is no saved output. On
the one-record sample in `tests/input/alma-rdf-messages-small.nt` Eyeron
prints, in N-Triples because of `-r`:

```text
<http://lib.ugent.be/record/9936831849109161> <http://example.org/ns#title> "Young's Market Company, LLC SWOT Analysis" .
```

That sample has no 650 or 920 field, so there is no subject or type. A record
with two subject fields gets two `:subject` statements, one for each.

---

## Why there is no proof

This example is about streaming, not about explaining one answer: it is meant
to run over a log far too large to keep, and its statements are made from
each message as it passes. The repository therefore keeps no output, proof
or check report for it. It shows how N3 rules can read inside a message as a
quoted graph and take apart nested lists, at the scale of a real catalogue.

---

## Try it

```sh
eyeron -r --stream-messages examples/alma-rdf-messages.n3 tests/input/alma-rdf-messages-small.nt
eyeron -r --stream-messages examples/alma-rdf-messages.n3 https://ugent-lib-opendata-prd.s3.ugent.be/alma-rdf/rdf-messages.20260404.nt
```

The first runs on the small sample; the second streams the whole catalogue,
more than 9 GB, so expect it to take a long time. Add a field such as
`("650" " " "0" "a" "Marketing")` to the sample's record and run again: a
`:subject` statement appears.

---

## Takeaway

N3 rules can work through a stream of messages one at a time, looking inside
each as a graph, and a few list-handling rules are enough to turn library
MARC records into plain statements.
