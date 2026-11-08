# Delegating one parcel pickup

[parcellocker.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/parcellocker.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/parcellocker.n3) · [proof](https://github.com/eyereasoner/eyeron/blob/main/examples/proof/parcellocker.n3) · [check](https://github.com/eyereasoner/eyeron/blob/main/examples/check/parcellocker.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=parcellocker)

---

## The question

A parcel owner authorizes a friend to collect one parcel at one locker. N3
rules match the person, parcel, locker, action, purpose and token state to
derive a limited pickup decision. SingleUse is a recorded condition; the rules
do not consume the token.

**Does the delegated pickup match the person, parcel, locker and token conditions?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Maya owns the parcel; Noah has an active, single-use pickup token.
# The request names the same parcel, locker, action and purpose.
:maya a :Person ;
    :name "Maya" .

# Shared variables require every requested field to match the token.
# Also require ready-for-pickup status and the token's restricted capabilities.
{
    :pickupToken :delegate ?who .
    :pickupRequest :requester ?who .
    :pickupToken :parcel ?parcel .
    :pickupRequest :parcel ?parcel .
    :pickupToken :locker ?locker .
    :pickupRequest :locker ?locker .
    :pickupToken :action ?action .
    :pickupRequest :action ?action .
    :pickupToken :purpose ?purpose .
    :pickupRequest :purpose ?purpose .
    :pickupToken :state :Active .
    :pickupToken :reuse :SingleUse .
    :parcel123 :status :ReadyForPickup .
    :pickupToken :billingAccess :None .
    :pickupToken :redirectAllowed :No .
} => {
    :case :decision :Permit .
} .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

These are the saved conclusions.

```n3
:case :decision :Permit .
```

---

## The proof, step by step

`eyeron -p` records why the conclusions follow. This excerpt is one recorded
step from the saved proof:

```n3
{ :case :decision :Permit . }
  pe:rule 1;
  pe:binding
    [ pe:var "action"; pe:value :CollectParcel ],
    [ pe:var "locker"; pe:value :lockerB17 ],
    [ pe:var "parcel"; pe:value :parcel123 ],
    [ pe:var "purpose"; pe:value :PickupOnly ],
    [ pe:var "who"; pe:value :noah ];
  pe:uses
    { :pickupToken :delegate :noah . },
    { :pickupRequest :requester :noah . },
    { :pickupToken :parcel :parcel123 . },
    { :pickupRequest :parcel :parcel123 . },
    { :pickupToken :locker :lockerB17 . },
    { :pickupRequest :locker :lockerB17 . },
    { :pickupToken :action :CollectParcel . },
    { :pickupRequest :action :CollectParcel . },
    { :pickupToken :purpose :PickupOnly . },
    { :pickupRequest :purpose :PickupOnly . },
    { :pickupToken :state :Active . },
    { :pickupToken :reuse :SingleUse . },
    { :parcel123 :status :ReadyForPickup . },
    { :pickupToken :billingAccess :None . },
    { :pickupToken :redirectAllowed :No . }.
```

`pe:rule 1` identifies the source rule used by this step. `pe:binding` records the values substituted for variables; `pe:uses` lists the premises the step depends on. Those premises have their own supporting steps in the full proof.

---

## Checked: what the report says

The saved check report gives this verdict and these selected conditions:

```n3
# checked: 16 steps, 16 verified, 0 trusted
    pe:verdict pe:checked;
    pe:condition [ pe:id "C1"; pe:name "resolution"; pe:checked 16; pe:failed 0 ];
    pe:condition [ pe:id "C10"; pe:name "call fidelity"; pe:checked 17; pe:failed 0 ].
```

Resolution checks that the recorded facts and rule applications match the
source program.

Call fidelity checks the answer against the question as it was called.

The verdict is **checked** for the recorded claims. It does not establish that
every possible answer was found.

---

## Try it

```sh
eyeron examples/parcellocker.n3
eyeron -p examples/parcellocker.n3
eyeron -c examples/parcellocker.n3
```

---

## Takeaway

A delegation can authorize one bounded action without granting general access.
