solve(ancestor(ann, bob)).
solve(ancestor(ann, cid)).
steps(ancestor(ann, cid), 4).
clause(ancestor(_0, _1), parent(_0, _1)).
clause(ancestor(_0, _1), (parent(_0, _2), ancestor(_2, _1))).
