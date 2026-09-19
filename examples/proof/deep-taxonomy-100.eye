# Eyelang result format 2
query(1, [call(arc(?v0, ?v1))], [binding("check", ?v0), binding("message", ?v1)]).
result(1, complete, 6).
answer(1, [binding("check", check1), binding("message", "C1 OK - the starting classification n0 is present.")]).
why(1, [binding("check", check1), binding("message", "C1 OK - the starting classification n0 is present.")], 4).
answer(1, [binding("check", check2), binding("message", "C2 OK - the first expansion produced n1 together with side labels i1 and j1.")]).
why(1, [binding("check", check2), binding("message", "C2 OK - the first expansion produced n1 together with side labels i1 and j1.")], 8).
answer(1, [binding("check", check3), binding("message", "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches.")]).
why(1, [binding("check", check3), binding("message", "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches.")], 66).
answer(1, [binding("check", check4), binding("message", "C4 OK - the final taxonomy step from n99 to n100 was completed.")]).
why(1, [binding("check", check4), binding("message", "C4 OK - the final taxonomy step from n99 to n100 was completed.")], 114).
answer(1, [binding("check", check5), binding("message", "C5 OK - once n100 is reached, the terminal class a2 is derived.")]).
why(1, [binding("check", check5), binding("message", "C5 OK - once n100 is reached, the terminal class a2 is derived.")], 116).
answer(1, [binding("check", check6), binding("message", "C6 OK - the success flag is raised only after the terminal class a2 is present.")]).
why(1, [binding("check", check6), binding("message", "C6 OK - the success flag is raised only after the terminal class a2 is present.")], 119).
query(2, [call(holds_result(test, true))], []).
result(2, complete, 1).
answer(2, []).
why(2, [], 223).
clause(1, a(ind, n0), []).
clause(2, a(var("x"), n1), [call(a(var("x"), n0))]).
clause(3, a(var("x"), i1), [call(a(var("x"), n0))]).
clause(4, a(var("x"), j1), [call(a(var("x"), n0))]).
clause(5, a(var("x"), n2), [call(a(var("x"), n1))]).
clause(8, a(var("x"), n3), [call(a(var("x"), n2))]).
clause(11, a(var("x"), n4), [call(a(var("x"), n3))]).
clause(14, a(var("x"), n5), [call(a(var("x"), n4))]).
clause(17, a(var("x"), n6), [call(a(var("x"), n5))]).
clause(20, a(var("x"), n7), [call(a(var("x"), n6))]).
clause(23, a(var("x"), n8), [call(a(var("x"), n7))]).
clause(26, a(var("x"), n9), [call(a(var("x"), n8))]).
clause(29, a(var("x"), n10), [call(a(var("x"), n9))]).
clause(32, a(var("x"), n11), [call(a(var("x"), n10))]).
clause(35, a(var("x"), n12), [call(a(var("x"), n11))]).
clause(38, a(var("x"), n13), [call(a(var("x"), n12))]).
clause(41, a(var("x"), n14), [call(a(var("x"), n13))]).
clause(44, a(var("x"), n15), [call(a(var("x"), n14))]).
clause(47, a(var("x"), n16), [call(a(var("x"), n15))]).
clause(50, a(var("x"), n17), [call(a(var("x"), n16))]).
clause(53, a(var("x"), n18), [call(a(var("x"), n17))]).
clause(56, a(var("x"), n19), [call(a(var("x"), n18))]).
clause(59, a(var("x"), n20), [call(a(var("x"), n19))]).
clause(62, a(var("x"), n21), [call(a(var("x"), n20))]).
clause(65, a(var("x"), n22), [call(a(var("x"), n21))]).
clause(68, a(var("x"), n23), [call(a(var("x"), n22))]).
clause(71, a(var("x"), n24), [call(a(var("x"), n23))]).
clause(74, a(var("x"), n25), [call(a(var("x"), n24))]).
clause(77, a(var("x"), n26), [call(a(var("x"), n25))]).
clause(80, a(var("x"), n27), [call(a(var("x"), n26))]).
clause(83, a(var("x"), n28), [call(a(var("x"), n27))]).
clause(86, a(var("x"), n29), [call(a(var("x"), n28))]).
clause(89, a(var("x"), n30), [call(a(var("x"), n29))]).
clause(92, a(var("x"), n31), [call(a(var("x"), n30))]).
clause(95, a(var("x"), n32), [call(a(var("x"), n31))]).
clause(98, a(var("x"), n33), [call(a(var("x"), n32))]).
clause(101, a(var("x"), n34), [call(a(var("x"), n33))]).
clause(104, a(var("x"), n35), [call(a(var("x"), n34))]).
clause(107, a(var("x"), n36), [call(a(var("x"), n35))]).
clause(110, a(var("x"), n37), [call(a(var("x"), n36))]).
clause(113, a(var("x"), n38), [call(a(var("x"), n37))]).
clause(116, a(var("x"), n39), [call(a(var("x"), n38))]).
clause(119, a(var("x"), n40), [call(a(var("x"), n39))]).
clause(122, a(var("x"), n41), [call(a(var("x"), n40))]).
clause(125, a(var("x"), n42), [call(a(var("x"), n41))]).
clause(128, a(var("x"), n43), [call(a(var("x"), n42))]).
clause(131, a(var("x"), n44), [call(a(var("x"), n43))]).
clause(134, a(var("x"), n45), [call(a(var("x"), n44))]).
clause(137, a(var("x"), n46), [call(a(var("x"), n45))]).
clause(140, a(var("x"), n47), [call(a(var("x"), n46))]).
clause(143, a(var("x"), n48), [call(a(var("x"), n47))]).
clause(146, a(var("x"), n49), [call(a(var("x"), n48))]).
clause(149, a(var("x"), n50), [call(a(var("x"), n49))]).
clause(150, a(var("x"), i50), [call(a(var("x"), n49))]).
clause(151, a(var("x"), j50), [call(a(var("x"), n49))]).
clause(152, a(var("x"), n51), [call(a(var("x"), n50))]).
clause(155, a(var("x"), n52), [call(a(var("x"), n51))]).
clause(158, a(var("x"), n53), [call(a(var("x"), n52))]).
clause(161, a(var("x"), n54), [call(a(var("x"), n53))]).
clause(164, a(var("x"), n55), [call(a(var("x"), n54))]).
clause(167, a(var("x"), n56), [call(a(var("x"), n55))]).
clause(170, a(var("x"), n57), [call(a(var("x"), n56))]).
clause(173, a(var("x"), n58), [call(a(var("x"), n57))]).
clause(176, a(var("x"), n59), [call(a(var("x"), n58))]).
clause(179, a(var("x"), n60), [call(a(var("x"), n59))]).
clause(182, a(var("x"), n61), [call(a(var("x"), n60))]).
clause(185, a(var("x"), n62), [call(a(var("x"), n61))]).
clause(188, a(var("x"), n63), [call(a(var("x"), n62))]).
clause(191, a(var("x"), n64), [call(a(var("x"), n63))]).
clause(194, a(var("x"), n65), [call(a(var("x"), n64))]).
clause(197, a(var("x"), n66), [call(a(var("x"), n65))]).
clause(200, a(var("x"), n67), [call(a(var("x"), n66))]).
clause(203, a(var("x"), n68), [call(a(var("x"), n67))]).
clause(206, a(var("x"), n69), [call(a(var("x"), n68))]).
clause(209, a(var("x"), n70), [call(a(var("x"), n69))]).
clause(212, a(var("x"), n71), [call(a(var("x"), n70))]).
clause(215, a(var("x"), n72), [call(a(var("x"), n71))]).
clause(218, a(var("x"), n73), [call(a(var("x"), n72))]).
clause(221, a(var("x"), n74), [call(a(var("x"), n73))]).
clause(224, a(var("x"), n75), [call(a(var("x"), n74))]).
clause(227, a(var("x"), n76), [call(a(var("x"), n75))]).
clause(230, a(var("x"), n77), [call(a(var("x"), n76))]).
clause(233, a(var("x"), n78), [call(a(var("x"), n77))]).
clause(236, a(var("x"), n79), [call(a(var("x"), n78))]).
clause(239, a(var("x"), n80), [call(a(var("x"), n79))]).
clause(242, a(var("x"), n81), [call(a(var("x"), n80))]).
clause(245, a(var("x"), n82), [call(a(var("x"), n81))]).
clause(248, a(var("x"), n83), [call(a(var("x"), n82))]).
clause(251, a(var("x"), n84), [call(a(var("x"), n83))]).
clause(254, a(var("x"), n85), [call(a(var("x"), n84))]).
clause(257, a(var("x"), n86), [call(a(var("x"), n85))]).
clause(260, a(var("x"), n87), [call(a(var("x"), n86))]).
clause(263, a(var("x"), n88), [call(a(var("x"), n87))]).
clause(266, a(var("x"), n89), [call(a(var("x"), n88))]).
clause(269, a(var("x"), n90), [call(a(var("x"), n89))]).
clause(272, a(var("x"), n91), [call(a(var("x"), n90))]).
clause(275, a(var("x"), n92), [call(a(var("x"), n91))]).
clause(278, a(var("x"), n93), [call(a(var("x"), n92))]).
clause(281, a(var("x"), n94), [call(a(var("x"), n93))]).
clause(284, a(var("x"), n95), [call(a(var("x"), n94))]).
clause(287, a(var("x"), n96), [call(a(var("x"), n95))]).
clause(290, a(var("x"), n97), [call(a(var("x"), n96))]).
clause(293, a(var("x"), n98), [call(a(var("x"), n97))]).
clause(296, a(var("x"), n99), [call(a(var("x"), n98))]).
clause(299, a(var("x"), n100), [call(a(var("x"), n99))]).
clause(302, a(var("x"), a2), [call(a(var("x"), n100))]).
clause(303, holds_result(test, true), [call(a(ind, a2))]).
clause(304, arc(check1, "C1 OK - the starting classification n0 is present."), [call(a(ind, n0))]).
clause(305, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."), [call(a(ind, n1)), call(a(ind, i1)), call(a(ind, j1))]).
clause(306, arc(check3, "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches."), [call(a(ind, n50)), call(a(ind, i50)), call(a(ind, j50))]).
clause(307, arc(check4, "C4 OK - the final taxonomy step from n99 to n100 was completed."), [call(a(ind, n99)), call(a(ind, n100))]).
clause(308, arc(check5, "C5 OK - once n100 is reached, the terminal class a2 is derived."), [call(a(ind, n100)), call(a(ind, a2))]).
clause(309, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."), [call(a(ind, a2)), call(holds_result(test, true))]).
substitution(1, []).
proof(1, a(ind, n0), rule(1), []).
substitution(2, [binding("x", ind)]).
proof(2, a(ind, n1), rule(2), [uses(1, a(ind, n0))]).
substitution(3, []).
proof(3, arc(check1, "C1 OK - the starting classification n0 is present."), rule(304), [uses(1, a(ind, n0))]).
substitution(4, [binding("check", check1), binding("message", "C1 OK - the starting classification n0 is present.")]).
proof(4, solution([check1, "C1 OK - the starting classification n0 is present."]), query, [uses(3, arc(check1, "C1 OK - the starting classification n0 is present."))]).
substitution(5, [binding("x", ind)]).
proof(5, a(ind, i1), rule(3), [uses(1, a(ind, n0))]).
substitution(6, [binding("x", ind)]).
proof(6, a(ind, j1), rule(4), [uses(1, a(ind, n0))]).
substitution(7, []).
proof(7, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."), rule(305), [uses(2, a(ind, n1)), uses(5, a(ind, i1)), uses(6, a(ind, j1))]).
substitution(8, [binding("check", check2), binding("message", "C2 OK - the first expansion produced n1 together with side labels i1 and j1.")]).
proof(8, solution([check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."]), query, [uses(7, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."))]).
substitution(9, [binding("x", ind)]).
proof(9, a(ind, n2), rule(5), [uses(2, a(ind, n1))]).
substitution(10, [binding("x", ind)]).
proof(10, a(ind, n3), rule(8), [uses(9, a(ind, n2))]).
substitution(11, [binding("x", ind)]).
proof(11, a(ind, n4), rule(11), [uses(10, a(ind, n3))]).
substitution(12, [binding("x", ind)]).
proof(12, a(ind, n5), rule(14), [uses(11, a(ind, n4))]).
substitution(13, [binding("x", ind)]).
proof(13, a(ind, n6), rule(17), [uses(12, a(ind, n5))]).
substitution(14, [binding("x", ind)]).
proof(14, a(ind, n7), rule(20), [uses(13, a(ind, n6))]).
substitution(15, [binding("x", ind)]).
proof(15, a(ind, n8), rule(23), [uses(14, a(ind, n7))]).
substitution(16, [binding("x", ind)]).
proof(16, a(ind, n9), rule(26), [uses(15, a(ind, n8))]).
substitution(17, [binding("x", ind)]).
proof(17, a(ind, n10), rule(29), [uses(16, a(ind, n9))]).
substitution(18, [binding("x", ind)]).
proof(18, a(ind, n11), rule(32), [uses(17, a(ind, n10))]).
substitution(19, [binding("x", ind)]).
proof(19, a(ind, n12), rule(35), [uses(18, a(ind, n11))]).
substitution(20, [binding("x", ind)]).
proof(20, a(ind, n13), rule(38), [uses(19, a(ind, n12))]).
substitution(21, [binding("x", ind)]).
proof(21, a(ind, n14), rule(41), [uses(20, a(ind, n13))]).
substitution(22, [binding("x", ind)]).
proof(22, a(ind, n15), rule(44), [uses(21, a(ind, n14))]).
substitution(23, [binding("x", ind)]).
proof(23, a(ind, n16), rule(47), [uses(22, a(ind, n15))]).
substitution(24, [binding("x", ind)]).
proof(24, a(ind, n17), rule(50), [uses(23, a(ind, n16))]).
substitution(25, [binding("x", ind)]).
proof(25, a(ind, n18), rule(53), [uses(24, a(ind, n17))]).
substitution(26, [binding("x", ind)]).
proof(26, a(ind, n19), rule(56), [uses(25, a(ind, n18))]).
substitution(27, [binding("x", ind)]).
proof(27, a(ind, n20), rule(59), [uses(26, a(ind, n19))]).
substitution(28, [binding("x", ind)]).
proof(28, a(ind, n21), rule(62), [uses(27, a(ind, n20))]).
substitution(29, [binding("x", ind)]).
proof(29, a(ind, n22), rule(65), [uses(28, a(ind, n21))]).
substitution(30, [binding("x", ind)]).
proof(30, a(ind, n23), rule(68), [uses(29, a(ind, n22))]).
substitution(31, [binding("x", ind)]).
proof(31, a(ind, n24), rule(71), [uses(30, a(ind, n23))]).
substitution(32, [binding("x", ind)]).
proof(32, a(ind, n25), rule(74), [uses(31, a(ind, n24))]).
substitution(33, [binding("x", ind)]).
proof(33, a(ind, n26), rule(77), [uses(32, a(ind, n25))]).
substitution(34, [binding("x", ind)]).
proof(34, a(ind, n27), rule(80), [uses(33, a(ind, n26))]).
substitution(35, [binding("x", ind)]).
proof(35, a(ind, n28), rule(83), [uses(34, a(ind, n27))]).
substitution(36, [binding("x", ind)]).
proof(36, a(ind, n29), rule(86), [uses(35, a(ind, n28))]).
substitution(37, [binding("x", ind)]).
proof(37, a(ind, n30), rule(89), [uses(36, a(ind, n29))]).
substitution(38, [binding("x", ind)]).
proof(38, a(ind, n31), rule(92), [uses(37, a(ind, n30))]).
substitution(39, [binding("x", ind)]).
proof(39, a(ind, n32), rule(95), [uses(38, a(ind, n31))]).
substitution(40, [binding("x", ind)]).
proof(40, a(ind, n33), rule(98), [uses(39, a(ind, n32))]).
substitution(41, [binding("x", ind)]).
proof(41, a(ind, n34), rule(101), [uses(40, a(ind, n33))]).
substitution(42, [binding("x", ind)]).
proof(42, a(ind, n35), rule(104), [uses(41, a(ind, n34))]).
substitution(43, [binding("x", ind)]).
proof(43, a(ind, n36), rule(107), [uses(42, a(ind, n35))]).
substitution(44, [binding("x", ind)]).
proof(44, a(ind, n37), rule(110), [uses(43, a(ind, n36))]).
substitution(45, [binding("x", ind)]).
proof(45, a(ind, n38), rule(113), [uses(44, a(ind, n37))]).
substitution(46, [binding("x", ind)]).
proof(46, a(ind, n39), rule(116), [uses(45, a(ind, n38))]).
substitution(47, [binding("x", ind)]).
proof(47, a(ind, n40), rule(119), [uses(46, a(ind, n39))]).
substitution(48, [binding("x", ind)]).
proof(48, a(ind, n41), rule(122), [uses(47, a(ind, n40))]).
substitution(49, [binding("x", ind)]).
proof(49, a(ind, n42), rule(125), [uses(48, a(ind, n41))]).
substitution(50, [binding("x", ind)]).
proof(50, a(ind, n43), rule(128), [uses(49, a(ind, n42))]).
substitution(51, [binding("x", ind)]).
proof(51, a(ind, n44), rule(131), [uses(50, a(ind, n43))]).
substitution(52, [binding("x", ind)]).
proof(52, a(ind, n45), rule(134), [uses(51, a(ind, n44))]).
substitution(53, [binding("x", ind)]).
proof(53, a(ind, n46), rule(137), [uses(52, a(ind, n45))]).
substitution(54, [binding("x", ind)]).
proof(54, a(ind, n47), rule(140), [uses(53, a(ind, n46))]).
substitution(55, [binding("x", ind)]).
proof(55, a(ind, n48), rule(143), [uses(54, a(ind, n47))]).
substitution(56, [binding("x", ind)]).
proof(56, a(ind, n49), rule(146), [uses(55, a(ind, n48))]).
substitution(57, [binding("x", ind)]).
proof(57, a(ind, n50), rule(149), [uses(56, a(ind, n49))]).
substitution(58, [binding("x", ind)]).
proof(58, a(ind, n51), rule(152), [uses(57, a(ind, n50))]).
substitution(59, [binding("x", ind)]).
proof(59, a(ind, i50), rule(150), [uses(56, a(ind, n49))]).
substitution(60, [binding("x", ind)]).
proof(60, a(ind, n52), rule(155), [uses(58, a(ind, n51))]).
substitution(61, [binding("x", ind)]).
proof(61, a(ind, n53), rule(158), [uses(60, a(ind, n52))]).
substitution(62, [binding("x", ind)]).
proof(62, a(ind, j50), rule(151), [uses(56, a(ind, n49))]).
substitution(63, [binding("x", ind)]).
proof(63, a(ind, n54), rule(161), [uses(61, a(ind, n53))]).
substitution(64, []).
proof(64, arc(check3, "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches."), rule(306), [uses(57, a(ind, n50)), uses(59, a(ind, i50)), uses(62, a(ind, j50))]).
substitution(65, [binding("x", ind)]).
proof(65, a(ind, n55), rule(164), [uses(63, a(ind, n54))]).
substitution(66, [binding("check", check3), binding("message", "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches.")]).
proof(66, solution([check3, "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches."]), query, [uses(64, arc(check3, "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches."))]).
substitution(67, [binding("x", ind)]).
proof(67, a(ind, n56), rule(167), [uses(65, a(ind, n55))]).
substitution(68, [binding("x", ind)]).
proof(68, a(ind, n57), rule(170), [uses(67, a(ind, n56))]).
substitution(69, [binding("x", ind)]).
proof(69, a(ind, n58), rule(173), [uses(68, a(ind, n57))]).
substitution(70, [binding("x", ind)]).
proof(70, a(ind, n59), rule(176), [uses(69, a(ind, n58))]).
substitution(71, [binding("x", ind)]).
proof(71, a(ind, n60), rule(179), [uses(70, a(ind, n59))]).
substitution(72, [binding("x", ind)]).
proof(72, a(ind, n61), rule(182), [uses(71, a(ind, n60))]).
substitution(73, [binding("x", ind)]).
proof(73, a(ind, n62), rule(185), [uses(72, a(ind, n61))]).
substitution(74, [binding("x", ind)]).
proof(74, a(ind, n63), rule(188), [uses(73, a(ind, n62))]).
substitution(75, [binding("x", ind)]).
proof(75, a(ind, n64), rule(191), [uses(74, a(ind, n63))]).
substitution(76, [binding("x", ind)]).
proof(76, a(ind, n65), rule(194), [uses(75, a(ind, n64))]).
substitution(77, [binding("x", ind)]).
proof(77, a(ind, n66), rule(197), [uses(76, a(ind, n65))]).
substitution(78, [binding("x", ind)]).
proof(78, a(ind, n67), rule(200), [uses(77, a(ind, n66))]).
substitution(79, [binding("x", ind)]).
proof(79, a(ind, n68), rule(203), [uses(78, a(ind, n67))]).
substitution(80, [binding("x", ind)]).
proof(80, a(ind, n69), rule(206), [uses(79, a(ind, n68))]).
substitution(81, [binding("x", ind)]).
proof(81, a(ind, n70), rule(209), [uses(80, a(ind, n69))]).
substitution(82, [binding("x", ind)]).
proof(82, a(ind, n71), rule(212), [uses(81, a(ind, n70))]).
substitution(83, [binding("x", ind)]).
proof(83, a(ind, n72), rule(215), [uses(82, a(ind, n71))]).
substitution(84, [binding("x", ind)]).
proof(84, a(ind, n73), rule(218), [uses(83, a(ind, n72))]).
substitution(85, [binding("x", ind)]).
proof(85, a(ind, n74), rule(221), [uses(84, a(ind, n73))]).
substitution(86, [binding("x", ind)]).
proof(86, a(ind, n75), rule(224), [uses(85, a(ind, n74))]).
substitution(87, [binding("x", ind)]).
proof(87, a(ind, n76), rule(227), [uses(86, a(ind, n75))]).
substitution(88, [binding("x", ind)]).
proof(88, a(ind, n77), rule(230), [uses(87, a(ind, n76))]).
substitution(89, [binding("x", ind)]).
proof(89, a(ind, n78), rule(233), [uses(88, a(ind, n77))]).
substitution(90, [binding("x", ind)]).
proof(90, a(ind, n79), rule(236), [uses(89, a(ind, n78))]).
substitution(91, [binding("x", ind)]).
proof(91, a(ind, n80), rule(239), [uses(90, a(ind, n79))]).
substitution(92, [binding("x", ind)]).
proof(92, a(ind, n81), rule(242), [uses(91, a(ind, n80))]).
substitution(93, [binding("x", ind)]).
proof(93, a(ind, n82), rule(245), [uses(92, a(ind, n81))]).
substitution(94, [binding("x", ind)]).
proof(94, a(ind, n83), rule(248), [uses(93, a(ind, n82))]).
substitution(95, [binding("x", ind)]).
proof(95, a(ind, n84), rule(251), [uses(94, a(ind, n83))]).
substitution(96, [binding("x", ind)]).
proof(96, a(ind, n85), rule(254), [uses(95, a(ind, n84))]).
substitution(97, [binding("x", ind)]).
proof(97, a(ind, n86), rule(257), [uses(96, a(ind, n85))]).
substitution(98, [binding("x", ind)]).
proof(98, a(ind, n87), rule(260), [uses(97, a(ind, n86))]).
substitution(99, [binding("x", ind)]).
proof(99, a(ind, n88), rule(263), [uses(98, a(ind, n87))]).
substitution(100, [binding("x", ind)]).
proof(100, a(ind, n89), rule(266), [uses(99, a(ind, n88))]).
substitution(101, [binding("x", ind)]).
proof(101, a(ind, n90), rule(269), [uses(100, a(ind, n89))]).
substitution(102, [binding("x", ind)]).
proof(102, a(ind, n91), rule(272), [uses(101, a(ind, n90))]).
substitution(103, [binding("x", ind)]).
proof(103, a(ind, n92), rule(275), [uses(102, a(ind, n91))]).
substitution(104, [binding("x", ind)]).
proof(104, a(ind, n93), rule(278), [uses(103, a(ind, n92))]).
substitution(105, [binding("x", ind)]).
proof(105, a(ind, n94), rule(281), [uses(104, a(ind, n93))]).
substitution(106, [binding("x", ind)]).
proof(106, a(ind, n95), rule(284), [uses(105, a(ind, n94))]).
substitution(107, [binding("x", ind)]).
proof(107, a(ind, n96), rule(287), [uses(106, a(ind, n95))]).
substitution(108, [binding("x", ind)]).
proof(108, a(ind, n97), rule(290), [uses(107, a(ind, n96))]).
substitution(109, [binding("x", ind)]).
proof(109, a(ind, n98), rule(293), [uses(108, a(ind, n97))]).
substitution(110, [binding("x", ind)]).
proof(110, a(ind, n99), rule(296), [uses(109, a(ind, n98))]).
substitution(111, [binding("x", ind)]).
proof(111, a(ind, n100), rule(299), [uses(110, a(ind, n99))]).
substitution(112, []).
proof(112, arc(check4, "C4 OK - the final taxonomy step from n99 to n100 was completed."), rule(307), [uses(110, a(ind, n99)), uses(111, a(ind, n100))]).
substitution(113, [binding("x", ind)]).
proof(113, a(ind, a2), rule(302), [uses(111, a(ind, n100))]).
substitution(114, [binding("check", check4), binding("message", "C4 OK - the final taxonomy step from n99 to n100 was completed.")]).
proof(114, solution([check4, "C4 OK - the final taxonomy step from n99 to n100 was completed."]), query, [uses(112, arc(check4, "C4 OK - the final taxonomy step from n99 to n100 was completed."))]).
substitution(115, []).
proof(115, arc(check5, "C5 OK - once n100 is reached, the terminal class a2 is derived."), rule(308), [uses(111, a(ind, n100)), uses(113, a(ind, a2))]).
substitution(116, [binding("check", check5), binding("message", "C5 OK - once n100 is reached, the terminal class a2 is derived.")]).
proof(116, solution([check5, "C5 OK - once n100 is reached, the terminal class a2 is derived."]), query, [uses(115, arc(check5, "C5 OK - once n100 is reached, the terminal class a2 is derived."))]).
substitution(117, []).
proof(117, holds_result(test, true), rule(303), [uses(113, a(ind, a2))]).
substitution(118, []).
proof(118, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."), rule(309), [uses(113, a(ind, a2)), uses(117, holds_result(test, true))]).
substitution(119, [binding("check", check6), binding("message", "C6 OK - the success flag is raised only after the terminal class a2 is present.")]).
proof(119, solution([check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."]), query, [uses(118, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."))]).
substitution(120, []).
proof(120, a(ind, n0), rule(1), []).
substitution(121, [binding("x", ind)]).
proof(121, a(ind, n1), rule(2), [uses(120, a(ind, n0))]).
substitution(122, [binding("x", ind)]).
proof(122, a(ind, n2), rule(5), [uses(121, a(ind, n1))]).
substitution(123, [binding("x", ind)]).
proof(123, a(ind, n3), rule(8), [uses(122, a(ind, n2))]).
substitution(124, [binding("x", ind)]).
proof(124, a(ind, n4), rule(11), [uses(123, a(ind, n3))]).
substitution(125, [binding("x", ind)]).
proof(125, a(ind, n5), rule(14), [uses(124, a(ind, n4))]).
substitution(126, [binding("x", ind)]).
proof(126, a(ind, n6), rule(17), [uses(125, a(ind, n5))]).
substitution(127, [binding("x", ind)]).
proof(127, a(ind, n7), rule(20), [uses(126, a(ind, n6))]).
substitution(128, [binding("x", ind)]).
proof(128, a(ind, n8), rule(23), [uses(127, a(ind, n7))]).
substitution(129, [binding("x", ind)]).
proof(129, a(ind, n9), rule(26), [uses(128, a(ind, n8))]).
substitution(130, [binding("x", ind)]).
proof(130, a(ind, n10), rule(29), [uses(129, a(ind, n9))]).
substitution(131, [binding("x", ind)]).
proof(131, a(ind, n11), rule(32), [uses(130, a(ind, n10))]).
substitution(132, [binding("x", ind)]).
proof(132, a(ind, n12), rule(35), [uses(131, a(ind, n11))]).
substitution(133, [binding("x", ind)]).
proof(133, a(ind, n13), rule(38), [uses(132, a(ind, n12))]).
substitution(134, [binding("x", ind)]).
proof(134, a(ind, n14), rule(41), [uses(133, a(ind, n13))]).
substitution(135, [binding("x", ind)]).
proof(135, a(ind, n15), rule(44), [uses(134, a(ind, n14))]).
substitution(136, [binding("x", ind)]).
proof(136, a(ind, n16), rule(47), [uses(135, a(ind, n15))]).
substitution(137, [binding("x", ind)]).
proof(137, a(ind, n17), rule(50), [uses(136, a(ind, n16))]).
substitution(138, [binding("x", ind)]).
proof(138, a(ind, n18), rule(53), [uses(137, a(ind, n17))]).
substitution(139, [binding("x", ind)]).
proof(139, a(ind, n19), rule(56), [uses(138, a(ind, n18))]).
substitution(140, [binding("x", ind)]).
proof(140, a(ind, n20), rule(59), [uses(139, a(ind, n19))]).
substitution(141, [binding("x", ind)]).
proof(141, a(ind, n21), rule(62), [uses(140, a(ind, n20))]).
substitution(142, [binding("x", ind)]).
proof(142, a(ind, n22), rule(65), [uses(141, a(ind, n21))]).
substitution(143, [binding("x", ind)]).
proof(143, a(ind, n23), rule(68), [uses(142, a(ind, n22))]).
substitution(144, [binding("x", ind)]).
proof(144, a(ind, n24), rule(71), [uses(143, a(ind, n23))]).
substitution(145, [binding("x", ind)]).
proof(145, a(ind, n25), rule(74), [uses(144, a(ind, n24))]).
substitution(146, [binding("x", ind)]).
proof(146, a(ind, n26), rule(77), [uses(145, a(ind, n25))]).
substitution(147, [binding("x", ind)]).
proof(147, a(ind, n27), rule(80), [uses(146, a(ind, n26))]).
substitution(148, [binding("x", ind)]).
proof(148, a(ind, n28), rule(83), [uses(147, a(ind, n27))]).
substitution(149, [binding("x", ind)]).
proof(149, a(ind, n29), rule(86), [uses(148, a(ind, n28))]).
substitution(150, [binding("x", ind)]).
proof(150, a(ind, n30), rule(89), [uses(149, a(ind, n29))]).
substitution(151, [binding("x", ind)]).
proof(151, a(ind, n31), rule(92), [uses(150, a(ind, n30))]).
substitution(152, [binding("x", ind)]).
proof(152, a(ind, n32), rule(95), [uses(151, a(ind, n31))]).
substitution(153, [binding("x", ind)]).
proof(153, a(ind, n33), rule(98), [uses(152, a(ind, n32))]).
substitution(154, [binding("x", ind)]).
proof(154, a(ind, n34), rule(101), [uses(153, a(ind, n33))]).
substitution(155, [binding("x", ind)]).
proof(155, a(ind, n35), rule(104), [uses(154, a(ind, n34))]).
substitution(156, [binding("x", ind)]).
proof(156, a(ind, n36), rule(107), [uses(155, a(ind, n35))]).
substitution(157, [binding("x", ind)]).
proof(157, a(ind, n37), rule(110), [uses(156, a(ind, n36))]).
substitution(158, [binding("x", ind)]).
proof(158, a(ind, n38), rule(113), [uses(157, a(ind, n37))]).
substitution(159, [binding("x", ind)]).
proof(159, a(ind, n39), rule(116), [uses(158, a(ind, n38))]).
substitution(160, [binding("x", ind)]).
proof(160, a(ind, n40), rule(119), [uses(159, a(ind, n39))]).
substitution(161, [binding("x", ind)]).
proof(161, a(ind, n41), rule(122), [uses(160, a(ind, n40))]).
substitution(162, [binding("x", ind)]).
proof(162, a(ind, n42), rule(125), [uses(161, a(ind, n41))]).
substitution(163, [binding("x", ind)]).
proof(163, a(ind, n43), rule(128), [uses(162, a(ind, n42))]).
substitution(164, [binding("x", ind)]).
proof(164, a(ind, n44), rule(131), [uses(163, a(ind, n43))]).
substitution(165, [binding("x", ind)]).
proof(165, a(ind, n45), rule(134), [uses(164, a(ind, n44))]).
substitution(166, [binding("x", ind)]).
proof(166, a(ind, n46), rule(137), [uses(165, a(ind, n45))]).
substitution(167, [binding("x", ind)]).
proof(167, a(ind, n47), rule(140), [uses(166, a(ind, n46))]).
substitution(168, [binding("x", ind)]).
proof(168, a(ind, n48), rule(143), [uses(167, a(ind, n47))]).
substitution(169, [binding("x", ind)]).
proof(169, a(ind, n49), rule(146), [uses(168, a(ind, n48))]).
substitution(170, [binding("x", ind)]).
proof(170, a(ind, n50), rule(149), [uses(169, a(ind, n49))]).
substitution(171, [binding("x", ind)]).
proof(171, a(ind, n51), rule(152), [uses(170, a(ind, n50))]).
substitution(172, [binding("x", ind)]).
proof(172, a(ind, n52), rule(155), [uses(171, a(ind, n51))]).
substitution(173, [binding("x", ind)]).
proof(173, a(ind, n53), rule(158), [uses(172, a(ind, n52))]).
substitution(174, [binding("x", ind)]).
proof(174, a(ind, n54), rule(161), [uses(173, a(ind, n53))]).
substitution(175, [binding("x", ind)]).
proof(175, a(ind, n55), rule(164), [uses(174, a(ind, n54))]).
substitution(176, [binding("x", ind)]).
proof(176, a(ind, n56), rule(167), [uses(175, a(ind, n55))]).
substitution(177, [binding("x", ind)]).
proof(177, a(ind, n57), rule(170), [uses(176, a(ind, n56))]).
substitution(178, [binding("x", ind)]).
proof(178, a(ind, n58), rule(173), [uses(177, a(ind, n57))]).
substitution(179, [binding("x", ind)]).
proof(179, a(ind, n59), rule(176), [uses(178, a(ind, n58))]).
substitution(180, [binding("x", ind)]).
proof(180, a(ind, n60), rule(179), [uses(179, a(ind, n59))]).
substitution(181, [binding("x", ind)]).
proof(181, a(ind, n61), rule(182), [uses(180, a(ind, n60))]).
substitution(182, [binding("x", ind)]).
proof(182, a(ind, n62), rule(185), [uses(181, a(ind, n61))]).
substitution(183, [binding("x", ind)]).
proof(183, a(ind, n63), rule(188), [uses(182, a(ind, n62))]).
substitution(184, [binding("x", ind)]).
proof(184, a(ind, n64), rule(191), [uses(183, a(ind, n63))]).
substitution(185, [binding("x", ind)]).
proof(185, a(ind, n65), rule(194), [uses(184, a(ind, n64))]).
substitution(186, [binding("x", ind)]).
proof(186, a(ind, n66), rule(197), [uses(185, a(ind, n65))]).
substitution(187, [binding("x", ind)]).
proof(187, a(ind, n67), rule(200), [uses(186, a(ind, n66))]).
substitution(188, [binding("x", ind)]).
proof(188, a(ind, n68), rule(203), [uses(187, a(ind, n67))]).
substitution(189, [binding("x", ind)]).
proof(189, a(ind, n69), rule(206), [uses(188, a(ind, n68))]).
substitution(190, [binding("x", ind)]).
proof(190, a(ind, n70), rule(209), [uses(189, a(ind, n69))]).
substitution(191, [binding("x", ind)]).
proof(191, a(ind, n71), rule(212), [uses(190, a(ind, n70))]).
substitution(192, [binding("x", ind)]).
proof(192, a(ind, n72), rule(215), [uses(191, a(ind, n71))]).
substitution(193, [binding("x", ind)]).
proof(193, a(ind, n73), rule(218), [uses(192, a(ind, n72))]).
substitution(194, [binding("x", ind)]).
proof(194, a(ind, n74), rule(221), [uses(193, a(ind, n73))]).
substitution(195, [binding("x", ind)]).
proof(195, a(ind, n75), rule(224), [uses(194, a(ind, n74))]).
substitution(196, [binding("x", ind)]).
proof(196, a(ind, n76), rule(227), [uses(195, a(ind, n75))]).
substitution(197, [binding("x", ind)]).
proof(197, a(ind, n77), rule(230), [uses(196, a(ind, n76))]).
substitution(198, [binding("x", ind)]).
proof(198, a(ind, n78), rule(233), [uses(197, a(ind, n77))]).
substitution(199, [binding("x", ind)]).
proof(199, a(ind, n79), rule(236), [uses(198, a(ind, n78))]).
substitution(200, [binding("x", ind)]).
proof(200, a(ind, n80), rule(239), [uses(199, a(ind, n79))]).
substitution(201, [binding("x", ind)]).
proof(201, a(ind, n81), rule(242), [uses(200, a(ind, n80))]).
substitution(202, [binding("x", ind)]).
proof(202, a(ind, n82), rule(245), [uses(201, a(ind, n81))]).
substitution(203, [binding("x", ind)]).
proof(203, a(ind, n83), rule(248), [uses(202, a(ind, n82))]).
substitution(204, [binding("x", ind)]).
proof(204, a(ind, n84), rule(251), [uses(203, a(ind, n83))]).
substitution(205, [binding("x", ind)]).
proof(205, a(ind, n85), rule(254), [uses(204, a(ind, n84))]).
substitution(206, [binding("x", ind)]).
proof(206, a(ind, n86), rule(257), [uses(205, a(ind, n85))]).
substitution(207, [binding("x", ind)]).
proof(207, a(ind, n87), rule(260), [uses(206, a(ind, n86))]).
substitution(208, [binding("x", ind)]).
proof(208, a(ind, n88), rule(263), [uses(207, a(ind, n87))]).
substitution(209, [binding("x", ind)]).
proof(209, a(ind, n89), rule(266), [uses(208, a(ind, n88))]).
substitution(210, [binding("x", ind)]).
proof(210, a(ind, n90), rule(269), [uses(209, a(ind, n89))]).
substitution(211, [binding("x", ind)]).
proof(211, a(ind, n91), rule(272), [uses(210, a(ind, n90))]).
substitution(212, [binding("x", ind)]).
proof(212, a(ind, n92), rule(275), [uses(211, a(ind, n91))]).
substitution(213, [binding("x", ind)]).
proof(213, a(ind, n93), rule(278), [uses(212, a(ind, n92))]).
substitution(214, [binding("x", ind)]).
proof(214, a(ind, n94), rule(281), [uses(213, a(ind, n93))]).
substitution(215, [binding("x", ind)]).
proof(215, a(ind, n95), rule(284), [uses(214, a(ind, n94))]).
substitution(216, [binding("x", ind)]).
proof(216, a(ind, n96), rule(287), [uses(215, a(ind, n95))]).
substitution(217, [binding("x", ind)]).
proof(217, a(ind, n97), rule(290), [uses(216, a(ind, n96))]).
substitution(218, [binding("x", ind)]).
proof(218, a(ind, n98), rule(293), [uses(217, a(ind, n97))]).
substitution(219, [binding("x", ind)]).
proof(219, a(ind, n99), rule(296), [uses(218, a(ind, n98))]).
substitution(220, [binding("x", ind)]).
proof(220, a(ind, n100), rule(299), [uses(219, a(ind, n99))]).
substitution(221, [binding("x", ind)]).
proof(221, a(ind, a2), rule(302), [uses(220, a(ind, n100))]).
substitution(222, []).
proof(222, holds_result(test, true), rule(303), [uses(221, a(ind, a2))]).
substitution(223, []).
proof(223, solution([]), query, [uses(222, holds_result(test, true))]).
