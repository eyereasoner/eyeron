# Eyelang example: string-builtins-tests.
# Companion to string-builtins-tests.n3/.srl: N3's version exhaustively
# checks 20 different string: builtins (contains, case-insensitive
# comparison, ordering, format, regex matching/scraping, replace, ...).
# Eyelang has a much smaller string surface -- only `concat(...)` and
# `str()`, plus structural `=`/`!=` (there is no string ordering
# operator at all; see log-collect-all-in.eye's own note) -- so this
# covers only concatenation and equality/inequality, the parts that
# carry over, rather than attempting a one-to-one port of the rest.
test_concatenation(true) if let ?s = concat("hello", " ", "world!"), ?s = "hello world!".
test_equal(true) if "hello world!" = "hello world!".
test_not_equal(true) if "hello world!" != "hi".

ask test_concatenation(?r).
ask test_equal(?r).
ask test_not_equal(?r).
