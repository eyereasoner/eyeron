# Eyelang example: version-and-in.
level(alice, gold). level(bob, bronze). level(carol, platinum).
priority(?x) if level(?x, gold). priority(?x) if level(?x, platinum).
ordinary(?x) if level(?x, ?level), not priority(?x).
ask priority(?person). ask ordinary(?person).
