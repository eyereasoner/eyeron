% Prolog result format 3
query(1, small_check(_0, _1), ['Naive' = _0, 'Fast' = _1]).
result(1, complete, 1).
answer(1, ['Naive' = 38, 'Fast' = 38]).
why(1, ['Naive' = 38, 'Fast' = 38], 25).
query(2, large_case(_0, _1), ['Case' = _0, 'Value' = _1]).
result(2, complete, 3).
answer(2, ['Case' = last_12_digits, 'Value' = 940335579136]).
why(2, ['Case' = last_12_digits, 'Value' = 940335579136], 178).
answer(2, ['Case' = seven_power_billion, 'Value' = 312556845]).
why(2, ['Case' = seven_power_billion, 'Value' = 312556845], 212).
answer(2, ['Case' = three_power_two_power_25, 'Value' = 849572438]).
why(2, ['Case' = three_power_two_power_25, 'Value' = 849572438], 220).
clause(1, mod_mul(var('A'), var('B'), var('M'), var('R')), var('R') is var('A') * var('B') rem var('M')).
clause(3, mod_pow(var('B'), 1, var('M'), var('R')), (var('M') > 0, var('R') is var('B') rem var('M'))).
clause(4, mod_pow(var('B'), var('E'), var('M'), var('R')), (var('M') > 0, var('E') > 1, var('Parity') is var('E') rem 2, var('Parity') = 0, mod_mul(var('B'), var('B'), var('M'), var('Squared')), var('Half') is var('E') // 2, mod_pow(var('Squared'), var('Half'), var('M'), var('R')))).
clause(5, mod_pow(var('B'), var('E'), var('M'), var('R')), (var('M') > 0, var('E') > 1, var('Parity') is var('E') rem 2, var('Parity') = 1, mod_mul(var('B'), var('B'), var('M'), var('Squared')), var('Half') is (var('E') - 1) // 2, mod_pow(var('Squared'), var('Half'), var('M'), var('Tail')), mod_mul(var('B'), var('Tail'), var('M'), var('R')))).
clause(6, power(anonymous(1), 0, 1), true).
clause(7, power(var('Base'), var('Exponent'), var('Value')), (var('Exponent') > 0, var('Previous') is var('Exponent') - 1, power(var('Base'), var('Previous'), var('Tail')), var('Value') is var('Base') * var('Tail'))).
clause(8, small_check(var('Naive'), var('Fast')), (power(7, 13, var('Power')), var('Naive') is var('Power') rem 97, mod_pow(7, 13, 97, var('Fast')))).
clause(9, large_case(seven_power_billion, var('Value')), mod_pow(7, 1000000000, 1000000007, var('Value'))).
clause(10, large_case(three_power_two_power_25, var('Value')), (power(2, 25, var('Exponent')), mod_pow(3, var('Exponent'), 1000000007, var('Value')))).
clause(11, large_case(last_12_digits, var('Value')), (power(2, 20, var('Exponent')), mod_pow(2, var('Exponent'), 1000000000000, var('Value')))).
substitution(1, []).
proof(1, power(7, 0, 1), rule(6), []).
substitution(2, ['Base' = 7, 'Exponent' = 1, 'Value' = 7, 'Previous' = 0, 'Tail' = 1]).
proof(2, power(7, 1, 7), rule(7), [builtin(1 > 0), builtin(0 is 1 - 1), uses(1, power(7, 0, 1)), builtin(7 is 7 * 1)]).
substitution(3, ['Base' = 7, 'Exponent' = 2, 'Value' = 49, 'Previous' = 1, 'Tail' = 7]).
proof(3, power(7, 2, 49), rule(7), [builtin(2 > 0), builtin(1 is 2 - 1), uses(2, power(7, 1, 7)), builtin(49 is 7 * 7)]).
substitution(4, ['Base' = 7, 'Exponent' = 3, 'Value' = 343, 'Previous' = 2, 'Tail' = 49]).
proof(4, power(7, 3, 343), rule(7), [builtin(3 > 0), builtin(2 is 3 - 1), uses(3, power(7, 2, 49)), builtin(343 is 7 * 49)]).
substitution(5, ['Base' = 7, 'Exponent' = 4, 'Value' = 2401, 'Previous' = 3, 'Tail' = 343]).
proof(5, power(7, 4, 2401), rule(7), [builtin(4 > 0), builtin(3 is 4 - 1), uses(4, power(7, 3, 343)), builtin(2401 is 7 * 343)]).
substitution(6, ['Base' = 7, 'Exponent' = 5, 'Value' = 16807, 'Previous' = 4, 'Tail' = 2401]).
proof(6, power(7, 5, 16807), rule(7), [builtin(5 > 0), builtin(4 is 5 - 1), uses(5, power(7, 4, 2401)), builtin(16807 is 7 * 2401)]).
substitution(7, ['Base' = 7, 'Exponent' = 6, 'Value' = 117649, 'Previous' = 5, 'Tail' = 16807]).
proof(7, power(7, 6, 117649), rule(7), [builtin(6 > 0), builtin(5 is 6 - 1), uses(6, power(7, 5, 16807)), builtin(117649 is 7 * 16807)]).
substitution(8, ['Base' = 7, 'Exponent' = 7, 'Value' = 823543, 'Previous' = 6, 'Tail' = 117649]).
proof(8, power(7, 7, 823543), rule(7), [builtin(7 > 0), builtin(6 is 7 - 1), uses(7, power(7, 6, 117649)), builtin(823543 is 7 * 117649)]).
substitution(9, ['Base' = 7, 'Exponent' = 8, 'Value' = 5764801, 'Previous' = 7, 'Tail' = 823543]).
proof(9, power(7, 8, 5764801), rule(7), [builtin(8 > 0), builtin(7 is 8 - 1), uses(8, power(7, 7, 823543)), builtin(5764801 is 7 * 823543)]).
substitution(10, ['Base' = 7, 'Exponent' = 9, 'Value' = 40353607, 'Previous' = 8, 'Tail' = 5764801]).
proof(10, power(7, 9, 40353607), rule(7), [builtin(9 > 0), builtin(8 is 9 - 1), uses(9, power(7, 8, 5764801)), builtin(40353607 is 7 * 5764801)]).
substitution(11, ['Base' = 7, 'Exponent' = 10, 'Value' = 282475249, 'Previous' = 9, 'Tail' = 40353607]).
proof(11, power(7, 10, 282475249), rule(7), [builtin(10 > 0), builtin(9 is 10 - 1), uses(10, power(7, 9, 40353607)), builtin(282475249 is 7 * 40353607)]).
substitution(12, ['Base' = 7, 'Exponent' = 11, 'Value' = 1977326743, 'Previous' = 10, 'Tail' = 282475249]).
proof(12, power(7, 11, 1977326743), rule(7), [builtin(11 > 0), builtin(10 is 11 - 1), uses(11, power(7, 10, 282475249)), builtin(1977326743 is 7 * 282475249)]).
substitution(13, ['Base' = 7, 'Exponent' = 12, 'Value' = 13841287201, 'Previous' = 11, 'Tail' = 1977326743]).
proof(13, power(7, 12, 13841287201), rule(7), [builtin(12 > 0), builtin(11 is 12 - 1), uses(12, power(7, 11, 1977326743)), builtin(13841287201 is 7 * 1977326743)]).
substitution(14, ['Base' = 7, 'Exponent' = 13, 'Value' = 96889010407, 'Previous' = 12, 'Tail' = 13841287201]).
proof(14, power(7, 13, 96889010407), rule(7), [builtin(13 > 0), builtin(12 is 13 - 1), uses(13, power(7, 12, 13841287201)), builtin(96889010407 is 7 * 13841287201)]).
substitution(15, ['A' = 7, 'B' = 7, 'M' = 97, 'R' = 49]).
proof(15, mod_mul(7, 7, 97, 49), rule(1), [builtin(49 is 7 * 7 rem 97)]).
substitution(16, ['A' = 49, 'B' = 49, 'M' = 97, 'R' = 73]).
proof(16, mod_mul(49, 49, 97, 73), rule(1), [builtin(73 is 49 * 49 rem 97)]).
substitution(17, ['A' = 73, 'B' = 73, 'M' = 97, 'R' = 91]).
proof(17, mod_mul(73, 73, 97, 91), rule(1), [builtin(91 is 73 * 73 rem 97)]).
substitution(18, ['B' = 91, 'M' = 97, 'R' = 91]).
proof(18, mod_pow(91, 1, 97, 91), rule(3), [builtin(97 > 0), builtin(91 is 91 rem 97)]).
substitution(19, ['A' = 73, 'B' = 91, 'M' = 97, 'R' = 47]).
proof(19, mod_mul(73, 91, 97, 47), rule(1), [builtin(47 is 73 * 91 rem 97)]).
substitution(20, ['B' = 73, 'E' = 3, 'M' = 97, 'R' = 47, 'Parity' = 1, 'Squared' = 91, 'Half' = 1, 'Tail' = 91]).
proof(20, mod_pow(73, 3, 97, 47), rule(5), [builtin(97 > 0), builtin(3 > 1), builtin(1 is 3 rem 2), builtin(1 = 1), uses(17, mod_mul(73, 73, 97, 91)), builtin(1 is (3 - 1) // 2), uses(18, mod_pow(91, 1, 97, 91)), uses(19, mod_mul(73, 91, 97, 47))]).
substitution(21, ['B' = 49, 'E' = 6, 'M' = 97, 'R' = 47, 'Parity' = 0, 'Squared' = 73, 'Half' = 3]).
proof(21, mod_pow(49, 6, 97, 47), rule(4), [builtin(97 > 0), builtin(6 > 1), builtin(0 is 6 rem 2), builtin(0 = 0), uses(16, mod_mul(49, 49, 97, 73)), builtin(3 is 6 // 2), uses(20, mod_pow(73, 3, 97, 47))]).
substitution(22, ['A' = 7, 'B' = 47, 'M' = 97, 'R' = 38]).
proof(22, mod_mul(7, 47, 97, 38), rule(1), [builtin(38 is 7 * 47 rem 97)]).
substitution(23, ['B' = 7, 'E' = 13, 'M' = 97, 'R' = 38, 'Parity' = 1, 'Squared' = 49, 'Half' = 6, 'Tail' = 47]).
proof(23, mod_pow(7, 13, 97, 38), rule(5), [builtin(97 > 0), builtin(13 > 1), builtin(1 is 13 rem 2), builtin(1 = 1), uses(15, mod_mul(7, 7, 97, 49)), builtin(6 is (13 - 1) // 2), uses(21, mod_pow(49, 6, 97, 47)), uses(22, mod_mul(7, 47, 97, 38))]).
substitution(24, ['Naive' = 38, 'Fast' = 38, 'Power' = 96889010407]).
proof(24, small_check(38, 38), rule(8), [uses(14, power(7, 13, 96889010407)), builtin(38 is 96889010407 rem 97), uses(23, mod_pow(7, 13, 97, 38))]).
substitution(25, ['Naive' = 38, 'Fast' = 38]).
proof(25, solution([38, 38]), query, [uses(24, small_check(38, 38))]).
substitution(26, ['A' = 7, 'B' = 7, 'M' = 1000000007, 'R' = 49]).
proof(26, mod_mul(7, 7, 1000000007, 49), rule(1), [builtin(49 is 7 * 7 rem 1000000007)]).
substitution(27, ['A' = 49, 'B' = 49, 'M' = 1000000007, 'R' = 2401]).
proof(27, mod_mul(49, 49, 1000000007, 2401), rule(1), [builtin(2401 is 49 * 49 rem 1000000007)]).
substitution(28, ['A' = 2401, 'B' = 2401, 'M' = 1000000007, 'R' = 5764801]).
proof(28, mod_mul(2401, 2401, 1000000007, 5764801), rule(1), [builtin(5764801 is 2401 * 2401 rem 1000000007)]).
substitution(29, ['A' = 5764801, 'B' = 5764801, 'M' = 1000000007, 'R' = 930336977]).
proof(29, mod_mul(5764801, 5764801, 1000000007, 930336977), rule(1), [builtin(930336977 is 5764801 * 5764801 rem 1000000007)]).
substitution(30, ['A' = 930336977, 'B' = 930336977, 'M' = 1000000007, 'R' = 714810341]).
proof(30, mod_mul(930336977, 930336977, 1000000007, 714810341), rule(1), [builtin(714810341 is 930336977 * 930336977 rem 1000000007)]).
substitution(31, ['A' = 714810341, 'B' = 714810341, 'M' = 1000000007, 'R' = 23859541]).
proof(31, mod_mul(714810341, 714810341, 1000000007, 23859541), rule(1), [builtin(23859541 is 714810341 * 714810341 rem 1000000007)]).
substitution(32, ['A' = 23859541, 'B' = 23859541, 'M' = 1000000007, 'R' = 692745742]).
proof(32, mod_mul(23859541, 23859541, 1000000007, 692745742), rule(1), [builtin(692745742 is 23859541 * 23859541 rem 1000000007)]).
substitution(33, []).
proof(33, power(2, 0, 1), rule(6), []).
substitution(34, ['Base' = 2, 'Exponent' = 1, 'Value' = 2, 'Previous' = 0, 'Tail' = 1]).
proof(34, power(2, 1, 2), rule(7), [builtin(1 > 0), builtin(0 is 1 - 1), uses(33, power(2, 0, 1)), builtin(2 is 2 * 1)]).
substitution(35, ['A' = 692745742, 'B' = 692745742, 'M' = 1000000007, 'R' = 699853951]).
proof(35, mod_mul(692745742, 692745742, 1000000007, 699853951), rule(1), [builtin(699853951 is 692745742 * 692745742 rem 1000000007)]).
substitution(36, ['Base' = 2, 'Exponent' = 2, 'Value' = 4, 'Previous' = 1, 'Tail' = 2]).
proof(36, power(2, 2, 4), rule(7), [builtin(2 > 0), builtin(1 is 2 - 1), uses(34, power(2, 1, 2)), builtin(4 is 2 * 2)]).
substitution(37, ['Base' = 2, 'Exponent' = 3, 'Value' = 8, 'Previous' = 2, 'Tail' = 4]).
proof(37, power(2, 3, 8), rule(7), [builtin(3 > 0), builtin(2 is 3 - 1), uses(36, power(2, 2, 4)), builtin(8 is 2 * 4)]).
substitution(38, ['Base' = 2, 'Exponent' = 4, 'Value' = 16, 'Previous' = 3, 'Tail' = 8]).
proof(38, power(2, 4, 16), rule(7), [builtin(4 > 0), builtin(3 is 4 - 1), uses(37, power(2, 3, 8)), builtin(16 is 2 * 8)]).
substitution(39, ['A' = 699853951, 'B' = 699853951, 'M' = 1000000007, 'R' = 301741558]).
proof(39, mod_mul(699853951, 699853951, 1000000007, 301741558), rule(1), [builtin(301741558 is 699853951 * 699853951 rem 1000000007)]).
substitution(40, ['Base' = 2, 'Exponent' = 5, 'Value' = 32, 'Previous' = 4, 'Tail' = 16]).
proof(40, power(2, 5, 32), rule(7), [builtin(5 > 0), builtin(4 is 5 - 1), uses(38, power(2, 4, 16)), builtin(32 is 2 * 16)]).
substitution(41, ['Base' = 2, 'Exponent' = 6, 'Value' = 64, 'Previous' = 5, 'Tail' = 32]).
proof(41, power(2, 6, 64), rule(7), [builtin(6 > 0), builtin(5 is 6 - 1), uses(40, power(2, 5, 32)), builtin(64 is 2 * 32)]).
substitution(42, ['Base' = 2, 'Exponent' = 7, 'Value' = 128, 'Previous' = 6, 'Tail' = 64]).
proof(42, power(2, 7, 128), rule(7), [builtin(7 > 0), builtin(6 is 7 - 1), uses(41, power(2, 6, 64)), builtin(128 is 2 * 64)]).
substitution(43, ['A' = 301741558, 'B' = 301741558, 'M' = 1000000007, 'R' = 186931595]).
proof(43, mod_mul(301741558, 301741558, 1000000007, 186931595), rule(1), [builtin(186931595 is 301741558 * 301741558 rem 1000000007)]).
substitution(44, ['Base' = 2, 'Exponent' = 8, 'Value' = 256, 'Previous' = 7, 'Tail' = 128]).
proof(44, power(2, 8, 256), rule(7), [builtin(8 > 0), builtin(7 is 8 - 1), uses(42, power(2, 7, 128)), builtin(256 is 2 * 128)]).
substitution(45, ['Base' = 2, 'Exponent' = 9, 'Value' = 512, 'Previous' = 8, 'Tail' = 256]).
proof(45, power(2, 9, 512), rule(7), [builtin(9 > 0), builtin(8 is 9 - 1), uses(44, power(2, 8, 256)), builtin(512 is 2 * 256)]).
substitution(46, ['Base' = 2, 'Exponent' = 10, 'Value' = 1024, 'Previous' = 9, 'Tail' = 512]).
proof(46, power(2, 10, 1024), rule(7), [builtin(10 > 0), builtin(9 is 10 - 1), uses(45, power(2, 9, 512)), builtin(1024 is 2 * 512)]).
substitution(47, ['A' = 186931595, 'B' = 186931595, 'M' = 1000000007, 'R' = 964640085]).
proof(47, mod_mul(186931595, 186931595, 1000000007, 964640085), rule(1), [builtin(964640085 is 186931595 * 186931595 rem 1000000007)]).
substitution(48, ['Base' = 2, 'Exponent' = 11, 'Value' = 2048, 'Previous' = 10, 'Tail' = 1024]).
proof(48, power(2, 11, 2048), rule(7), [builtin(11 > 0), builtin(10 is 11 - 1), uses(46, power(2, 10, 1024)), builtin(2048 is 2 * 1024)]).
substitution(49, ['Base' = 2, 'Exponent' = 12, 'Value' = 4096, 'Previous' = 11, 'Tail' = 2048]).
proof(49, power(2, 12, 4096), rule(7), [builtin(12 > 0), builtin(11 is 12 - 1), uses(48, power(2, 11, 2048)), builtin(4096 is 2 * 2048)]).
substitution(50, ['Base' = 2, 'Exponent' = 13, 'Value' = 8192, 'Previous' = 12, 'Tail' = 4096]).
proof(50, power(2, 13, 8192), rule(7), [builtin(13 > 0), builtin(12 is 13 - 1), uses(49, power(2, 12, 4096)), builtin(8192 is 2 * 4096)]).
substitution(51, ['A' = 964640085, 'B' = 964640085, 'M' = 1000000007, 'R' = 75093816]).
proof(51, mod_mul(964640085, 964640085, 1000000007, 75093816), rule(1), [builtin(75093816 is 964640085 * 964640085 rem 1000000007)]).
substitution(52, ['Base' = 2, 'Exponent' = 14, 'Value' = 16384, 'Previous' = 13, 'Tail' = 8192]).
proof(52, power(2, 14, 16384), rule(7), [builtin(14 > 0), builtin(13 is 14 - 1), uses(50, power(2, 13, 8192)), builtin(16384 is 2 * 8192)]).
substitution(53, ['Base' = 2, 'Exponent' = 15, 'Value' = 32768, 'Previous' = 14, 'Tail' = 16384]).
proof(53, power(2, 15, 32768), rule(7), [builtin(15 > 0), builtin(14 is 15 - 1), uses(52, power(2, 14, 16384)), builtin(32768 is 2 * 16384)]).
substitution(54, ['Base' = 2, 'Exponent' = 16, 'Value' = 65536, 'Previous' = 15, 'Tail' = 32768]).
proof(54, power(2, 16, 65536), rule(7), [builtin(16 > 0), builtin(15 is 16 - 1), uses(53, power(2, 15, 32768)), builtin(65536 is 2 * 32768)]).
substitution(55, ['A' = 75093816, 'B' = 75093816, 'M' = 1000000007, 'R' = 161968289]).
proof(55, mod_mul(75093816, 75093816, 1000000007, 161968289), rule(1), [builtin(161968289 is 75093816 * 75093816 rem 1000000007)]).
substitution(56, ['Base' = 2, 'Exponent' = 17, 'Value' = 131072, 'Previous' = 16, 'Tail' = 65536]).
proof(56, power(2, 17, 131072), rule(7), [builtin(17 > 0), builtin(16 is 17 - 1), uses(54, power(2, 16, 65536)), builtin(131072 is 2 * 65536)]).
substitution(57, ['Base' = 2, 'Exponent' = 18, 'Value' = 262144, 'Previous' = 17, 'Tail' = 131072]).
proof(57, power(2, 18, 262144), rule(7), [builtin(18 > 0), builtin(17 is 18 - 1), uses(56, power(2, 17, 131072)), builtin(262144 is 2 * 131072)]).
substitution(58, ['Base' = 2, 'Exponent' = 19, 'Value' = 524288, 'Previous' = 18, 'Tail' = 262144]).
proof(58, power(2, 19, 524288), rule(7), [builtin(19 > 0), builtin(18 is 19 - 1), uses(57, power(2, 18, 262144)), builtin(524288 is 2 * 262144)]).
substitution(59, ['A' = 161968289, 'B' = 161968289, 'M' = 1000000007, 'R' = 457951439]).
proof(59, mod_mul(161968289, 161968289, 1000000007, 457951439), rule(1), [builtin(457951439 is 161968289 * 161968289 rem 1000000007)]).
substitution(60, ['Base' = 2, 'Exponent' = 20, 'Value' = 1048576, 'Previous' = 19, 'Tail' = 524288]).
proof(60, power(2, 20, 1048576), rule(7), [builtin(20 > 0), builtin(19 is 20 - 1), uses(58, power(2, 19, 524288)), builtin(1048576 is 2 * 524288)]).
substitution(61, ['Base' = 2, 'Exponent' = 21, 'Value' = 2097152, 'Previous' = 20, 'Tail' = 1048576]).
proof(61, power(2, 21, 2097152), rule(7), [builtin(21 > 0), builtin(20 is 21 - 1), uses(60, power(2, 20, 1048576)), builtin(2097152 is 2 * 1048576)]).
substitution(62, ['Base' = 2, 'Exponent' = 22, 'Value' = 4194304, 'Previous' = 21, 'Tail' = 2097152]).
proof(62, power(2, 22, 4194304), rule(7), [builtin(22 > 0), builtin(21 is 22 - 1), uses(61, power(2, 21, 2097152)), builtin(4194304 is 2 * 2097152)]).
substitution(63, ['A' = 457951439, 'B' = 457951439, 'M' = 1000000007, 'R' = 14134088]).
proof(63, mod_mul(457951439, 457951439, 1000000007, 14134088), rule(1), [builtin(14134088 is 457951439 * 457951439 rem 1000000007)]).
substitution(64, ['A' = 2, 'B' = 2, 'M' = 1000000000000, 'R' = 4]).
proof(64, mod_mul(2, 2, 1000000000000, 4), rule(1), [builtin(4 is 2 * 2 rem 1000000000000)]).
substitution(65, ['Base' = 2, 'Exponent' = 23, 'Value' = 8388608, 'Previous' = 22, 'Tail' = 4194304]).
proof(65, power(2, 23, 8388608), rule(7), [builtin(23 > 0), builtin(22 is 23 - 1), uses(62, power(2, 22, 4194304)), builtin(8388608 is 2 * 4194304)]).
substitution(66, ['Base' = 2, 'Exponent' = 24, 'Value' = 16777216, 'Previous' = 23, 'Tail' = 8388608]).
proof(66, power(2, 24, 16777216), rule(7), [builtin(24 > 0), builtin(23 is 24 - 1), uses(65, power(2, 23, 8388608)), builtin(16777216 is 2 * 8388608)]).
substitution(67, ['Base' = 2, 'Exponent' = 25, 'Value' = 33554432, 'Previous' = 24, 'Tail' = 16777216]).
proof(67, power(2, 25, 33554432), rule(7), [builtin(25 > 0), builtin(24 is 25 - 1), uses(66, power(2, 24, 16777216)), builtin(33554432 is 2 * 16777216)]).
substitution(68, ['A' = 14134088, 'B' = 14134088, 'M' = 1000000007, 'R' = 442193340]).
proof(68, mod_mul(14134088, 14134088, 1000000007, 442193340), rule(1), [builtin(442193340 is 14134088 * 14134088 rem 1000000007)]).
substitution(69, ['A' = 4, 'B' = 4, 'M' = 1000000000000, 'R' = 16]).
proof(69, mod_mul(4, 4, 1000000000000, 16), rule(1), [builtin(16 is 4 * 4 rem 1000000000000)]).
substitution(70, ['A' = 3, 'B' = 3, 'M' = 1000000007, 'R' = 9]).
proof(70, mod_mul(3, 3, 1000000007, 9), rule(1), [builtin(9 is 3 * 3 rem 1000000007)]).
substitution(71, ['A' = 442193340, 'B' = 442193340, 'M' = 1000000007, 'R' = 571610964]).
proof(71, mod_mul(442193340, 442193340, 1000000007, 571610964), rule(1), [builtin(571610964 is 442193340 * 442193340 rem 1000000007)]).
substitution(72, ['A' = 16, 'B' = 16, 'M' = 1000000000000, 'R' = 256]).
proof(72, mod_mul(16, 16, 1000000000000, 256), rule(1), [builtin(256 is 16 * 16 rem 1000000000000)]).
substitution(73, ['A' = 9, 'B' = 9, 'M' = 1000000007, 'R' = 81]).
proof(73, mod_mul(9, 9, 1000000007, 81), rule(1), [builtin(81 is 9 * 9 rem 1000000007)]).
substitution(74, ['A' = 571610964, 'B' = 571610964, 'M' = 1000000007, 'R' = 877835659]).
proof(74, mod_mul(571610964, 571610964, 1000000007, 877835659), rule(1), [builtin(877835659 is 571610964 * 571610964 rem 1000000007)]).
substitution(75, ['A' = 256, 'B' = 256, 'M' = 1000000000000, 'R' = 65536]).
proof(75, mod_mul(256, 256, 1000000000000, 65536), rule(1), [builtin(65536 is 256 * 256 rem 1000000000000)]).
substitution(76, ['A' = 81, 'B' = 81, 'M' = 1000000007, 'R' = 6561]).
proof(76, mod_mul(81, 81, 1000000007, 6561), rule(1), [builtin(6561 is 81 * 81 rem 1000000007)]).
substitution(77, ['A' = 877835659, 'B' = 877835659, 'M' = 1000000007, 'R' = 817796215]).
proof(77, mod_mul(877835659, 877835659, 1000000007, 817796215), rule(1), [builtin(817796215 is 877835659 * 877835659 rem 1000000007)]).
substitution(78, ['A' = 65536, 'B' = 65536, 'M' = 1000000000000, 'R' = 4294967296]).
proof(78, mod_mul(65536, 65536, 1000000000000, 4294967296), rule(1), [builtin(4294967296 is 65536 * 65536 rem 1000000000000)]).
substitution(79, ['A' = 6561, 'B' = 6561, 'M' = 1000000007, 'R' = 43046721]).
proof(79, mod_mul(6561, 6561, 1000000007, 43046721), rule(1), [builtin(43046721 is 6561 * 6561 rem 1000000007)]).
substitution(80, ['A' = 817796215, 'B' = 817796215, 'M' = 1000000007, 'R' = 586791717]).
proof(80, mod_mul(817796215, 817796215, 1000000007, 586791717), rule(1), [builtin(586791717 is 817796215 * 817796215 rem 1000000007)]).
substitution(81, ['A' = 4294967296, 'B' = 4294967296, 'M' = 1000000000000, 'R' = 73709551616]).
proof(81, mod_mul(4294967296, 4294967296, 1000000000000, 73709551616), rule(1), [builtin(73709551616 is 4294967296 * 4294967296 rem 1000000000000)]).
substitution(82, ['A' = 43046721, 'B' = 43046721, 'M' = 1000000007, 'R' = 175880701]).
proof(82, mod_mul(43046721, 43046721, 1000000007, 175880701), rule(1), [builtin(175880701 is 43046721 * 43046721 rem 1000000007)]).
substitution(83, ['A' = 586791717, 'B' = 586791717, 'M' = 1000000007, 'R' = 729536477]).
proof(83, mod_mul(586791717, 586791717, 1000000007, 729536477), rule(1), [builtin(729536477 is 586791717 * 586791717 rem 1000000007)]).
substitution(84, ['A' = 73709551616, 'B' = 73709551616, 'M' = 1000000000000, 'R' = 431768211456]).
proof(84, mod_mul(73709551616, 73709551616, 1000000000000, 431768211456), rule(1), [builtin(431768211456 is 73709551616 * 73709551616 rem 1000000000000)]).
substitution(85, ['A' = 175880701, 'B' = 175880701, 'M' = 1000000007, 'R' = 767713261]).
proof(85, mod_mul(175880701, 175880701, 1000000007, 767713261), rule(1), [builtin(767713261 is 175880701 * 175880701 rem 1000000007)]).
substitution(86, ['A' = 729536477, 'B' = 729536477, 'M' = 1000000007, 'R' = 548007260]).
proof(86, mod_mul(729536477, 729536477, 1000000007, 548007260), rule(1), [builtin(548007260 is 729536477 * 729536477 rem 1000000007)]).
substitution(87, ['A' = 431768211456, 'B' = 431768211456, 'M' = 1000000000000, 'R' = 913129639936]).
proof(87, mod_mul(431768211456, 431768211456, 1000000000000, 913129639936), rule(1), [builtin(913129639936 is 431768211456 * 431768211456 rem 1000000000000)]).
substitution(88, ['A' = 767713261, 'B' = 767713261, 'M' = 1000000007, 'R' = 989568599]).
proof(88, mod_mul(767713261, 767713261, 1000000007, 989568599), rule(1), [builtin(989568599 is 767713261 * 767713261 rem 1000000007)]).
substitution(89, ['A' = 548007260, 'B' = 548007260, 'M' = 1000000007, 'R' = 910523922]).
proof(89, mod_mul(548007260, 548007260, 1000000007, 910523922), rule(1), [builtin(910523922 is 548007260 * 548007260 rem 1000000007)]).
substitution(90, ['A' = 913129639936, 'B' = 913129639936, 'M' = 1000000000000, 'R' = 649006084096]).
proof(90, mod_mul(913129639936, 913129639936, 1000000000000, 649006084096), rule(1), [builtin(649006084096 is 913129639936 * 913129639936 rem 1000000000000)]).
substitution(91, ['A' = 989568599, 'B' = 989568599, 'M' = 1000000007, 'R' = 272100766]).
proof(91, mod_mul(989568599, 989568599, 1000000007, 272100766), rule(1), [builtin(272100766 is 989568599 * 989568599 rem 1000000007)]).
substitution(92, ['A' = 910523922, 'B' = 910523922, 'M' = 1000000007, 'R' = 730885442]).
proof(92, mod_mul(910523922, 910523922, 1000000007, 730885442), rule(1), [builtin(730885442 is 910523922 * 910523922 rem 1000000007)]).
substitution(93, ['A' = 649006084096, 'B' = 649006084096, 'M' = 1000000000000, 'R' = 624224137216]).
proof(93, mod_mul(649006084096, 649006084096, 1000000000000, 624224137216), rule(1), [builtin(624224137216 is 649006084096 * 649006084096 rem 1000000000000)]).
substitution(94, ['A' = 272100766, 'B' = 272100766, 'M' = 1000000007, 'R' = 339514974]).
proof(94, mod_mul(272100766, 272100766, 1000000007, 339514974), rule(1), [builtin(339514974 is 272100766 * 272100766 rem 1000000007)]).
substitution(95, ['A' = 730885442, 'B' = 730885442, 'M' = 1000000007, 'R' = 588180689]).
proof(95, mod_mul(730885442, 730885442, 1000000007, 588180689), rule(1), [builtin(588180689 is 730885442 * 730885442 rem 1000000007)]).
substitution(96, ['A' = 624224137216, 'B' = 624224137216, 'M' = 1000000000000, 'R' = 59596230656]).
proof(96, mod_mul(624224137216, 624224137216, 1000000000000, 59596230656), rule(1), [builtin(59596230656 is 624224137216 * 624224137216 rem 1000000000000)]).
substitution(97, ['A' = 339514974, 'B' = 339514974, 'M' = 1000000007, 'R' = 763327764]).
proof(97, mod_mul(339514974, 339514974, 1000000007, 763327764), rule(1), [builtin(763327764 is 339514974 * 339514974 rem 1000000007)]).
substitution(98, ['A' = 588180689, 'B' = 588180689, 'M' = 1000000007, 'R' = 490819081]).
proof(98, mod_mul(588180689, 588180689, 1000000007, 490819081), rule(1), [builtin(490819081 is 588180689 * 588180689 rem 1000000007)]).
substitution(99, ['A' = 59596230656, 'B' = 59596230656, 'M' = 1000000000000, 'R' = 403154190336]).
proof(99, mod_mul(59596230656, 59596230656, 1000000000000, 403154190336), rule(1), [builtin(403154190336 is 59596230656 * 59596230656 rem 1000000000000)]).
substitution(100, ['A' = 763327764, 'B' = 763327764, 'M' = 1000000007, 'R' = 214554799]).
proof(100, mod_mul(763327764, 763327764, 1000000007, 214554799), rule(1), [builtin(214554799 is 763327764 * 763327764 rem 1000000007)]).
substitution(101, ['A' = 490819081, 'B' = 490819081, 'M' = 1000000007, 'R' = 587360985]).
proof(101, mod_mul(490819081, 490819081, 1000000007, 587360985), rule(1), [builtin(587360985 is 490819081 * 490819081 rem 1000000007)]).
substitution(102, ['A' = 403154190336, 'B' = 403154190336, 'M' = 1000000000000, 'R' = 475715792896]).
proof(102, mod_mul(403154190336, 403154190336, 1000000000000, 475715792896), rule(1), [builtin(475715792896 is 403154190336 * 403154190336 rem 1000000000000)]).
substitution(103, ['A' = 214554799, 'B' = 214554799, 'M' = 1000000007, 'R' = 451694074]).
proof(103, mod_mul(214554799, 214554799, 1000000007, 451694074), rule(1), [builtin(451694074 is 214554799 * 214554799 rem 1000000007)]).
substitution(104, ['A' = 587360985, 'B' = 587360985, 'M' = 1000000007, 'R' = 285219757]).
proof(104, mod_mul(587360985, 587360985, 1000000007, 285219757), rule(1), [builtin(285219757 is 587360985 * 587360985 rem 1000000007)]).
substitution(105, ['A' = 475715792896, 'B' = 475715792896, 'M' = 1000000000000, 'R' = 669964066816]).
proof(105, mod_mul(475715792896, 475715792896, 1000000000000, 669964066816), rule(1), [builtin(669964066816 is 475715792896 * 475715792896 rem 1000000000000)]).
substitution(106, ['A' = 451694074, 'B' = 451694074, 'M' = 1000000007, 'R' = 58524731]).
proof(106, mod_mul(451694074, 451694074, 1000000007, 58524731), rule(1), [builtin(58524731 is 451694074 * 451694074 rem 1000000007)]).
substitution(107, ['A' = 285219757, 'B' = 285219757, 'M' = 1000000007, 'R' = 213686886]).
proof(107, mod_mul(285219757, 285219757, 1000000007, 213686886), rule(1), [builtin(213686886 is 285219757 * 285219757 rem 1000000007)]).
substitution(108, ['A' = 669964066816, 'B' = 669964066816, 'M' = 1000000000000, 'R' = 633712377856]).
proof(108, mod_mul(669964066816, 669964066816, 1000000000000, 633712377856), rule(1), [builtin(633712377856 is 669964066816 * 669964066816 rem 1000000000000)]).
substitution(109, ['B' = 213686886, 'M' = 1000000007, 'R' = 213686886]).
proof(109, mod_pow(213686886, 1, 1000000007, 213686886), rule(3), [builtin(1000000007 > 0), builtin(213686886 is 213686886 rem 1000000007)]).
substitution(110, ['A' = 58524731, 'B' = 58524731, 'M' = 1000000007, 'R' = 114646353]).
proof(110, mod_mul(58524731, 58524731, 1000000007, 114646353), rule(1), [builtin(114646353 is 58524731 * 58524731 rem 1000000007)]).
substitution(111, ['A' = 633712377856, 'B' = 633712377856, 'M' = 1000000000000, 'R' = 905719156736]).
proof(111, mod_mul(633712377856, 633712377856, 1000000000000, 905719156736), rule(1), [builtin(905719156736 is 633712377856 * 633712377856 rem 1000000000000)]).
substitution(112, ['A' = 285219757, 'B' = 213686886, 'M' = 1000000007, 'R' = 272372655]).
proof(112, mod_mul(285219757, 213686886, 1000000007, 272372655), rule(1), [builtin(272372655 is 285219757 * 213686886 rem 1000000007)]).
substitution(113, ['B' = 285219757, 'E' = 3, 'M' = 1000000007, 'R' = 272372655, 'Parity' = 1, 'Squared' = 213686886, 'Half' = 1, 'Tail' = 213686886]).
proof(113, mod_pow(285219757, 3, 1000000007, 272372655), rule(5), [builtin(1000000007 > 0), builtin(3 > 1), builtin(1 is 3 rem 2), builtin(1 = 1), uses(107, mod_mul(285219757, 285219757, 1000000007, 213686886)), builtin(1 is (3 - 1) // 2), uses(109, mod_pow(213686886, 1, 1000000007, 213686886)), uses(112, mod_mul(285219757, 213686886, 1000000007, 272372655))]).
substitution(114, ['A' = 114646353, 'B' = 114646353, 'M' = 1000000007, 'R' = 164194107]).
proof(114, mod_mul(114646353, 114646353, 1000000007, 164194107), rule(1), [builtin(164194107 is 114646353 * 114646353 rem 1000000007)]).
substitution(115, ['A' = 905719156736, 'B' = 905719156736, 'M' = 1000000000000, 'R' = 570934173696]).
proof(115, mod_mul(905719156736, 905719156736, 1000000000000, 570934173696), rule(1), [builtin(570934173696 is 905719156736 * 905719156736 rem 1000000000000)]).
substitution(116, ['A' = 587360985, 'B' = 272372655, 'M' = 1000000007, 'R' = 807997692]).
proof(116, mod_mul(587360985, 272372655, 1000000007, 807997692), rule(1), [builtin(807997692 is 587360985 * 272372655 rem 1000000007)]).
substitution(117, ['B' = 587360985, 'E' = 7, 'M' = 1000000007, 'R' = 807997692, 'Parity' = 1, 'Squared' = 285219757, 'Half' = 3, 'Tail' = 272372655]).
proof(117, mod_pow(587360985, 7, 1000000007, 807997692), rule(5), [builtin(1000000007 > 0), builtin(7 > 1), builtin(1 is 7 rem 2), builtin(1 = 1), uses(104, mod_mul(587360985, 587360985, 1000000007, 285219757)), builtin(3 is (7 - 1) // 2), uses(113, mod_pow(285219757, 3, 1000000007, 272372655)), uses(116, mod_mul(587360985, 272372655, 1000000007, 807997692))]).
substitution(118, ['A' = 164194107, 'B' = 164194107, 'M' = 1000000007, 'R' = 584809521]).
proof(118, mod_mul(164194107, 164194107, 1000000007, 584809521), rule(1), [builtin(584809521 is 164194107 * 164194107 rem 1000000007)]).
substitution(119, ['B' = 490819081, 'E' = 14, 'M' = 1000000007, 'R' = 807997692, 'Parity' = 0, 'Squared' = 587360985, 'Half' = 7]).
proof(119, mod_pow(490819081, 14, 1000000007, 807997692), rule(4), [builtin(1000000007 > 0), builtin(14 > 1), builtin(0 is 14 rem 2), builtin(0 = 0), uses(101, mod_mul(490819081, 490819081, 1000000007, 587360985)), builtin(7 is 14 // 2), uses(117, mod_pow(587360985, 7, 1000000007, 807997692))]).
substitution(120, ['A' = 570934173696, 'B' = 570934173696, 'M' = 1000000000000, 'R' = 934298300416]).
proof(120, mod_mul(570934173696, 570934173696, 1000000000000, 934298300416), rule(1), [builtin(934298300416 is 570934173696 * 570934173696 rem 1000000000000)]).
substitution(121, ['A' = 588180689, 'B' = 807997692, 'M' = 1000000007, 'R' = 864229343]).
proof(121, mod_mul(588180689, 807997692, 1000000007, 864229343), rule(1), [builtin(864229343 is 588180689 * 807997692 rem 1000000007)]).
substitution(122, ['A' = 584809521, 'B' = 584809521, 'M' = 1000000007, 'R' = 458234230]).
proof(122, mod_mul(584809521, 584809521, 1000000007, 458234230), rule(1), [builtin(458234230 is 584809521 * 584809521 rem 1000000007)]).
substitution(123, ['B' = 588180689, 'E' = 29, 'M' = 1000000007, 'R' = 864229343, 'Parity' = 1, 'Squared' = 490819081, 'Half' = 14, 'Tail' = 807997692]).
proof(123, mod_pow(588180689, 29, 1000000007, 864229343), rule(5), [builtin(1000000007 > 0), builtin(29 > 1), builtin(1 is 29 rem 2), builtin(1 = 1), uses(98, mod_mul(588180689, 588180689, 1000000007, 490819081)), builtin(14 is (29 - 1) // 2), uses(119, mod_pow(490819081, 14, 1000000007, 807997692)), uses(121, mod_mul(588180689, 807997692, 1000000007, 864229343))]).
substitution(124, ['A' = 934298300416, 'B' = 934298300416, 'M' = 1000000000000, 'R' = 226185773056]).
proof(124, mod_mul(934298300416, 934298300416, 1000000000000, 226185773056), rule(1), [builtin(226185773056 is 934298300416 * 934298300416 rem 1000000000000)]).
substitution(125, ['A' = 730885442, 'B' = 864229343, 'M' = 1000000007, 'R' = 926356126]).
proof(125, mod_mul(730885442, 864229343, 1000000007, 926356126), rule(1), [builtin(926356126 is 730885442 * 864229343 rem 1000000007)]).
substitution(126, ['A' = 458234230, 'B' = 458234230, 'M' = 1000000007, 'R' = 73842644]).
proof(126, mod_mul(458234230, 458234230, 1000000007, 73842644), rule(1), [builtin(73842644 is 458234230 * 458234230 rem 1000000007)]).
substitution(127, ['B' = 730885442, 'E' = 59, 'M' = 1000000007, 'R' = 926356126, 'Parity' = 1, 'Squared' = 588180689, 'Half' = 29, 'Tail' = 864229343]).
proof(127, mod_pow(730885442, 59, 1000000007, 926356126), rule(5), [builtin(1000000007 > 0), builtin(59 > 1), builtin(1 is 59 rem 2), builtin(1 = 1), uses(95, mod_mul(730885442, 730885442, 1000000007, 588180689)), builtin(29 is (59 - 1) // 2), uses(123, mod_pow(588180689, 29, 1000000007, 864229343)), uses(125, mod_mul(730885442, 864229343, 1000000007, 926356126))]).
substitution(128, ['A' = 226185773056, 'B' = 226185773056, 'M' = 1000000000000, 'R' = 940335579136]).
proof(128, mod_mul(226185773056, 226185773056, 1000000000000, 940335579136), rule(1), [builtin(940335579136 is 226185773056 * 226185773056 rem 1000000000000)]).
substitution(129, ['A' = 910523922, 'B' = 926356126, 'M' = 1000000007, 'R' = 109960323]).
proof(129, mod_mul(910523922, 926356126, 1000000007, 109960323), rule(1), [builtin(109960323 is 910523922 * 926356126 rem 1000000007)]).
substitution(130, ['B' = 940335579136, 'M' = 1000000000000, 'R' = 940335579136]).
proof(130, mod_pow(940335579136, 1, 1000000000000, 940335579136), rule(3), [builtin(1000000000000 > 0), builtin(940335579136 is 940335579136 rem 1000000000000)]).
substitution(131, ['A' = 73842644, 'B' = 73842644, 'M' = 1000000007, 'R' = 34741584]).
proof(131, mod_mul(73842644, 73842644, 1000000007, 34741584), rule(1), [builtin(34741584 is 73842644 * 73842644 rem 1000000007)]).
substitution(132, ['B' = 910523922, 'E' = 119, 'M' = 1000000007, 'R' = 109960323, 'Parity' = 1, 'Squared' = 730885442, 'Half' = 59, 'Tail' = 926356126]).
proof(132, mod_pow(910523922, 119, 1000000007, 109960323), rule(5), [builtin(1000000007 > 0), builtin(119 > 1), builtin(1 is 119 rem 2), builtin(1 = 1), uses(92, mod_mul(910523922, 910523922, 1000000007, 730885442)), builtin(59 is (119 - 1) // 2), uses(127, mod_pow(730885442, 59, 1000000007, 926356126)), uses(129, mod_mul(910523922, 926356126, 1000000007, 109960323))]).
substitution(133, ['B' = 226185773056, 'E' = 2, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 940335579136, 'Half' = 1]).
proof(133, mod_pow(226185773056, 2, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(2 > 1), builtin(0 is 2 rem 2), builtin(0 = 0), uses(128, mod_mul(226185773056, 226185773056, 1000000000000, 940335579136)), builtin(1 is 2 // 2), uses(130, mod_pow(940335579136, 1, 1000000000000, 940335579136))]).
substitution(134, ['B' = 548007260, 'E' = 238, 'M' = 1000000007, 'R' = 109960323, 'Parity' = 0, 'Squared' = 910523922, 'Half' = 119]).
proof(134, mod_pow(548007260, 238, 1000000007, 109960323), rule(4), [builtin(1000000007 > 0), builtin(238 > 1), builtin(0 is 238 rem 2), builtin(0 = 0), uses(89, mod_mul(548007260, 548007260, 1000000007, 910523922)), builtin(119 is 238 // 2), uses(132, mod_pow(910523922, 119, 1000000007, 109960323))]).
substitution(135, ['B' = 934298300416, 'E' = 4, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 226185773056, 'Half' = 2]).
proof(135, mod_pow(934298300416, 4, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(4 > 1), builtin(0 is 4 rem 2), builtin(0 = 0), uses(124, mod_mul(934298300416, 934298300416, 1000000000000, 226185773056)), builtin(2 is 4 // 2), uses(133, mod_pow(226185773056, 2, 1000000000000, 940335579136))]).
substitution(136, ['B' = 729536477, 'E' = 476, 'M' = 1000000007, 'R' = 109960323, 'Parity' = 0, 'Squared' = 548007260, 'Half' = 238]).
proof(136, mod_pow(729536477, 476, 1000000007, 109960323), rule(4), [builtin(1000000007 > 0), builtin(476 > 1), builtin(0 is 476 rem 2), builtin(0 = 0), uses(86, mod_mul(729536477, 729536477, 1000000007, 548007260)), builtin(238 is 476 // 2), uses(134, mod_pow(548007260, 238, 1000000007, 109960323))]).
substitution(137, ['B' = 570934173696, 'E' = 8, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 934298300416, 'Half' = 4]).
proof(137, mod_pow(570934173696, 8, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(8 > 1), builtin(0 is 8 rem 2), builtin(0 = 0), uses(120, mod_mul(570934173696, 570934173696, 1000000000000, 934298300416)), builtin(4 is 8 // 2), uses(135, mod_pow(934298300416, 4, 1000000000000, 940335579136))]).
substitution(138, ['A' = 34741584, 'B' = 34741584, 'M' = 1000000007, 'R' = 650380217]).
proof(138, mod_mul(34741584, 34741584, 1000000007, 650380217), rule(1), [builtin(650380217 is 34741584 * 34741584 rem 1000000007)]).
substitution(139, ['B' = 905719156736, 'E' = 16, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 570934173696, 'Half' = 8]).
proof(139, mod_pow(905719156736, 16, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(16 > 1), builtin(0 is 16 rem 2), builtin(0 = 0), uses(115, mod_mul(905719156736, 905719156736, 1000000000000, 570934173696)), builtin(8 is 16 // 2), uses(137, mod_pow(570934173696, 8, 1000000000000, 940335579136))]).
substitution(140, ['A' = 586791717, 'B' = 109960323, 'M' = 1000000007, 'R' = 283377949]).
proof(140, mod_mul(586791717, 109960323, 1000000007, 283377949), rule(1), [builtin(283377949 is 586791717 * 109960323 rem 1000000007)]).
substitution(141, ['B' = 633712377856, 'E' = 32, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 905719156736, 'Half' = 16]).
proof(141, mod_pow(633712377856, 32, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(32 > 1), builtin(0 is 32 rem 2), builtin(0 = 0), uses(111, mod_mul(633712377856, 633712377856, 1000000000000, 905719156736)), builtin(16 is 32 // 2), uses(139, mod_pow(905719156736, 16, 1000000000000, 940335579136))]).
substitution(142, ['B' = 586791717, 'E' = 953, 'M' = 1000000007, 'R' = 283377949, 'Parity' = 1, 'Squared' = 729536477, 'Half' = 476, 'Tail' = 109960323]).
proof(142, mod_pow(586791717, 953, 1000000007, 283377949), rule(5), [builtin(1000000007 > 0), builtin(953 > 1), builtin(1 is 953 rem 2), builtin(1 = 1), uses(83, mod_mul(586791717, 586791717, 1000000007, 729536477)), builtin(476 is (953 - 1) // 2), uses(136, mod_pow(729536477, 476, 1000000007, 109960323)), uses(140, mod_mul(586791717, 109960323, 1000000007, 283377949))]).
substitution(143, ['B' = 669964066816, 'E' = 64, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 633712377856, 'Half' = 32]).
proof(143, mod_pow(669964066816, 64, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(64 > 1), builtin(0 is 64 rem 2), builtin(0 = 0), uses(108, mod_mul(669964066816, 669964066816, 1000000000000, 633712377856)), builtin(32 is 64 // 2), uses(141, mod_pow(633712377856, 32, 1000000000000, 940335579136))]).
substitution(144, ['A' = 650380217, 'B' = 650380217, 'M' = 1000000007, 'R' = 704006128]).
proof(144, mod_mul(650380217, 650380217, 1000000007, 704006128), rule(1), [builtin(704006128 is 650380217 * 650380217 rem 1000000007)]).
substitution(145, ['B' = 475715792896, 'E' = 128, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 669964066816, 'Half' = 64]).
proof(145, mod_pow(475715792896, 128, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(128 > 1), builtin(0 is 128 rem 2), builtin(0 = 0), uses(105, mod_mul(475715792896, 475715792896, 1000000000000, 669964066816)), builtin(64 is 128 // 2), uses(143, mod_pow(669964066816, 64, 1000000000000, 940335579136))]).
substitution(146, ['A' = 817796215, 'B' = 283377949, 'M' = 1000000007, 'R' = 484445151]).
proof(146, mod_mul(817796215, 283377949, 1000000007, 484445151), rule(1), [builtin(484445151 is 817796215 * 283377949 rem 1000000007)]).
substitution(147, ['B' = 403154190336, 'E' = 256, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 475715792896, 'Half' = 128]).
proof(147, mod_pow(403154190336, 256, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(256 > 1), builtin(0 is 256 rem 2), builtin(0 = 0), uses(102, mod_mul(403154190336, 403154190336, 1000000000000, 475715792896)), builtin(128 is 256 // 2), uses(145, mod_pow(475715792896, 128, 1000000000000, 940335579136))]).
substitution(148, ['B' = 817796215, 'E' = 1907, 'M' = 1000000007, 'R' = 484445151, 'Parity' = 1, 'Squared' = 586791717, 'Half' = 953, 'Tail' = 283377949]).
proof(148, mod_pow(817796215, 1907, 1000000007, 484445151), rule(5), [builtin(1000000007 > 0), builtin(1907 > 1), builtin(1 is 1907 rem 2), builtin(1 = 1), uses(80, mod_mul(817796215, 817796215, 1000000007, 586791717)), builtin(953 is (1907 - 1) // 2), uses(142, mod_pow(586791717, 953, 1000000007, 283377949)), uses(146, mod_mul(817796215, 283377949, 1000000007, 484445151))]).
substitution(149, ['B' = 59596230656, 'E' = 512, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 403154190336, 'Half' = 256]).
proof(149, mod_pow(59596230656, 512, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(512 > 1), builtin(0 is 512 rem 2), builtin(0 = 0), uses(99, mod_mul(59596230656, 59596230656, 1000000000000, 403154190336)), builtin(256 is 512 // 2), uses(147, mod_pow(403154190336, 256, 1000000000000, 940335579136))]).
substitution(150, ['A' = 704006128, 'B' = 704006128, 'M' = 1000000007, 'R' = 792180016]).
proof(150, mod_mul(704006128, 704006128, 1000000007, 792180016), rule(1), [builtin(792180016 is 704006128 * 704006128 rem 1000000007)]).
substitution(151, ['B' = 877835659, 'E' = 3814, 'M' = 1000000007, 'R' = 484445151, 'Parity' = 0, 'Squared' = 817796215, 'Half' = 1907]).
proof(151, mod_pow(877835659, 3814, 1000000007, 484445151), rule(4), [builtin(1000000007 > 0), builtin(3814 > 1), builtin(0 is 3814 rem 2), builtin(0 = 0), uses(77, mod_mul(877835659, 877835659, 1000000007, 817796215)), builtin(1907 is 3814 // 2), uses(148, mod_pow(817796215, 1907, 1000000007, 484445151))]).
substitution(152, ['B' = 624224137216, 'E' = 1024, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 59596230656, 'Half' = 512]).
proof(152, mod_pow(624224137216, 1024, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(1024 > 1), builtin(0 is 1024 rem 2), builtin(0 = 0), uses(96, mod_mul(624224137216, 624224137216, 1000000000000, 59596230656)), builtin(512 is 1024 // 2), uses(149, mod_pow(59596230656, 512, 1000000000000, 940335579136))]).
substitution(153, ['B' = 649006084096, 'E' = 2048, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 624224137216, 'Half' = 1024]).
proof(153, mod_pow(649006084096, 2048, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(2048 > 1), builtin(0 is 2048 rem 2), builtin(0 = 0), uses(93, mod_mul(649006084096, 649006084096, 1000000000000, 624224137216)), builtin(1024 is 2048 // 2), uses(152, mod_pow(624224137216, 1024, 1000000000000, 940335579136))]).
substitution(154, ['A' = 571610964, 'B' = 484445151, 'M' = 1000000007, 'R' = 829836465]).
proof(154, mod_mul(571610964, 484445151, 1000000007, 829836465), rule(1), [builtin(829836465 is 571610964 * 484445151 rem 1000000007)]).
substitution(155, ['B' = 913129639936, 'E' = 4096, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 649006084096, 'Half' = 2048]).
proof(155, mod_pow(913129639936, 4096, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(4096 > 1), builtin(0 is 4096 rem 2), builtin(0 = 0), uses(90, mod_mul(913129639936, 913129639936, 1000000000000, 649006084096)), builtin(2048 is 4096 // 2), uses(153, mod_pow(649006084096, 2048, 1000000000000, 940335579136))]).
substitution(156, ['A' = 792180016, 'B' = 792180016, 'M' = 1000000007, 'R' = 356916045]).
proof(156, mod_mul(792180016, 792180016, 1000000007, 356916045), rule(1), [builtin(356916045 is 792180016 * 792180016 rem 1000000007)]).
substitution(157, ['B' = 571610964, 'E' = 7629, 'M' = 1000000007, 'R' = 829836465, 'Parity' = 1, 'Squared' = 877835659, 'Half' = 3814, 'Tail' = 484445151]).
proof(157, mod_pow(571610964, 7629, 1000000007, 829836465), rule(5), [builtin(1000000007 > 0), builtin(7629 > 1), builtin(1 is 7629 rem 2), builtin(1 = 1), uses(74, mod_mul(571610964, 571610964, 1000000007, 877835659)), builtin(3814 is (7629 - 1) // 2), uses(151, mod_pow(877835659, 3814, 1000000007, 484445151)), uses(154, mod_mul(571610964, 484445151, 1000000007, 829836465))]).
substitution(158, ['B' = 431768211456, 'E' = 8192, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 913129639936, 'Half' = 4096]).
proof(158, mod_pow(431768211456, 8192, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(8192 > 1), builtin(0 is 8192 rem 2), builtin(0 = 0), uses(87, mod_mul(431768211456, 431768211456, 1000000000000, 913129639936)), builtin(4096 is 8192 // 2), uses(155, mod_pow(913129639936, 4096, 1000000000000, 940335579136))]).
substitution(159, ['B' = 442193340, 'E' = 15258, 'M' = 1000000007, 'R' = 829836465, 'Parity' = 0, 'Squared' = 571610964, 'Half' = 7629]).
proof(159, mod_pow(442193340, 15258, 1000000007, 829836465), rule(4), [builtin(1000000007 > 0), builtin(15258 > 1), builtin(0 is 15258 rem 2), builtin(0 = 0), uses(71, mod_mul(442193340, 442193340, 1000000007, 571610964)), builtin(7629 is 15258 // 2), uses(157, mod_pow(571610964, 7629, 1000000007, 829836465))]).
substitution(160, ['B' = 73709551616, 'E' = 16384, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 431768211456, 'Half' = 8192]).
proof(160, mod_pow(73709551616, 16384, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(16384 > 1), builtin(0 is 16384 rem 2), builtin(0 = 0), uses(84, mod_mul(73709551616, 73709551616, 1000000000000, 431768211456)), builtin(8192 is 16384 // 2), uses(158, mod_pow(431768211456, 8192, 1000000000000, 940335579136))]).
substitution(161, ['B' = 4294967296, 'E' = 32768, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 73709551616, 'Half' = 16384]).
proof(161, mod_pow(4294967296, 32768, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(32768 > 1), builtin(0 is 32768 rem 2), builtin(0 = 0), uses(81, mod_mul(4294967296, 4294967296, 1000000000000, 73709551616)), builtin(16384 is 32768 // 2), uses(160, mod_pow(73709551616, 16384, 1000000000000, 940335579136))]).
substitution(162, ['A' = 356916045, 'B' = 356916045, 'M' = 1000000007, 'R' = 286718591]).
proof(162, mod_mul(356916045, 356916045, 1000000007, 286718591), rule(1), [builtin(286718591 is 356916045 * 356916045 rem 1000000007)]).
substitution(163, ['A' = 14134088, 'B' = 829836465, 'M' = 1000000007, 'R' = 539816053]).
proof(163, mod_mul(14134088, 829836465, 1000000007, 539816053), rule(1), [builtin(539816053 is 14134088 * 829836465 rem 1000000007)]).
substitution(164, ['B' = 65536, 'E' = 65536, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 4294967296, 'Half' = 32768]).
proof(164, mod_pow(65536, 65536, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(65536 > 1), builtin(0 is 65536 rem 2), builtin(0 = 0), uses(78, mod_mul(65536, 65536, 1000000000000, 4294967296)), builtin(32768 is 65536 // 2), uses(161, mod_pow(4294967296, 32768, 1000000000000, 940335579136))]).
substitution(165, ['B' = 14134088, 'E' = 30517, 'M' = 1000000007, 'R' = 539816053, 'Parity' = 1, 'Squared' = 442193340, 'Half' = 15258, 'Tail' = 829836465]).
proof(165, mod_pow(14134088, 30517, 1000000007, 539816053), rule(5), [builtin(1000000007 > 0), builtin(30517 > 1), builtin(1 is 30517 rem 2), builtin(1 = 1), uses(68, mod_mul(14134088, 14134088, 1000000007, 442193340)), builtin(15258 is (30517 - 1) // 2), uses(159, mod_pow(442193340, 15258, 1000000007, 829836465)), uses(163, mod_mul(14134088, 829836465, 1000000007, 539816053))]).
substitution(166, ['B' = 256, 'E' = 131072, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 65536, 'Half' = 65536]).
proof(166, mod_pow(256, 131072, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(131072 > 1), builtin(0 is 131072 rem 2), builtin(0 = 0), uses(75, mod_mul(256, 256, 1000000000000, 65536)), builtin(65536 is 131072 // 2), uses(164, mod_pow(65536, 65536, 1000000000000, 940335579136))]).
substitution(167, ['B' = 16, 'E' = 262144, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 256, 'Half' = 131072]).
proof(167, mod_pow(16, 262144, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(262144 > 1), builtin(0 is 262144 rem 2), builtin(0 = 0), uses(72, mod_mul(16, 16, 1000000000000, 256)), builtin(131072 is 262144 // 2), uses(166, mod_pow(256, 131072, 1000000000000, 940335579136))]).
substitution(168, ['A' = 286718591, 'B' = 286718591, 'M' = 1000000007, 'R' = 849572438]).
proof(168, mod_mul(286718591, 286718591, 1000000007, 849572438), rule(1), [builtin(849572438 is 286718591 * 286718591 rem 1000000007)]).
substitution(169, ['A' = 457951439, 'B' = 539816053, 'M' = 1000000007, 'R' = 536183515]).
proof(169, mod_mul(457951439, 539816053, 1000000007, 536183515), rule(1), [builtin(536183515 is 457951439 * 539816053 rem 1000000007)]).
substitution(170, ['B' = 4, 'E' = 524288, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 16, 'Half' = 262144]).
proof(170, mod_pow(4, 524288, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(524288 > 1), builtin(0 is 524288 rem 2), builtin(0 = 0), uses(69, mod_mul(4, 4, 1000000000000, 16)), builtin(262144 is 524288 // 2), uses(167, mod_pow(16, 262144, 1000000000000, 940335579136))]).
substitution(171, ['B' = 457951439, 'E' = 61035, 'M' = 1000000007, 'R' = 536183515, 'Parity' = 1, 'Squared' = 14134088, 'Half' = 30517, 'Tail' = 539816053]).
proof(171, mod_pow(457951439, 61035, 1000000007, 536183515), rule(5), [builtin(1000000007 > 0), builtin(61035 > 1), builtin(1 is 61035 rem 2), builtin(1 = 1), uses(63, mod_mul(457951439, 457951439, 1000000007, 14134088)), builtin(30517 is (61035 - 1) // 2), uses(165, mod_pow(14134088, 30517, 1000000007, 539816053)), uses(169, mod_mul(457951439, 539816053, 1000000007, 536183515))]).
substitution(172, ['B' = 2, 'E' = 1048576, 'M' = 1000000000000, 'R' = 940335579136, 'Parity' = 0, 'Squared' = 4, 'Half' = 524288]).
proof(172, mod_pow(2, 1048576, 1000000000000, 940335579136), rule(4), [builtin(1000000000000 > 0), builtin(1048576 > 1), builtin(0 is 1048576 rem 2), builtin(0 = 0), uses(64, mod_mul(2, 2, 1000000000000, 4)), builtin(524288 is 1048576 // 2), uses(170, mod_pow(4, 524288, 1000000000000, 940335579136))]).
substitution(173, ['B' = 849572438, 'M' = 1000000007, 'R' = 849572438]).
proof(173, mod_pow(849572438, 1, 1000000007, 849572438), rule(3), [builtin(1000000007 > 0), builtin(849572438 is 849572438 rem 1000000007)]).
substitution(174, ['B' = 161968289, 'E' = 122070, 'M' = 1000000007, 'R' = 536183515, 'Parity' = 0, 'Squared' = 457951439, 'Half' = 61035]).
proof(174, mod_pow(161968289, 122070, 1000000007, 536183515), rule(4), [builtin(1000000007 > 0), builtin(122070 > 1), builtin(0 is 122070 rem 2), builtin(0 = 0), uses(59, mod_mul(161968289, 161968289, 1000000007, 457951439)), builtin(61035 is 122070 // 2), uses(171, mod_pow(457951439, 61035, 1000000007, 536183515))]).
substitution(175, ['Value' = 940335579136, 'Exponent' = 1048576]).
proof(175, large_case(last_12_digits, 940335579136), rule(11), [uses(60, power(2, 20, 1048576)), uses(172, mod_pow(2, 1048576, 1000000000000, 940335579136))]).
substitution(176, ['B' = 286718591, 'E' = 2, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 849572438, 'Half' = 1]).
proof(176, mod_pow(286718591, 2, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(2 > 1), builtin(0 is 2 rem 2), builtin(0 = 0), uses(168, mod_mul(286718591, 286718591, 1000000007, 849572438)), builtin(1 is 2 // 2), uses(173, mod_pow(849572438, 1, 1000000007, 849572438))]).
substitution(177, ['B' = 75093816, 'E' = 244140, 'M' = 1000000007, 'R' = 536183515, 'Parity' = 0, 'Squared' = 161968289, 'Half' = 122070]).
proof(177, mod_pow(75093816, 244140, 1000000007, 536183515), rule(4), [builtin(1000000007 > 0), builtin(244140 > 1), builtin(0 is 244140 rem 2), builtin(0 = 0), uses(55, mod_mul(75093816, 75093816, 1000000007, 161968289)), builtin(122070 is 244140 // 2), uses(174, mod_pow(161968289, 122070, 1000000007, 536183515))]).
substitution(178, ['Case' = last_12_digits, 'Value' = 940335579136]).
proof(178, solution([last_12_digits, 940335579136]), query, [uses(175, large_case(last_12_digits, 940335579136))]).
substitution(179, ['B' = 356916045, 'E' = 4, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 286718591, 'Half' = 2]).
proof(179, mod_pow(356916045, 4, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(4 > 1), builtin(0 is 4 rem 2), builtin(0 = 0), uses(162, mod_mul(356916045, 356916045, 1000000007, 286718591)), builtin(2 is 4 // 2), uses(176, mod_pow(286718591, 2, 1000000007, 849572438))]).
substitution(180, ['B' = 792180016, 'E' = 8, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 356916045, 'Half' = 4]).
proof(180, mod_pow(792180016, 8, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(8 > 1), builtin(0 is 8 rem 2), builtin(0 = 0), uses(156, mod_mul(792180016, 792180016, 1000000007, 356916045)), builtin(4 is 8 // 2), uses(179, mod_pow(356916045, 4, 1000000007, 849572438))]).
substitution(181, ['A' = 964640085, 'B' = 536183515, 'M' = 1000000007, 'R' = 864630026]).
proof(181, mod_mul(964640085, 536183515, 1000000007, 864630026), rule(1), [builtin(864630026 is 964640085 * 536183515 rem 1000000007)]).
substitution(182, ['B' = 704006128, 'E' = 16, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 792180016, 'Half' = 8]).
proof(182, mod_pow(704006128, 16, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(16 > 1), builtin(0 is 16 rem 2), builtin(0 = 0), uses(150, mod_mul(704006128, 704006128, 1000000007, 792180016)), builtin(8 is 16 // 2), uses(180, mod_pow(792180016, 8, 1000000007, 849572438))]).
substitution(183, ['B' = 964640085, 'E' = 488281, 'M' = 1000000007, 'R' = 864630026, 'Parity' = 1, 'Squared' = 75093816, 'Half' = 244140, 'Tail' = 536183515]).
proof(183, mod_pow(964640085, 488281, 1000000007, 864630026), rule(5), [builtin(1000000007 > 0), builtin(488281 > 1), builtin(1 is 488281 rem 2), builtin(1 = 1), uses(51, mod_mul(964640085, 964640085, 1000000007, 75093816)), builtin(244140 is (488281 - 1) // 2), uses(177, mod_pow(75093816, 244140, 1000000007, 536183515)), uses(181, mod_mul(964640085, 536183515, 1000000007, 864630026))]).
substitution(184, ['B' = 650380217, 'E' = 32, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 704006128, 'Half' = 16]).
proof(184, mod_pow(650380217, 32, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(32 > 1), builtin(0 is 32 rem 2), builtin(0 = 0), uses(144, mod_mul(650380217, 650380217, 1000000007, 704006128)), builtin(16 is 32 // 2), uses(182, mod_pow(704006128, 16, 1000000007, 849572438))]).
substitution(185, ['B' = 186931595, 'E' = 976562, 'M' = 1000000007, 'R' = 864630026, 'Parity' = 0, 'Squared' = 964640085, 'Half' = 488281]).
proof(185, mod_pow(186931595, 976562, 1000000007, 864630026), rule(4), [builtin(1000000007 > 0), builtin(976562 > 1), builtin(0 is 976562 rem 2), builtin(0 = 0), uses(47, mod_mul(186931595, 186931595, 1000000007, 964640085)), builtin(488281 is 976562 // 2), uses(183, mod_pow(964640085, 488281, 1000000007, 864630026))]).
substitution(186, ['B' = 34741584, 'E' = 64, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 650380217, 'Half' = 32]).
proof(186, mod_pow(34741584, 64, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(64 > 1), builtin(0 is 64 rem 2), builtin(0 = 0), uses(138, mod_mul(34741584, 34741584, 1000000007, 650380217)), builtin(32 is 64 // 2), uses(184, mod_pow(650380217, 32, 1000000007, 849572438))]).
substitution(187, ['B' = 73842644, 'E' = 128, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 34741584, 'Half' = 64]).
proof(187, mod_pow(73842644, 128, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(128 > 1), builtin(0 is 128 rem 2), builtin(0 = 0), uses(131, mod_mul(73842644, 73842644, 1000000007, 34741584)), builtin(64 is 128 // 2), uses(186, mod_pow(34741584, 64, 1000000007, 849572438))]).
substitution(188, ['A' = 301741558, 'B' = 864630026, 'M' = 1000000007, 'R' = 312556845]).
proof(188, mod_mul(301741558, 864630026, 1000000007, 312556845), rule(1), [builtin(312556845 is 301741558 * 864630026 rem 1000000007)]).
substitution(189, ['B' = 458234230, 'E' = 256, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 73842644, 'Half' = 128]).
proof(189, mod_pow(458234230, 256, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(256 > 1), builtin(0 is 256 rem 2), builtin(0 = 0), uses(126, mod_mul(458234230, 458234230, 1000000007, 73842644)), builtin(128 is 256 // 2), uses(187, mod_pow(73842644, 128, 1000000007, 849572438))]).
substitution(190, ['B' = 301741558, 'E' = 1953125, 'M' = 1000000007, 'R' = 312556845, 'Parity' = 1, 'Squared' = 186931595, 'Half' = 976562, 'Tail' = 864630026]).
proof(190, mod_pow(301741558, 1953125, 1000000007, 312556845), rule(5), [builtin(1000000007 > 0), builtin(1953125 > 1), builtin(1 is 1953125 rem 2), builtin(1 = 1), uses(43, mod_mul(301741558, 301741558, 1000000007, 186931595)), builtin(976562 is (1953125 - 1) // 2), uses(185, mod_pow(186931595, 976562, 1000000007, 864630026)), uses(188, mod_mul(301741558, 864630026, 1000000007, 312556845))]).
substitution(191, ['B' = 584809521, 'E' = 512, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 458234230, 'Half' = 256]).
proof(191, mod_pow(584809521, 512, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(512 > 1), builtin(0 is 512 rem 2), builtin(0 = 0), uses(122, mod_mul(584809521, 584809521, 1000000007, 458234230)), builtin(256 is 512 // 2), uses(189, mod_pow(458234230, 256, 1000000007, 849572438))]).
substitution(192, ['B' = 699853951, 'E' = 3906250, 'M' = 1000000007, 'R' = 312556845, 'Parity' = 0, 'Squared' = 301741558, 'Half' = 1953125]).
proof(192, mod_pow(699853951, 3906250, 1000000007, 312556845), rule(4), [builtin(1000000007 > 0), builtin(3906250 > 1), builtin(0 is 3906250 rem 2), builtin(0 = 0), uses(39, mod_mul(699853951, 699853951, 1000000007, 301741558)), builtin(1953125 is 3906250 // 2), uses(190, mod_pow(301741558, 1953125, 1000000007, 312556845))]).
substitution(193, ['B' = 164194107, 'E' = 1024, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 584809521, 'Half' = 512]).
proof(193, mod_pow(164194107, 1024, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(1024 > 1), builtin(0 is 1024 rem 2), builtin(0 = 0), uses(118, mod_mul(164194107, 164194107, 1000000007, 584809521)), builtin(512 is 1024 // 2), uses(191, mod_pow(584809521, 512, 1000000007, 849572438))]).
substitution(194, ['B' = 692745742, 'E' = 7812500, 'M' = 1000000007, 'R' = 312556845, 'Parity' = 0, 'Squared' = 699853951, 'Half' = 3906250]).
proof(194, mod_pow(692745742, 7812500, 1000000007, 312556845), rule(4), [builtin(1000000007 > 0), builtin(7812500 > 1), builtin(0 is 7812500 rem 2), builtin(0 = 0), uses(35, mod_mul(692745742, 692745742, 1000000007, 699853951)), builtin(3906250 is 7812500 // 2), uses(192, mod_pow(699853951, 3906250, 1000000007, 312556845))]).
substitution(195, ['B' = 114646353, 'E' = 2048, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 164194107, 'Half' = 1024]).
proof(195, mod_pow(114646353, 2048, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(2048 > 1), builtin(0 is 2048 rem 2), builtin(0 = 0), uses(114, mod_mul(114646353, 114646353, 1000000007, 164194107)), builtin(1024 is 2048 // 2), uses(193, mod_pow(164194107, 1024, 1000000007, 849572438))]).
substitution(196, ['B' = 23859541, 'E' = 15625000, 'M' = 1000000007, 'R' = 312556845, 'Parity' = 0, 'Squared' = 692745742, 'Half' = 7812500]).
proof(196, mod_pow(23859541, 15625000, 1000000007, 312556845), rule(4), [builtin(1000000007 > 0), builtin(15625000 > 1), builtin(0 is 15625000 rem 2), builtin(0 = 0), uses(32, mod_mul(23859541, 23859541, 1000000007, 692745742)), builtin(7812500 is 15625000 // 2), uses(194, mod_pow(692745742, 7812500, 1000000007, 312556845))]).
substitution(197, ['B' = 58524731, 'E' = 4096, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 114646353, 'Half' = 2048]).
proof(197, mod_pow(58524731, 4096, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(4096 > 1), builtin(0 is 4096 rem 2), builtin(0 = 0), uses(110, mod_mul(58524731, 58524731, 1000000007, 114646353)), builtin(2048 is 4096 // 2), uses(195, mod_pow(114646353, 2048, 1000000007, 849572438))]).
substitution(198, ['B' = 714810341, 'E' = 31250000, 'M' = 1000000007, 'R' = 312556845, 'Parity' = 0, 'Squared' = 23859541, 'Half' = 15625000]).
proof(198, mod_pow(714810341, 31250000, 1000000007, 312556845), rule(4), [builtin(1000000007 > 0), builtin(31250000 > 1), builtin(0 is 31250000 rem 2), builtin(0 = 0), uses(31, mod_mul(714810341, 714810341, 1000000007, 23859541)), builtin(15625000 is 31250000 // 2), uses(196, mod_pow(23859541, 15625000, 1000000007, 312556845))]).
substitution(199, ['B' = 451694074, 'E' = 8192, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 58524731, 'Half' = 4096]).
proof(199, mod_pow(451694074, 8192, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(8192 > 1), builtin(0 is 8192 rem 2), builtin(0 = 0), uses(106, mod_mul(451694074, 451694074, 1000000007, 58524731)), builtin(4096 is 8192 // 2), uses(197, mod_pow(58524731, 4096, 1000000007, 849572438))]).
substitution(200, ['B' = 930336977, 'E' = 62500000, 'M' = 1000000007, 'R' = 312556845, 'Parity' = 0, 'Squared' = 714810341, 'Half' = 31250000]).
proof(200, mod_pow(930336977, 62500000, 1000000007, 312556845), rule(4), [builtin(1000000007 > 0), builtin(62500000 > 1), builtin(0 is 62500000 rem 2), builtin(0 = 0), uses(30, mod_mul(930336977, 930336977, 1000000007, 714810341)), builtin(31250000 is 62500000 // 2), uses(198, mod_pow(714810341, 31250000, 1000000007, 312556845))]).
substitution(201, ['B' = 214554799, 'E' = 16384, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 451694074, 'Half' = 8192]).
proof(201, mod_pow(214554799, 16384, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(16384 > 1), builtin(0 is 16384 rem 2), builtin(0 = 0), uses(103, mod_mul(214554799, 214554799, 1000000007, 451694074)), builtin(8192 is 16384 // 2), uses(199, mod_pow(451694074, 8192, 1000000007, 849572438))]).
substitution(202, ['B' = 5764801, 'E' = 125000000, 'M' = 1000000007, 'R' = 312556845, 'Parity' = 0, 'Squared' = 930336977, 'Half' = 62500000]).
proof(202, mod_pow(5764801, 125000000, 1000000007, 312556845), rule(4), [builtin(1000000007 > 0), builtin(125000000 > 1), builtin(0 is 125000000 rem 2), builtin(0 = 0), uses(29, mod_mul(5764801, 5764801, 1000000007, 930336977)), builtin(62500000 is 125000000 // 2), uses(200, mod_pow(930336977, 62500000, 1000000007, 312556845))]).
substitution(203, ['B' = 763327764, 'E' = 32768, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 214554799, 'Half' = 16384]).
proof(203, mod_pow(763327764, 32768, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(32768 > 1), builtin(0 is 32768 rem 2), builtin(0 = 0), uses(100, mod_mul(763327764, 763327764, 1000000007, 214554799)), builtin(16384 is 32768 // 2), uses(201, mod_pow(214554799, 16384, 1000000007, 849572438))]).
substitution(204, ['B' = 2401, 'E' = 250000000, 'M' = 1000000007, 'R' = 312556845, 'Parity' = 0, 'Squared' = 5764801, 'Half' = 125000000]).
proof(204, mod_pow(2401, 250000000, 1000000007, 312556845), rule(4), [builtin(1000000007 > 0), builtin(250000000 > 1), builtin(0 is 250000000 rem 2), builtin(0 = 0), uses(28, mod_mul(2401, 2401, 1000000007, 5764801)), builtin(125000000 is 250000000 // 2), uses(202, mod_pow(5764801, 125000000, 1000000007, 312556845))]).
substitution(205, ['B' = 339514974, 'E' = 65536, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 763327764, 'Half' = 32768]).
proof(205, mod_pow(339514974, 65536, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(65536 > 1), builtin(0 is 65536 rem 2), builtin(0 = 0), uses(97, mod_mul(339514974, 339514974, 1000000007, 763327764)), builtin(32768 is 65536 // 2), uses(203, mod_pow(763327764, 32768, 1000000007, 849572438))]).
substitution(206, ['B' = 49, 'E' = 500000000, 'M' = 1000000007, 'R' = 312556845, 'Parity' = 0, 'Squared' = 2401, 'Half' = 250000000]).
proof(206, mod_pow(49, 500000000, 1000000007, 312556845), rule(4), [builtin(1000000007 > 0), builtin(500000000 > 1), builtin(0 is 500000000 rem 2), builtin(0 = 0), uses(27, mod_mul(49, 49, 1000000007, 2401)), builtin(250000000 is 500000000 // 2), uses(204, mod_pow(2401, 250000000, 1000000007, 312556845))]).
substitution(207, ['B' = 272100766, 'E' = 131072, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 339514974, 'Half' = 65536]).
proof(207, mod_pow(272100766, 131072, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(131072 > 1), builtin(0 is 131072 rem 2), builtin(0 = 0), uses(94, mod_mul(272100766, 272100766, 1000000007, 339514974)), builtin(65536 is 131072 // 2), uses(205, mod_pow(339514974, 65536, 1000000007, 849572438))]).
substitution(208, ['B' = 7, 'E' = 1000000000, 'M' = 1000000007, 'R' = 312556845, 'Parity' = 0, 'Squared' = 49, 'Half' = 500000000]).
proof(208, mod_pow(7, 1000000000, 1000000007, 312556845), rule(4), [builtin(1000000007 > 0), builtin(1000000000 > 1), builtin(0 is 1000000000 rem 2), builtin(0 = 0), uses(26, mod_mul(7, 7, 1000000007, 49)), builtin(500000000 is 1000000000 // 2), uses(206, mod_pow(49, 500000000, 1000000007, 312556845))]).
substitution(209, ['B' = 989568599, 'E' = 262144, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 272100766, 'Half' = 131072]).
proof(209, mod_pow(989568599, 262144, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(262144 > 1), builtin(0 is 262144 rem 2), builtin(0 = 0), uses(91, mod_mul(989568599, 989568599, 1000000007, 272100766)), builtin(131072 is 262144 // 2), uses(207, mod_pow(272100766, 131072, 1000000007, 849572438))]).
substitution(210, ['Value' = 312556845]).
proof(210, large_case(seven_power_billion, 312556845), rule(9), [uses(208, mod_pow(7, 1000000000, 1000000007, 312556845))]).
substitution(211, ['B' = 767713261, 'E' = 524288, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 989568599, 'Half' = 262144]).
proof(211, mod_pow(767713261, 524288, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(524288 > 1), builtin(0 is 524288 rem 2), builtin(0 = 0), uses(88, mod_mul(767713261, 767713261, 1000000007, 989568599)), builtin(262144 is 524288 // 2), uses(209, mod_pow(989568599, 262144, 1000000007, 849572438))]).
substitution(212, ['Case' = seven_power_billion, 'Value' = 312556845]).
proof(212, solution([seven_power_billion, 312556845]), query, [uses(210, large_case(seven_power_billion, 312556845))]).
substitution(213, ['B' = 175880701, 'E' = 1048576, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 767713261, 'Half' = 524288]).
proof(213, mod_pow(175880701, 1048576, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(1048576 > 1), builtin(0 is 1048576 rem 2), builtin(0 = 0), uses(85, mod_mul(175880701, 175880701, 1000000007, 767713261)), builtin(524288 is 1048576 // 2), uses(211, mod_pow(767713261, 524288, 1000000007, 849572438))]).
substitution(214, ['B' = 43046721, 'E' = 2097152, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 175880701, 'Half' = 1048576]).
proof(214, mod_pow(43046721, 2097152, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(2097152 > 1), builtin(0 is 2097152 rem 2), builtin(0 = 0), uses(82, mod_mul(43046721, 43046721, 1000000007, 175880701)), builtin(1048576 is 2097152 // 2), uses(213, mod_pow(175880701, 1048576, 1000000007, 849572438))]).
substitution(215, ['B' = 6561, 'E' = 4194304, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 43046721, 'Half' = 2097152]).
proof(215, mod_pow(6561, 4194304, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(4194304 > 1), builtin(0 is 4194304 rem 2), builtin(0 = 0), uses(79, mod_mul(6561, 6561, 1000000007, 43046721)), builtin(2097152 is 4194304 // 2), uses(214, mod_pow(43046721, 2097152, 1000000007, 849572438))]).
substitution(216, ['B' = 81, 'E' = 8388608, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 6561, 'Half' = 4194304]).
proof(216, mod_pow(81, 8388608, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(8388608 > 1), builtin(0 is 8388608 rem 2), builtin(0 = 0), uses(76, mod_mul(81, 81, 1000000007, 6561)), builtin(4194304 is 8388608 // 2), uses(215, mod_pow(6561, 4194304, 1000000007, 849572438))]).
substitution(217, ['B' = 9, 'E' = 16777216, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 81, 'Half' = 8388608]).
proof(217, mod_pow(9, 16777216, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(16777216 > 1), builtin(0 is 16777216 rem 2), builtin(0 = 0), uses(73, mod_mul(9, 9, 1000000007, 81)), builtin(8388608 is 16777216 // 2), uses(216, mod_pow(81, 8388608, 1000000007, 849572438))]).
substitution(218, ['B' = 3, 'E' = 33554432, 'M' = 1000000007, 'R' = 849572438, 'Parity' = 0, 'Squared' = 9, 'Half' = 16777216]).
proof(218, mod_pow(3, 33554432, 1000000007, 849572438), rule(4), [builtin(1000000007 > 0), builtin(33554432 > 1), builtin(0 is 33554432 rem 2), builtin(0 = 0), uses(70, mod_mul(3, 3, 1000000007, 9)), builtin(16777216 is 33554432 // 2), uses(217, mod_pow(9, 16777216, 1000000007, 849572438))]).
substitution(219, ['Value' = 849572438, 'Exponent' = 33554432]).
proof(219, large_case(three_power_two_power_25, 849572438), rule(10), [uses(67, power(2, 25, 33554432)), uses(218, mod_pow(3, 33554432, 1000000007, 849572438))]).
substitution(220, ['Case' = three_power_two_power_25, 'Value' = 849572438]).
proof(220, solution([three_power_two_power_25, 849572438]), query, [uses(219, large_case(three_power_two_power_25, 849572438))]).
