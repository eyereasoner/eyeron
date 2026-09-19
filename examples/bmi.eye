# BMI calculation with unit normalization, WHO adult categories, and the
# healthy-weight band for the supplied height. This is an example, not medical advice.
input(metric, 72.0, 178.0).
# A US input can instead use input(us, WeightPounds, HeightInches).

normalized(?weight, ?meters) if
    input(metric, ?weight, ?centimeters), let ?meters = ?centimeters / 100.0.
normalized(?kilograms, ?meters) if
    input(us, ?pounds, ?inches),
    let ?kilograms = ?pounds * 0.45359237,
    let ?meters = ?inches * 0.0254.

bmi_case(?bmi, ?height_squared, ?healthy_min, ?healthy_max) if
    normalized(?weight, ?meters),
    let ?height_squared = ?meters * ?meters,
    let ?bmi = ?weight / ?height_squared,
    let ?healthy_min = 18.5 * ?height_squared,
    let ?healthy_max = 24.9 * ?height_squared.

category(?bmi, underweight) if ?bmi < 18.5.
category(?bmi, normal) if ?bmi >= 18.5, ?bmi < 25.0.
category(?bmi, overweight) if ?bmi >= 25.0, ?bmi < 30.0.
category(?bmi, obesity_i) if ?bmi >= 30.0, ?bmi < 35.0.
category(?bmi, obesity_ii) if ?bmi >= 35.0, ?bmi < 40.0.
category(?bmi, obesity_iii) if ?bmi >= 40.0.

report(?bmi_rounded, ?category, ?healthy_min_rounded, ?healthy_max_rounded) if
    bmi_case(?bmi, ?height_squared, ?healthy_min, ?healthy_max),
    category(?bmi, ?category),
    let ?bmi_scaled = ?bmi * 100.0,
    let ?bmi_integer = round(?bmi_scaled),
    let ?bmi_rounded = ?bmi_integer / 100.0,
    let ?min_scaled = ?healthy_min * 10.0,
    let ?min_integer = round(?min_scaled),
    let ?healthy_min_rounded = ?min_integer / 10.0,
    let ?max_scaled = ?healthy_max * 10.0,
    let ?max_integer = round(?max_scaled),
    let ?healthy_max_rounded = ?max_integer / 10.0.

ask report(?bmi, ?category, ?healthy_min, ?healthy_max).
