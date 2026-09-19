# Eyelang example: import-lib.
parent(iris, jules). parent(jules, kai).
ancestor(?x, ?y) if parent(?x, ?y).
ancestor(?x, ?z) if parent(?x, ?y), ancestor(?y, ?z).
ask ancestor(iris, ?descendant).
