# Eyelang example: developmental-genetics-becoming.
# Companion to developmental-genetics-becoming.n3/.srl: a developmental
# genetics model of lineage, inheritance, signal-driven activation, and
# differentiation, as ordinary relations.
suggests(neurogenicSignal, proneuralProgram). introduces_marker(neurogenicSignal, neuroD1).
suggests(maturationSignal, neuronalMaturationProgram). introduces_marker(maturationSignal, tubb3).

compatible_with(proneuralProgram, sox2). compatible_with(proneuralProgram, pax6). enables(proneuralProgram, neuroD1).
compatible_with(neuronalMaturationProgram, pax6). compatible_with(neuronalMaturationProgram, neuroD1). enables(neuronalMaturationProgram, tubb3).

expresses(s1, sox2). expresses(s1, pax6). achieves(s1, stableCellState).
derives_from(s2, s1). receives(s2, neurogenicSignal).
derives_from(s3, s2). receives(s3, maturationSignal).

inherits_marker(?later, ?marker) if derives_from(?later, ?earlier), expresses(?earlier, ?marker).
considers(?cell, ?program) if receives(?cell, ?signal), suggests(?signal, ?program).
targets_marker(?cell, ?marker) if receives(?cell, ?signal), introduces_marker(?signal, ?marker).
preserves_marker(?cell, ?marker) if inherits_marker(?cell, ?marker), considers(?cell, ?program), compatible_with(?program, ?marker).
integrates(?cell, ?program) if inherits_marker(?cell, ?marker), considers(?cell, ?program), compatible_with(?program, ?marker).
expresses(?cell, ?marker) if targets_marker(?cell, ?marker), considers(?cell, ?program), enables(?program, ?marker).
integrates(?cell, ?program) if targets_marker(?cell, ?marker), considers(?cell, ?program), enables(?program, ?marker).
expresses(?cell, ?marker) if preserves_marker(?cell, ?marker).
realizes(?cell, ?program) if integrates(?cell, ?program).
achieves(?cell, stableCellState) if realizes(?cell, ?program).
available_for_further_differentiation(?cell, yes) if realizes(?cell, ?program).
status(?cell, stableCellState) if achieves(?cell, stableCellState).

ask inherits_marker(?l, ?m).
ask considers(?c, ?p).
ask targets_marker(?c, ?m).
ask preserves_marker(?c, ?m).
ask integrates(?c, ?p).
ask expresses(?c, ?m).
ask realizes(?c, ?p).
ask status(?c, ?s).
ask available_for_further_differentiation(?c, ?y).
