# Eyelang example: check-unsafe.
knows(alice, bob).
# Like the source warning, ?someone is deliberately not bound by the body.
seen(?someone) if knows(alice, bob).
ask seen(?someone).
