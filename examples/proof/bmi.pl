% Prolog result format 3
query(1, report(_0, _1, _2, _3), ['Bmi' = _0, 'Category' = _1, 'Healthy_min' = _2, 'Healthy_max' = _3]).
result(1, complete, 1).
answer(1, ['Bmi' = 22.72, 'Category' = normal, 'Healthy_min' = 58.6, 'Healthy_max' = 78.9]).
why(1, ['Bmi' = 22.72, 'Category' = normal, 'Healthy_min' = 58.6, 'Healthy_max' = 78.9], 6).
clause(1, input(metric, 72.0, 178.0), true).
clause(2, normalized(var('Weight'), var('Meters')), (input(metric, var('Weight'), var('Centimeters')), var('Meters') is var('Centimeters') / 100.0)).
clause(4, bmi_case(var('Bmi'), var('Height_squared'), var('Healthy_min'), var('Healthy_max')), (normalized(var('Weight'), var('Meters')), var('Height_squared') is var('Meters') * var('Meters'), var('Bmi') is var('Weight') / var('Height_squared'), var('Healthy_min') is 18.5 * var('Height_squared'), var('Healthy_max') is 24.9 * var('Height_squared'))).
clause(6, category(var('Bmi'), normal), (var('Bmi') >= 18.5, var('Bmi') < 25.0)).
clause(11, report(var('Bmi_rounded'), var('Category'), var('Healthy_min_rounded'), var('Healthy_max_rounded')), (bmi_case(var('Bmi'), var('Height_squared'), var('Healthy_min'), var('Healthy_max')), category(var('Bmi'), var('Category')), var('Bmi_scaled') is var('Bmi') * 100.0, var('Bmi_integer') is round(var('Bmi_scaled')), var('Bmi_rounded') is var('Bmi_integer') / 100.0, var('Min_scaled') is var('Healthy_min') * 10.0, var('Min_integer') is round(var('Min_scaled')), var('Healthy_min_rounded') is var('Min_integer') / 10.0, var('Max_scaled') is var('Healthy_max') * 10.0, var('Max_integer') is round(var('Max_scaled')), var('Healthy_max_rounded') is var('Max_integer') / 10.0)).
substitution(1, []).
proof(1, input(metric, 72.0, 178.0), rule(1), []).
substitution(2, ['Weight' = 72.0, 'Meters' = 1.78, 'Centimeters' = 178.0]).
proof(2, normalized(72.0, 1.78), rule(2), [uses(1, input(metric, 72.0, 178.0)), builtin(1.78 is 178.0 / 100.0)]).
substitution(3, ['Bmi' = 22.724403484408533, 'Height_squared' = 3.1684, 'Healthy_min' = 58.6154, 'Healthy_max' = 78.89316, 'Weight' = 72.0, 'Meters' = 1.78]).
proof(3, bmi_case(22.724403484408533, 3.1684, 58.6154, 78.89316), rule(4), [uses(2, normalized(72.0, 1.78)), builtin(3.1684 is 1.78 * 1.78), builtin(22.724403484408533 is 72.0 / 3.1684), builtin(58.6154 is 18.5 * 3.1684), builtin(78.89316 is 24.9 * 3.1684)]).
substitution(4, ['Bmi' = 22.724403484408533]).
proof(4, category(22.724403484408533, normal), rule(6), [builtin(22.724403484408533 >= 18.5), builtin(22.724403484408533 < 25.0)]).
substitution(5, ['Bmi_rounded' = 22.72, 'Category' = normal, 'Healthy_min_rounded' = 58.6, 'Healthy_max_rounded' = 78.9, 'Bmi' = 22.724403484408533, 'Height_squared' = 3.1684, 'Healthy_min' = 58.6154, 'Healthy_max' = 78.89316, 'Bmi_scaled' = 2272.4403484408535, 'Bmi_integer' = 2272, 'Min_scaled' = 586.154, 'Min_integer' = 586, 'Max_scaled' = 788.9315999999999, 'Max_integer' = 789]).
proof(5, report(22.72, normal, 58.6, 78.9), rule(11), [uses(3, bmi_case(22.724403484408533, 3.1684, 58.6154, 78.89316)), uses(4, category(22.724403484408533, normal)), builtin(2272.4403484408535 is 22.724403484408533 * 100.0), builtin(2272 is round(2272.4403484408535)), builtin(22.72 is 2272 / 100.0), builtin(586.154 is 58.6154 * 10.0), builtin(586 is round(586.154)), builtin(58.6 is 586 / 10.0), builtin(788.9315999999999 is 78.89316 * 10.0), builtin(789 is round(788.9315999999999)), builtin(78.9 is 789 / 10.0)]).
substitution(6, ['Bmi' = 22.72, 'Category' = normal, 'Healthy_min' = 58.6, 'Healthy_max' = 78.9]).
proof(6, solution([22.72, normal, 58.6, 78.9]), query, [uses(5, report(22.72, normal, 58.6, 78.9))]).
