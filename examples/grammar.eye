# A relational grammar written with explicit input and remainder lists.
sentence(command(?verb, ?object), ?input, ?rest) if
    verb(?verb, ?input, ?middle), noun(?object, ?middle, ?rest).
verb(open, [open | ?rest], ?rest).
verb(close, [close | ?rest], ?rest).
noun(door, [door | ?rest], ?rest).
noun(window, [window | ?rest], ?rest).
ask sentence(?ast, [open, door], []).
ask sentence(command(close, window), ?words, []).
