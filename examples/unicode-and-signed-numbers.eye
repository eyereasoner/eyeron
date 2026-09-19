# Eyelang example: unicode-and-signed-numbers.
text(sample, "ABC"). delta(thermo, -12).
unicode_decoded if text(sample, "ABC"). below_zero if delta(thermo, ?d), ?d < 0.
ask unicode_decoded. ask below_zero.
