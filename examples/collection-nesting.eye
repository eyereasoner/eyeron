# Eyelang example: collection-nesting.
nested(root, [1, node(q), [2]]).
first(?first) if nested(root, [?first, ?second, ?third]).
second_property(?value) if nested(root, [?first, node(?value), ?third]).
third_first(?value) if nested(root, [?first, ?second, [?value]]).
ask first(?value). ask second_property(?value). ask third_first(?value).
