% BMI calculation with unit normalization, WHO adult categories, and the
% healthy-weight band for the supplied height. This is an example, not medical advice.
input(metric, 72.0, 178.0).

% A US input can instead use input(us, WeightPounds, HeightInches).

normalized(Weight, Meters) :-
    input(metric, Weight, Centimeters),
    Meters is Centimeters / 100.0.

normalized(Kilograms, Meters) :-
    input(us, Pounds, Inches),
    Kilograms is Pounds * 0.45359237,
    Meters is Inches * 0.0254.

bmi_case(Bmi, Height_squared, Healthy_min, Healthy_max) :-
    normalized(Weight, Meters),
    Height_squared is Meters * Meters,
    Bmi is Weight / Height_squared,
    Healthy_min is 18.5 * Height_squared,
    Healthy_max is 24.9 * Height_squared.

category(Bmi, underweight) :-
    Bmi < 18.5.
category(Bmi, normal) :-
    Bmi >= 18.5,
    Bmi < 25.0.
category(Bmi, overweight) :-
    Bmi >= 25.0,
    Bmi < 30.0.
category(Bmi, obesity_i) :-
    Bmi >= 30.0,
    Bmi < 35.0.
category(Bmi, obesity_ii) :-
    Bmi >= 35.0,
    Bmi < 40.0.
category(Bmi, obesity_iii) :-
    Bmi >= 40.0.

report(Bmi_rounded, Category, Healthy_min_rounded, Healthy_max_rounded) :-
    bmi_case(Bmi, Height_squared, Healthy_min, Healthy_max),
    category(Bmi, Category),
    Bmi_scaled is Bmi * 100.0,
    Bmi_integer is round(Bmi_scaled),
    Bmi_rounded is Bmi_integer / 100.0,
    Min_scaled is Healthy_min * 10.0,
    Min_integer is round(Min_scaled),
    Healthy_min_rounded is Min_integer / 10.0,
    Max_scaled is Healthy_max * 10.0,
    Max_integer is round(Max_scaled),
    Healthy_max_rounded is Max_integer / 10.0.

?- report(Bmi, Category, Healthy_min, Healthy_max).
