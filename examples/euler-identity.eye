# Eyelang example: euler-identity.
# Companion to euler-identity.n3/.srl: certifies exp(i*pi) + 1 = 0 using
# exact integer arithmetic (Eyelang's arbitrary-precision integers make
# this exact, matching the N3 source's own "certificate-friendly" design
# note), rather than a floating-point approximation.
phase_pi(?re, ?im) if let ?re = 0 - 1, let ?im = 0.
lhs(?sumRe, ?sumIm) if phase_pi(?re, ?im), let ?sumRe = ?re + 1, let ?sumIm = ?im + 0.
holds(true) if lhs(0, 0).
mod_sq(?m) if phase_pi(?re, ?im), let ?re2 = ?re*?re, let ?im2 = ?im*?im, let ?m = ?re2+?im2.
mod_sq_is_one(true) if mod_sq(1).

ask phase_pi(?re, ?im).
ask lhs(?re, ?im).
ask holds(?ok).
ask mod_sq(?m).
ask mod_sq_is_one(?ok).
