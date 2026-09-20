# Eyelang example: age.
# Companion to age.n3/.srl: is a person's age above some duration?
# Eyelang has no current-time builtin (unlike N3's time:localTime), so
# this uses a fixed reference year in place of "now" -- anyone born in
# 1944 is over 80 in any reference year from 2024 onward, so the answer
# does not depend on which such year is chosen.
birth_year(patH, 1944).
reference_year(2025).

age_above(?person, ?years) if
    birth_year(?person, ?birthYear), reference_year(?now),
    let ?age = ?now - ?birthYear, ?age > ?years.

test_is(true) if age_above(patH, 80).

ask test_is(?result).
