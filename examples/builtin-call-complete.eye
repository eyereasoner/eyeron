# Eyelang example: builtin-call-complete.
numbers([-3.7, 7, 2]).
summary(?absolute, ?root, ?count, ?sorted) if numbers(?values), let ?absolute = abs(-3.7), let ?root = sqrt(9), let ?count = count(?values), sort(?values, ?sorted).
ask summary(?absolute, ?root, ?count, ?sorted).
