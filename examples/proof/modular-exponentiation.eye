# Eyelang result format 2
query(1, [call(small_check(?v0, ?v1))], [binding("naive", ?v0), binding("fast", ?v1)]).
result(1, complete, 1).
answer(1, [binding("naive", 38), binding("fast", 38)]).
why(1, [binding("naive", 38), binding("fast", 38)], 25).
query(2, [call(large_case(?v0, ?v1))], [binding("case", ?v0), binding("value", ?v1)]).
result(2, complete, 3).
answer(2, [binding("case", last_12_digits), binding("value", 940335579136)]).
why(2, [binding("case", last_12_digits), binding("value", 940335579136)], 178).
answer(2, [binding("case", seven_power_billion), binding("value", 312556845)]).
why(2, [binding("case", seven_power_billion), binding("value", 312556845)], 212).
answer(2, [binding("case", three_power_two_power_25), binding("value", 849572438)]).
why(2, [binding("case", three_power_two_power_25), binding("value", 849572438)], 220).
clause(1, mod_mul(var("a"), var("b"), var("m"), var("r")), [calculate(var("r"), binary("%", binary("*", value(var("a")), value(var("b"))), value(var("m"))))]).
clause(3, mod_pow(var("b"), 1, var("m"), var("r")), [compare(">", var("m"), 0), calculate(var("r"), binary("%", value(var("b")), value(var("m"))))]).
clause(4, mod_pow(var("b"), var("e"), var("m"), var("r")), [compare(">", var("m"), 0), compare(">", var("e"), 1), calculate(var("parity"), binary("%", value(var("e")), value(2))), compare("=", var("parity"), 0), call(mod_mul(var("b"), var("b"), var("m"), var("squared"))), calculate(var("half"), binary("//", value(var("e")), value(2))), call(mod_pow(var("squared"), var("half"), var("m"), var("r")))]).
clause(5, mod_pow(var("b"), var("e"), var("m"), var("r")), [compare(">", var("m"), 0), compare(">", var("e"), 1), calculate(var("parity"), binary("%", value(var("e")), value(2))), compare("=", var("parity"), 1), call(mod_mul(var("b"), var("b"), var("m"), var("squared"))), calculate(var("half"), binary("//", binary("-", value(var("e")), value(1)), value(2))), call(mod_pow(var("squared"), var("half"), var("m"), var("tail"))), call(mod_mul(var("b"), var("tail"), var("m"), var("r")))]).
clause(6, power(anonymous(1), 0, 1), []).
clause(7, power(var("base"), var("exponent"), var("value")), [compare(">", var("exponent"), 0), calculate(var("previous"), binary("-", value(var("exponent")), value(1))), call(power(var("base"), var("previous"), var("tail"))), calculate(var("value"), binary("*", value(var("base")), value(var("tail"))))]).
clause(8, small_check(var("naive"), var("fast")), [call(power(7, 13, var("power"))), calculate(var("naive"), binary("%", value(var("power")), value(97))), call(mod_pow(7, 13, 97, var("fast")))]).
clause(9, large_case(seven_power_billion, var("value")), [call(mod_pow(7, 1000000000, 1000000007, var("value")))]).
clause(10, large_case(three_power_two_power_25, var("value")), [call(power(2, 25, var("exponent"))), call(mod_pow(3, var("exponent"), 1000000007, var("value")))]).
clause(11, large_case(last_12_digits, var("value")), [call(power(2, 20, var("exponent"))), call(mod_pow(2, var("exponent"), 1000000000000, var("value")))]).
substitution(1, []).
proof(1, power(7, 0, 1), rule(6), []).
substitution(2, [binding("base", 7), binding("exponent", 1), binding("value", 7), binding("previous", 0), binding("tail", 1)]).
proof(2, power(7, 1, 7), rule(7), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(1, power(7, 0, 1)), calculated(7, binary("*", value(7), value(1)))]).
substitution(3, [binding("base", 7), binding("exponent", 2), binding("value", 49), binding("previous", 1), binding("tail", 7)]).
proof(3, power(7, 2, 49), rule(7), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(2, power(7, 1, 7)), calculated(49, binary("*", value(7), value(7)))]).
substitution(4, [binding("base", 7), binding("exponent", 3), binding("value", 343), binding("previous", 2), binding("tail", 49)]).
proof(4, power(7, 3, 343), rule(7), [compared(">", 3, 0), calculated(2, binary("-", value(3), value(1))), uses(3, power(7, 2, 49)), calculated(343, binary("*", value(7), value(49)))]).
substitution(5, [binding("base", 7), binding("exponent", 4), binding("value", 2401), binding("previous", 3), binding("tail", 343)]).
proof(5, power(7, 4, 2401), rule(7), [compared(">", 4, 0), calculated(3, binary("-", value(4), value(1))), uses(4, power(7, 3, 343)), calculated(2401, binary("*", value(7), value(343)))]).
substitution(6, [binding("base", 7), binding("exponent", 5), binding("value", 16807), binding("previous", 4), binding("tail", 2401)]).
proof(6, power(7, 5, 16807), rule(7), [compared(">", 5, 0), calculated(4, binary("-", value(5), value(1))), uses(5, power(7, 4, 2401)), calculated(16807, binary("*", value(7), value(2401)))]).
substitution(7, [binding("base", 7), binding("exponent", 6), binding("value", 117649), binding("previous", 5), binding("tail", 16807)]).
proof(7, power(7, 6, 117649), rule(7), [compared(">", 6, 0), calculated(5, binary("-", value(6), value(1))), uses(6, power(7, 5, 16807)), calculated(117649, binary("*", value(7), value(16807)))]).
substitution(8, [binding("base", 7), binding("exponent", 7), binding("value", 823543), binding("previous", 6), binding("tail", 117649)]).
proof(8, power(7, 7, 823543), rule(7), [compared(">", 7, 0), calculated(6, binary("-", value(7), value(1))), uses(7, power(7, 6, 117649)), calculated(823543, binary("*", value(7), value(117649)))]).
substitution(9, [binding("base", 7), binding("exponent", 8), binding("value", 5764801), binding("previous", 7), binding("tail", 823543)]).
proof(9, power(7, 8, 5764801), rule(7), [compared(">", 8, 0), calculated(7, binary("-", value(8), value(1))), uses(8, power(7, 7, 823543)), calculated(5764801, binary("*", value(7), value(823543)))]).
substitution(10, [binding("base", 7), binding("exponent", 9), binding("value", 40353607), binding("previous", 8), binding("tail", 5764801)]).
proof(10, power(7, 9, 40353607), rule(7), [compared(">", 9, 0), calculated(8, binary("-", value(9), value(1))), uses(9, power(7, 8, 5764801)), calculated(40353607, binary("*", value(7), value(5764801)))]).
substitution(11, [binding("base", 7), binding("exponent", 10), binding("value", 282475249), binding("previous", 9), binding("tail", 40353607)]).
proof(11, power(7, 10, 282475249), rule(7), [compared(">", 10, 0), calculated(9, binary("-", value(10), value(1))), uses(10, power(7, 9, 40353607)), calculated(282475249, binary("*", value(7), value(40353607)))]).
substitution(12, [binding("base", 7), binding("exponent", 11), binding("value", 1977326743), binding("previous", 10), binding("tail", 282475249)]).
proof(12, power(7, 11, 1977326743), rule(7), [compared(">", 11, 0), calculated(10, binary("-", value(11), value(1))), uses(11, power(7, 10, 282475249)), calculated(1977326743, binary("*", value(7), value(282475249)))]).
substitution(13, [binding("base", 7), binding("exponent", 12), binding("value", 13841287201), binding("previous", 11), binding("tail", 1977326743)]).
proof(13, power(7, 12, 13841287201), rule(7), [compared(">", 12, 0), calculated(11, binary("-", value(12), value(1))), uses(12, power(7, 11, 1977326743)), calculated(13841287201, binary("*", value(7), value(1977326743)))]).
substitution(14, [binding("base", 7), binding("exponent", 13), binding("value", 96889010407), binding("previous", 12), binding("tail", 13841287201)]).
proof(14, power(7, 13, 96889010407), rule(7), [compared(">", 13, 0), calculated(12, binary("-", value(13), value(1))), uses(13, power(7, 12, 13841287201)), calculated(96889010407, binary("*", value(7), value(13841287201)))]).
substitution(15, [binding("a", 7), binding("b", 7), binding("m", 97), binding("r", 49)]).
proof(15, mod_mul(7, 7, 97, 49), rule(1), [calculated(49, binary("%", binary("*", value(7), value(7)), value(97)))]).
substitution(16, [binding("a", 49), binding("b", 49), binding("m", 97), binding("r", 73)]).
proof(16, mod_mul(49, 49, 97, 73), rule(1), [calculated(73, binary("%", binary("*", value(49), value(49)), value(97)))]).
substitution(17, [binding("a", 73), binding("b", 73), binding("m", 97), binding("r", 91)]).
proof(17, mod_mul(73, 73, 97, 91), rule(1), [calculated(91, binary("%", binary("*", value(73), value(73)), value(97)))]).
substitution(18, [binding("b", 91), binding("m", 97), binding("r", 91)]).
proof(18, mod_pow(91, 1, 97, 91), rule(3), [compared(">", 97, 0), calculated(91, binary("%", value(91), value(97)))]).
substitution(19, [binding("a", 73), binding("b", 91), binding("m", 97), binding("r", 47)]).
proof(19, mod_mul(73, 91, 97, 47), rule(1), [calculated(47, binary("%", binary("*", value(73), value(91)), value(97)))]).
substitution(20, [binding("b", 73), binding("e", 3), binding("m", 97), binding("r", 47), binding("parity", 1), binding("squared", 91), binding("half", 1), binding("tail", 91)]).
proof(20, mod_pow(73, 3, 97, 47), rule(5), [compared(">", 97, 0), compared(">", 3, 1), calculated(1, binary("%", value(3), value(2))), compared("=", 1, 1), uses(17, mod_mul(73, 73, 97, 91)), calculated(1, binary("//", binary("-", value(3), value(1)), value(2))), uses(18, mod_pow(91, 1, 97, 91)), uses(19, mod_mul(73, 91, 97, 47))]).
substitution(21, [binding("b", 49), binding("e", 6), binding("m", 97), binding("r", 47), binding("parity", 0), binding("squared", 73), binding("half", 3)]).
proof(21, mod_pow(49, 6, 97, 47), rule(4), [compared(">", 97, 0), compared(">", 6, 1), calculated(0, binary("%", value(6), value(2))), compared("=", 0, 0), uses(16, mod_mul(49, 49, 97, 73)), calculated(3, binary("//", value(6), value(2))), uses(20, mod_pow(73, 3, 97, 47))]).
substitution(22, [binding("a", 7), binding("b", 47), binding("m", 97), binding("r", 38)]).
proof(22, mod_mul(7, 47, 97, 38), rule(1), [calculated(38, binary("%", binary("*", value(7), value(47)), value(97)))]).
substitution(23, [binding("b", 7), binding("e", 13), binding("m", 97), binding("r", 38), binding("parity", 1), binding("squared", 49), binding("half", 6), binding("tail", 47)]).
proof(23, mod_pow(7, 13, 97, 38), rule(5), [compared(">", 97, 0), compared(">", 13, 1), calculated(1, binary("%", value(13), value(2))), compared("=", 1, 1), uses(15, mod_mul(7, 7, 97, 49)), calculated(6, binary("//", binary("-", value(13), value(1)), value(2))), uses(21, mod_pow(49, 6, 97, 47)), uses(22, mod_mul(7, 47, 97, 38))]).
substitution(24, [binding("naive", 38), binding("fast", 38), binding("power", 96889010407)]).
proof(24, small_check(38, 38), rule(8), [uses(14, power(7, 13, 96889010407)), calculated(38, binary("%", value(96889010407), value(97))), uses(23, mod_pow(7, 13, 97, 38))]).
substitution(25, [binding("naive", 38), binding("fast", 38)]).
proof(25, solution([38, 38]), query, [uses(24, small_check(38, 38))]).
substitution(26, [binding("a", 7), binding("b", 7), binding("m", 1000000007), binding("r", 49)]).
proof(26, mod_mul(7, 7, 1000000007, 49), rule(1), [calculated(49, binary("%", binary("*", value(7), value(7)), value(1000000007)))]).
substitution(27, [binding("a", 49), binding("b", 49), binding("m", 1000000007), binding("r", 2401)]).
proof(27, mod_mul(49, 49, 1000000007, 2401), rule(1), [calculated(2401, binary("%", binary("*", value(49), value(49)), value(1000000007)))]).
substitution(28, [binding("a", 2401), binding("b", 2401), binding("m", 1000000007), binding("r", 5764801)]).
proof(28, mod_mul(2401, 2401, 1000000007, 5764801), rule(1), [calculated(5764801, binary("%", binary("*", value(2401), value(2401)), value(1000000007)))]).
substitution(29, [binding("a", 5764801), binding("b", 5764801), binding("m", 1000000007), binding("r", 930336977)]).
proof(29, mod_mul(5764801, 5764801, 1000000007, 930336977), rule(1), [calculated(930336977, binary("%", binary("*", value(5764801), value(5764801)), value(1000000007)))]).
substitution(30, [binding("a", 930336977), binding("b", 930336977), binding("m", 1000000007), binding("r", 714810341)]).
proof(30, mod_mul(930336977, 930336977, 1000000007, 714810341), rule(1), [calculated(714810341, binary("%", binary("*", value(930336977), value(930336977)), value(1000000007)))]).
substitution(31, [binding("a", 714810341), binding("b", 714810341), binding("m", 1000000007), binding("r", 23859541)]).
proof(31, mod_mul(714810341, 714810341, 1000000007, 23859541), rule(1), [calculated(23859541, binary("%", binary("*", value(714810341), value(714810341)), value(1000000007)))]).
substitution(32, [binding("a", 23859541), binding("b", 23859541), binding("m", 1000000007), binding("r", 692745742)]).
proof(32, mod_mul(23859541, 23859541, 1000000007, 692745742), rule(1), [calculated(692745742, binary("%", binary("*", value(23859541), value(23859541)), value(1000000007)))]).
substitution(33, []).
proof(33, power(2, 0, 1), rule(6), []).
substitution(34, [binding("base", 2), binding("exponent", 1), binding("value", 2), binding("previous", 0), binding("tail", 1)]).
proof(34, power(2, 1, 2), rule(7), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(33, power(2, 0, 1)), calculated(2, binary("*", value(2), value(1)))]).
substitution(35, [binding("a", 692745742), binding("b", 692745742), binding("m", 1000000007), binding("r", 699853951)]).
proof(35, mod_mul(692745742, 692745742, 1000000007, 699853951), rule(1), [calculated(699853951, binary("%", binary("*", value(692745742), value(692745742)), value(1000000007)))]).
substitution(36, [binding("base", 2), binding("exponent", 2), binding("value", 4), binding("previous", 1), binding("tail", 2)]).
proof(36, power(2, 2, 4), rule(7), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(34, power(2, 1, 2)), calculated(4, binary("*", value(2), value(2)))]).
substitution(37, [binding("base", 2), binding("exponent", 3), binding("value", 8), binding("previous", 2), binding("tail", 4)]).
proof(37, power(2, 3, 8), rule(7), [compared(">", 3, 0), calculated(2, binary("-", value(3), value(1))), uses(36, power(2, 2, 4)), calculated(8, binary("*", value(2), value(4)))]).
substitution(38, [binding("base", 2), binding("exponent", 4), binding("value", 16), binding("previous", 3), binding("tail", 8)]).
proof(38, power(2, 4, 16), rule(7), [compared(">", 4, 0), calculated(3, binary("-", value(4), value(1))), uses(37, power(2, 3, 8)), calculated(16, binary("*", value(2), value(8)))]).
substitution(39, [binding("a", 699853951), binding("b", 699853951), binding("m", 1000000007), binding("r", 301741558)]).
proof(39, mod_mul(699853951, 699853951, 1000000007, 301741558), rule(1), [calculated(301741558, binary("%", binary("*", value(699853951), value(699853951)), value(1000000007)))]).
substitution(40, [binding("base", 2), binding("exponent", 5), binding("value", 32), binding("previous", 4), binding("tail", 16)]).
proof(40, power(2, 5, 32), rule(7), [compared(">", 5, 0), calculated(4, binary("-", value(5), value(1))), uses(38, power(2, 4, 16)), calculated(32, binary("*", value(2), value(16)))]).
substitution(41, [binding("base", 2), binding("exponent", 6), binding("value", 64), binding("previous", 5), binding("tail", 32)]).
proof(41, power(2, 6, 64), rule(7), [compared(">", 6, 0), calculated(5, binary("-", value(6), value(1))), uses(40, power(2, 5, 32)), calculated(64, binary("*", value(2), value(32)))]).
substitution(42, [binding("base", 2), binding("exponent", 7), binding("value", 128), binding("previous", 6), binding("tail", 64)]).
proof(42, power(2, 7, 128), rule(7), [compared(">", 7, 0), calculated(6, binary("-", value(7), value(1))), uses(41, power(2, 6, 64)), calculated(128, binary("*", value(2), value(64)))]).
substitution(43, [binding("a", 301741558), binding("b", 301741558), binding("m", 1000000007), binding("r", 186931595)]).
proof(43, mod_mul(301741558, 301741558, 1000000007, 186931595), rule(1), [calculated(186931595, binary("%", binary("*", value(301741558), value(301741558)), value(1000000007)))]).
substitution(44, [binding("base", 2), binding("exponent", 8), binding("value", 256), binding("previous", 7), binding("tail", 128)]).
proof(44, power(2, 8, 256), rule(7), [compared(">", 8, 0), calculated(7, binary("-", value(8), value(1))), uses(42, power(2, 7, 128)), calculated(256, binary("*", value(2), value(128)))]).
substitution(45, [binding("base", 2), binding("exponent", 9), binding("value", 512), binding("previous", 8), binding("tail", 256)]).
proof(45, power(2, 9, 512), rule(7), [compared(">", 9, 0), calculated(8, binary("-", value(9), value(1))), uses(44, power(2, 8, 256)), calculated(512, binary("*", value(2), value(256)))]).
substitution(46, [binding("base", 2), binding("exponent", 10), binding("value", 1024), binding("previous", 9), binding("tail", 512)]).
proof(46, power(2, 10, 1024), rule(7), [compared(">", 10, 0), calculated(9, binary("-", value(10), value(1))), uses(45, power(2, 9, 512)), calculated(1024, binary("*", value(2), value(512)))]).
substitution(47, [binding("a", 186931595), binding("b", 186931595), binding("m", 1000000007), binding("r", 964640085)]).
proof(47, mod_mul(186931595, 186931595, 1000000007, 964640085), rule(1), [calculated(964640085, binary("%", binary("*", value(186931595), value(186931595)), value(1000000007)))]).
substitution(48, [binding("base", 2), binding("exponent", 11), binding("value", 2048), binding("previous", 10), binding("tail", 1024)]).
proof(48, power(2, 11, 2048), rule(7), [compared(">", 11, 0), calculated(10, binary("-", value(11), value(1))), uses(46, power(2, 10, 1024)), calculated(2048, binary("*", value(2), value(1024)))]).
substitution(49, [binding("base", 2), binding("exponent", 12), binding("value", 4096), binding("previous", 11), binding("tail", 2048)]).
proof(49, power(2, 12, 4096), rule(7), [compared(">", 12, 0), calculated(11, binary("-", value(12), value(1))), uses(48, power(2, 11, 2048)), calculated(4096, binary("*", value(2), value(2048)))]).
substitution(50, [binding("base", 2), binding("exponent", 13), binding("value", 8192), binding("previous", 12), binding("tail", 4096)]).
proof(50, power(2, 13, 8192), rule(7), [compared(">", 13, 0), calculated(12, binary("-", value(13), value(1))), uses(49, power(2, 12, 4096)), calculated(8192, binary("*", value(2), value(4096)))]).
substitution(51, [binding("a", 964640085), binding("b", 964640085), binding("m", 1000000007), binding("r", 75093816)]).
proof(51, mod_mul(964640085, 964640085, 1000000007, 75093816), rule(1), [calculated(75093816, binary("%", binary("*", value(964640085), value(964640085)), value(1000000007)))]).
substitution(52, [binding("base", 2), binding("exponent", 14), binding("value", 16384), binding("previous", 13), binding("tail", 8192)]).
proof(52, power(2, 14, 16384), rule(7), [compared(">", 14, 0), calculated(13, binary("-", value(14), value(1))), uses(50, power(2, 13, 8192)), calculated(16384, binary("*", value(2), value(8192)))]).
substitution(53, [binding("base", 2), binding("exponent", 15), binding("value", 32768), binding("previous", 14), binding("tail", 16384)]).
proof(53, power(2, 15, 32768), rule(7), [compared(">", 15, 0), calculated(14, binary("-", value(15), value(1))), uses(52, power(2, 14, 16384)), calculated(32768, binary("*", value(2), value(16384)))]).
substitution(54, [binding("base", 2), binding("exponent", 16), binding("value", 65536), binding("previous", 15), binding("tail", 32768)]).
proof(54, power(2, 16, 65536), rule(7), [compared(">", 16, 0), calculated(15, binary("-", value(16), value(1))), uses(53, power(2, 15, 32768)), calculated(65536, binary("*", value(2), value(32768)))]).
substitution(55, [binding("a", 75093816), binding("b", 75093816), binding("m", 1000000007), binding("r", 161968289)]).
proof(55, mod_mul(75093816, 75093816, 1000000007, 161968289), rule(1), [calculated(161968289, binary("%", binary("*", value(75093816), value(75093816)), value(1000000007)))]).
substitution(56, [binding("base", 2), binding("exponent", 17), binding("value", 131072), binding("previous", 16), binding("tail", 65536)]).
proof(56, power(2, 17, 131072), rule(7), [compared(">", 17, 0), calculated(16, binary("-", value(17), value(1))), uses(54, power(2, 16, 65536)), calculated(131072, binary("*", value(2), value(65536)))]).
substitution(57, [binding("base", 2), binding("exponent", 18), binding("value", 262144), binding("previous", 17), binding("tail", 131072)]).
proof(57, power(2, 18, 262144), rule(7), [compared(">", 18, 0), calculated(17, binary("-", value(18), value(1))), uses(56, power(2, 17, 131072)), calculated(262144, binary("*", value(2), value(131072)))]).
substitution(58, [binding("base", 2), binding("exponent", 19), binding("value", 524288), binding("previous", 18), binding("tail", 262144)]).
proof(58, power(2, 19, 524288), rule(7), [compared(">", 19, 0), calculated(18, binary("-", value(19), value(1))), uses(57, power(2, 18, 262144)), calculated(524288, binary("*", value(2), value(262144)))]).
substitution(59, [binding("a", 161968289), binding("b", 161968289), binding("m", 1000000007), binding("r", 457951439)]).
proof(59, mod_mul(161968289, 161968289, 1000000007, 457951439), rule(1), [calculated(457951439, binary("%", binary("*", value(161968289), value(161968289)), value(1000000007)))]).
substitution(60, [binding("base", 2), binding("exponent", 20), binding("value", 1048576), binding("previous", 19), binding("tail", 524288)]).
proof(60, power(2, 20, 1048576), rule(7), [compared(">", 20, 0), calculated(19, binary("-", value(20), value(1))), uses(58, power(2, 19, 524288)), calculated(1048576, binary("*", value(2), value(524288)))]).
substitution(61, [binding("base", 2), binding("exponent", 21), binding("value", 2097152), binding("previous", 20), binding("tail", 1048576)]).
proof(61, power(2, 21, 2097152), rule(7), [compared(">", 21, 0), calculated(20, binary("-", value(21), value(1))), uses(60, power(2, 20, 1048576)), calculated(2097152, binary("*", value(2), value(1048576)))]).
substitution(62, [binding("base", 2), binding("exponent", 22), binding("value", 4194304), binding("previous", 21), binding("tail", 2097152)]).
proof(62, power(2, 22, 4194304), rule(7), [compared(">", 22, 0), calculated(21, binary("-", value(22), value(1))), uses(61, power(2, 21, 2097152)), calculated(4194304, binary("*", value(2), value(2097152)))]).
substitution(63, [binding("a", 457951439), binding("b", 457951439), binding("m", 1000000007), binding("r", 14134088)]).
proof(63, mod_mul(457951439, 457951439, 1000000007, 14134088), rule(1), [calculated(14134088, binary("%", binary("*", value(457951439), value(457951439)), value(1000000007)))]).
substitution(64, [binding("a", 2), binding("b", 2), binding("m", 1000000000000), binding("r", 4)]).
proof(64, mod_mul(2, 2, 1000000000000, 4), rule(1), [calculated(4, binary("%", binary("*", value(2), value(2)), value(1000000000000)))]).
substitution(65, [binding("base", 2), binding("exponent", 23), binding("value", 8388608), binding("previous", 22), binding("tail", 4194304)]).
proof(65, power(2, 23, 8388608), rule(7), [compared(">", 23, 0), calculated(22, binary("-", value(23), value(1))), uses(62, power(2, 22, 4194304)), calculated(8388608, binary("*", value(2), value(4194304)))]).
substitution(66, [binding("base", 2), binding("exponent", 24), binding("value", 16777216), binding("previous", 23), binding("tail", 8388608)]).
proof(66, power(2, 24, 16777216), rule(7), [compared(">", 24, 0), calculated(23, binary("-", value(24), value(1))), uses(65, power(2, 23, 8388608)), calculated(16777216, binary("*", value(2), value(8388608)))]).
substitution(67, [binding("base", 2), binding("exponent", 25), binding("value", 33554432), binding("previous", 24), binding("tail", 16777216)]).
proof(67, power(2, 25, 33554432), rule(7), [compared(">", 25, 0), calculated(24, binary("-", value(25), value(1))), uses(66, power(2, 24, 16777216)), calculated(33554432, binary("*", value(2), value(16777216)))]).
substitution(68, [binding("a", 14134088), binding("b", 14134088), binding("m", 1000000007), binding("r", 442193340)]).
proof(68, mod_mul(14134088, 14134088, 1000000007, 442193340), rule(1), [calculated(442193340, binary("%", binary("*", value(14134088), value(14134088)), value(1000000007)))]).
substitution(69, [binding("a", 4), binding("b", 4), binding("m", 1000000000000), binding("r", 16)]).
proof(69, mod_mul(4, 4, 1000000000000, 16), rule(1), [calculated(16, binary("%", binary("*", value(4), value(4)), value(1000000000000)))]).
substitution(70, [binding("a", 3), binding("b", 3), binding("m", 1000000007), binding("r", 9)]).
proof(70, mod_mul(3, 3, 1000000007, 9), rule(1), [calculated(9, binary("%", binary("*", value(3), value(3)), value(1000000007)))]).
substitution(71, [binding("a", 442193340), binding("b", 442193340), binding("m", 1000000007), binding("r", 571610964)]).
proof(71, mod_mul(442193340, 442193340, 1000000007, 571610964), rule(1), [calculated(571610964, binary("%", binary("*", value(442193340), value(442193340)), value(1000000007)))]).
substitution(72, [binding("a", 16), binding("b", 16), binding("m", 1000000000000), binding("r", 256)]).
proof(72, mod_mul(16, 16, 1000000000000, 256), rule(1), [calculated(256, binary("%", binary("*", value(16), value(16)), value(1000000000000)))]).
substitution(73, [binding("a", 9), binding("b", 9), binding("m", 1000000007), binding("r", 81)]).
proof(73, mod_mul(9, 9, 1000000007, 81), rule(1), [calculated(81, binary("%", binary("*", value(9), value(9)), value(1000000007)))]).
substitution(74, [binding("a", 571610964), binding("b", 571610964), binding("m", 1000000007), binding("r", 877835659)]).
proof(74, mod_mul(571610964, 571610964, 1000000007, 877835659), rule(1), [calculated(877835659, binary("%", binary("*", value(571610964), value(571610964)), value(1000000007)))]).
substitution(75, [binding("a", 256), binding("b", 256), binding("m", 1000000000000), binding("r", 65536)]).
proof(75, mod_mul(256, 256, 1000000000000, 65536), rule(1), [calculated(65536, binary("%", binary("*", value(256), value(256)), value(1000000000000)))]).
substitution(76, [binding("a", 81), binding("b", 81), binding("m", 1000000007), binding("r", 6561)]).
proof(76, mod_mul(81, 81, 1000000007, 6561), rule(1), [calculated(6561, binary("%", binary("*", value(81), value(81)), value(1000000007)))]).
substitution(77, [binding("a", 877835659), binding("b", 877835659), binding("m", 1000000007), binding("r", 817796215)]).
proof(77, mod_mul(877835659, 877835659, 1000000007, 817796215), rule(1), [calculated(817796215, binary("%", binary("*", value(877835659), value(877835659)), value(1000000007)))]).
substitution(78, [binding("a", 65536), binding("b", 65536), binding("m", 1000000000000), binding("r", 4294967296)]).
proof(78, mod_mul(65536, 65536, 1000000000000, 4294967296), rule(1), [calculated(4294967296, binary("%", binary("*", value(65536), value(65536)), value(1000000000000)))]).
substitution(79, [binding("a", 6561), binding("b", 6561), binding("m", 1000000007), binding("r", 43046721)]).
proof(79, mod_mul(6561, 6561, 1000000007, 43046721), rule(1), [calculated(43046721, binary("%", binary("*", value(6561), value(6561)), value(1000000007)))]).
substitution(80, [binding("a", 817796215), binding("b", 817796215), binding("m", 1000000007), binding("r", 586791717)]).
proof(80, mod_mul(817796215, 817796215, 1000000007, 586791717), rule(1), [calculated(586791717, binary("%", binary("*", value(817796215), value(817796215)), value(1000000007)))]).
substitution(81, [binding("a", 4294967296), binding("b", 4294967296), binding("m", 1000000000000), binding("r", 73709551616)]).
proof(81, mod_mul(4294967296, 4294967296, 1000000000000, 73709551616), rule(1), [calculated(73709551616, binary("%", binary("*", value(4294967296), value(4294967296)), value(1000000000000)))]).
substitution(82, [binding("a", 43046721), binding("b", 43046721), binding("m", 1000000007), binding("r", 175880701)]).
proof(82, mod_mul(43046721, 43046721, 1000000007, 175880701), rule(1), [calculated(175880701, binary("%", binary("*", value(43046721), value(43046721)), value(1000000007)))]).
substitution(83, [binding("a", 586791717), binding("b", 586791717), binding("m", 1000000007), binding("r", 729536477)]).
proof(83, mod_mul(586791717, 586791717, 1000000007, 729536477), rule(1), [calculated(729536477, binary("%", binary("*", value(586791717), value(586791717)), value(1000000007)))]).
substitution(84, [binding("a", 73709551616), binding("b", 73709551616), binding("m", 1000000000000), binding("r", 431768211456)]).
proof(84, mod_mul(73709551616, 73709551616, 1000000000000, 431768211456), rule(1), [calculated(431768211456, binary("%", binary("*", value(73709551616), value(73709551616)), value(1000000000000)))]).
substitution(85, [binding("a", 175880701), binding("b", 175880701), binding("m", 1000000007), binding("r", 767713261)]).
proof(85, mod_mul(175880701, 175880701, 1000000007, 767713261), rule(1), [calculated(767713261, binary("%", binary("*", value(175880701), value(175880701)), value(1000000007)))]).
substitution(86, [binding("a", 729536477), binding("b", 729536477), binding("m", 1000000007), binding("r", 548007260)]).
proof(86, mod_mul(729536477, 729536477, 1000000007, 548007260), rule(1), [calculated(548007260, binary("%", binary("*", value(729536477), value(729536477)), value(1000000007)))]).
substitution(87, [binding("a", 431768211456), binding("b", 431768211456), binding("m", 1000000000000), binding("r", 913129639936)]).
proof(87, mod_mul(431768211456, 431768211456, 1000000000000, 913129639936), rule(1), [calculated(913129639936, binary("%", binary("*", value(431768211456), value(431768211456)), value(1000000000000)))]).
substitution(88, [binding("a", 767713261), binding("b", 767713261), binding("m", 1000000007), binding("r", 989568599)]).
proof(88, mod_mul(767713261, 767713261, 1000000007, 989568599), rule(1), [calculated(989568599, binary("%", binary("*", value(767713261), value(767713261)), value(1000000007)))]).
substitution(89, [binding("a", 548007260), binding("b", 548007260), binding("m", 1000000007), binding("r", 910523922)]).
proof(89, mod_mul(548007260, 548007260, 1000000007, 910523922), rule(1), [calculated(910523922, binary("%", binary("*", value(548007260), value(548007260)), value(1000000007)))]).
substitution(90, [binding("a", 913129639936), binding("b", 913129639936), binding("m", 1000000000000), binding("r", 649006084096)]).
proof(90, mod_mul(913129639936, 913129639936, 1000000000000, 649006084096), rule(1), [calculated(649006084096, binary("%", binary("*", value(913129639936), value(913129639936)), value(1000000000000)))]).
substitution(91, [binding("a", 989568599), binding("b", 989568599), binding("m", 1000000007), binding("r", 272100766)]).
proof(91, mod_mul(989568599, 989568599, 1000000007, 272100766), rule(1), [calculated(272100766, binary("%", binary("*", value(989568599), value(989568599)), value(1000000007)))]).
substitution(92, [binding("a", 910523922), binding("b", 910523922), binding("m", 1000000007), binding("r", 730885442)]).
proof(92, mod_mul(910523922, 910523922, 1000000007, 730885442), rule(1), [calculated(730885442, binary("%", binary("*", value(910523922), value(910523922)), value(1000000007)))]).
substitution(93, [binding("a", 649006084096), binding("b", 649006084096), binding("m", 1000000000000), binding("r", 624224137216)]).
proof(93, mod_mul(649006084096, 649006084096, 1000000000000, 624224137216), rule(1), [calculated(624224137216, binary("%", binary("*", value(649006084096), value(649006084096)), value(1000000000000)))]).
substitution(94, [binding("a", 272100766), binding("b", 272100766), binding("m", 1000000007), binding("r", 339514974)]).
proof(94, mod_mul(272100766, 272100766, 1000000007, 339514974), rule(1), [calculated(339514974, binary("%", binary("*", value(272100766), value(272100766)), value(1000000007)))]).
substitution(95, [binding("a", 730885442), binding("b", 730885442), binding("m", 1000000007), binding("r", 588180689)]).
proof(95, mod_mul(730885442, 730885442, 1000000007, 588180689), rule(1), [calculated(588180689, binary("%", binary("*", value(730885442), value(730885442)), value(1000000007)))]).
substitution(96, [binding("a", 624224137216), binding("b", 624224137216), binding("m", 1000000000000), binding("r", 59596230656)]).
proof(96, mod_mul(624224137216, 624224137216, 1000000000000, 59596230656), rule(1), [calculated(59596230656, binary("%", binary("*", value(624224137216), value(624224137216)), value(1000000000000)))]).
substitution(97, [binding("a", 339514974), binding("b", 339514974), binding("m", 1000000007), binding("r", 763327764)]).
proof(97, mod_mul(339514974, 339514974, 1000000007, 763327764), rule(1), [calculated(763327764, binary("%", binary("*", value(339514974), value(339514974)), value(1000000007)))]).
substitution(98, [binding("a", 588180689), binding("b", 588180689), binding("m", 1000000007), binding("r", 490819081)]).
proof(98, mod_mul(588180689, 588180689, 1000000007, 490819081), rule(1), [calculated(490819081, binary("%", binary("*", value(588180689), value(588180689)), value(1000000007)))]).
substitution(99, [binding("a", 59596230656), binding("b", 59596230656), binding("m", 1000000000000), binding("r", 403154190336)]).
proof(99, mod_mul(59596230656, 59596230656, 1000000000000, 403154190336), rule(1), [calculated(403154190336, binary("%", binary("*", value(59596230656), value(59596230656)), value(1000000000000)))]).
substitution(100, [binding("a", 763327764), binding("b", 763327764), binding("m", 1000000007), binding("r", 214554799)]).
proof(100, mod_mul(763327764, 763327764, 1000000007, 214554799), rule(1), [calculated(214554799, binary("%", binary("*", value(763327764), value(763327764)), value(1000000007)))]).
substitution(101, [binding("a", 490819081), binding("b", 490819081), binding("m", 1000000007), binding("r", 587360985)]).
proof(101, mod_mul(490819081, 490819081, 1000000007, 587360985), rule(1), [calculated(587360985, binary("%", binary("*", value(490819081), value(490819081)), value(1000000007)))]).
substitution(102, [binding("a", 403154190336), binding("b", 403154190336), binding("m", 1000000000000), binding("r", 475715792896)]).
proof(102, mod_mul(403154190336, 403154190336, 1000000000000, 475715792896), rule(1), [calculated(475715792896, binary("%", binary("*", value(403154190336), value(403154190336)), value(1000000000000)))]).
substitution(103, [binding("a", 214554799), binding("b", 214554799), binding("m", 1000000007), binding("r", 451694074)]).
proof(103, mod_mul(214554799, 214554799, 1000000007, 451694074), rule(1), [calculated(451694074, binary("%", binary("*", value(214554799), value(214554799)), value(1000000007)))]).
substitution(104, [binding("a", 587360985), binding("b", 587360985), binding("m", 1000000007), binding("r", 285219757)]).
proof(104, mod_mul(587360985, 587360985, 1000000007, 285219757), rule(1), [calculated(285219757, binary("%", binary("*", value(587360985), value(587360985)), value(1000000007)))]).
substitution(105, [binding("a", 475715792896), binding("b", 475715792896), binding("m", 1000000000000), binding("r", 669964066816)]).
proof(105, mod_mul(475715792896, 475715792896, 1000000000000, 669964066816), rule(1), [calculated(669964066816, binary("%", binary("*", value(475715792896), value(475715792896)), value(1000000000000)))]).
substitution(106, [binding("a", 451694074), binding("b", 451694074), binding("m", 1000000007), binding("r", 58524731)]).
proof(106, mod_mul(451694074, 451694074, 1000000007, 58524731), rule(1), [calculated(58524731, binary("%", binary("*", value(451694074), value(451694074)), value(1000000007)))]).
substitution(107, [binding("a", 285219757), binding("b", 285219757), binding("m", 1000000007), binding("r", 213686886)]).
proof(107, mod_mul(285219757, 285219757, 1000000007, 213686886), rule(1), [calculated(213686886, binary("%", binary("*", value(285219757), value(285219757)), value(1000000007)))]).
substitution(108, [binding("a", 669964066816), binding("b", 669964066816), binding("m", 1000000000000), binding("r", 633712377856)]).
proof(108, mod_mul(669964066816, 669964066816, 1000000000000, 633712377856), rule(1), [calculated(633712377856, binary("%", binary("*", value(669964066816), value(669964066816)), value(1000000000000)))]).
substitution(109, [binding("b", 213686886), binding("m", 1000000007), binding("r", 213686886)]).
proof(109, mod_pow(213686886, 1, 1000000007, 213686886), rule(3), [compared(">", 1000000007, 0), calculated(213686886, binary("%", value(213686886), value(1000000007)))]).
substitution(110, [binding("a", 58524731), binding("b", 58524731), binding("m", 1000000007), binding("r", 114646353)]).
proof(110, mod_mul(58524731, 58524731, 1000000007, 114646353), rule(1), [calculated(114646353, binary("%", binary("*", value(58524731), value(58524731)), value(1000000007)))]).
substitution(111, [binding("a", 633712377856), binding("b", 633712377856), binding("m", 1000000000000), binding("r", 905719156736)]).
proof(111, mod_mul(633712377856, 633712377856, 1000000000000, 905719156736), rule(1), [calculated(905719156736, binary("%", binary("*", value(633712377856), value(633712377856)), value(1000000000000)))]).
substitution(112, [binding("a", 285219757), binding("b", 213686886), binding("m", 1000000007), binding("r", 272372655)]).
proof(112, mod_mul(285219757, 213686886, 1000000007, 272372655), rule(1), [calculated(272372655, binary("%", binary("*", value(285219757), value(213686886)), value(1000000007)))]).
substitution(113, [binding("b", 285219757), binding("e", 3), binding("m", 1000000007), binding("r", 272372655), binding("parity", 1), binding("squared", 213686886), binding("half", 1), binding("tail", 213686886)]).
proof(113, mod_pow(285219757, 3, 1000000007, 272372655), rule(5), [compared(">", 1000000007, 0), compared(">", 3, 1), calculated(1, binary("%", value(3), value(2))), compared("=", 1, 1), uses(107, mod_mul(285219757, 285219757, 1000000007, 213686886)), calculated(1, binary("//", binary("-", value(3), value(1)), value(2))), uses(109, mod_pow(213686886, 1, 1000000007, 213686886)), uses(112, mod_mul(285219757, 213686886, 1000000007, 272372655))]).
substitution(114, [binding("a", 114646353), binding("b", 114646353), binding("m", 1000000007), binding("r", 164194107)]).
proof(114, mod_mul(114646353, 114646353, 1000000007, 164194107), rule(1), [calculated(164194107, binary("%", binary("*", value(114646353), value(114646353)), value(1000000007)))]).
substitution(115, [binding("a", 905719156736), binding("b", 905719156736), binding("m", 1000000000000), binding("r", 570934173696)]).
proof(115, mod_mul(905719156736, 905719156736, 1000000000000, 570934173696), rule(1), [calculated(570934173696, binary("%", binary("*", value(905719156736), value(905719156736)), value(1000000000000)))]).
substitution(116, [binding("a", 587360985), binding("b", 272372655), binding("m", 1000000007), binding("r", 807997692)]).
proof(116, mod_mul(587360985, 272372655, 1000000007, 807997692), rule(1), [calculated(807997692, binary("%", binary("*", value(587360985), value(272372655)), value(1000000007)))]).
substitution(117, [binding("b", 587360985), binding("e", 7), binding("m", 1000000007), binding("r", 807997692), binding("parity", 1), binding("squared", 285219757), binding("half", 3), binding("tail", 272372655)]).
proof(117, mod_pow(587360985, 7, 1000000007, 807997692), rule(5), [compared(">", 1000000007, 0), compared(">", 7, 1), calculated(1, binary("%", value(7), value(2))), compared("=", 1, 1), uses(104, mod_mul(587360985, 587360985, 1000000007, 285219757)), calculated(3, binary("//", binary("-", value(7), value(1)), value(2))), uses(113, mod_pow(285219757, 3, 1000000007, 272372655)), uses(116, mod_mul(587360985, 272372655, 1000000007, 807997692))]).
substitution(118, [binding("a", 164194107), binding("b", 164194107), binding("m", 1000000007), binding("r", 584809521)]).
proof(118, mod_mul(164194107, 164194107, 1000000007, 584809521), rule(1), [calculated(584809521, binary("%", binary("*", value(164194107), value(164194107)), value(1000000007)))]).
substitution(119, [binding("b", 490819081), binding("e", 14), binding("m", 1000000007), binding("r", 807997692), binding("parity", 0), binding("squared", 587360985), binding("half", 7)]).
proof(119, mod_pow(490819081, 14, 1000000007, 807997692), rule(4), [compared(">", 1000000007, 0), compared(">", 14, 1), calculated(0, binary("%", value(14), value(2))), compared("=", 0, 0), uses(101, mod_mul(490819081, 490819081, 1000000007, 587360985)), calculated(7, binary("//", value(14), value(2))), uses(117, mod_pow(587360985, 7, 1000000007, 807997692))]).
substitution(120, [binding("a", 570934173696), binding("b", 570934173696), binding("m", 1000000000000), binding("r", 934298300416)]).
proof(120, mod_mul(570934173696, 570934173696, 1000000000000, 934298300416), rule(1), [calculated(934298300416, binary("%", binary("*", value(570934173696), value(570934173696)), value(1000000000000)))]).
substitution(121, [binding("a", 588180689), binding("b", 807997692), binding("m", 1000000007), binding("r", 864229343)]).
proof(121, mod_mul(588180689, 807997692, 1000000007, 864229343), rule(1), [calculated(864229343, binary("%", binary("*", value(588180689), value(807997692)), value(1000000007)))]).
substitution(122, [binding("a", 584809521), binding("b", 584809521), binding("m", 1000000007), binding("r", 458234230)]).
proof(122, mod_mul(584809521, 584809521, 1000000007, 458234230), rule(1), [calculated(458234230, binary("%", binary("*", value(584809521), value(584809521)), value(1000000007)))]).
substitution(123, [binding("b", 588180689), binding("e", 29), binding("m", 1000000007), binding("r", 864229343), binding("parity", 1), binding("squared", 490819081), binding("half", 14), binding("tail", 807997692)]).
proof(123, mod_pow(588180689, 29, 1000000007, 864229343), rule(5), [compared(">", 1000000007, 0), compared(">", 29, 1), calculated(1, binary("%", value(29), value(2))), compared("=", 1, 1), uses(98, mod_mul(588180689, 588180689, 1000000007, 490819081)), calculated(14, binary("//", binary("-", value(29), value(1)), value(2))), uses(119, mod_pow(490819081, 14, 1000000007, 807997692)), uses(121, mod_mul(588180689, 807997692, 1000000007, 864229343))]).
substitution(124, [binding("a", 934298300416), binding("b", 934298300416), binding("m", 1000000000000), binding("r", 226185773056)]).
proof(124, mod_mul(934298300416, 934298300416, 1000000000000, 226185773056), rule(1), [calculated(226185773056, binary("%", binary("*", value(934298300416), value(934298300416)), value(1000000000000)))]).
substitution(125, [binding("a", 730885442), binding("b", 864229343), binding("m", 1000000007), binding("r", 926356126)]).
proof(125, mod_mul(730885442, 864229343, 1000000007, 926356126), rule(1), [calculated(926356126, binary("%", binary("*", value(730885442), value(864229343)), value(1000000007)))]).
substitution(126, [binding("a", 458234230), binding("b", 458234230), binding("m", 1000000007), binding("r", 73842644)]).
proof(126, mod_mul(458234230, 458234230, 1000000007, 73842644), rule(1), [calculated(73842644, binary("%", binary("*", value(458234230), value(458234230)), value(1000000007)))]).
substitution(127, [binding("b", 730885442), binding("e", 59), binding("m", 1000000007), binding("r", 926356126), binding("parity", 1), binding("squared", 588180689), binding("half", 29), binding("tail", 864229343)]).
proof(127, mod_pow(730885442, 59, 1000000007, 926356126), rule(5), [compared(">", 1000000007, 0), compared(">", 59, 1), calculated(1, binary("%", value(59), value(2))), compared("=", 1, 1), uses(95, mod_mul(730885442, 730885442, 1000000007, 588180689)), calculated(29, binary("//", binary("-", value(59), value(1)), value(2))), uses(123, mod_pow(588180689, 29, 1000000007, 864229343)), uses(125, mod_mul(730885442, 864229343, 1000000007, 926356126))]).
substitution(128, [binding("a", 226185773056), binding("b", 226185773056), binding("m", 1000000000000), binding("r", 940335579136)]).
proof(128, mod_mul(226185773056, 226185773056, 1000000000000, 940335579136), rule(1), [calculated(940335579136, binary("%", binary("*", value(226185773056), value(226185773056)), value(1000000000000)))]).
substitution(129, [binding("a", 910523922), binding("b", 926356126), binding("m", 1000000007), binding("r", 109960323)]).
proof(129, mod_mul(910523922, 926356126, 1000000007, 109960323), rule(1), [calculated(109960323, binary("%", binary("*", value(910523922), value(926356126)), value(1000000007)))]).
substitution(130, [binding("b", 940335579136), binding("m", 1000000000000), binding("r", 940335579136)]).
proof(130, mod_pow(940335579136, 1, 1000000000000, 940335579136), rule(3), [compared(">", 1000000000000, 0), calculated(940335579136, binary("%", value(940335579136), value(1000000000000)))]).
substitution(131, [binding("a", 73842644), binding("b", 73842644), binding("m", 1000000007), binding("r", 34741584)]).
proof(131, mod_mul(73842644, 73842644, 1000000007, 34741584), rule(1), [calculated(34741584, binary("%", binary("*", value(73842644), value(73842644)), value(1000000007)))]).
substitution(132, [binding("b", 910523922), binding("e", 119), binding("m", 1000000007), binding("r", 109960323), binding("parity", 1), binding("squared", 730885442), binding("half", 59), binding("tail", 926356126)]).
proof(132, mod_pow(910523922, 119, 1000000007, 109960323), rule(5), [compared(">", 1000000007, 0), compared(">", 119, 1), calculated(1, binary("%", value(119), value(2))), compared("=", 1, 1), uses(92, mod_mul(910523922, 910523922, 1000000007, 730885442)), calculated(59, binary("//", binary("-", value(119), value(1)), value(2))), uses(127, mod_pow(730885442, 59, 1000000007, 926356126)), uses(129, mod_mul(910523922, 926356126, 1000000007, 109960323))]).
substitution(133, [binding("b", 226185773056), binding("e", 2), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 940335579136), binding("half", 1)]).
proof(133, mod_pow(226185773056, 2, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 2, 1), calculated(0, binary("%", value(2), value(2))), compared("=", 0, 0), uses(128, mod_mul(226185773056, 226185773056, 1000000000000, 940335579136)), calculated(1, binary("//", value(2), value(2))), uses(130, mod_pow(940335579136, 1, 1000000000000, 940335579136))]).
substitution(134, [binding("b", 548007260), binding("e", 238), binding("m", 1000000007), binding("r", 109960323), binding("parity", 0), binding("squared", 910523922), binding("half", 119)]).
proof(134, mod_pow(548007260, 238, 1000000007, 109960323), rule(4), [compared(">", 1000000007, 0), compared(">", 238, 1), calculated(0, binary("%", value(238), value(2))), compared("=", 0, 0), uses(89, mod_mul(548007260, 548007260, 1000000007, 910523922)), calculated(119, binary("//", value(238), value(2))), uses(132, mod_pow(910523922, 119, 1000000007, 109960323))]).
substitution(135, [binding("b", 934298300416), binding("e", 4), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 226185773056), binding("half", 2)]).
proof(135, mod_pow(934298300416, 4, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 4, 1), calculated(0, binary("%", value(4), value(2))), compared("=", 0, 0), uses(124, mod_mul(934298300416, 934298300416, 1000000000000, 226185773056)), calculated(2, binary("//", value(4), value(2))), uses(133, mod_pow(226185773056, 2, 1000000000000, 940335579136))]).
substitution(136, [binding("b", 729536477), binding("e", 476), binding("m", 1000000007), binding("r", 109960323), binding("parity", 0), binding("squared", 548007260), binding("half", 238)]).
proof(136, mod_pow(729536477, 476, 1000000007, 109960323), rule(4), [compared(">", 1000000007, 0), compared(">", 476, 1), calculated(0, binary("%", value(476), value(2))), compared("=", 0, 0), uses(86, mod_mul(729536477, 729536477, 1000000007, 548007260)), calculated(238, binary("//", value(476), value(2))), uses(134, mod_pow(548007260, 238, 1000000007, 109960323))]).
substitution(137, [binding("b", 570934173696), binding("e", 8), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 934298300416), binding("half", 4)]).
proof(137, mod_pow(570934173696, 8, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 8, 1), calculated(0, binary("%", value(8), value(2))), compared("=", 0, 0), uses(120, mod_mul(570934173696, 570934173696, 1000000000000, 934298300416)), calculated(4, binary("//", value(8), value(2))), uses(135, mod_pow(934298300416, 4, 1000000000000, 940335579136))]).
substitution(138, [binding("a", 34741584), binding("b", 34741584), binding("m", 1000000007), binding("r", 650380217)]).
proof(138, mod_mul(34741584, 34741584, 1000000007, 650380217), rule(1), [calculated(650380217, binary("%", binary("*", value(34741584), value(34741584)), value(1000000007)))]).
substitution(139, [binding("b", 905719156736), binding("e", 16), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 570934173696), binding("half", 8)]).
proof(139, mod_pow(905719156736, 16, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 16, 1), calculated(0, binary("%", value(16), value(2))), compared("=", 0, 0), uses(115, mod_mul(905719156736, 905719156736, 1000000000000, 570934173696)), calculated(8, binary("//", value(16), value(2))), uses(137, mod_pow(570934173696, 8, 1000000000000, 940335579136))]).
substitution(140, [binding("a", 586791717), binding("b", 109960323), binding("m", 1000000007), binding("r", 283377949)]).
proof(140, mod_mul(586791717, 109960323, 1000000007, 283377949), rule(1), [calculated(283377949, binary("%", binary("*", value(586791717), value(109960323)), value(1000000007)))]).
substitution(141, [binding("b", 633712377856), binding("e", 32), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 905719156736), binding("half", 16)]).
proof(141, mod_pow(633712377856, 32, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 32, 1), calculated(0, binary("%", value(32), value(2))), compared("=", 0, 0), uses(111, mod_mul(633712377856, 633712377856, 1000000000000, 905719156736)), calculated(16, binary("//", value(32), value(2))), uses(139, mod_pow(905719156736, 16, 1000000000000, 940335579136))]).
substitution(142, [binding("b", 586791717), binding("e", 953), binding("m", 1000000007), binding("r", 283377949), binding("parity", 1), binding("squared", 729536477), binding("half", 476), binding("tail", 109960323)]).
proof(142, mod_pow(586791717, 953, 1000000007, 283377949), rule(5), [compared(">", 1000000007, 0), compared(">", 953, 1), calculated(1, binary("%", value(953), value(2))), compared("=", 1, 1), uses(83, mod_mul(586791717, 586791717, 1000000007, 729536477)), calculated(476, binary("//", binary("-", value(953), value(1)), value(2))), uses(136, mod_pow(729536477, 476, 1000000007, 109960323)), uses(140, mod_mul(586791717, 109960323, 1000000007, 283377949))]).
substitution(143, [binding("b", 669964066816), binding("e", 64), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 633712377856), binding("half", 32)]).
proof(143, mod_pow(669964066816, 64, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 64, 1), calculated(0, binary("%", value(64), value(2))), compared("=", 0, 0), uses(108, mod_mul(669964066816, 669964066816, 1000000000000, 633712377856)), calculated(32, binary("//", value(64), value(2))), uses(141, mod_pow(633712377856, 32, 1000000000000, 940335579136))]).
substitution(144, [binding("a", 650380217), binding("b", 650380217), binding("m", 1000000007), binding("r", 704006128)]).
proof(144, mod_mul(650380217, 650380217, 1000000007, 704006128), rule(1), [calculated(704006128, binary("%", binary("*", value(650380217), value(650380217)), value(1000000007)))]).
substitution(145, [binding("b", 475715792896), binding("e", 128), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 669964066816), binding("half", 64)]).
proof(145, mod_pow(475715792896, 128, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 128, 1), calculated(0, binary("%", value(128), value(2))), compared("=", 0, 0), uses(105, mod_mul(475715792896, 475715792896, 1000000000000, 669964066816)), calculated(64, binary("//", value(128), value(2))), uses(143, mod_pow(669964066816, 64, 1000000000000, 940335579136))]).
substitution(146, [binding("a", 817796215), binding("b", 283377949), binding("m", 1000000007), binding("r", 484445151)]).
proof(146, mod_mul(817796215, 283377949, 1000000007, 484445151), rule(1), [calculated(484445151, binary("%", binary("*", value(817796215), value(283377949)), value(1000000007)))]).
substitution(147, [binding("b", 403154190336), binding("e", 256), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 475715792896), binding("half", 128)]).
proof(147, mod_pow(403154190336, 256, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 256, 1), calculated(0, binary("%", value(256), value(2))), compared("=", 0, 0), uses(102, mod_mul(403154190336, 403154190336, 1000000000000, 475715792896)), calculated(128, binary("//", value(256), value(2))), uses(145, mod_pow(475715792896, 128, 1000000000000, 940335579136))]).
substitution(148, [binding("b", 817796215), binding("e", 1907), binding("m", 1000000007), binding("r", 484445151), binding("parity", 1), binding("squared", 586791717), binding("half", 953), binding("tail", 283377949)]).
proof(148, mod_pow(817796215, 1907, 1000000007, 484445151), rule(5), [compared(">", 1000000007, 0), compared(">", 1907, 1), calculated(1, binary("%", value(1907), value(2))), compared("=", 1, 1), uses(80, mod_mul(817796215, 817796215, 1000000007, 586791717)), calculated(953, binary("//", binary("-", value(1907), value(1)), value(2))), uses(142, mod_pow(586791717, 953, 1000000007, 283377949)), uses(146, mod_mul(817796215, 283377949, 1000000007, 484445151))]).
substitution(149, [binding("b", 59596230656), binding("e", 512), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 403154190336), binding("half", 256)]).
proof(149, mod_pow(59596230656, 512, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 512, 1), calculated(0, binary("%", value(512), value(2))), compared("=", 0, 0), uses(99, mod_mul(59596230656, 59596230656, 1000000000000, 403154190336)), calculated(256, binary("//", value(512), value(2))), uses(147, mod_pow(403154190336, 256, 1000000000000, 940335579136))]).
substitution(150, [binding("a", 704006128), binding("b", 704006128), binding("m", 1000000007), binding("r", 792180016)]).
proof(150, mod_mul(704006128, 704006128, 1000000007, 792180016), rule(1), [calculated(792180016, binary("%", binary("*", value(704006128), value(704006128)), value(1000000007)))]).
substitution(151, [binding("b", 877835659), binding("e", 3814), binding("m", 1000000007), binding("r", 484445151), binding("parity", 0), binding("squared", 817796215), binding("half", 1907)]).
proof(151, mod_pow(877835659, 3814, 1000000007, 484445151), rule(4), [compared(">", 1000000007, 0), compared(">", 3814, 1), calculated(0, binary("%", value(3814), value(2))), compared("=", 0, 0), uses(77, mod_mul(877835659, 877835659, 1000000007, 817796215)), calculated(1907, binary("//", value(3814), value(2))), uses(148, mod_pow(817796215, 1907, 1000000007, 484445151))]).
substitution(152, [binding("b", 624224137216), binding("e", 1024), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 59596230656), binding("half", 512)]).
proof(152, mod_pow(624224137216, 1024, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 1024, 1), calculated(0, binary("%", value(1024), value(2))), compared("=", 0, 0), uses(96, mod_mul(624224137216, 624224137216, 1000000000000, 59596230656)), calculated(512, binary("//", value(1024), value(2))), uses(149, mod_pow(59596230656, 512, 1000000000000, 940335579136))]).
substitution(153, [binding("b", 649006084096), binding("e", 2048), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 624224137216), binding("half", 1024)]).
proof(153, mod_pow(649006084096, 2048, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 2048, 1), calculated(0, binary("%", value(2048), value(2))), compared("=", 0, 0), uses(93, mod_mul(649006084096, 649006084096, 1000000000000, 624224137216)), calculated(1024, binary("//", value(2048), value(2))), uses(152, mod_pow(624224137216, 1024, 1000000000000, 940335579136))]).
substitution(154, [binding("a", 571610964), binding("b", 484445151), binding("m", 1000000007), binding("r", 829836465)]).
proof(154, mod_mul(571610964, 484445151, 1000000007, 829836465), rule(1), [calculated(829836465, binary("%", binary("*", value(571610964), value(484445151)), value(1000000007)))]).
substitution(155, [binding("b", 913129639936), binding("e", 4096), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 649006084096), binding("half", 2048)]).
proof(155, mod_pow(913129639936, 4096, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 4096, 1), calculated(0, binary("%", value(4096), value(2))), compared("=", 0, 0), uses(90, mod_mul(913129639936, 913129639936, 1000000000000, 649006084096)), calculated(2048, binary("//", value(4096), value(2))), uses(153, mod_pow(649006084096, 2048, 1000000000000, 940335579136))]).
substitution(156, [binding("a", 792180016), binding("b", 792180016), binding("m", 1000000007), binding("r", 356916045)]).
proof(156, mod_mul(792180016, 792180016, 1000000007, 356916045), rule(1), [calculated(356916045, binary("%", binary("*", value(792180016), value(792180016)), value(1000000007)))]).
substitution(157, [binding("b", 571610964), binding("e", 7629), binding("m", 1000000007), binding("r", 829836465), binding("parity", 1), binding("squared", 877835659), binding("half", 3814), binding("tail", 484445151)]).
proof(157, mod_pow(571610964, 7629, 1000000007, 829836465), rule(5), [compared(">", 1000000007, 0), compared(">", 7629, 1), calculated(1, binary("%", value(7629), value(2))), compared("=", 1, 1), uses(74, mod_mul(571610964, 571610964, 1000000007, 877835659)), calculated(3814, binary("//", binary("-", value(7629), value(1)), value(2))), uses(151, mod_pow(877835659, 3814, 1000000007, 484445151)), uses(154, mod_mul(571610964, 484445151, 1000000007, 829836465))]).
substitution(158, [binding("b", 431768211456), binding("e", 8192), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 913129639936), binding("half", 4096)]).
proof(158, mod_pow(431768211456, 8192, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 8192, 1), calculated(0, binary("%", value(8192), value(2))), compared("=", 0, 0), uses(87, mod_mul(431768211456, 431768211456, 1000000000000, 913129639936)), calculated(4096, binary("//", value(8192), value(2))), uses(155, mod_pow(913129639936, 4096, 1000000000000, 940335579136))]).
substitution(159, [binding("b", 442193340), binding("e", 15258), binding("m", 1000000007), binding("r", 829836465), binding("parity", 0), binding("squared", 571610964), binding("half", 7629)]).
proof(159, mod_pow(442193340, 15258, 1000000007, 829836465), rule(4), [compared(">", 1000000007, 0), compared(">", 15258, 1), calculated(0, binary("%", value(15258), value(2))), compared("=", 0, 0), uses(71, mod_mul(442193340, 442193340, 1000000007, 571610964)), calculated(7629, binary("//", value(15258), value(2))), uses(157, mod_pow(571610964, 7629, 1000000007, 829836465))]).
substitution(160, [binding("b", 73709551616), binding("e", 16384), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 431768211456), binding("half", 8192)]).
proof(160, mod_pow(73709551616, 16384, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 16384, 1), calculated(0, binary("%", value(16384), value(2))), compared("=", 0, 0), uses(84, mod_mul(73709551616, 73709551616, 1000000000000, 431768211456)), calculated(8192, binary("//", value(16384), value(2))), uses(158, mod_pow(431768211456, 8192, 1000000000000, 940335579136))]).
substitution(161, [binding("b", 4294967296), binding("e", 32768), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 73709551616), binding("half", 16384)]).
proof(161, mod_pow(4294967296, 32768, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 32768, 1), calculated(0, binary("%", value(32768), value(2))), compared("=", 0, 0), uses(81, mod_mul(4294967296, 4294967296, 1000000000000, 73709551616)), calculated(16384, binary("//", value(32768), value(2))), uses(160, mod_pow(73709551616, 16384, 1000000000000, 940335579136))]).
substitution(162, [binding("a", 356916045), binding("b", 356916045), binding("m", 1000000007), binding("r", 286718591)]).
proof(162, mod_mul(356916045, 356916045, 1000000007, 286718591), rule(1), [calculated(286718591, binary("%", binary("*", value(356916045), value(356916045)), value(1000000007)))]).
substitution(163, [binding("a", 14134088), binding("b", 829836465), binding("m", 1000000007), binding("r", 539816053)]).
proof(163, mod_mul(14134088, 829836465, 1000000007, 539816053), rule(1), [calculated(539816053, binary("%", binary("*", value(14134088), value(829836465)), value(1000000007)))]).
substitution(164, [binding("b", 65536), binding("e", 65536), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 4294967296), binding("half", 32768)]).
proof(164, mod_pow(65536, 65536, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 65536, 1), calculated(0, binary("%", value(65536), value(2))), compared("=", 0, 0), uses(78, mod_mul(65536, 65536, 1000000000000, 4294967296)), calculated(32768, binary("//", value(65536), value(2))), uses(161, mod_pow(4294967296, 32768, 1000000000000, 940335579136))]).
substitution(165, [binding("b", 14134088), binding("e", 30517), binding("m", 1000000007), binding("r", 539816053), binding("parity", 1), binding("squared", 442193340), binding("half", 15258), binding("tail", 829836465)]).
proof(165, mod_pow(14134088, 30517, 1000000007, 539816053), rule(5), [compared(">", 1000000007, 0), compared(">", 30517, 1), calculated(1, binary("%", value(30517), value(2))), compared("=", 1, 1), uses(68, mod_mul(14134088, 14134088, 1000000007, 442193340)), calculated(15258, binary("//", binary("-", value(30517), value(1)), value(2))), uses(159, mod_pow(442193340, 15258, 1000000007, 829836465)), uses(163, mod_mul(14134088, 829836465, 1000000007, 539816053))]).
substitution(166, [binding("b", 256), binding("e", 131072), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 65536), binding("half", 65536)]).
proof(166, mod_pow(256, 131072, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 131072, 1), calculated(0, binary("%", value(131072), value(2))), compared("=", 0, 0), uses(75, mod_mul(256, 256, 1000000000000, 65536)), calculated(65536, binary("//", value(131072), value(2))), uses(164, mod_pow(65536, 65536, 1000000000000, 940335579136))]).
substitution(167, [binding("b", 16), binding("e", 262144), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 256), binding("half", 131072)]).
proof(167, mod_pow(16, 262144, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 262144, 1), calculated(0, binary("%", value(262144), value(2))), compared("=", 0, 0), uses(72, mod_mul(16, 16, 1000000000000, 256)), calculated(131072, binary("//", value(262144), value(2))), uses(166, mod_pow(256, 131072, 1000000000000, 940335579136))]).
substitution(168, [binding("a", 286718591), binding("b", 286718591), binding("m", 1000000007), binding("r", 849572438)]).
proof(168, mod_mul(286718591, 286718591, 1000000007, 849572438), rule(1), [calculated(849572438, binary("%", binary("*", value(286718591), value(286718591)), value(1000000007)))]).
substitution(169, [binding("a", 457951439), binding("b", 539816053), binding("m", 1000000007), binding("r", 536183515)]).
proof(169, mod_mul(457951439, 539816053, 1000000007, 536183515), rule(1), [calculated(536183515, binary("%", binary("*", value(457951439), value(539816053)), value(1000000007)))]).
substitution(170, [binding("b", 4), binding("e", 524288), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 16), binding("half", 262144)]).
proof(170, mod_pow(4, 524288, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 524288, 1), calculated(0, binary("%", value(524288), value(2))), compared("=", 0, 0), uses(69, mod_mul(4, 4, 1000000000000, 16)), calculated(262144, binary("//", value(524288), value(2))), uses(167, mod_pow(16, 262144, 1000000000000, 940335579136))]).
substitution(171, [binding("b", 457951439), binding("e", 61035), binding("m", 1000000007), binding("r", 536183515), binding("parity", 1), binding("squared", 14134088), binding("half", 30517), binding("tail", 539816053)]).
proof(171, mod_pow(457951439, 61035, 1000000007, 536183515), rule(5), [compared(">", 1000000007, 0), compared(">", 61035, 1), calculated(1, binary("%", value(61035), value(2))), compared("=", 1, 1), uses(63, mod_mul(457951439, 457951439, 1000000007, 14134088)), calculated(30517, binary("//", binary("-", value(61035), value(1)), value(2))), uses(165, mod_pow(14134088, 30517, 1000000007, 539816053)), uses(169, mod_mul(457951439, 539816053, 1000000007, 536183515))]).
substitution(172, [binding("b", 2), binding("e", 1048576), binding("m", 1000000000000), binding("r", 940335579136), binding("parity", 0), binding("squared", 4), binding("half", 524288)]).
proof(172, mod_pow(2, 1048576, 1000000000000, 940335579136), rule(4), [compared(">", 1000000000000, 0), compared(">", 1048576, 1), calculated(0, binary("%", value(1048576), value(2))), compared("=", 0, 0), uses(64, mod_mul(2, 2, 1000000000000, 4)), calculated(524288, binary("//", value(1048576), value(2))), uses(170, mod_pow(4, 524288, 1000000000000, 940335579136))]).
substitution(173, [binding("b", 849572438), binding("m", 1000000007), binding("r", 849572438)]).
proof(173, mod_pow(849572438, 1, 1000000007, 849572438), rule(3), [compared(">", 1000000007, 0), calculated(849572438, binary("%", value(849572438), value(1000000007)))]).
substitution(174, [binding("b", 161968289), binding("e", 122070), binding("m", 1000000007), binding("r", 536183515), binding("parity", 0), binding("squared", 457951439), binding("half", 61035)]).
proof(174, mod_pow(161968289, 122070, 1000000007, 536183515), rule(4), [compared(">", 1000000007, 0), compared(">", 122070, 1), calculated(0, binary("%", value(122070), value(2))), compared("=", 0, 0), uses(59, mod_mul(161968289, 161968289, 1000000007, 457951439)), calculated(61035, binary("//", value(122070), value(2))), uses(171, mod_pow(457951439, 61035, 1000000007, 536183515))]).
substitution(175, [binding("value", 940335579136), binding("exponent", 1048576)]).
proof(175, large_case(last_12_digits, 940335579136), rule(11), [uses(60, power(2, 20, 1048576)), uses(172, mod_pow(2, 1048576, 1000000000000, 940335579136))]).
substitution(176, [binding("b", 286718591), binding("e", 2), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 849572438), binding("half", 1)]).
proof(176, mod_pow(286718591, 2, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 2, 1), calculated(0, binary("%", value(2), value(2))), compared("=", 0, 0), uses(168, mod_mul(286718591, 286718591, 1000000007, 849572438)), calculated(1, binary("//", value(2), value(2))), uses(173, mod_pow(849572438, 1, 1000000007, 849572438))]).
substitution(177, [binding("b", 75093816), binding("e", 244140), binding("m", 1000000007), binding("r", 536183515), binding("parity", 0), binding("squared", 161968289), binding("half", 122070)]).
proof(177, mod_pow(75093816, 244140, 1000000007, 536183515), rule(4), [compared(">", 1000000007, 0), compared(">", 244140, 1), calculated(0, binary("%", value(244140), value(2))), compared("=", 0, 0), uses(55, mod_mul(75093816, 75093816, 1000000007, 161968289)), calculated(122070, binary("//", value(244140), value(2))), uses(174, mod_pow(161968289, 122070, 1000000007, 536183515))]).
substitution(178, [binding("case", last_12_digits), binding("value", 940335579136)]).
proof(178, solution([last_12_digits, 940335579136]), query, [uses(175, large_case(last_12_digits, 940335579136))]).
substitution(179, [binding("b", 356916045), binding("e", 4), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 286718591), binding("half", 2)]).
proof(179, mod_pow(356916045, 4, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 4, 1), calculated(0, binary("%", value(4), value(2))), compared("=", 0, 0), uses(162, mod_mul(356916045, 356916045, 1000000007, 286718591)), calculated(2, binary("//", value(4), value(2))), uses(176, mod_pow(286718591, 2, 1000000007, 849572438))]).
substitution(180, [binding("b", 792180016), binding("e", 8), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 356916045), binding("half", 4)]).
proof(180, mod_pow(792180016, 8, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 8, 1), calculated(0, binary("%", value(8), value(2))), compared("=", 0, 0), uses(156, mod_mul(792180016, 792180016, 1000000007, 356916045)), calculated(4, binary("//", value(8), value(2))), uses(179, mod_pow(356916045, 4, 1000000007, 849572438))]).
substitution(181, [binding("a", 964640085), binding("b", 536183515), binding("m", 1000000007), binding("r", 864630026)]).
proof(181, mod_mul(964640085, 536183515, 1000000007, 864630026), rule(1), [calculated(864630026, binary("%", binary("*", value(964640085), value(536183515)), value(1000000007)))]).
substitution(182, [binding("b", 704006128), binding("e", 16), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 792180016), binding("half", 8)]).
proof(182, mod_pow(704006128, 16, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 16, 1), calculated(0, binary("%", value(16), value(2))), compared("=", 0, 0), uses(150, mod_mul(704006128, 704006128, 1000000007, 792180016)), calculated(8, binary("//", value(16), value(2))), uses(180, mod_pow(792180016, 8, 1000000007, 849572438))]).
substitution(183, [binding("b", 964640085), binding("e", 488281), binding("m", 1000000007), binding("r", 864630026), binding("parity", 1), binding("squared", 75093816), binding("half", 244140), binding("tail", 536183515)]).
proof(183, mod_pow(964640085, 488281, 1000000007, 864630026), rule(5), [compared(">", 1000000007, 0), compared(">", 488281, 1), calculated(1, binary("%", value(488281), value(2))), compared("=", 1, 1), uses(51, mod_mul(964640085, 964640085, 1000000007, 75093816)), calculated(244140, binary("//", binary("-", value(488281), value(1)), value(2))), uses(177, mod_pow(75093816, 244140, 1000000007, 536183515)), uses(181, mod_mul(964640085, 536183515, 1000000007, 864630026))]).
substitution(184, [binding("b", 650380217), binding("e", 32), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 704006128), binding("half", 16)]).
proof(184, mod_pow(650380217, 32, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 32, 1), calculated(0, binary("%", value(32), value(2))), compared("=", 0, 0), uses(144, mod_mul(650380217, 650380217, 1000000007, 704006128)), calculated(16, binary("//", value(32), value(2))), uses(182, mod_pow(704006128, 16, 1000000007, 849572438))]).
substitution(185, [binding("b", 186931595), binding("e", 976562), binding("m", 1000000007), binding("r", 864630026), binding("parity", 0), binding("squared", 964640085), binding("half", 488281)]).
proof(185, mod_pow(186931595, 976562, 1000000007, 864630026), rule(4), [compared(">", 1000000007, 0), compared(">", 976562, 1), calculated(0, binary("%", value(976562), value(2))), compared("=", 0, 0), uses(47, mod_mul(186931595, 186931595, 1000000007, 964640085)), calculated(488281, binary("//", value(976562), value(2))), uses(183, mod_pow(964640085, 488281, 1000000007, 864630026))]).
substitution(186, [binding("b", 34741584), binding("e", 64), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 650380217), binding("half", 32)]).
proof(186, mod_pow(34741584, 64, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 64, 1), calculated(0, binary("%", value(64), value(2))), compared("=", 0, 0), uses(138, mod_mul(34741584, 34741584, 1000000007, 650380217)), calculated(32, binary("//", value(64), value(2))), uses(184, mod_pow(650380217, 32, 1000000007, 849572438))]).
substitution(187, [binding("b", 73842644), binding("e", 128), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 34741584), binding("half", 64)]).
proof(187, mod_pow(73842644, 128, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 128, 1), calculated(0, binary("%", value(128), value(2))), compared("=", 0, 0), uses(131, mod_mul(73842644, 73842644, 1000000007, 34741584)), calculated(64, binary("//", value(128), value(2))), uses(186, mod_pow(34741584, 64, 1000000007, 849572438))]).
substitution(188, [binding("a", 301741558), binding("b", 864630026), binding("m", 1000000007), binding("r", 312556845)]).
proof(188, mod_mul(301741558, 864630026, 1000000007, 312556845), rule(1), [calculated(312556845, binary("%", binary("*", value(301741558), value(864630026)), value(1000000007)))]).
substitution(189, [binding("b", 458234230), binding("e", 256), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 73842644), binding("half", 128)]).
proof(189, mod_pow(458234230, 256, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 256, 1), calculated(0, binary("%", value(256), value(2))), compared("=", 0, 0), uses(126, mod_mul(458234230, 458234230, 1000000007, 73842644)), calculated(128, binary("//", value(256), value(2))), uses(187, mod_pow(73842644, 128, 1000000007, 849572438))]).
substitution(190, [binding("b", 301741558), binding("e", 1953125), binding("m", 1000000007), binding("r", 312556845), binding("parity", 1), binding("squared", 186931595), binding("half", 976562), binding("tail", 864630026)]).
proof(190, mod_pow(301741558, 1953125, 1000000007, 312556845), rule(5), [compared(">", 1000000007, 0), compared(">", 1953125, 1), calculated(1, binary("%", value(1953125), value(2))), compared("=", 1, 1), uses(43, mod_mul(301741558, 301741558, 1000000007, 186931595)), calculated(976562, binary("//", binary("-", value(1953125), value(1)), value(2))), uses(185, mod_pow(186931595, 976562, 1000000007, 864630026)), uses(188, mod_mul(301741558, 864630026, 1000000007, 312556845))]).
substitution(191, [binding("b", 584809521), binding("e", 512), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 458234230), binding("half", 256)]).
proof(191, mod_pow(584809521, 512, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 512, 1), calculated(0, binary("%", value(512), value(2))), compared("=", 0, 0), uses(122, mod_mul(584809521, 584809521, 1000000007, 458234230)), calculated(256, binary("//", value(512), value(2))), uses(189, mod_pow(458234230, 256, 1000000007, 849572438))]).
substitution(192, [binding("b", 699853951), binding("e", 3906250), binding("m", 1000000007), binding("r", 312556845), binding("parity", 0), binding("squared", 301741558), binding("half", 1953125)]).
proof(192, mod_pow(699853951, 3906250, 1000000007, 312556845), rule(4), [compared(">", 1000000007, 0), compared(">", 3906250, 1), calculated(0, binary("%", value(3906250), value(2))), compared("=", 0, 0), uses(39, mod_mul(699853951, 699853951, 1000000007, 301741558)), calculated(1953125, binary("//", value(3906250), value(2))), uses(190, mod_pow(301741558, 1953125, 1000000007, 312556845))]).
substitution(193, [binding("b", 164194107), binding("e", 1024), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 584809521), binding("half", 512)]).
proof(193, mod_pow(164194107, 1024, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 1024, 1), calculated(0, binary("%", value(1024), value(2))), compared("=", 0, 0), uses(118, mod_mul(164194107, 164194107, 1000000007, 584809521)), calculated(512, binary("//", value(1024), value(2))), uses(191, mod_pow(584809521, 512, 1000000007, 849572438))]).
substitution(194, [binding("b", 692745742), binding("e", 7812500), binding("m", 1000000007), binding("r", 312556845), binding("parity", 0), binding("squared", 699853951), binding("half", 3906250)]).
proof(194, mod_pow(692745742, 7812500, 1000000007, 312556845), rule(4), [compared(">", 1000000007, 0), compared(">", 7812500, 1), calculated(0, binary("%", value(7812500), value(2))), compared("=", 0, 0), uses(35, mod_mul(692745742, 692745742, 1000000007, 699853951)), calculated(3906250, binary("//", value(7812500), value(2))), uses(192, mod_pow(699853951, 3906250, 1000000007, 312556845))]).
substitution(195, [binding("b", 114646353), binding("e", 2048), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 164194107), binding("half", 1024)]).
proof(195, mod_pow(114646353, 2048, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 2048, 1), calculated(0, binary("%", value(2048), value(2))), compared("=", 0, 0), uses(114, mod_mul(114646353, 114646353, 1000000007, 164194107)), calculated(1024, binary("//", value(2048), value(2))), uses(193, mod_pow(164194107, 1024, 1000000007, 849572438))]).
substitution(196, [binding("b", 23859541), binding("e", 15625000), binding("m", 1000000007), binding("r", 312556845), binding("parity", 0), binding("squared", 692745742), binding("half", 7812500)]).
proof(196, mod_pow(23859541, 15625000, 1000000007, 312556845), rule(4), [compared(">", 1000000007, 0), compared(">", 15625000, 1), calculated(0, binary("%", value(15625000), value(2))), compared("=", 0, 0), uses(32, mod_mul(23859541, 23859541, 1000000007, 692745742)), calculated(7812500, binary("//", value(15625000), value(2))), uses(194, mod_pow(692745742, 7812500, 1000000007, 312556845))]).
substitution(197, [binding("b", 58524731), binding("e", 4096), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 114646353), binding("half", 2048)]).
proof(197, mod_pow(58524731, 4096, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 4096, 1), calculated(0, binary("%", value(4096), value(2))), compared("=", 0, 0), uses(110, mod_mul(58524731, 58524731, 1000000007, 114646353)), calculated(2048, binary("//", value(4096), value(2))), uses(195, mod_pow(114646353, 2048, 1000000007, 849572438))]).
substitution(198, [binding("b", 714810341), binding("e", 31250000), binding("m", 1000000007), binding("r", 312556845), binding("parity", 0), binding("squared", 23859541), binding("half", 15625000)]).
proof(198, mod_pow(714810341, 31250000, 1000000007, 312556845), rule(4), [compared(">", 1000000007, 0), compared(">", 31250000, 1), calculated(0, binary("%", value(31250000), value(2))), compared("=", 0, 0), uses(31, mod_mul(714810341, 714810341, 1000000007, 23859541)), calculated(15625000, binary("//", value(31250000), value(2))), uses(196, mod_pow(23859541, 15625000, 1000000007, 312556845))]).
substitution(199, [binding("b", 451694074), binding("e", 8192), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 58524731), binding("half", 4096)]).
proof(199, mod_pow(451694074, 8192, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 8192, 1), calculated(0, binary("%", value(8192), value(2))), compared("=", 0, 0), uses(106, mod_mul(451694074, 451694074, 1000000007, 58524731)), calculated(4096, binary("//", value(8192), value(2))), uses(197, mod_pow(58524731, 4096, 1000000007, 849572438))]).
substitution(200, [binding("b", 930336977), binding("e", 62500000), binding("m", 1000000007), binding("r", 312556845), binding("parity", 0), binding("squared", 714810341), binding("half", 31250000)]).
proof(200, mod_pow(930336977, 62500000, 1000000007, 312556845), rule(4), [compared(">", 1000000007, 0), compared(">", 62500000, 1), calculated(0, binary("%", value(62500000), value(2))), compared("=", 0, 0), uses(30, mod_mul(930336977, 930336977, 1000000007, 714810341)), calculated(31250000, binary("//", value(62500000), value(2))), uses(198, mod_pow(714810341, 31250000, 1000000007, 312556845))]).
substitution(201, [binding("b", 214554799), binding("e", 16384), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 451694074), binding("half", 8192)]).
proof(201, mod_pow(214554799, 16384, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 16384, 1), calculated(0, binary("%", value(16384), value(2))), compared("=", 0, 0), uses(103, mod_mul(214554799, 214554799, 1000000007, 451694074)), calculated(8192, binary("//", value(16384), value(2))), uses(199, mod_pow(451694074, 8192, 1000000007, 849572438))]).
substitution(202, [binding("b", 5764801), binding("e", 125000000), binding("m", 1000000007), binding("r", 312556845), binding("parity", 0), binding("squared", 930336977), binding("half", 62500000)]).
proof(202, mod_pow(5764801, 125000000, 1000000007, 312556845), rule(4), [compared(">", 1000000007, 0), compared(">", 125000000, 1), calculated(0, binary("%", value(125000000), value(2))), compared("=", 0, 0), uses(29, mod_mul(5764801, 5764801, 1000000007, 930336977)), calculated(62500000, binary("//", value(125000000), value(2))), uses(200, mod_pow(930336977, 62500000, 1000000007, 312556845))]).
substitution(203, [binding("b", 763327764), binding("e", 32768), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 214554799), binding("half", 16384)]).
proof(203, mod_pow(763327764, 32768, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 32768, 1), calculated(0, binary("%", value(32768), value(2))), compared("=", 0, 0), uses(100, mod_mul(763327764, 763327764, 1000000007, 214554799)), calculated(16384, binary("//", value(32768), value(2))), uses(201, mod_pow(214554799, 16384, 1000000007, 849572438))]).
substitution(204, [binding("b", 2401), binding("e", 250000000), binding("m", 1000000007), binding("r", 312556845), binding("parity", 0), binding("squared", 5764801), binding("half", 125000000)]).
proof(204, mod_pow(2401, 250000000, 1000000007, 312556845), rule(4), [compared(">", 1000000007, 0), compared(">", 250000000, 1), calculated(0, binary("%", value(250000000), value(2))), compared("=", 0, 0), uses(28, mod_mul(2401, 2401, 1000000007, 5764801)), calculated(125000000, binary("//", value(250000000), value(2))), uses(202, mod_pow(5764801, 125000000, 1000000007, 312556845))]).
substitution(205, [binding("b", 339514974), binding("e", 65536), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 763327764), binding("half", 32768)]).
proof(205, mod_pow(339514974, 65536, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 65536, 1), calculated(0, binary("%", value(65536), value(2))), compared("=", 0, 0), uses(97, mod_mul(339514974, 339514974, 1000000007, 763327764)), calculated(32768, binary("//", value(65536), value(2))), uses(203, mod_pow(763327764, 32768, 1000000007, 849572438))]).
substitution(206, [binding("b", 49), binding("e", 500000000), binding("m", 1000000007), binding("r", 312556845), binding("parity", 0), binding("squared", 2401), binding("half", 250000000)]).
proof(206, mod_pow(49, 500000000, 1000000007, 312556845), rule(4), [compared(">", 1000000007, 0), compared(">", 500000000, 1), calculated(0, binary("%", value(500000000), value(2))), compared("=", 0, 0), uses(27, mod_mul(49, 49, 1000000007, 2401)), calculated(250000000, binary("//", value(500000000), value(2))), uses(204, mod_pow(2401, 250000000, 1000000007, 312556845))]).
substitution(207, [binding("b", 272100766), binding("e", 131072), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 339514974), binding("half", 65536)]).
proof(207, mod_pow(272100766, 131072, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 131072, 1), calculated(0, binary("%", value(131072), value(2))), compared("=", 0, 0), uses(94, mod_mul(272100766, 272100766, 1000000007, 339514974)), calculated(65536, binary("//", value(131072), value(2))), uses(205, mod_pow(339514974, 65536, 1000000007, 849572438))]).
substitution(208, [binding("b", 7), binding("e", 1000000000), binding("m", 1000000007), binding("r", 312556845), binding("parity", 0), binding("squared", 49), binding("half", 500000000)]).
proof(208, mod_pow(7, 1000000000, 1000000007, 312556845), rule(4), [compared(">", 1000000007, 0), compared(">", 1000000000, 1), calculated(0, binary("%", value(1000000000), value(2))), compared("=", 0, 0), uses(26, mod_mul(7, 7, 1000000007, 49)), calculated(500000000, binary("//", value(1000000000), value(2))), uses(206, mod_pow(49, 500000000, 1000000007, 312556845))]).
substitution(209, [binding("b", 989568599), binding("e", 262144), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 272100766), binding("half", 131072)]).
proof(209, mod_pow(989568599, 262144, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 262144, 1), calculated(0, binary("%", value(262144), value(2))), compared("=", 0, 0), uses(91, mod_mul(989568599, 989568599, 1000000007, 272100766)), calculated(131072, binary("//", value(262144), value(2))), uses(207, mod_pow(272100766, 131072, 1000000007, 849572438))]).
substitution(210, [binding("value", 312556845)]).
proof(210, large_case(seven_power_billion, 312556845), rule(9), [uses(208, mod_pow(7, 1000000000, 1000000007, 312556845))]).
substitution(211, [binding("b", 767713261), binding("e", 524288), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 989568599), binding("half", 262144)]).
proof(211, mod_pow(767713261, 524288, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 524288, 1), calculated(0, binary("%", value(524288), value(2))), compared("=", 0, 0), uses(88, mod_mul(767713261, 767713261, 1000000007, 989568599)), calculated(262144, binary("//", value(524288), value(2))), uses(209, mod_pow(989568599, 262144, 1000000007, 849572438))]).
substitution(212, [binding("case", seven_power_billion), binding("value", 312556845)]).
proof(212, solution([seven_power_billion, 312556845]), query, [uses(210, large_case(seven_power_billion, 312556845))]).
substitution(213, [binding("b", 175880701), binding("e", 1048576), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 767713261), binding("half", 524288)]).
proof(213, mod_pow(175880701, 1048576, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 1048576, 1), calculated(0, binary("%", value(1048576), value(2))), compared("=", 0, 0), uses(85, mod_mul(175880701, 175880701, 1000000007, 767713261)), calculated(524288, binary("//", value(1048576), value(2))), uses(211, mod_pow(767713261, 524288, 1000000007, 849572438))]).
substitution(214, [binding("b", 43046721), binding("e", 2097152), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 175880701), binding("half", 1048576)]).
proof(214, mod_pow(43046721, 2097152, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 2097152, 1), calculated(0, binary("%", value(2097152), value(2))), compared("=", 0, 0), uses(82, mod_mul(43046721, 43046721, 1000000007, 175880701)), calculated(1048576, binary("//", value(2097152), value(2))), uses(213, mod_pow(175880701, 1048576, 1000000007, 849572438))]).
substitution(215, [binding("b", 6561), binding("e", 4194304), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 43046721), binding("half", 2097152)]).
proof(215, mod_pow(6561, 4194304, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 4194304, 1), calculated(0, binary("%", value(4194304), value(2))), compared("=", 0, 0), uses(79, mod_mul(6561, 6561, 1000000007, 43046721)), calculated(2097152, binary("//", value(4194304), value(2))), uses(214, mod_pow(43046721, 2097152, 1000000007, 849572438))]).
substitution(216, [binding("b", 81), binding("e", 8388608), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 6561), binding("half", 4194304)]).
proof(216, mod_pow(81, 8388608, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 8388608, 1), calculated(0, binary("%", value(8388608), value(2))), compared("=", 0, 0), uses(76, mod_mul(81, 81, 1000000007, 6561)), calculated(4194304, binary("//", value(8388608), value(2))), uses(215, mod_pow(6561, 4194304, 1000000007, 849572438))]).
substitution(217, [binding("b", 9), binding("e", 16777216), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 81), binding("half", 8388608)]).
proof(217, mod_pow(9, 16777216, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 16777216, 1), calculated(0, binary("%", value(16777216), value(2))), compared("=", 0, 0), uses(73, mod_mul(9, 9, 1000000007, 81)), calculated(8388608, binary("//", value(16777216), value(2))), uses(216, mod_pow(81, 8388608, 1000000007, 849572438))]).
substitution(218, [binding("b", 3), binding("e", 33554432), binding("m", 1000000007), binding("r", 849572438), binding("parity", 0), binding("squared", 9), binding("half", 16777216)]).
proof(218, mod_pow(3, 33554432, 1000000007, 849572438), rule(4), [compared(">", 1000000007, 0), compared(">", 33554432, 1), calculated(0, binary("%", value(33554432), value(2))), compared("=", 0, 0), uses(70, mod_mul(3, 3, 1000000007, 9)), calculated(16777216, binary("//", value(33554432), value(2))), uses(217, mod_pow(9, 16777216, 1000000007, 849572438))]).
substitution(219, [binding("value", 849572438), binding("exponent", 33554432)]).
proof(219, large_case(three_power_two_power_25, 849572438), rule(10), [uses(67, power(2, 25, 33554432)), uses(218, mod_pow(3, 33554432, 1000000007, 849572438))]).
substitution(220, [binding("case", three_power_two_power_25), binding("value", 849572438)]).
proof(220, solution([three_power_two_power_25, 849572438]), query, [uses(219, large_case(three_power_two_power_25, 849572438))]).
