# Eyelang example: family-cousins.
parent(adam, bob). parent(adam, carol). parent(bob, dave). parent(bob, eve). parent(carol, frank). parent(carol, grace).
parent(dave, heidi). parent(eve, ivan). parent(frank, judy).
branch(dave, b). branch(eve, b). branch(frank, c). branch(grace, c).
different(b, c). different(c, b).
generation(adam, 0).
generation(?child, ?next) if parent(?parent, ?child), generation(?parent, ?current), let ?next = ?current + 1.
branch(?child, ?branch) if parent(?parent, ?child), branch(?parent, ?branch).
cousin(?x, ?y) if generation(?x, ?g), generation(?y, ?g), branch(?x, ?bx), branch(?y, ?by), different(?bx, ?by).
ask cousin(?person, ?cousin).
