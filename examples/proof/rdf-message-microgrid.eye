# Eyelang result format 2
query(1, [call(critical_watts(?v0))], [binding("critical", ?v0)]).
result(1, complete, 1).
answer(1, [binding("critical", 620)]).
why(1, [binding("critical", 620)], 4).
query(2, [call(available_total(?v0))], [binding("available", ?v0)]).
result(2, complete, 1).
answer(2, [binding("available", 800)]).
why(2, [binding("available", 800)], 8).
query(3, [call(deferrable_watts(?v0))], [binding("deferrable", ?v0)]).
result(3, complete, 1).
answer(3, [binding("deferrable", 600)]).
why(3, [binding("deferrable", 600)], 11).
query(4, [call(protected_budget(?v0))], [binding("protected", ?v0)]).
result(4, complete, 1).
answer(4, [binding("protected", 1400)]).
why(4, [binding("protected", 1400)], 18).
query(5, [call(resilience_action(?v0))], [binding("action", ?v0)]).
result(5, complete, 1).
answer(5, [binding("action", protect_clinic)]).
why(5, [binding("action", protect_clinic)], 29).
clause(1, requires_watts(oxygen_concentrator, 500), []).
clause(2, requires_watts(vaccine_fridge, 120), []).
clause(3, available_watts(battery_bank, 650), []).
clause(4, expected_watts(solar_forecast, 150), []).
clause(5, shed_watts(ev_chargers, 600), []).
clause(7, critical_watts(var("w")), [call(requires_watts(oxygen_concentrator, var("o"))), call(requires_watts(vaccine_fridge, var("f"))), calculate(var("w"), binary("+", value(var("o")), value(var("f"))))]).
clause(8, available_total(var("w")), [call(available_watts(battery_bank, var("b"))), call(expected_watts(solar_forecast, var("s"))), calculate(var("w"), binary("+", value(var("b")), value(var("s"))))]).
clause(9, deferrable_watts(var("w")), [call(shed_watts(ev_chargers, var("w")))]).
clause(10, protected_budget(var("w")), [call(available_total(var("a"))), call(deferrable_watts(var("d"))), calculate(var("w"), binary("+", value(var("a")), value(var("d"))))]).
clause(11, resilience_action(protect_clinic), [call(protected_budget(var("p"))), call(critical_watts(var("c"))), compare(">", var("p"), var("c"))]).
substitution(1, []).
proof(1, requires_watts(oxygen_concentrator, 500), rule(1), []).
substitution(2, []).
proof(2, requires_watts(vaccine_fridge, 120), rule(2), []).
substitution(3, [binding("w", 620), binding("o", 500), binding("f", 120)]).
proof(3, critical_watts(620), rule(7), [uses(1, requires_watts(oxygen_concentrator, 500)), uses(2, requires_watts(vaccine_fridge, 120)), calculated(620, binary("+", value(500), value(120)))]).
substitution(4, [binding("critical", 620)]).
proof(4, solution([620]), query, [uses(3, critical_watts(620))]).
substitution(5, []).
proof(5, available_watts(battery_bank, 650), rule(3), []).
substitution(6, []).
proof(6, expected_watts(solar_forecast, 150), rule(4), []).
substitution(7, [binding("w", 800), binding("b", 650), binding("s", 150)]).
proof(7, available_total(800), rule(8), [uses(5, available_watts(battery_bank, 650)), uses(6, expected_watts(solar_forecast, 150)), calculated(800, binary("+", value(650), value(150)))]).
substitution(8, [binding("available", 800)]).
proof(8, solution([800]), query, [uses(7, available_total(800))]).
substitution(9, []).
proof(9, shed_watts(ev_chargers, 600), rule(5), []).
substitution(10, [binding("w", 600)]).
proof(10, deferrable_watts(600), rule(9), [uses(9, shed_watts(ev_chargers, 600))]).
substitution(11, [binding("deferrable", 600)]).
proof(11, solution([600]), query, [uses(10, deferrable_watts(600))]).
substitution(12, []).
proof(12, available_watts(battery_bank, 650), rule(3), []).
substitution(13, []).
proof(13, expected_watts(solar_forecast, 150), rule(4), []).
substitution(14, [binding("w", 800), binding("b", 650), binding("s", 150)]).
proof(14, available_total(800), rule(8), [uses(12, available_watts(battery_bank, 650)), uses(13, expected_watts(solar_forecast, 150)), calculated(800, binary("+", value(650), value(150)))]).
substitution(15, []).
proof(15, shed_watts(ev_chargers, 600), rule(5), []).
substitution(16, [binding("w", 600)]).
proof(16, deferrable_watts(600), rule(9), [uses(15, shed_watts(ev_chargers, 600))]).
substitution(17, [binding("w", 1400), binding("a", 800), binding("d", 600)]).
proof(17, protected_budget(1400), rule(10), [uses(14, available_total(800)), uses(16, deferrable_watts(600)), calculated(1400, binary("+", value(800), value(600)))]).
substitution(18, [binding("protected", 1400)]).
proof(18, solution([1400]), query, [uses(17, protected_budget(1400))]).
substitution(19, []).
proof(19, available_watts(battery_bank, 650), rule(3), []).
substitution(20, []).
proof(20, expected_watts(solar_forecast, 150), rule(4), []).
substitution(21, [binding("w", 800), binding("b", 650), binding("s", 150)]).
proof(21, available_total(800), rule(8), [uses(19, available_watts(battery_bank, 650)), uses(20, expected_watts(solar_forecast, 150)), calculated(800, binary("+", value(650), value(150)))]).
substitution(22, []).
proof(22, shed_watts(ev_chargers, 600), rule(5), []).
substitution(23, [binding("w", 600)]).
proof(23, deferrable_watts(600), rule(9), [uses(22, shed_watts(ev_chargers, 600))]).
substitution(24, [binding("w", 1400), binding("a", 800), binding("d", 600)]).
proof(24, protected_budget(1400), rule(10), [uses(21, available_total(800)), uses(23, deferrable_watts(600)), calculated(1400, binary("+", value(800), value(600)))]).
substitution(25, []).
proof(25, requires_watts(oxygen_concentrator, 500), rule(1), []).
substitution(26, []).
proof(26, requires_watts(vaccine_fridge, 120), rule(2), []).
substitution(27, [binding("w", 620), binding("o", 500), binding("f", 120)]).
proof(27, critical_watts(620), rule(7), [uses(25, requires_watts(oxygen_concentrator, 500)), uses(26, requires_watts(vaccine_fridge, 120)), calculated(620, binary("+", value(500), value(120)))]).
substitution(28, [binding("p", 1400), binding("c", 620)]).
proof(28, resilience_action(protect_clinic), rule(11), [uses(24, protected_budget(1400)), uses(27, critical_watts(620)), compared(">", 1400, 620)]).
substitution(29, [binding("action", protect_clinic)]).
proof(29, solution([protect_clinic]), query, [uses(28, resilience_action(protect_clinic))]).
