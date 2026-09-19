# Eyelang example: backward-recursion.
parent(a, b). parent(b, c). parent(c, d).
ancestor(?x, ?y) if parent(?x, ?y).
ancestor(?x, ?z) if parent(?x, ?y), ancestor(?y, ?z).
ask ancestor(a, ?who).
