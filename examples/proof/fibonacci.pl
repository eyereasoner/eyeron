% Prolog result format 3
query(1, fib(100, _0), ['Value' = _0]).
result(1, complete, 1).
answer(1, ['Value' = 354224848179261915075]).
why(1, ['Value' = 354224848179261915075], 102).
clause(1, fib(0, 0), true).
clause(2, fib(1, 1), true).
clause(3, fib(var('N'), var('F')), (var('N') > 1, var('Previous') is var('N') - 1, var('Earlier') is var('N') - 2, fib(var('Previous'), var('A')), fib(var('Earlier'), var('B')), var('F') is var('A') + var('B'))).
substitution(1, []).
proof(1, fib(1, 1), rule(2), []).
substitution(2, []).
proof(2, fib(0, 0), rule(1), []).
substitution(3, ['N' = 2, 'F' = 1, 'Previous' = 1, 'Earlier' = 0, 'A' = 1, 'B' = 0]).
proof(3, fib(2, 1), rule(3), [builtin(2 > 1), builtin(1 is 2 - 1), builtin(0 is 2 - 2), uses(1, fib(1, 1)), uses(2, fib(0, 0)), builtin(1 is 1 + 0)]).
substitution(4, ['N' = 3, 'F' = 2, 'Previous' = 2, 'Earlier' = 1, 'A' = 1, 'B' = 1]).
proof(4, fib(3, 2), rule(3), [builtin(3 > 1), builtin(2 is 3 - 1), builtin(1 is 3 - 2), uses(3, fib(2, 1)), uses(1, fib(1, 1)), builtin(2 is 1 + 1)]).
substitution(5, ['N' = 4, 'F' = 3, 'Previous' = 3, 'Earlier' = 2, 'A' = 2, 'B' = 1]).
proof(5, fib(4, 3), rule(3), [builtin(4 > 1), builtin(3 is 4 - 1), builtin(2 is 4 - 2), uses(4, fib(3, 2)), uses(3, fib(2, 1)), builtin(3 is 2 + 1)]).
substitution(6, ['N' = 5, 'F' = 5, 'Previous' = 4, 'Earlier' = 3, 'A' = 3, 'B' = 2]).
proof(6, fib(5, 5), rule(3), [builtin(5 > 1), builtin(4 is 5 - 1), builtin(3 is 5 - 2), uses(5, fib(4, 3)), uses(4, fib(3, 2)), builtin(5 is 3 + 2)]).
substitution(7, ['N' = 6, 'F' = 8, 'Previous' = 5, 'Earlier' = 4, 'A' = 5, 'B' = 3]).
proof(7, fib(6, 8), rule(3), [builtin(6 > 1), builtin(5 is 6 - 1), builtin(4 is 6 - 2), uses(6, fib(5, 5)), uses(5, fib(4, 3)), builtin(8 is 5 + 3)]).
substitution(8, ['N' = 7, 'F' = 13, 'Previous' = 6, 'Earlier' = 5, 'A' = 8, 'B' = 5]).
proof(8, fib(7, 13), rule(3), [builtin(7 > 1), builtin(6 is 7 - 1), builtin(5 is 7 - 2), uses(7, fib(6, 8)), uses(6, fib(5, 5)), builtin(13 is 8 + 5)]).
substitution(9, ['N' = 8, 'F' = 21, 'Previous' = 7, 'Earlier' = 6, 'A' = 13, 'B' = 8]).
proof(9, fib(8, 21), rule(3), [builtin(8 > 1), builtin(7 is 8 - 1), builtin(6 is 8 - 2), uses(8, fib(7, 13)), uses(7, fib(6, 8)), builtin(21 is 13 + 8)]).
substitution(10, ['N' = 9, 'F' = 34, 'Previous' = 8, 'Earlier' = 7, 'A' = 21, 'B' = 13]).
proof(10, fib(9, 34), rule(3), [builtin(9 > 1), builtin(8 is 9 - 1), builtin(7 is 9 - 2), uses(9, fib(8, 21)), uses(8, fib(7, 13)), builtin(34 is 21 + 13)]).
substitution(11, ['N' = 10, 'F' = 55, 'Previous' = 9, 'Earlier' = 8, 'A' = 34, 'B' = 21]).
proof(11, fib(10, 55), rule(3), [builtin(10 > 1), builtin(9 is 10 - 1), builtin(8 is 10 - 2), uses(10, fib(9, 34)), uses(9, fib(8, 21)), builtin(55 is 34 + 21)]).
substitution(12, ['N' = 11, 'F' = 89, 'Previous' = 10, 'Earlier' = 9, 'A' = 55, 'B' = 34]).
proof(12, fib(11, 89), rule(3), [builtin(11 > 1), builtin(10 is 11 - 1), builtin(9 is 11 - 2), uses(11, fib(10, 55)), uses(10, fib(9, 34)), builtin(89 is 55 + 34)]).
substitution(13, ['N' = 12, 'F' = 144, 'Previous' = 11, 'Earlier' = 10, 'A' = 89, 'B' = 55]).
proof(13, fib(12, 144), rule(3), [builtin(12 > 1), builtin(11 is 12 - 1), builtin(10 is 12 - 2), uses(12, fib(11, 89)), uses(11, fib(10, 55)), builtin(144 is 89 + 55)]).
substitution(14, ['N' = 13, 'F' = 233, 'Previous' = 12, 'Earlier' = 11, 'A' = 144, 'B' = 89]).
proof(14, fib(13, 233), rule(3), [builtin(13 > 1), builtin(12 is 13 - 1), builtin(11 is 13 - 2), uses(13, fib(12, 144)), uses(12, fib(11, 89)), builtin(233 is 144 + 89)]).
substitution(15, ['N' = 14, 'F' = 377, 'Previous' = 13, 'Earlier' = 12, 'A' = 233, 'B' = 144]).
proof(15, fib(14, 377), rule(3), [builtin(14 > 1), builtin(13 is 14 - 1), builtin(12 is 14 - 2), uses(14, fib(13, 233)), uses(13, fib(12, 144)), builtin(377 is 233 + 144)]).
substitution(16, ['N' = 15, 'F' = 610, 'Previous' = 14, 'Earlier' = 13, 'A' = 377, 'B' = 233]).
proof(16, fib(15, 610), rule(3), [builtin(15 > 1), builtin(14 is 15 - 1), builtin(13 is 15 - 2), uses(15, fib(14, 377)), uses(14, fib(13, 233)), builtin(610 is 377 + 233)]).
substitution(17, ['N' = 16, 'F' = 987, 'Previous' = 15, 'Earlier' = 14, 'A' = 610, 'B' = 377]).
proof(17, fib(16, 987), rule(3), [builtin(16 > 1), builtin(15 is 16 - 1), builtin(14 is 16 - 2), uses(16, fib(15, 610)), uses(15, fib(14, 377)), builtin(987 is 610 + 377)]).
substitution(18, ['N' = 17, 'F' = 1597, 'Previous' = 16, 'Earlier' = 15, 'A' = 987, 'B' = 610]).
proof(18, fib(17, 1597), rule(3), [builtin(17 > 1), builtin(16 is 17 - 1), builtin(15 is 17 - 2), uses(17, fib(16, 987)), uses(16, fib(15, 610)), builtin(1597 is 987 + 610)]).
substitution(19, ['N' = 18, 'F' = 2584, 'Previous' = 17, 'Earlier' = 16, 'A' = 1597, 'B' = 987]).
proof(19, fib(18, 2584), rule(3), [builtin(18 > 1), builtin(17 is 18 - 1), builtin(16 is 18 - 2), uses(18, fib(17, 1597)), uses(17, fib(16, 987)), builtin(2584 is 1597 + 987)]).
substitution(20, ['N' = 19, 'F' = 4181, 'Previous' = 18, 'Earlier' = 17, 'A' = 2584, 'B' = 1597]).
proof(20, fib(19, 4181), rule(3), [builtin(19 > 1), builtin(18 is 19 - 1), builtin(17 is 19 - 2), uses(19, fib(18, 2584)), uses(18, fib(17, 1597)), builtin(4181 is 2584 + 1597)]).
substitution(21, ['N' = 20, 'F' = 6765, 'Previous' = 19, 'Earlier' = 18, 'A' = 4181, 'B' = 2584]).
proof(21, fib(20, 6765), rule(3), [builtin(20 > 1), builtin(19 is 20 - 1), builtin(18 is 20 - 2), uses(20, fib(19, 4181)), uses(19, fib(18, 2584)), builtin(6765 is 4181 + 2584)]).
substitution(22, ['N' = 21, 'F' = 10946, 'Previous' = 20, 'Earlier' = 19, 'A' = 6765, 'B' = 4181]).
proof(22, fib(21, 10946), rule(3), [builtin(21 > 1), builtin(20 is 21 - 1), builtin(19 is 21 - 2), uses(21, fib(20, 6765)), uses(20, fib(19, 4181)), builtin(10946 is 6765 + 4181)]).
substitution(23, ['N' = 22, 'F' = 17711, 'Previous' = 21, 'Earlier' = 20, 'A' = 10946, 'B' = 6765]).
proof(23, fib(22, 17711), rule(3), [builtin(22 > 1), builtin(21 is 22 - 1), builtin(20 is 22 - 2), uses(22, fib(21, 10946)), uses(21, fib(20, 6765)), builtin(17711 is 10946 + 6765)]).
substitution(24, ['N' = 23, 'F' = 28657, 'Previous' = 22, 'Earlier' = 21, 'A' = 17711, 'B' = 10946]).
proof(24, fib(23, 28657), rule(3), [builtin(23 > 1), builtin(22 is 23 - 1), builtin(21 is 23 - 2), uses(23, fib(22, 17711)), uses(22, fib(21, 10946)), builtin(28657 is 17711 + 10946)]).
substitution(25, ['N' = 24, 'F' = 46368, 'Previous' = 23, 'Earlier' = 22, 'A' = 28657, 'B' = 17711]).
proof(25, fib(24, 46368), rule(3), [builtin(24 > 1), builtin(23 is 24 - 1), builtin(22 is 24 - 2), uses(24, fib(23, 28657)), uses(23, fib(22, 17711)), builtin(46368 is 28657 + 17711)]).
substitution(26, ['N' = 25, 'F' = 75025, 'Previous' = 24, 'Earlier' = 23, 'A' = 46368, 'B' = 28657]).
proof(26, fib(25, 75025), rule(3), [builtin(25 > 1), builtin(24 is 25 - 1), builtin(23 is 25 - 2), uses(25, fib(24, 46368)), uses(24, fib(23, 28657)), builtin(75025 is 46368 + 28657)]).
substitution(27, ['N' = 26, 'F' = 121393, 'Previous' = 25, 'Earlier' = 24, 'A' = 75025, 'B' = 46368]).
proof(27, fib(26, 121393), rule(3), [builtin(26 > 1), builtin(25 is 26 - 1), builtin(24 is 26 - 2), uses(26, fib(25, 75025)), uses(25, fib(24, 46368)), builtin(121393 is 75025 + 46368)]).
substitution(28, ['N' = 27, 'F' = 196418, 'Previous' = 26, 'Earlier' = 25, 'A' = 121393, 'B' = 75025]).
proof(28, fib(27, 196418), rule(3), [builtin(27 > 1), builtin(26 is 27 - 1), builtin(25 is 27 - 2), uses(27, fib(26, 121393)), uses(26, fib(25, 75025)), builtin(196418 is 121393 + 75025)]).
substitution(29, ['N' = 28, 'F' = 317811, 'Previous' = 27, 'Earlier' = 26, 'A' = 196418, 'B' = 121393]).
proof(29, fib(28, 317811), rule(3), [builtin(28 > 1), builtin(27 is 28 - 1), builtin(26 is 28 - 2), uses(28, fib(27, 196418)), uses(27, fib(26, 121393)), builtin(317811 is 196418 + 121393)]).
substitution(30, ['N' = 29, 'F' = 514229, 'Previous' = 28, 'Earlier' = 27, 'A' = 317811, 'B' = 196418]).
proof(30, fib(29, 514229), rule(3), [builtin(29 > 1), builtin(28 is 29 - 1), builtin(27 is 29 - 2), uses(29, fib(28, 317811)), uses(28, fib(27, 196418)), builtin(514229 is 317811 + 196418)]).
substitution(31, ['N' = 30, 'F' = 832040, 'Previous' = 29, 'Earlier' = 28, 'A' = 514229, 'B' = 317811]).
proof(31, fib(30, 832040), rule(3), [builtin(30 > 1), builtin(29 is 30 - 1), builtin(28 is 30 - 2), uses(30, fib(29, 514229)), uses(29, fib(28, 317811)), builtin(832040 is 514229 + 317811)]).
substitution(32, ['N' = 31, 'F' = 1346269, 'Previous' = 30, 'Earlier' = 29, 'A' = 832040, 'B' = 514229]).
proof(32, fib(31, 1346269), rule(3), [builtin(31 > 1), builtin(30 is 31 - 1), builtin(29 is 31 - 2), uses(31, fib(30, 832040)), uses(30, fib(29, 514229)), builtin(1346269 is 832040 + 514229)]).
substitution(33, ['N' = 32, 'F' = 2178309, 'Previous' = 31, 'Earlier' = 30, 'A' = 1346269, 'B' = 832040]).
proof(33, fib(32, 2178309), rule(3), [builtin(32 > 1), builtin(31 is 32 - 1), builtin(30 is 32 - 2), uses(32, fib(31, 1346269)), uses(31, fib(30, 832040)), builtin(2178309 is 1346269 + 832040)]).
substitution(34, ['N' = 33, 'F' = 3524578, 'Previous' = 32, 'Earlier' = 31, 'A' = 2178309, 'B' = 1346269]).
proof(34, fib(33, 3524578), rule(3), [builtin(33 > 1), builtin(32 is 33 - 1), builtin(31 is 33 - 2), uses(33, fib(32, 2178309)), uses(32, fib(31, 1346269)), builtin(3524578 is 2178309 + 1346269)]).
substitution(35, ['N' = 34, 'F' = 5702887, 'Previous' = 33, 'Earlier' = 32, 'A' = 3524578, 'B' = 2178309]).
proof(35, fib(34, 5702887), rule(3), [builtin(34 > 1), builtin(33 is 34 - 1), builtin(32 is 34 - 2), uses(34, fib(33, 3524578)), uses(33, fib(32, 2178309)), builtin(5702887 is 3524578 + 2178309)]).
substitution(36, ['N' = 35, 'F' = 9227465, 'Previous' = 34, 'Earlier' = 33, 'A' = 5702887, 'B' = 3524578]).
proof(36, fib(35, 9227465), rule(3), [builtin(35 > 1), builtin(34 is 35 - 1), builtin(33 is 35 - 2), uses(35, fib(34, 5702887)), uses(34, fib(33, 3524578)), builtin(9227465 is 5702887 + 3524578)]).
substitution(37, ['N' = 36, 'F' = 14930352, 'Previous' = 35, 'Earlier' = 34, 'A' = 9227465, 'B' = 5702887]).
proof(37, fib(36, 14930352), rule(3), [builtin(36 > 1), builtin(35 is 36 - 1), builtin(34 is 36 - 2), uses(36, fib(35, 9227465)), uses(35, fib(34, 5702887)), builtin(14930352 is 9227465 + 5702887)]).
substitution(38, ['N' = 37, 'F' = 24157817, 'Previous' = 36, 'Earlier' = 35, 'A' = 14930352, 'B' = 9227465]).
proof(38, fib(37, 24157817), rule(3), [builtin(37 > 1), builtin(36 is 37 - 1), builtin(35 is 37 - 2), uses(37, fib(36, 14930352)), uses(36, fib(35, 9227465)), builtin(24157817 is 14930352 + 9227465)]).
substitution(39, ['N' = 38, 'F' = 39088169, 'Previous' = 37, 'Earlier' = 36, 'A' = 24157817, 'B' = 14930352]).
proof(39, fib(38, 39088169), rule(3), [builtin(38 > 1), builtin(37 is 38 - 1), builtin(36 is 38 - 2), uses(38, fib(37, 24157817)), uses(37, fib(36, 14930352)), builtin(39088169 is 24157817 + 14930352)]).
substitution(40, ['N' = 39, 'F' = 63245986, 'Previous' = 38, 'Earlier' = 37, 'A' = 39088169, 'B' = 24157817]).
proof(40, fib(39, 63245986), rule(3), [builtin(39 > 1), builtin(38 is 39 - 1), builtin(37 is 39 - 2), uses(39, fib(38, 39088169)), uses(38, fib(37, 24157817)), builtin(63245986 is 39088169 + 24157817)]).
substitution(41, ['N' = 40, 'F' = 102334155, 'Previous' = 39, 'Earlier' = 38, 'A' = 63245986, 'B' = 39088169]).
proof(41, fib(40, 102334155), rule(3), [builtin(40 > 1), builtin(39 is 40 - 1), builtin(38 is 40 - 2), uses(40, fib(39, 63245986)), uses(39, fib(38, 39088169)), builtin(102334155 is 63245986 + 39088169)]).
substitution(42, ['N' = 41, 'F' = 165580141, 'Previous' = 40, 'Earlier' = 39, 'A' = 102334155, 'B' = 63245986]).
proof(42, fib(41, 165580141), rule(3), [builtin(41 > 1), builtin(40 is 41 - 1), builtin(39 is 41 - 2), uses(41, fib(40, 102334155)), uses(40, fib(39, 63245986)), builtin(165580141 is 102334155 + 63245986)]).
substitution(43, ['N' = 42, 'F' = 267914296, 'Previous' = 41, 'Earlier' = 40, 'A' = 165580141, 'B' = 102334155]).
proof(43, fib(42, 267914296), rule(3), [builtin(42 > 1), builtin(41 is 42 - 1), builtin(40 is 42 - 2), uses(42, fib(41, 165580141)), uses(41, fib(40, 102334155)), builtin(267914296 is 165580141 + 102334155)]).
substitution(44, ['N' = 43, 'F' = 433494437, 'Previous' = 42, 'Earlier' = 41, 'A' = 267914296, 'B' = 165580141]).
proof(44, fib(43, 433494437), rule(3), [builtin(43 > 1), builtin(42 is 43 - 1), builtin(41 is 43 - 2), uses(43, fib(42, 267914296)), uses(42, fib(41, 165580141)), builtin(433494437 is 267914296 + 165580141)]).
substitution(45, ['N' = 44, 'F' = 701408733, 'Previous' = 43, 'Earlier' = 42, 'A' = 433494437, 'B' = 267914296]).
proof(45, fib(44, 701408733), rule(3), [builtin(44 > 1), builtin(43 is 44 - 1), builtin(42 is 44 - 2), uses(44, fib(43, 433494437)), uses(43, fib(42, 267914296)), builtin(701408733 is 433494437 + 267914296)]).
substitution(46, ['N' = 45, 'F' = 1134903170, 'Previous' = 44, 'Earlier' = 43, 'A' = 701408733, 'B' = 433494437]).
proof(46, fib(45, 1134903170), rule(3), [builtin(45 > 1), builtin(44 is 45 - 1), builtin(43 is 45 - 2), uses(45, fib(44, 701408733)), uses(44, fib(43, 433494437)), builtin(1134903170 is 701408733 + 433494437)]).
substitution(47, ['N' = 46, 'F' = 1836311903, 'Previous' = 45, 'Earlier' = 44, 'A' = 1134903170, 'B' = 701408733]).
proof(47, fib(46, 1836311903), rule(3), [builtin(46 > 1), builtin(45 is 46 - 1), builtin(44 is 46 - 2), uses(46, fib(45, 1134903170)), uses(45, fib(44, 701408733)), builtin(1836311903 is 1134903170 + 701408733)]).
substitution(48, ['N' = 47, 'F' = 2971215073, 'Previous' = 46, 'Earlier' = 45, 'A' = 1836311903, 'B' = 1134903170]).
proof(48, fib(47, 2971215073), rule(3), [builtin(47 > 1), builtin(46 is 47 - 1), builtin(45 is 47 - 2), uses(47, fib(46, 1836311903)), uses(46, fib(45, 1134903170)), builtin(2971215073 is 1836311903 + 1134903170)]).
substitution(49, ['N' = 48, 'F' = 4807526976, 'Previous' = 47, 'Earlier' = 46, 'A' = 2971215073, 'B' = 1836311903]).
proof(49, fib(48, 4807526976), rule(3), [builtin(48 > 1), builtin(47 is 48 - 1), builtin(46 is 48 - 2), uses(48, fib(47, 2971215073)), uses(47, fib(46, 1836311903)), builtin(4807526976 is 2971215073 + 1836311903)]).
substitution(50, ['N' = 49, 'F' = 7778742049, 'Previous' = 48, 'Earlier' = 47, 'A' = 4807526976, 'B' = 2971215073]).
proof(50, fib(49, 7778742049), rule(3), [builtin(49 > 1), builtin(48 is 49 - 1), builtin(47 is 49 - 2), uses(49, fib(48, 4807526976)), uses(48, fib(47, 2971215073)), builtin(7778742049 is 4807526976 + 2971215073)]).
substitution(51, ['N' = 50, 'F' = 12586269025, 'Previous' = 49, 'Earlier' = 48, 'A' = 7778742049, 'B' = 4807526976]).
proof(51, fib(50, 12586269025), rule(3), [builtin(50 > 1), builtin(49 is 50 - 1), builtin(48 is 50 - 2), uses(50, fib(49, 7778742049)), uses(49, fib(48, 4807526976)), builtin(12586269025 is 7778742049 + 4807526976)]).
substitution(52, ['N' = 51, 'F' = 20365011074, 'Previous' = 50, 'Earlier' = 49, 'A' = 12586269025, 'B' = 7778742049]).
proof(52, fib(51, 20365011074), rule(3), [builtin(51 > 1), builtin(50 is 51 - 1), builtin(49 is 51 - 2), uses(51, fib(50, 12586269025)), uses(50, fib(49, 7778742049)), builtin(20365011074 is 12586269025 + 7778742049)]).
substitution(53, ['N' = 52, 'F' = 32951280099, 'Previous' = 51, 'Earlier' = 50, 'A' = 20365011074, 'B' = 12586269025]).
proof(53, fib(52, 32951280099), rule(3), [builtin(52 > 1), builtin(51 is 52 - 1), builtin(50 is 52 - 2), uses(52, fib(51, 20365011074)), uses(51, fib(50, 12586269025)), builtin(32951280099 is 20365011074 + 12586269025)]).
substitution(54, ['N' = 53, 'F' = 53316291173, 'Previous' = 52, 'Earlier' = 51, 'A' = 32951280099, 'B' = 20365011074]).
proof(54, fib(53, 53316291173), rule(3), [builtin(53 > 1), builtin(52 is 53 - 1), builtin(51 is 53 - 2), uses(53, fib(52, 32951280099)), uses(52, fib(51, 20365011074)), builtin(53316291173 is 32951280099 + 20365011074)]).
substitution(55, ['N' = 54, 'F' = 86267571272, 'Previous' = 53, 'Earlier' = 52, 'A' = 53316291173, 'B' = 32951280099]).
proof(55, fib(54, 86267571272), rule(3), [builtin(54 > 1), builtin(53 is 54 - 1), builtin(52 is 54 - 2), uses(54, fib(53, 53316291173)), uses(53, fib(52, 32951280099)), builtin(86267571272 is 53316291173 + 32951280099)]).
substitution(56, ['N' = 55, 'F' = 139583862445, 'Previous' = 54, 'Earlier' = 53, 'A' = 86267571272, 'B' = 53316291173]).
proof(56, fib(55, 139583862445), rule(3), [builtin(55 > 1), builtin(54 is 55 - 1), builtin(53 is 55 - 2), uses(55, fib(54, 86267571272)), uses(54, fib(53, 53316291173)), builtin(139583862445 is 86267571272 + 53316291173)]).
substitution(57, ['N' = 56, 'F' = 225851433717, 'Previous' = 55, 'Earlier' = 54, 'A' = 139583862445, 'B' = 86267571272]).
proof(57, fib(56, 225851433717), rule(3), [builtin(56 > 1), builtin(55 is 56 - 1), builtin(54 is 56 - 2), uses(56, fib(55, 139583862445)), uses(55, fib(54, 86267571272)), builtin(225851433717 is 139583862445 + 86267571272)]).
substitution(58, ['N' = 57, 'F' = 365435296162, 'Previous' = 56, 'Earlier' = 55, 'A' = 225851433717, 'B' = 139583862445]).
proof(58, fib(57, 365435296162), rule(3), [builtin(57 > 1), builtin(56 is 57 - 1), builtin(55 is 57 - 2), uses(57, fib(56, 225851433717)), uses(56, fib(55, 139583862445)), builtin(365435296162 is 225851433717 + 139583862445)]).
substitution(59, ['N' = 58, 'F' = 591286729879, 'Previous' = 57, 'Earlier' = 56, 'A' = 365435296162, 'B' = 225851433717]).
proof(59, fib(58, 591286729879), rule(3), [builtin(58 > 1), builtin(57 is 58 - 1), builtin(56 is 58 - 2), uses(58, fib(57, 365435296162)), uses(57, fib(56, 225851433717)), builtin(591286729879 is 365435296162 + 225851433717)]).
substitution(60, ['N' = 59, 'F' = 956722026041, 'Previous' = 58, 'Earlier' = 57, 'A' = 591286729879, 'B' = 365435296162]).
proof(60, fib(59, 956722026041), rule(3), [builtin(59 > 1), builtin(58 is 59 - 1), builtin(57 is 59 - 2), uses(59, fib(58, 591286729879)), uses(58, fib(57, 365435296162)), builtin(956722026041 is 591286729879 + 365435296162)]).
substitution(61, ['N' = 60, 'F' = 1548008755920, 'Previous' = 59, 'Earlier' = 58, 'A' = 956722026041, 'B' = 591286729879]).
proof(61, fib(60, 1548008755920), rule(3), [builtin(60 > 1), builtin(59 is 60 - 1), builtin(58 is 60 - 2), uses(60, fib(59, 956722026041)), uses(59, fib(58, 591286729879)), builtin(1548008755920 is 956722026041 + 591286729879)]).
substitution(62, ['N' = 61, 'F' = 2504730781961, 'Previous' = 60, 'Earlier' = 59, 'A' = 1548008755920, 'B' = 956722026041]).
proof(62, fib(61, 2504730781961), rule(3), [builtin(61 > 1), builtin(60 is 61 - 1), builtin(59 is 61 - 2), uses(61, fib(60, 1548008755920)), uses(60, fib(59, 956722026041)), builtin(2504730781961 is 1548008755920 + 956722026041)]).
substitution(63, ['N' = 62, 'F' = 4052739537881, 'Previous' = 61, 'Earlier' = 60, 'A' = 2504730781961, 'B' = 1548008755920]).
proof(63, fib(62, 4052739537881), rule(3), [builtin(62 > 1), builtin(61 is 62 - 1), builtin(60 is 62 - 2), uses(62, fib(61, 2504730781961)), uses(61, fib(60, 1548008755920)), builtin(4052739537881 is 2504730781961 + 1548008755920)]).
substitution(64, ['N' = 63, 'F' = 6557470319842, 'Previous' = 62, 'Earlier' = 61, 'A' = 4052739537881, 'B' = 2504730781961]).
proof(64, fib(63, 6557470319842), rule(3), [builtin(63 > 1), builtin(62 is 63 - 1), builtin(61 is 63 - 2), uses(63, fib(62, 4052739537881)), uses(62, fib(61, 2504730781961)), builtin(6557470319842 is 4052739537881 + 2504730781961)]).
substitution(65, ['N' = 64, 'F' = 10610209857723, 'Previous' = 63, 'Earlier' = 62, 'A' = 6557470319842, 'B' = 4052739537881]).
proof(65, fib(64, 10610209857723), rule(3), [builtin(64 > 1), builtin(63 is 64 - 1), builtin(62 is 64 - 2), uses(64, fib(63, 6557470319842)), uses(63, fib(62, 4052739537881)), builtin(10610209857723 is 6557470319842 + 4052739537881)]).
substitution(66, ['N' = 65, 'F' = 17167680177565, 'Previous' = 64, 'Earlier' = 63, 'A' = 10610209857723, 'B' = 6557470319842]).
proof(66, fib(65, 17167680177565), rule(3), [builtin(65 > 1), builtin(64 is 65 - 1), builtin(63 is 65 - 2), uses(65, fib(64, 10610209857723)), uses(64, fib(63, 6557470319842)), builtin(17167680177565 is 10610209857723 + 6557470319842)]).
substitution(67, ['N' = 66, 'F' = 27777890035288, 'Previous' = 65, 'Earlier' = 64, 'A' = 17167680177565, 'B' = 10610209857723]).
proof(67, fib(66, 27777890035288), rule(3), [builtin(66 > 1), builtin(65 is 66 - 1), builtin(64 is 66 - 2), uses(66, fib(65, 17167680177565)), uses(65, fib(64, 10610209857723)), builtin(27777890035288 is 17167680177565 + 10610209857723)]).
substitution(68, ['N' = 67, 'F' = 44945570212853, 'Previous' = 66, 'Earlier' = 65, 'A' = 27777890035288, 'B' = 17167680177565]).
proof(68, fib(67, 44945570212853), rule(3), [builtin(67 > 1), builtin(66 is 67 - 1), builtin(65 is 67 - 2), uses(67, fib(66, 27777890035288)), uses(66, fib(65, 17167680177565)), builtin(44945570212853 is 27777890035288 + 17167680177565)]).
substitution(69, ['N' = 68, 'F' = 72723460248141, 'Previous' = 67, 'Earlier' = 66, 'A' = 44945570212853, 'B' = 27777890035288]).
proof(69, fib(68, 72723460248141), rule(3), [builtin(68 > 1), builtin(67 is 68 - 1), builtin(66 is 68 - 2), uses(68, fib(67, 44945570212853)), uses(67, fib(66, 27777890035288)), builtin(72723460248141 is 44945570212853 + 27777890035288)]).
substitution(70, ['N' = 69, 'F' = 117669030460994, 'Previous' = 68, 'Earlier' = 67, 'A' = 72723460248141, 'B' = 44945570212853]).
proof(70, fib(69, 117669030460994), rule(3), [builtin(69 > 1), builtin(68 is 69 - 1), builtin(67 is 69 - 2), uses(69, fib(68, 72723460248141)), uses(68, fib(67, 44945570212853)), builtin(117669030460994 is 72723460248141 + 44945570212853)]).
substitution(71, ['N' = 70, 'F' = 190392490709135, 'Previous' = 69, 'Earlier' = 68, 'A' = 117669030460994, 'B' = 72723460248141]).
proof(71, fib(70, 190392490709135), rule(3), [builtin(70 > 1), builtin(69 is 70 - 1), builtin(68 is 70 - 2), uses(70, fib(69, 117669030460994)), uses(69, fib(68, 72723460248141)), builtin(190392490709135 is 117669030460994 + 72723460248141)]).
substitution(72, ['N' = 71, 'F' = 308061521170129, 'Previous' = 70, 'Earlier' = 69, 'A' = 190392490709135, 'B' = 117669030460994]).
proof(72, fib(71, 308061521170129), rule(3), [builtin(71 > 1), builtin(70 is 71 - 1), builtin(69 is 71 - 2), uses(71, fib(70, 190392490709135)), uses(70, fib(69, 117669030460994)), builtin(308061521170129 is 190392490709135 + 117669030460994)]).
substitution(73, ['N' = 72, 'F' = 498454011879264, 'Previous' = 71, 'Earlier' = 70, 'A' = 308061521170129, 'B' = 190392490709135]).
proof(73, fib(72, 498454011879264), rule(3), [builtin(72 > 1), builtin(71 is 72 - 1), builtin(70 is 72 - 2), uses(72, fib(71, 308061521170129)), uses(71, fib(70, 190392490709135)), builtin(498454011879264 is 308061521170129 + 190392490709135)]).
substitution(74, ['N' = 73, 'F' = 806515533049393, 'Previous' = 72, 'Earlier' = 71, 'A' = 498454011879264, 'B' = 308061521170129]).
proof(74, fib(73, 806515533049393), rule(3), [builtin(73 > 1), builtin(72 is 73 - 1), builtin(71 is 73 - 2), uses(73, fib(72, 498454011879264)), uses(72, fib(71, 308061521170129)), builtin(806515533049393 is 498454011879264 + 308061521170129)]).
substitution(75, ['N' = 74, 'F' = 1304969544928657, 'Previous' = 73, 'Earlier' = 72, 'A' = 806515533049393, 'B' = 498454011879264]).
proof(75, fib(74, 1304969544928657), rule(3), [builtin(74 > 1), builtin(73 is 74 - 1), builtin(72 is 74 - 2), uses(74, fib(73, 806515533049393)), uses(73, fib(72, 498454011879264)), builtin(1304969544928657 is 806515533049393 + 498454011879264)]).
substitution(76, ['N' = 75, 'F' = 2111485077978050, 'Previous' = 74, 'Earlier' = 73, 'A' = 1304969544928657, 'B' = 806515533049393]).
proof(76, fib(75, 2111485077978050), rule(3), [builtin(75 > 1), builtin(74 is 75 - 1), builtin(73 is 75 - 2), uses(75, fib(74, 1304969544928657)), uses(74, fib(73, 806515533049393)), builtin(2111485077978050 is 1304969544928657 + 806515533049393)]).
substitution(77, ['N' = 76, 'F' = 3416454622906707, 'Previous' = 75, 'Earlier' = 74, 'A' = 2111485077978050, 'B' = 1304969544928657]).
proof(77, fib(76, 3416454622906707), rule(3), [builtin(76 > 1), builtin(75 is 76 - 1), builtin(74 is 76 - 2), uses(76, fib(75, 2111485077978050)), uses(75, fib(74, 1304969544928657)), builtin(3416454622906707 is 2111485077978050 + 1304969544928657)]).
substitution(78, ['N' = 77, 'F' = 5527939700884757, 'Previous' = 76, 'Earlier' = 75, 'A' = 3416454622906707, 'B' = 2111485077978050]).
proof(78, fib(77, 5527939700884757), rule(3), [builtin(77 > 1), builtin(76 is 77 - 1), builtin(75 is 77 - 2), uses(77, fib(76, 3416454622906707)), uses(76, fib(75, 2111485077978050)), builtin(5527939700884757 is 3416454622906707 + 2111485077978050)]).
substitution(79, ['N' = 78, 'F' = 8944394323791464, 'Previous' = 77, 'Earlier' = 76, 'A' = 5527939700884757, 'B' = 3416454622906707]).
proof(79, fib(78, 8944394323791464), rule(3), [builtin(78 > 1), builtin(77 is 78 - 1), builtin(76 is 78 - 2), uses(78, fib(77, 5527939700884757)), uses(77, fib(76, 3416454622906707)), builtin(8944394323791464 is 5527939700884757 + 3416454622906707)]).
substitution(80, ['N' = 79, 'F' = 14472334024676221, 'Previous' = 78, 'Earlier' = 77, 'A' = 8944394323791464, 'B' = 5527939700884757]).
proof(80, fib(79, 14472334024676221), rule(3), [builtin(79 > 1), builtin(78 is 79 - 1), builtin(77 is 79 - 2), uses(79, fib(78, 8944394323791464)), uses(78, fib(77, 5527939700884757)), builtin(14472334024676221 is 8944394323791464 + 5527939700884757)]).
substitution(81, ['N' = 80, 'F' = 23416728348467685, 'Previous' = 79, 'Earlier' = 78, 'A' = 14472334024676221, 'B' = 8944394323791464]).
proof(81, fib(80, 23416728348467685), rule(3), [builtin(80 > 1), builtin(79 is 80 - 1), builtin(78 is 80 - 2), uses(80, fib(79, 14472334024676221)), uses(79, fib(78, 8944394323791464)), builtin(23416728348467685 is 14472334024676221 + 8944394323791464)]).
substitution(82, ['N' = 81, 'F' = 37889062373143906, 'Previous' = 80, 'Earlier' = 79, 'A' = 23416728348467685, 'B' = 14472334024676221]).
proof(82, fib(81, 37889062373143906), rule(3), [builtin(81 > 1), builtin(80 is 81 - 1), builtin(79 is 81 - 2), uses(81, fib(80, 23416728348467685)), uses(80, fib(79, 14472334024676221)), builtin(37889062373143906 is 23416728348467685 + 14472334024676221)]).
substitution(83, ['N' = 82, 'F' = 61305790721611591, 'Previous' = 81, 'Earlier' = 80, 'A' = 37889062373143906, 'B' = 23416728348467685]).
proof(83, fib(82, 61305790721611591), rule(3), [builtin(82 > 1), builtin(81 is 82 - 1), builtin(80 is 82 - 2), uses(82, fib(81, 37889062373143906)), uses(81, fib(80, 23416728348467685)), builtin(61305790721611591 is 37889062373143906 + 23416728348467685)]).
substitution(84, ['N' = 83, 'F' = 99194853094755497, 'Previous' = 82, 'Earlier' = 81, 'A' = 61305790721611591, 'B' = 37889062373143906]).
proof(84, fib(83, 99194853094755497), rule(3), [builtin(83 > 1), builtin(82 is 83 - 1), builtin(81 is 83 - 2), uses(83, fib(82, 61305790721611591)), uses(82, fib(81, 37889062373143906)), builtin(99194853094755497 is 61305790721611591 + 37889062373143906)]).
substitution(85, ['N' = 84, 'F' = 160500643816367088, 'Previous' = 83, 'Earlier' = 82, 'A' = 99194853094755497, 'B' = 61305790721611591]).
proof(85, fib(84, 160500643816367088), rule(3), [builtin(84 > 1), builtin(83 is 84 - 1), builtin(82 is 84 - 2), uses(84, fib(83, 99194853094755497)), uses(83, fib(82, 61305790721611591)), builtin(160500643816367088 is 99194853094755497 + 61305790721611591)]).
substitution(86, ['N' = 85, 'F' = 259695496911122585, 'Previous' = 84, 'Earlier' = 83, 'A' = 160500643816367088, 'B' = 99194853094755497]).
proof(86, fib(85, 259695496911122585), rule(3), [builtin(85 > 1), builtin(84 is 85 - 1), builtin(83 is 85 - 2), uses(85, fib(84, 160500643816367088)), uses(84, fib(83, 99194853094755497)), builtin(259695496911122585 is 160500643816367088 + 99194853094755497)]).
substitution(87, ['N' = 86, 'F' = 420196140727489673, 'Previous' = 85, 'Earlier' = 84, 'A' = 259695496911122585, 'B' = 160500643816367088]).
proof(87, fib(86, 420196140727489673), rule(3), [builtin(86 > 1), builtin(85 is 86 - 1), builtin(84 is 86 - 2), uses(86, fib(85, 259695496911122585)), uses(85, fib(84, 160500643816367088)), builtin(420196140727489673 is 259695496911122585 + 160500643816367088)]).
substitution(88, ['N' = 87, 'F' = 679891637638612258, 'Previous' = 86, 'Earlier' = 85, 'A' = 420196140727489673, 'B' = 259695496911122585]).
proof(88, fib(87, 679891637638612258), rule(3), [builtin(87 > 1), builtin(86 is 87 - 1), builtin(85 is 87 - 2), uses(87, fib(86, 420196140727489673)), uses(86, fib(85, 259695496911122585)), builtin(679891637638612258 is 420196140727489673 + 259695496911122585)]).
substitution(89, ['N' = 88, 'F' = 1100087778366101931, 'Previous' = 87, 'Earlier' = 86, 'A' = 679891637638612258, 'B' = 420196140727489673]).
proof(89, fib(88, 1100087778366101931), rule(3), [builtin(88 > 1), builtin(87 is 88 - 1), builtin(86 is 88 - 2), uses(88, fib(87, 679891637638612258)), uses(87, fib(86, 420196140727489673)), builtin(1100087778366101931 is 679891637638612258 + 420196140727489673)]).
substitution(90, ['N' = 89, 'F' = 1779979416004714189, 'Previous' = 88, 'Earlier' = 87, 'A' = 1100087778366101931, 'B' = 679891637638612258]).
proof(90, fib(89, 1779979416004714189), rule(3), [builtin(89 > 1), builtin(88 is 89 - 1), builtin(87 is 89 - 2), uses(89, fib(88, 1100087778366101931)), uses(88, fib(87, 679891637638612258)), builtin(1779979416004714189 is 1100087778366101931 + 679891637638612258)]).
substitution(91, ['N' = 90, 'F' = 2880067194370816120, 'Previous' = 89, 'Earlier' = 88, 'A' = 1779979416004714189, 'B' = 1100087778366101931]).
proof(91, fib(90, 2880067194370816120), rule(3), [builtin(90 > 1), builtin(89 is 90 - 1), builtin(88 is 90 - 2), uses(90, fib(89, 1779979416004714189)), uses(89, fib(88, 1100087778366101931)), builtin(2880067194370816120 is 1779979416004714189 + 1100087778366101931)]).
substitution(92, ['N' = 91, 'F' = 4660046610375530309, 'Previous' = 90, 'Earlier' = 89, 'A' = 2880067194370816120, 'B' = 1779979416004714189]).
proof(92, fib(91, 4660046610375530309), rule(3), [builtin(91 > 1), builtin(90 is 91 - 1), builtin(89 is 91 - 2), uses(91, fib(90, 2880067194370816120)), uses(90, fib(89, 1779979416004714189)), builtin(4660046610375530309 is 2880067194370816120 + 1779979416004714189)]).
substitution(93, ['N' = 92, 'F' = 7540113804746346429, 'Previous' = 91, 'Earlier' = 90, 'A' = 4660046610375530309, 'B' = 2880067194370816120]).
proof(93, fib(92, 7540113804746346429), rule(3), [builtin(92 > 1), builtin(91 is 92 - 1), builtin(90 is 92 - 2), uses(92, fib(91, 4660046610375530309)), uses(91, fib(90, 2880067194370816120)), builtin(7540113804746346429 is 4660046610375530309 + 2880067194370816120)]).
substitution(94, ['N' = 93, 'F' = 12200160415121876738, 'Previous' = 92, 'Earlier' = 91, 'A' = 7540113804746346429, 'B' = 4660046610375530309]).
proof(94, fib(93, 12200160415121876738), rule(3), [builtin(93 > 1), builtin(92 is 93 - 1), builtin(91 is 93 - 2), uses(93, fib(92, 7540113804746346429)), uses(92, fib(91, 4660046610375530309)), builtin(12200160415121876738 is 7540113804746346429 + 4660046610375530309)]).
substitution(95, ['N' = 94, 'F' = 19740274219868223167, 'Previous' = 93, 'Earlier' = 92, 'A' = 12200160415121876738, 'B' = 7540113804746346429]).
proof(95, fib(94, 19740274219868223167), rule(3), [builtin(94 > 1), builtin(93 is 94 - 1), builtin(92 is 94 - 2), uses(94, fib(93, 12200160415121876738)), uses(93, fib(92, 7540113804746346429)), builtin(19740274219868223167 is 12200160415121876738 + 7540113804746346429)]).
substitution(96, ['N' = 95, 'F' = 31940434634990099905, 'Previous' = 94, 'Earlier' = 93, 'A' = 19740274219868223167, 'B' = 12200160415121876738]).
proof(96, fib(95, 31940434634990099905), rule(3), [builtin(95 > 1), builtin(94 is 95 - 1), builtin(93 is 95 - 2), uses(95, fib(94, 19740274219868223167)), uses(94, fib(93, 12200160415121876738)), builtin(31940434634990099905 is 19740274219868223167 + 12200160415121876738)]).
substitution(97, ['N' = 96, 'F' = 51680708854858323072, 'Previous' = 95, 'Earlier' = 94, 'A' = 31940434634990099905, 'B' = 19740274219868223167]).
proof(97, fib(96, 51680708854858323072), rule(3), [builtin(96 > 1), builtin(95 is 96 - 1), builtin(94 is 96 - 2), uses(96, fib(95, 31940434634990099905)), uses(95, fib(94, 19740274219868223167)), builtin(51680708854858323072 is 31940434634990099905 + 19740274219868223167)]).
substitution(98, ['N' = 97, 'F' = 83621143489848422977, 'Previous' = 96, 'Earlier' = 95, 'A' = 51680708854858323072, 'B' = 31940434634990099905]).
proof(98, fib(97, 83621143489848422977), rule(3), [builtin(97 > 1), builtin(96 is 97 - 1), builtin(95 is 97 - 2), uses(97, fib(96, 51680708854858323072)), uses(96, fib(95, 31940434634990099905)), builtin(83621143489848422977 is 51680708854858323072 + 31940434634990099905)]).
substitution(99, ['N' = 98, 'F' = 135301852344706746049, 'Previous' = 97, 'Earlier' = 96, 'A' = 83621143489848422977, 'B' = 51680708854858323072]).
proof(99, fib(98, 135301852344706746049), rule(3), [builtin(98 > 1), builtin(97 is 98 - 1), builtin(96 is 98 - 2), uses(98, fib(97, 83621143489848422977)), uses(97, fib(96, 51680708854858323072)), builtin(135301852344706746049 is 83621143489848422977 + 51680708854858323072)]).
substitution(100, ['N' = 99, 'F' = 218922995834555169026, 'Previous' = 98, 'Earlier' = 97, 'A' = 135301852344706746049, 'B' = 83621143489848422977]).
proof(100, fib(99, 218922995834555169026), rule(3), [builtin(99 > 1), builtin(98 is 99 - 1), builtin(97 is 99 - 2), uses(99, fib(98, 135301852344706746049)), uses(98, fib(97, 83621143489848422977)), builtin(218922995834555169026 is 135301852344706746049 + 83621143489848422977)]).
substitution(101, ['N' = 100, 'F' = 354224848179261915075, 'Previous' = 99, 'Earlier' = 98, 'A' = 218922995834555169026, 'B' = 135301852344706746049]).
proof(101, fib(100, 354224848179261915075), rule(3), [builtin(100 > 1), builtin(99 is 100 - 1), builtin(98 is 100 - 2), uses(100, fib(99, 218922995834555169026)), uses(99, fib(98, 135301852344706746049)), builtin(354224848179261915075 is 218922995834555169026 + 135301852344706746049)]).
substitution(102, ['Value' = 354224848179261915075]).
proof(102, solution([354224848179261915075]), query, [uses(101, fib(100, 354224848179261915075))]).
