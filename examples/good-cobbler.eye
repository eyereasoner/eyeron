# Keep the compound property: being a good cobbler does not imply being good.
# quoted([...]) represents the selected statement as data. It does not implement
# N3 formula entailment, quantifier scopes, or rule activation.

is(joe, [good, Cobbler]).
report(quoted([triple(?person, is, [good, ?occupation])])) if
    is(?person, [good, ?occupation]).

ask report(?statement).
ask is(joe, good).
