# Eyelang example: query.
parent(alice, bob). parent(bob, carol). parent(dora, emma).
ancestor(?x, ?y) if parent(?x, ?y).
ancestor(?x, ?z) if parent(?x, ?y), ancestor(?y, ?z).
ask ancestor(?x, ?y).
