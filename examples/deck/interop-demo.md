# Connecting Customer Vocabularies

*Three applications, three ways to describe one customer, one shared view.*

[interop-demo.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/interop-demo.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/interop-demo.md) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/interop-demo.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/interop-demo.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=interop-demo)

---

## The question

A company runs three applications. The shop calls Alice a *Buyer* and records
what she spent. Billing calls her a *Client*, with a total and an open
invoice. The marketing tool calls her a *Contact* and knows she agreed to
receive email. None of them sees the whole picture.

**Should Alice get the gold discount and an invoice reminder?** That needs
facts from all three systems at once.

---

## What we tell Eyeron

Each application keeps its own vocabulary, marked by its prefix `a:`,
`b:` or `c:`:

```n3
:aliceA a a:Buyer ;
    a:email "alice@example.com" ;
    a:spentEur "1200"^^xsd:decimal .
…
:aliceB a b:Client ;
    b:email "alice@example.com" ;
    b:totalSpent "1200.00"^^xsd:decimal .
…
:aliceC a c:Contact ;
    c:primaryEmail "alice@example.com" ;
    c:marketingOptIn "true"^^xsd:boolean ;
```

Mapping rules translate each into a shared vocabulary `ex:`. For billing:

```n3
{
    ?p a b:Client .
    ?p b:email ?e .
} => {
    ?p a ex:Customer .
    ?p ex:email ?e .
} .
```

Then an identity rule links records that share an email address, and further
rules copy the invoice, spend, opt-in and channel onto the shop's record,
which is chosen as the canonical one:

```n3
{
    ?x a ex:Customer .
    ?x ex:email ?e .
    ?y a ex:Customer .
    ?y ex:email ?e .
} => {
    ?x ex:sameCustomerAs ?y .
} .
```

Finally the business rule, which compares the spend with the built-in
`math:greaterThan` and prints a line with `log:outputString`:

```n3
{
    ?c a ex:Customer ;
        ex:lifetimeSpendEur ?s ;
        ex:hasOpenInvoice ?inv ;
        ex:marketingOptIn "true"^^xsd:boolean .
    ?s math:greaterThan "1000"^^xsd:decimal .
} => {
    ?c ex:eligibleFor ex:GoldDiscount .
    ?c ex:recommendedAction ex:ApplyGoldDiscountAndSendInvoiceReminder .
```

---

## What Eyeron concludes

Because the program uses `log:outputString`, Eyeron prints the strings, in
the order of their keys, as a small Markdown report instead of triples:

```markdown
# interop-demo  
- [N3 rules](../interop-demo.n3)  
ACTION: apply GoldDiscount and send invoice reminder (opt-in confirmed).  
```

Only the shop's record `:aliceA` qualifies: on their own, billing's record
has no opt-in and marketing's has no invoice. Put together, Alice gets the
discount and the reminder.

---

## The proof, step by step

The proof lists every derived statement, then justifies each one. The
decisive step is the business rule (rule 15 of the program):

```n3
{ :aliceA ex:recommendedAction ex:ApplyGoldDiscountAndSendInvoiceReminder . }
  pe:rule 15;
  pe:binding
    [ pe:var "c"; pe:value :aliceA ],
    [ pe:var "inv"; pe:value :invoice42 ],
    [ pe:var "s"; pe:value 1200.00 ];
  pe:uses
…
    { :aliceA ex:hasOpenInvoice :invoice42 . },
    { :aliceA ex:marketingOptIn true . },
    { 1200.00 math:greaterThan "1000"^^xsd:decimal . }.
```

Each of those uses is justified further back: the invoice and opt-in were
copied over through `ex:sameCustomerAs`, which itself rests on matching
emails, which rest on the mapping rules and the original facts. The
comparison is marked as a built-in:

```n3
{ 1200.00 math:greaterThan "1000"^^xsd:decimal . }
  pe:builtin math:greaterThan.
```

---

## Checked: what the report says

```n3
# checked: 42 steps, 42 verified, 0 trusted
pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 41; pe:failed 0 ];
pe:condition [ pe:id "C5"; pe:name "re-decision"; pe:checked 1; pe:failed 0 ];
pe:condition [ pe:id "C7"; pe:name "relevance"; pe:checked 70; pe:failed 0 ];
pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 28; pe:failed 0 ].
```

The 41 fact and rule steps were re-performed against the program (C1). The
one comparison was recomputed by the checker rather than believed (C5): 1200
really is greater than 1000. No step depends on itself (C2), and every step
contributes to an answer (C7). Nothing was taken on trust.

---

## Try it

```sh
eyeron examples/interop-demo.n3
eyeron -c examples/interop-demo.n3
```

Change Alice's marketing opt-in to `"false"^^xsd:boolean`. The business rule
no longer fires, no action line is printed, and Eyeron falls back to printing
the derived shared-vocabulary triples instead of a report.

---

## Takeaway

Small mapping rules let separate systems speak one vocabulary, and the proof
shows exactly which system contributed which fact to a business decision.
