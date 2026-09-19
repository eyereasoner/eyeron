# Family relations: facts and recursive definitions use the same rule model.
parent(alice, bob).
parent(bob, carol).
parent(carol, dana).
ancestor(?x, ?y) if parent(?x, ?y).
ancestor(?x, ?z) if parent(?x, ?y), ancestor(?y, ?z).
ask ancestor(alice, ?who).
