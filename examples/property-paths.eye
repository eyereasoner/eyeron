# Direct expansion of the source's sequence and inverse paths into relations.
# This example covers sequence and inverse paths, not a full path grammar.

parent_of(alice, bob).
parent_of(bob, carol).
grandparent_of(?x, ?z) if parent_of(?x, ?y), parent_of(?y, ?z).
has_parent(?child, ?parent) if parent_of(?parent, ?child).

ask grandparent_of(?person, ?grandchild).
ask has_parent(?child, ?parent).
