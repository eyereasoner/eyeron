# Eyelang example: time.
# Companion to time.n3/.srl: extracts the year, month, day, minute,
# second, and time zone from a fixed datetime. Eyelang has no datetime
# parser, so (matching spec-builtins.eye's own datetime(...) convention)
# the datetime's components are given already decomposed, matching what
# N3's time: builtins compute from the ISO 8601 literal
# "2023-04-01T18:06:04Z".
dt(letv, datetime(2023, 4, 1, 18, 6, 4, "Z")).
out(?y, ?m, ?d, ?min, ?sec, ?tz) if dt(letv, datetime(?y, ?m, ?d, ?h, ?min, ?sec, ?tz)).
ask out(?y, ?m, ?d, ?min, ?sec, ?tz).
