# Eyelang example: list-iterate.
# Companion to list-iterate.n3/.srl: N3's list:iterate produces every
# (0-based index, item) pair for a list, defined here as an ordinary
# recursive relation over Eyelang's own list syntax.
param(letv, [huey, dewey, louie]).

iterate([?x | ?xs], 0, ?x).
iterate([?x | ?xs], ?i, ?y) if iterate(?xs, ?prev, ?y), let ?i = ?prev + 1.

test_iterate(?x, ?i, ?y) if param(letv, ?x), iterate(?x, ?i, ?y).
test_is(true) if test_iterate(?x, 1, dewey).

ask test_iterate(?x, ?i, ?y).
ask test_is(?r).
