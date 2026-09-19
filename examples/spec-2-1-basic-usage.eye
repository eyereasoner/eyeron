# Eyelang example: spec-2-1-basic-usage.
father(a, x). mother(b, x). mother(c, a).
child(?x, ?y) if father(?y, ?x). child(?x, ?y) if mother(?y, ?x).
ask child(?child, ?parent).
