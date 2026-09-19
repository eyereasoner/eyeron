# Eyelang example: cat-koko.
animal(koko).
cat(generated_cat) if animal(koko).
british_short_hair(generated_bsh) if animal(koko).
test if cat(?x), british_short_hair(?y), ?x != ?y.
ask test.
