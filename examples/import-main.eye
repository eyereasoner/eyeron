# Eyelang example: import-main.
parent(alice, bob). parent(bob, carol).
ancestor(?x, ?y) if parent(?x, ?y).
ancestor(?x, ?z) if parent(?x, ?y), ancestor(?y, ?z).
ask ancestor(alice, ?who).
