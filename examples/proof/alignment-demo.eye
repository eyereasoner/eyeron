# Eyelang result format 2
query(1, [call(rolls_up_to(?v0, car))], [binding("concept", ?v0)]).
result(1, complete, 5).
answer(1, [binding("concept", car)]).
why(1, [binding("concept", car)], 8).
answer(1, [binding("concept", tel_car)]).
why(1, [binding("concept", tel_car)], 46).
answer(1, [binding("concept", heavy_vehicle)]).
why(1, [binding("concept", heavy_vehicle)], 47).
answer(1, [binding("concept", plate_vehicle)]).
why(1, [binding("concept", plate_vehicle)], 48).
answer(1, [binding("concept", passenger_car)]).
why(1, [binding("concept", passenger_car)], 68).
clause(1, concept(car), []).
clause(6, broad_match(tel_car, car), []).
clause(7, broad_match(heavy_vehicle, car), []).
clause(8, broad_match(plate_vehicle, car), []).
clause(9, broader(passenger_car, plate_vehicle), []).
clause(10, broader(var("a"), var("b")), [call(broad_match(var("a"), var("b")))]).
clause(11, narrower(var("b"), var("a")), [call(broader(var("a"), var("b")))]).
clause(12, broader_transitive(var("a"), var("b")), [call(broader(var("a"), var("b")))]).
clause(13, narrower_transitive(var("a"), var("b")), [call(narrower(var("a"), var("b")))]).
clause(14, broader_transitive(var("a"), var("c")), [call(broader_transitive(var("a"), var("b"))), call(broader_transitive(var("b"), var("c")))]).
clause(15, narrower_transitive(var("a"), var("c")), [call(narrower_transitive(var("a"), var("b"))), call(narrower_transitive(var("b"), var("c")))]).
clause(16, narrower_transitive(var("b"), var("a")), [call(broader_transitive(var("a"), var("b")))]).
clause(18, narrower_or_equal(var("concept"), var("concept")), [call(concept(var("concept")))]).
clause(19, narrower_or_equal(var("concept"), var("broader")), [call(broader_transitive(var("concept"), var("broader")))]).
clause(20, rolls_up_to(var("x"), car), [call(narrower_or_equal(var("x"), car))]).
substitution(1, []).
proof(1, concept(car), rule(1), []).
substitution(2, [binding("concept", car)]).
proof(2, narrower_or_equal(car, car), rule(18), [uses(1, concept(car))]).
substitution(3, [binding("x", car)]).
proof(3, rolls_up_to(car, car), rule(20), [uses(2, narrower_or_equal(car, car))]).
substitution(4, []).
proof(4, broad_match(tel_car, car), rule(6), []).
substitution(5, []).
proof(5, broad_match(heavy_vehicle, car), rule(7), []).
substitution(6, []).
proof(6, broad_match(plate_vehicle, car), rule(8), []).
substitution(7, []).
proof(7, broader(passenger_car, plate_vehicle), rule(9), []).
substitution(8, [binding("concept", car)]).
proof(8, solution([car]), query, [uses(3, rolls_up_to(car, car))]).
substitution(9, [binding("a", tel_car), binding("b", car)]).
proof(9, broader(tel_car, car), rule(10), [uses(4, broad_match(tel_car, car))]).
substitution(10, [binding("a", heavy_vehicle), binding("b", car)]).
proof(10, broader(heavy_vehicle, car), rule(10), [uses(5, broad_match(heavy_vehicle, car))]).
substitution(11, [binding("a", plate_vehicle), binding("b", car)]).
proof(11, broader(plate_vehicle, car), rule(10), [uses(6, broad_match(plate_vehicle, car))]).
substitution(12, [binding("a", passenger_car), binding("b", plate_vehicle)]).
proof(12, broader_transitive(passenger_car, plate_vehicle), rule(12), [uses(7, broader(passenger_car, plate_vehicle))]).
substitution(13, []).
proof(13, broad_match(tel_car, car), rule(6), []).
substitution(14, []).
proof(14, broad_match(heavy_vehicle, car), rule(7), []).
substitution(15, []).
proof(15, broad_match(plate_vehicle, car), rule(8), []).
substitution(16, [binding("b", plate_vehicle), binding("a", passenger_car)]).
proof(16, narrower(plate_vehicle, passenger_car), rule(11), [uses(7, broader(passenger_car, plate_vehicle))]).
substitution(17, [binding("a", tel_car), binding("b", car)]).
proof(17, broader_transitive(tel_car, car), rule(12), [uses(9, broader(tel_car, car))]).
substitution(18, [binding("a", heavy_vehicle), binding("b", car)]).
proof(18, broader_transitive(heavy_vehicle, car), rule(12), [uses(10, broader(heavy_vehicle, car))]).
substitution(19, [binding("a", plate_vehicle), binding("b", car)]).
proof(19, broader_transitive(plate_vehicle, car), rule(12), [uses(11, broader(plate_vehicle, car))]).
substitution(20, [binding("b", car), binding("a", tel_car)]).
proof(20, narrower(car, tel_car), rule(11), [uses(9, broader(tel_car, car))]).
substitution(21, [binding("b", car), binding("a", heavy_vehicle)]).
proof(21, narrower(car, heavy_vehicle), rule(11), [uses(10, broader(heavy_vehicle, car))]).
substitution(22, [binding("b", car), binding("a", plate_vehicle)]).
proof(22, narrower(car, plate_vehicle), rule(11), [uses(11, broader(plate_vehicle, car))]).
substitution(23, [binding("a", plate_vehicle), binding("b", passenger_car)]).
proof(23, narrower_transitive(plate_vehicle, passenger_car), rule(13), [uses(16, narrower(plate_vehicle, passenger_car))]).
substitution(24, [binding("a", tel_car), binding("b", car)]).
proof(24, broader(tel_car, car), rule(10), [uses(13, broad_match(tel_car, car))]).
substitution(25, [binding("a", heavy_vehicle), binding("b", car)]).
proof(25, broader(heavy_vehicle, car), rule(10), [uses(14, broad_match(heavy_vehicle, car))]).
substitution(26, [binding("a", plate_vehicle), binding("b", car)]).
proof(26, broader(plate_vehicle, car), rule(10), [uses(15, broad_match(plate_vehicle, car))]).
substitution(27, [binding("concept", tel_car), binding("broader", car)]).
proof(27, narrower_or_equal(tel_car, car), rule(19), [uses(17, broader_transitive(tel_car, car))]).
substitution(28, [binding("concept", heavy_vehicle), binding("broader", car)]).
proof(28, narrower_or_equal(heavy_vehicle, car), rule(19), [uses(18, broader_transitive(heavy_vehicle, car))]).
substitution(29, [binding("concept", plate_vehicle), binding("broader", car)]).
proof(29, narrower_or_equal(plate_vehicle, car), rule(19), [uses(19, broader_transitive(plate_vehicle, car))]).
substitution(30, [binding("a", car), binding("b", tel_car)]).
proof(30, narrower_transitive(car, tel_car), rule(13), [uses(20, narrower(car, tel_car))]).
substitution(31, [binding("a", car), binding("b", heavy_vehicle)]).
proof(31, narrower_transitive(car, heavy_vehicle), rule(13), [uses(21, narrower(car, heavy_vehicle))]).
substitution(32, [binding("a", car), binding("b", plate_vehicle)]).
proof(32, narrower_transitive(car, plate_vehicle), rule(13), [uses(22, narrower(car, plate_vehicle))]).
substitution(33, [binding("a", tel_car), binding("b", car)]).
proof(33, broader_transitive(tel_car, car), rule(12), [uses(24, broader(tel_car, car))]).
substitution(34, [binding("a", heavy_vehicle), binding("b", car)]).
proof(34, broader_transitive(heavy_vehicle, car), rule(12), [uses(25, broader(heavy_vehicle, car))]).
substitution(35, [binding("a", plate_vehicle), binding("b", car)]).
proof(35, broader_transitive(plate_vehicle, car), rule(12), [uses(26, broader(plate_vehicle, car))]).
substitution(36, [binding("b", car), binding("a", tel_car)]).
proof(36, narrower_transitive(car, tel_car), rule(16), [uses(33, broader_transitive(tel_car, car))]).
substitution(37, [binding("b", car), binding("a", heavy_vehicle)]).
proof(37, narrower_transitive(car, heavy_vehicle), rule(16), [uses(34, broader_transitive(heavy_vehicle, car))]).
substitution(38, [binding("b", car), binding("a", plate_vehicle)]).
proof(38, narrower_transitive(car, plate_vehicle), rule(16), [uses(35, broader_transitive(plate_vehicle, car))]).
substitution(39, [binding("b", car), binding("a", tel_car)]).
proof(39, narrower(car, tel_car), rule(11), [uses(24, broader(tel_car, car))]).
substitution(40, [binding("b", car), binding("a", heavy_vehicle)]).
proof(40, narrower(car, heavy_vehicle), rule(11), [uses(25, broader(heavy_vehicle, car))]).
substitution(41, [binding("b", car), binding("a", plate_vehicle)]).
proof(41, narrower(car, plate_vehicle), rule(11), [uses(26, broader(plate_vehicle, car))]).
substitution(42, [binding("x", tel_car)]).
proof(42, rolls_up_to(tel_car, car), rule(20), [uses(27, narrower_or_equal(tel_car, car))]).
substitution(43, [binding("x", heavy_vehicle)]).
proof(43, rolls_up_to(heavy_vehicle, car), rule(20), [uses(28, narrower_or_equal(heavy_vehicle, car))]).
substitution(44, [binding("x", plate_vehicle)]).
proof(44, rolls_up_to(plate_vehicle, car), rule(20), [uses(29, narrower_or_equal(plate_vehicle, car))]).
substitution(45, []).
proof(45, broad_match(plate_vehicle, car), rule(8), []).
substitution(46, [binding("concept", tel_car)]).
proof(46, solution([tel_car]), query, [uses(42, rolls_up_to(tel_car, car))]).
substitution(47, [binding("concept", heavy_vehicle)]).
proof(47, solution([heavy_vehicle]), query, [uses(43, rolls_up_to(heavy_vehicle, car))]).
substitution(48, [binding("concept", plate_vehicle)]).
proof(48, solution([plate_vehicle]), query, [uses(44, rolls_up_to(plate_vehicle, car))]).
substitution(49, []).
proof(49, broad_match(plate_vehicle, car), rule(8), []).
substitution(50, [binding("a", plate_vehicle), binding("b", car)]).
proof(50, broader(plate_vehicle, car), rule(10), [uses(45, broad_match(plate_vehicle, car))]).
substitution(51, []).
proof(51, broader(passenger_car, plate_vehicle), rule(9), []).
substitution(52, [binding("a", plate_vehicle), binding("b", car)]).
proof(52, broader(plate_vehicle, car), rule(10), [uses(49, broad_match(plate_vehicle, car))]).
substitution(53, [binding("a", plate_vehicle), binding("b", car)]).
proof(53, broader_transitive(plate_vehicle, car), rule(12), [uses(50, broader(plate_vehicle, car))]).
substitution(54, [binding("b", car), binding("a", plate_vehicle)]).
proof(54, narrower(car, plate_vehicle), rule(11), [uses(50, broader(plate_vehicle, car))]).
substitution(55, [binding("b", plate_vehicle), binding("a", passenger_car)]).
proof(55, narrower(plate_vehicle, passenger_car), rule(11), [uses(51, broader(passenger_car, plate_vehicle))]).
substitution(56, [binding("a", passenger_car), binding("b", plate_vehicle)]).
proof(56, broader_transitive(passenger_car, plate_vehicle), rule(12), [uses(51, broader(passenger_car, plate_vehicle))]).
substitution(57, [binding("a", plate_vehicle), binding("b", car)]).
proof(57, broader_transitive(plate_vehicle, car), rule(12), [uses(52, broader(plate_vehicle, car))]).
substitution(58, [binding("b", car), binding("a", plate_vehicle)]).
proof(58, narrower(car, plate_vehicle), rule(11), [uses(52, broader(plate_vehicle, car))]).
substitution(59, [binding("a", passenger_car), binding("c", car), binding("b", plate_vehicle)]).
proof(59, broader_transitive(passenger_car, car), rule(14), [uses(12, broader_transitive(passenger_car, plate_vehicle)), uses(53, broader_transitive(plate_vehicle, car))]).
substitution(60, [binding("a", car), binding("b", plate_vehicle)]).
proof(60, narrower_transitive(car, plate_vehicle), rule(13), [uses(54, narrower(car, plate_vehicle))]).
substitution(61, [binding("a", plate_vehicle), binding("b", passenger_car)]).
proof(61, narrower_transitive(plate_vehicle, passenger_car), rule(13), [uses(55, narrower(plate_vehicle, passenger_car))]).
substitution(62, [binding("a", passenger_car), binding("c", car), binding("b", plate_vehicle)]).
proof(62, broader_transitive(passenger_car, car), rule(14), [uses(12, broader_transitive(passenger_car, plate_vehicle)), uses(57, broader_transitive(plate_vehicle, car))]).
substitution(63, [binding("a", car), binding("b", plate_vehicle)]).
proof(63, narrower_transitive(car, plate_vehicle), rule(13), [uses(58, narrower(car, plate_vehicle))]).
substitution(64, [binding("a", car), binding("c", passenger_car), binding("b", plate_vehicle)]).
proof(64, narrower_transitive(car, passenger_car), rule(15), [uses(38, narrower_transitive(car, plate_vehicle)), uses(61, narrower_transitive(plate_vehicle, passenger_car))]).
substitution(65, [binding("a", car), binding("c", passenger_car), binding("b", plate_vehicle)]).
proof(65, narrower_transitive(car, passenger_car), rule(15), [uses(32, narrower_transitive(car, plate_vehicle)), uses(61, narrower_transitive(plate_vehicle, passenger_car))]).
substitution(66, [binding("concept", passenger_car), binding("broader", car)]).
proof(66, narrower_or_equal(passenger_car, car), rule(19), [uses(62, broader_transitive(passenger_car, car))]).
substitution(67, [binding("x", passenger_car)]).
proof(67, rolls_up_to(passenger_car, car), rule(20), [uses(66, narrower_or_equal(passenger_car, car))]).
substitution(68, [binding("concept", passenger_car)]).
proof(68, solution([passenger_car]), query, [uses(67, rolls_up_to(passenger_car, car))]).
