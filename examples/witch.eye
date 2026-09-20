# Eyelang example: witch.
# Companion to witch.n3/.srl: the classic "burn the witch" syllogism chain
# (floating implies made of wood, made of wood implies it burns, burning
# plus being a woman implies witch), including the same-weight inference
# that makes the girl float because she weighs the same as the duck.
burns(?x) if is_made_of_wood(?x).
is_made_of_wood(?x) if floats(?x).
floats(duck).
floats(?y) if floats(?x), same_weight(?x, ?y).
same_weight(duck, girl).
woman(girl).
witch(?x) if burns(?x), woman(?x).
ask witch(?x).
