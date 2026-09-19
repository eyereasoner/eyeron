# Eyelang example: spec-2-1-descended-from.
father(a, x). mother(b, x). mother(c, a).
child(?x, ?y) if father(?y, ?x).
child(?x, ?y) if mother(?y, ?x).
descended(?x, ?y) if child(?x, ?y).
descended(?x, ?y) if child(?x, ?z), descended(?z, ?y).
ask descended(?person, ?ancestor).
