# Eyelang example: relational-cube-lookup.
# Compact, calculated equivalent of the source's repeated three-key lookup table.
cube(?a, ?b, ?c, ?value) if range(0, 224, ?a), range(0, 14, ?c), let ?offset = ?a * 17, let ?b = (?offset + ?c * 31) % 512, let ?value = ?a * 15 + ?c.
ask cube(137, ?b, 11, ?value).
