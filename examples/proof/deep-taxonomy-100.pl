% Prolog result format 3
query(1, arc(_0, _1), ['Check' = _0, 'Message' = _1]).
result(1, complete, 6).
answer(1, ['Check' = check1, 'Message' = "C1 OK - the starting classification n0 is present."]).
why(1, ['Check' = check1, 'Message' = "C1 OK - the starting classification n0 is present."], 4).
answer(1, ['Check' = check2, 'Message' = "C2 OK - the first expansion produced n1 together with side labels i1 and j1."]).
why(1, ['Check' = check2, 'Message' = "C2 OK - the first expansion produced n1 together with side labels i1 and j1."], 8).
answer(1, ['Check' = check3, 'Message' = "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches."]).
why(1, ['Check' = check3, 'Message' = "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches."], 66).
answer(1, ['Check' = check4, 'Message' = "C4 OK - the final taxonomy step from n99 to n100 was completed."]).
why(1, ['Check' = check4, 'Message' = "C4 OK - the final taxonomy step from n99 to n100 was completed."], 114).
answer(1, ['Check' = check5, 'Message' = "C5 OK - once n100 is reached, the terminal class a2 is derived."]).
why(1, ['Check' = check5, 'Message' = "C5 OK - once n100 is reached, the terminal class a2 is derived."], 116).
answer(1, ['Check' = check6, 'Message' = "C6 OK - the success flag is raised only after the terminal class a2 is present."]).
why(1, ['Check' = check6, 'Message' = "C6 OK - the success flag is raised only after the terminal class a2 is present."], 119).
query(2, holds_result(test, true), []).
result(2, complete, 1).
answer(2, []).
why(2, [], 223).
clause(1, a(ind, n0), true).
clause(2, a(var('X'), n1), a(var('X'), n0)).
clause(3, a(var('X'), i1), a(var('X'), n0)).
clause(4, a(var('X'), j1), a(var('X'), n0)).
clause(5, a(var('X'), n2), a(var('X'), n1)).
clause(8, a(var('X'), n3), a(var('X'), n2)).
clause(11, a(var('X'), n4), a(var('X'), n3)).
clause(14, a(var('X'), n5), a(var('X'), n4)).
clause(17, a(var('X'), n6), a(var('X'), n5)).
clause(20, a(var('X'), n7), a(var('X'), n6)).
clause(23, a(var('X'), n8), a(var('X'), n7)).
clause(26, a(var('X'), n9), a(var('X'), n8)).
clause(29, a(var('X'), n10), a(var('X'), n9)).
clause(32, a(var('X'), n11), a(var('X'), n10)).
clause(35, a(var('X'), n12), a(var('X'), n11)).
clause(38, a(var('X'), n13), a(var('X'), n12)).
clause(41, a(var('X'), n14), a(var('X'), n13)).
clause(44, a(var('X'), n15), a(var('X'), n14)).
clause(47, a(var('X'), n16), a(var('X'), n15)).
clause(50, a(var('X'), n17), a(var('X'), n16)).
clause(53, a(var('X'), n18), a(var('X'), n17)).
clause(56, a(var('X'), n19), a(var('X'), n18)).
clause(59, a(var('X'), n20), a(var('X'), n19)).
clause(62, a(var('X'), n21), a(var('X'), n20)).
clause(65, a(var('X'), n22), a(var('X'), n21)).
clause(68, a(var('X'), n23), a(var('X'), n22)).
clause(71, a(var('X'), n24), a(var('X'), n23)).
clause(74, a(var('X'), n25), a(var('X'), n24)).
clause(77, a(var('X'), n26), a(var('X'), n25)).
clause(80, a(var('X'), n27), a(var('X'), n26)).
clause(83, a(var('X'), n28), a(var('X'), n27)).
clause(86, a(var('X'), n29), a(var('X'), n28)).
clause(89, a(var('X'), n30), a(var('X'), n29)).
clause(92, a(var('X'), n31), a(var('X'), n30)).
clause(95, a(var('X'), n32), a(var('X'), n31)).
clause(98, a(var('X'), n33), a(var('X'), n32)).
clause(101, a(var('X'), n34), a(var('X'), n33)).
clause(104, a(var('X'), n35), a(var('X'), n34)).
clause(107, a(var('X'), n36), a(var('X'), n35)).
clause(110, a(var('X'), n37), a(var('X'), n36)).
clause(113, a(var('X'), n38), a(var('X'), n37)).
clause(116, a(var('X'), n39), a(var('X'), n38)).
clause(119, a(var('X'), n40), a(var('X'), n39)).
clause(122, a(var('X'), n41), a(var('X'), n40)).
clause(125, a(var('X'), n42), a(var('X'), n41)).
clause(128, a(var('X'), n43), a(var('X'), n42)).
clause(131, a(var('X'), n44), a(var('X'), n43)).
clause(134, a(var('X'), n45), a(var('X'), n44)).
clause(137, a(var('X'), n46), a(var('X'), n45)).
clause(140, a(var('X'), n47), a(var('X'), n46)).
clause(143, a(var('X'), n48), a(var('X'), n47)).
clause(146, a(var('X'), n49), a(var('X'), n48)).
clause(149, a(var('X'), n50), a(var('X'), n49)).
clause(150, a(var('X'), i50), a(var('X'), n49)).
clause(151, a(var('X'), j50), a(var('X'), n49)).
clause(152, a(var('X'), n51), a(var('X'), n50)).
clause(155, a(var('X'), n52), a(var('X'), n51)).
clause(158, a(var('X'), n53), a(var('X'), n52)).
clause(161, a(var('X'), n54), a(var('X'), n53)).
clause(164, a(var('X'), n55), a(var('X'), n54)).
clause(167, a(var('X'), n56), a(var('X'), n55)).
clause(170, a(var('X'), n57), a(var('X'), n56)).
clause(173, a(var('X'), n58), a(var('X'), n57)).
clause(176, a(var('X'), n59), a(var('X'), n58)).
clause(179, a(var('X'), n60), a(var('X'), n59)).
clause(182, a(var('X'), n61), a(var('X'), n60)).
clause(185, a(var('X'), n62), a(var('X'), n61)).
clause(188, a(var('X'), n63), a(var('X'), n62)).
clause(191, a(var('X'), n64), a(var('X'), n63)).
clause(194, a(var('X'), n65), a(var('X'), n64)).
clause(197, a(var('X'), n66), a(var('X'), n65)).
clause(200, a(var('X'), n67), a(var('X'), n66)).
clause(203, a(var('X'), n68), a(var('X'), n67)).
clause(206, a(var('X'), n69), a(var('X'), n68)).
clause(209, a(var('X'), n70), a(var('X'), n69)).
clause(212, a(var('X'), n71), a(var('X'), n70)).
clause(215, a(var('X'), n72), a(var('X'), n71)).
clause(218, a(var('X'), n73), a(var('X'), n72)).
clause(221, a(var('X'), n74), a(var('X'), n73)).
clause(224, a(var('X'), n75), a(var('X'), n74)).
clause(227, a(var('X'), n76), a(var('X'), n75)).
clause(230, a(var('X'), n77), a(var('X'), n76)).
clause(233, a(var('X'), n78), a(var('X'), n77)).
clause(236, a(var('X'), n79), a(var('X'), n78)).
clause(239, a(var('X'), n80), a(var('X'), n79)).
clause(242, a(var('X'), n81), a(var('X'), n80)).
clause(245, a(var('X'), n82), a(var('X'), n81)).
clause(248, a(var('X'), n83), a(var('X'), n82)).
clause(251, a(var('X'), n84), a(var('X'), n83)).
clause(254, a(var('X'), n85), a(var('X'), n84)).
clause(257, a(var('X'), n86), a(var('X'), n85)).
clause(260, a(var('X'), n87), a(var('X'), n86)).
clause(263, a(var('X'), n88), a(var('X'), n87)).
clause(266, a(var('X'), n89), a(var('X'), n88)).
clause(269, a(var('X'), n90), a(var('X'), n89)).
clause(272, a(var('X'), n91), a(var('X'), n90)).
clause(275, a(var('X'), n92), a(var('X'), n91)).
clause(278, a(var('X'), n93), a(var('X'), n92)).
clause(281, a(var('X'), n94), a(var('X'), n93)).
clause(284, a(var('X'), n95), a(var('X'), n94)).
clause(287, a(var('X'), n96), a(var('X'), n95)).
clause(290, a(var('X'), n97), a(var('X'), n96)).
clause(293, a(var('X'), n98), a(var('X'), n97)).
clause(296, a(var('X'), n99), a(var('X'), n98)).
clause(299, a(var('X'), n100), a(var('X'), n99)).
clause(302, a(var('X'), a2), a(var('X'), n100)).
clause(303, holds_result(test, true), a(ind, a2)).
clause(304, arc(check1, "C1 OK - the starting classification n0 is present."), a(ind, n0)).
clause(305, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."), (a(ind, n1), a(ind, i1), a(ind, j1))).
clause(306, arc(check3, "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches."), (a(ind, n50), a(ind, i50), a(ind, j50))).
clause(307, arc(check4, "C4 OK - the final taxonomy step from n99 to n100 was completed."), (a(ind, n99), a(ind, n100))).
clause(308, arc(check5, "C5 OK - once n100 is reached, the terminal class a2 is derived."), (a(ind, n100), a(ind, a2))).
clause(309, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."), (a(ind, a2), holds_result(test, true))).
substitution(1, []).
proof(1, a(ind, n0), rule(1), []).
substitution(2, ['X' = ind]).
proof(2, a(ind, n1), rule(2), [uses(1, a(ind, n0))]).
substitution(3, []).
proof(3, arc(check1, "C1 OK - the starting classification n0 is present."), rule(304), [uses(1, a(ind, n0))]).
substitution(4, ['Check' = check1, 'Message' = "C1 OK - the starting classification n0 is present."]).
proof(4, solution([check1, "C1 OK - the starting classification n0 is present."]), query, [uses(3, arc(check1, "C1 OK - the starting classification n0 is present."))]).
substitution(5, ['X' = ind]).
proof(5, a(ind, i1), rule(3), [uses(1, a(ind, n0))]).
substitution(6, ['X' = ind]).
proof(6, a(ind, j1), rule(4), [uses(1, a(ind, n0))]).
substitution(7, []).
proof(7, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."), rule(305), [uses(2, a(ind, n1)), uses(5, a(ind, i1)), uses(6, a(ind, j1))]).
substitution(8, ['Check' = check2, 'Message' = "C2 OK - the first expansion produced n1 together with side labels i1 and j1."]).
proof(8, solution([check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."]), query, [uses(7, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."))]).
substitution(9, ['X' = ind]).
proof(9, a(ind, n2), rule(5), [uses(2, a(ind, n1))]).
substitution(10, ['X' = ind]).
proof(10, a(ind, n3), rule(8), [uses(9, a(ind, n2))]).
substitution(11, ['X' = ind]).
proof(11, a(ind, n4), rule(11), [uses(10, a(ind, n3))]).
substitution(12, ['X' = ind]).
proof(12, a(ind, n5), rule(14), [uses(11, a(ind, n4))]).
substitution(13, ['X' = ind]).
proof(13, a(ind, n6), rule(17), [uses(12, a(ind, n5))]).
substitution(14, ['X' = ind]).
proof(14, a(ind, n7), rule(20), [uses(13, a(ind, n6))]).
substitution(15, ['X' = ind]).
proof(15, a(ind, n8), rule(23), [uses(14, a(ind, n7))]).
substitution(16, ['X' = ind]).
proof(16, a(ind, n9), rule(26), [uses(15, a(ind, n8))]).
substitution(17, ['X' = ind]).
proof(17, a(ind, n10), rule(29), [uses(16, a(ind, n9))]).
substitution(18, ['X' = ind]).
proof(18, a(ind, n11), rule(32), [uses(17, a(ind, n10))]).
substitution(19, ['X' = ind]).
proof(19, a(ind, n12), rule(35), [uses(18, a(ind, n11))]).
substitution(20, ['X' = ind]).
proof(20, a(ind, n13), rule(38), [uses(19, a(ind, n12))]).
substitution(21, ['X' = ind]).
proof(21, a(ind, n14), rule(41), [uses(20, a(ind, n13))]).
substitution(22, ['X' = ind]).
proof(22, a(ind, n15), rule(44), [uses(21, a(ind, n14))]).
substitution(23, ['X' = ind]).
proof(23, a(ind, n16), rule(47), [uses(22, a(ind, n15))]).
substitution(24, ['X' = ind]).
proof(24, a(ind, n17), rule(50), [uses(23, a(ind, n16))]).
substitution(25, ['X' = ind]).
proof(25, a(ind, n18), rule(53), [uses(24, a(ind, n17))]).
substitution(26, ['X' = ind]).
proof(26, a(ind, n19), rule(56), [uses(25, a(ind, n18))]).
substitution(27, ['X' = ind]).
proof(27, a(ind, n20), rule(59), [uses(26, a(ind, n19))]).
substitution(28, ['X' = ind]).
proof(28, a(ind, n21), rule(62), [uses(27, a(ind, n20))]).
substitution(29, ['X' = ind]).
proof(29, a(ind, n22), rule(65), [uses(28, a(ind, n21))]).
substitution(30, ['X' = ind]).
proof(30, a(ind, n23), rule(68), [uses(29, a(ind, n22))]).
substitution(31, ['X' = ind]).
proof(31, a(ind, n24), rule(71), [uses(30, a(ind, n23))]).
substitution(32, ['X' = ind]).
proof(32, a(ind, n25), rule(74), [uses(31, a(ind, n24))]).
substitution(33, ['X' = ind]).
proof(33, a(ind, n26), rule(77), [uses(32, a(ind, n25))]).
substitution(34, ['X' = ind]).
proof(34, a(ind, n27), rule(80), [uses(33, a(ind, n26))]).
substitution(35, ['X' = ind]).
proof(35, a(ind, n28), rule(83), [uses(34, a(ind, n27))]).
substitution(36, ['X' = ind]).
proof(36, a(ind, n29), rule(86), [uses(35, a(ind, n28))]).
substitution(37, ['X' = ind]).
proof(37, a(ind, n30), rule(89), [uses(36, a(ind, n29))]).
substitution(38, ['X' = ind]).
proof(38, a(ind, n31), rule(92), [uses(37, a(ind, n30))]).
substitution(39, ['X' = ind]).
proof(39, a(ind, n32), rule(95), [uses(38, a(ind, n31))]).
substitution(40, ['X' = ind]).
proof(40, a(ind, n33), rule(98), [uses(39, a(ind, n32))]).
substitution(41, ['X' = ind]).
proof(41, a(ind, n34), rule(101), [uses(40, a(ind, n33))]).
substitution(42, ['X' = ind]).
proof(42, a(ind, n35), rule(104), [uses(41, a(ind, n34))]).
substitution(43, ['X' = ind]).
proof(43, a(ind, n36), rule(107), [uses(42, a(ind, n35))]).
substitution(44, ['X' = ind]).
proof(44, a(ind, n37), rule(110), [uses(43, a(ind, n36))]).
substitution(45, ['X' = ind]).
proof(45, a(ind, n38), rule(113), [uses(44, a(ind, n37))]).
substitution(46, ['X' = ind]).
proof(46, a(ind, n39), rule(116), [uses(45, a(ind, n38))]).
substitution(47, ['X' = ind]).
proof(47, a(ind, n40), rule(119), [uses(46, a(ind, n39))]).
substitution(48, ['X' = ind]).
proof(48, a(ind, n41), rule(122), [uses(47, a(ind, n40))]).
substitution(49, ['X' = ind]).
proof(49, a(ind, n42), rule(125), [uses(48, a(ind, n41))]).
substitution(50, ['X' = ind]).
proof(50, a(ind, n43), rule(128), [uses(49, a(ind, n42))]).
substitution(51, ['X' = ind]).
proof(51, a(ind, n44), rule(131), [uses(50, a(ind, n43))]).
substitution(52, ['X' = ind]).
proof(52, a(ind, n45), rule(134), [uses(51, a(ind, n44))]).
substitution(53, ['X' = ind]).
proof(53, a(ind, n46), rule(137), [uses(52, a(ind, n45))]).
substitution(54, ['X' = ind]).
proof(54, a(ind, n47), rule(140), [uses(53, a(ind, n46))]).
substitution(55, ['X' = ind]).
proof(55, a(ind, n48), rule(143), [uses(54, a(ind, n47))]).
substitution(56, ['X' = ind]).
proof(56, a(ind, n49), rule(146), [uses(55, a(ind, n48))]).
substitution(57, ['X' = ind]).
proof(57, a(ind, n50), rule(149), [uses(56, a(ind, n49))]).
substitution(58, ['X' = ind]).
proof(58, a(ind, n51), rule(152), [uses(57, a(ind, n50))]).
substitution(59, ['X' = ind]).
proof(59, a(ind, i50), rule(150), [uses(56, a(ind, n49))]).
substitution(60, ['X' = ind]).
proof(60, a(ind, n52), rule(155), [uses(58, a(ind, n51))]).
substitution(61, ['X' = ind]).
proof(61, a(ind, n53), rule(158), [uses(60, a(ind, n52))]).
substitution(62, ['X' = ind]).
proof(62, a(ind, j50), rule(151), [uses(56, a(ind, n49))]).
substitution(63, ['X' = ind]).
proof(63, a(ind, n54), rule(161), [uses(61, a(ind, n53))]).
substitution(64, []).
proof(64, arc(check3, "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches."), rule(306), [uses(57, a(ind, n50)), uses(59, a(ind, i50)), uses(62, a(ind, j50))]).
substitution(65, ['X' = ind]).
proof(65, a(ind, n55), rule(164), [uses(63, a(ind, n54))]).
substitution(66, ['Check' = check3, 'Message' = "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches."]).
proof(66, solution([check3, "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches."]), query, [uses(64, arc(check3, "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches."))]).
substitution(67, ['X' = ind]).
proof(67, a(ind, n56), rule(167), [uses(65, a(ind, n55))]).
substitution(68, ['X' = ind]).
proof(68, a(ind, n57), rule(170), [uses(67, a(ind, n56))]).
substitution(69, ['X' = ind]).
proof(69, a(ind, n58), rule(173), [uses(68, a(ind, n57))]).
substitution(70, ['X' = ind]).
proof(70, a(ind, n59), rule(176), [uses(69, a(ind, n58))]).
substitution(71, ['X' = ind]).
proof(71, a(ind, n60), rule(179), [uses(70, a(ind, n59))]).
substitution(72, ['X' = ind]).
proof(72, a(ind, n61), rule(182), [uses(71, a(ind, n60))]).
substitution(73, ['X' = ind]).
proof(73, a(ind, n62), rule(185), [uses(72, a(ind, n61))]).
substitution(74, ['X' = ind]).
proof(74, a(ind, n63), rule(188), [uses(73, a(ind, n62))]).
substitution(75, ['X' = ind]).
proof(75, a(ind, n64), rule(191), [uses(74, a(ind, n63))]).
substitution(76, ['X' = ind]).
proof(76, a(ind, n65), rule(194), [uses(75, a(ind, n64))]).
substitution(77, ['X' = ind]).
proof(77, a(ind, n66), rule(197), [uses(76, a(ind, n65))]).
substitution(78, ['X' = ind]).
proof(78, a(ind, n67), rule(200), [uses(77, a(ind, n66))]).
substitution(79, ['X' = ind]).
proof(79, a(ind, n68), rule(203), [uses(78, a(ind, n67))]).
substitution(80, ['X' = ind]).
proof(80, a(ind, n69), rule(206), [uses(79, a(ind, n68))]).
substitution(81, ['X' = ind]).
proof(81, a(ind, n70), rule(209), [uses(80, a(ind, n69))]).
substitution(82, ['X' = ind]).
proof(82, a(ind, n71), rule(212), [uses(81, a(ind, n70))]).
substitution(83, ['X' = ind]).
proof(83, a(ind, n72), rule(215), [uses(82, a(ind, n71))]).
substitution(84, ['X' = ind]).
proof(84, a(ind, n73), rule(218), [uses(83, a(ind, n72))]).
substitution(85, ['X' = ind]).
proof(85, a(ind, n74), rule(221), [uses(84, a(ind, n73))]).
substitution(86, ['X' = ind]).
proof(86, a(ind, n75), rule(224), [uses(85, a(ind, n74))]).
substitution(87, ['X' = ind]).
proof(87, a(ind, n76), rule(227), [uses(86, a(ind, n75))]).
substitution(88, ['X' = ind]).
proof(88, a(ind, n77), rule(230), [uses(87, a(ind, n76))]).
substitution(89, ['X' = ind]).
proof(89, a(ind, n78), rule(233), [uses(88, a(ind, n77))]).
substitution(90, ['X' = ind]).
proof(90, a(ind, n79), rule(236), [uses(89, a(ind, n78))]).
substitution(91, ['X' = ind]).
proof(91, a(ind, n80), rule(239), [uses(90, a(ind, n79))]).
substitution(92, ['X' = ind]).
proof(92, a(ind, n81), rule(242), [uses(91, a(ind, n80))]).
substitution(93, ['X' = ind]).
proof(93, a(ind, n82), rule(245), [uses(92, a(ind, n81))]).
substitution(94, ['X' = ind]).
proof(94, a(ind, n83), rule(248), [uses(93, a(ind, n82))]).
substitution(95, ['X' = ind]).
proof(95, a(ind, n84), rule(251), [uses(94, a(ind, n83))]).
substitution(96, ['X' = ind]).
proof(96, a(ind, n85), rule(254), [uses(95, a(ind, n84))]).
substitution(97, ['X' = ind]).
proof(97, a(ind, n86), rule(257), [uses(96, a(ind, n85))]).
substitution(98, ['X' = ind]).
proof(98, a(ind, n87), rule(260), [uses(97, a(ind, n86))]).
substitution(99, ['X' = ind]).
proof(99, a(ind, n88), rule(263), [uses(98, a(ind, n87))]).
substitution(100, ['X' = ind]).
proof(100, a(ind, n89), rule(266), [uses(99, a(ind, n88))]).
substitution(101, ['X' = ind]).
proof(101, a(ind, n90), rule(269), [uses(100, a(ind, n89))]).
substitution(102, ['X' = ind]).
proof(102, a(ind, n91), rule(272), [uses(101, a(ind, n90))]).
substitution(103, ['X' = ind]).
proof(103, a(ind, n92), rule(275), [uses(102, a(ind, n91))]).
substitution(104, ['X' = ind]).
proof(104, a(ind, n93), rule(278), [uses(103, a(ind, n92))]).
substitution(105, ['X' = ind]).
proof(105, a(ind, n94), rule(281), [uses(104, a(ind, n93))]).
substitution(106, ['X' = ind]).
proof(106, a(ind, n95), rule(284), [uses(105, a(ind, n94))]).
substitution(107, ['X' = ind]).
proof(107, a(ind, n96), rule(287), [uses(106, a(ind, n95))]).
substitution(108, ['X' = ind]).
proof(108, a(ind, n97), rule(290), [uses(107, a(ind, n96))]).
substitution(109, ['X' = ind]).
proof(109, a(ind, n98), rule(293), [uses(108, a(ind, n97))]).
substitution(110, ['X' = ind]).
proof(110, a(ind, n99), rule(296), [uses(109, a(ind, n98))]).
substitution(111, ['X' = ind]).
proof(111, a(ind, n100), rule(299), [uses(110, a(ind, n99))]).
substitution(112, []).
proof(112, arc(check4, "C4 OK - the final taxonomy step from n99 to n100 was completed."), rule(307), [uses(110, a(ind, n99)), uses(111, a(ind, n100))]).
substitution(113, ['X' = ind]).
proof(113, a(ind, a2), rule(302), [uses(111, a(ind, n100))]).
substitution(114, ['Check' = check4, 'Message' = "C4 OK - the final taxonomy step from n99 to n100 was completed."]).
proof(114, solution([check4, "C4 OK - the final taxonomy step from n99 to n100 was completed."]), query, [uses(112, arc(check4, "C4 OK - the final taxonomy step from n99 to n100 was completed."))]).
substitution(115, []).
proof(115, arc(check5, "C5 OK - once n100 is reached, the terminal class a2 is derived."), rule(308), [uses(111, a(ind, n100)), uses(113, a(ind, a2))]).
substitution(116, ['Check' = check5, 'Message' = "C5 OK - once n100 is reached, the terminal class a2 is derived."]).
proof(116, solution([check5, "C5 OK - once n100 is reached, the terminal class a2 is derived."]), query, [uses(115, arc(check5, "C5 OK - once n100 is reached, the terminal class a2 is derived."))]).
substitution(117, []).
proof(117, holds_result(test, true), rule(303), [uses(113, a(ind, a2))]).
substitution(118, []).
proof(118, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."), rule(309), [uses(113, a(ind, a2)), uses(117, holds_result(test, true))]).
substitution(119, ['Check' = check6, 'Message' = "C6 OK - the success flag is raised only after the terminal class a2 is present."]).
proof(119, solution([check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."]), query, [uses(118, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."))]).
substitution(120, []).
proof(120, a(ind, n0), rule(1), []).
substitution(121, ['X' = ind]).
proof(121, a(ind, n1), rule(2), [uses(120, a(ind, n0))]).
substitution(122, ['X' = ind]).
proof(122, a(ind, n2), rule(5), [uses(121, a(ind, n1))]).
substitution(123, ['X' = ind]).
proof(123, a(ind, n3), rule(8), [uses(122, a(ind, n2))]).
substitution(124, ['X' = ind]).
proof(124, a(ind, n4), rule(11), [uses(123, a(ind, n3))]).
substitution(125, ['X' = ind]).
proof(125, a(ind, n5), rule(14), [uses(124, a(ind, n4))]).
substitution(126, ['X' = ind]).
proof(126, a(ind, n6), rule(17), [uses(125, a(ind, n5))]).
substitution(127, ['X' = ind]).
proof(127, a(ind, n7), rule(20), [uses(126, a(ind, n6))]).
substitution(128, ['X' = ind]).
proof(128, a(ind, n8), rule(23), [uses(127, a(ind, n7))]).
substitution(129, ['X' = ind]).
proof(129, a(ind, n9), rule(26), [uses(128, a(ind, n8))]).
substitution(130, ['X' = ind]).
proof(130, a(ind, n10), rule(29), [uses(129, a(ind, n9))]).
substitution(131, ['X' = ind]).
proof(131, a(ind, n11), rule(32), [uses(130, a(ind, n10))]).
substitution(132, ['X' = ind]).
proof(132, a(ind, n12), rule(35), [uses(131, a(ind, n11))]).
substitution(133, ['X' = ind]).
proof(133, a(ind, n13), rule(38), [uses(132, a(ind, n12))]).
substitution(134, ['X' = ind]).
proof(134, a(ind, n14), rule(41), [uses(133, a(ind, n13))]).
substitution(135, ['X' = ind]).
proof(135, a(ind, n15), rule(44), [uses(134, a(ind, n14))]).
substitution(136, ['X' = ind]).
proof(136, a(ind, n16), rule(47), [uses(135, a(ind, n15))]).
substitution(137, ['X' = ind]).
proof(137, a(ind, n17), rule(50), [uses(136, a(ind, n16))]).
substitution(138, ['X' = ind]).
proof(138, a(ind, n18), rule(53), [uses(137, a(ind, n17))]).
substitution(139, ['X' = ind]).
proof(139, a(ind, n19), rule(56), [uses(138, a(ind, n18))]).
substitution(140, ['X' = ind]).
proof(140, a(ind, n20), rule(59), [uses(139, a(ind, n19))]).
substitution(141, ['X' = ind]).
proof(141, a(ind, n21), rule(62), [uses(140, a(ind, n20))]).
substitution(142, ['X' = ind]).
proof(142, a(ind, n22), rule(65), [uses(141, a(ind, n21))]).
substitution(143, ['X' = ind]).
proof(143, a(ind, n23), rule(68), [uses(142, a(ind, n22))]).
substitution(144, ['X' = ind]).
proof(144, a(ind, n24), rule(71), [uses(143, a(ind, n23))]).
substitution(145, ['X' = ind]).
proof(145, a(ind, n25), rule(74), [uses(144, a(ind, n24))]).
substitution(146, ['X' = ind]).
proof(146, a(ind, n26), rule(77), [uses(145, a(ind, n25))]).
substitution(147, ['X' = ind]).
proof(147, a(ind, n27), rule(80), [uses(146, a(ind, n26))]).
substitution(148, ['X' = ind]).
proof(148, a(ind, n28), rule(83), [uses(147, a(ind, n27))]).
substitution(149, ['X' = ind]).
proof(149, a(ind, n29), rule(86), [uses(148, a(ind, n28))]).
substitution(150, ['X' = ind]).
proof(150, a(ind, n30), rule(89), [uses(149, a(ind, n29))]).
substitution(151, ['X' = ind]).
proof(151, a(ind, n31), rule(92), [uses(150, a(ind, n30))]).
substitution(152, ['X' = ind]).
proof(152, a(ind, n32), rule(95), [uses(151, a(ind, n31))]).
substitution(153, ['X' = ind]).
proof(153, a(ind, n33), rule(98), [uses(152, a(ind, n32))]).
substitution(154, ['X' = ind]).
proof(154, a(ind, n34), rule(101), [uses(153, a(ind, n33))]).
substitution(155, ['X' = ind]).
proof(155, a(ind, n35), rule(104), [uses(154, a(ind, n34))]).
substitution(156, ['X' = ind]).
proof(156, a(ind, n36), rule(107), [uses(155, a(ind, n35))]).
substitution(157, ['X' = ind]).
proof(157, a(ind, n37), rule(110), [uses(156, a(ind, n36))]).
substitution(158, ['X' = ind]).
proof(158, a(ind, n38), rule(113), [uses(157, a(ind, n37))]).
substitution(159, ['X' = ind]).
proof(159, a(ind, n39), rule(116), [uses(158, a(ind, n38))]).
substitution(160, ['X' = ind]).
proof(160, a(ind, n40), rule(119), [uses(159, a(ind, n39))]).
substitution(161, ['X' = ind]).
proof(161, a(ind, n41), rule(122), [uses(160, a(ind, n40))]).
substitution(162, ['X' = ind]).
proof(162, a(ind, n42), rule(125), [uses(161, a(ind, n41))]).
substitution(163, ['X' = ind]).
proof(163, a(ind, n43), rule(128), [uses(162, a(ind, n42))]).
substitution(164, ['X' = ind]).
proof(164, a(ind, n44), rule(131), [uses(163, a(ind, n43))]).
substitution(165, ['X' = ind]).
proof(165, a(ind, n45), rule(134), [uses(164, a(ind, n44))]).
substitution(166, ['X' = ind]).
proof(166, a(ind, n46), rule(137), [uses(165, a(ind, n45))]).
substitution(167, ['X' = ind]).
proof(167, a(ind, n47), rule(140), [uses(166, a(ind, n46))]).
substitution(168, ['X' = ind]).
proof(168, a(ind, n48), rule(143), [uses(167, a(ind, n47))]).
substitution(169, ['X' = ind]).
proof(169, a(ind, n49), rule(146), [uses(168, a(ind, n48))]).
substitution(170, ['X' = ind]).
proof(170, a(ind, n50), rule(149), [uses(169, a(ind, n49))]).
substitution(171, ['X' = ind]).
proof(171, a(ind, n51), rule(152), [uses(170, a(ind, n50))]).
substitution(172, ['X' = ind]).
proof(172, a(ind, n52), rule(155), [uses(171, a(ind, n51))]).
substitution(173, ['X' = ind]).
proof(173, a(ind, n53), rule(158), [uses(172, a(ind, n52))]).
substitution(174, ['X' = ind]).
proof(174, a(ind, n54), rule(161), [uses(173, a(ind, n53))]).
substitution(175, ['X' = ind]).
proof(175, a(ind, n55), rule(164), [uses(174, a(ind, n54))]).
substitution(176, ['X' = ind]).
proof(176, a(ind, n56), rule(167), [uses(175, a(ind, n55))]).
substitution(177, ['X' = ind]).
proof(177, a(ind, n57), rule(170), [uses(176, a(ind, n56))]).
substitution(178, ['X' = ind]).
proof(178, a(ind, n58), rule(173), [uses(177, a(ind, n57))]).
substitution(179, ['X' = ind]).
proof(179, a(ind, n59), rule(176), [uses(178, a(ind, n58))]).
substitution(180, ['X' = ind]).
proof(180, a(ind, n60), rule(179), [uses(179, a(ind, n59))]).
substitution(181, ['X' = ind]).
proof(181, a(ind, n61), rule(182), [uses(180, a(ind, n60))]).
substitution(182, ['X' = ind]).
proof(182, a(ind, n62), rule(185), [uses(181, a(ind, n61))]).
substitution(183, ['X' = ind]).
proof(183, a(ind, n63), rule(188), [uses(182, a(ind, n62))]).
substitution(184, ['X' = ind]).
proof(184, a(ind, n64), rule(191), [uses(183, a(ind, n63))]).
substitution(185, ['X' = ind]).
proof(185, a(ind, n65), rule(194), [uses(184, a(ind, n64))]).
substitution(186, ['X' = ind]).
proof(186, a(ind, n66), rule(197), [uses(185, a(ind, n65))]).
substitution(187, ['X' = ind]).
proof(187, a(ind, n67), rule(200), [uses(186, a(ind, n66))]).
substitution(188, ['X' = ind]).
proof(188, a(ind, n68), rule(203), [uses(187, a(ind, n67))]).
substitution(189, ['X' = ind]).
proof(189, a(ind, n69), rule(206), [uses(188, a(ind, n68))]).
substitution(190, ['X' = ind]).
proof(190, a(ind, n70), rule(209), [uses(189, a(ind, n69))]).
substitution(191, ['X' = ind]).
proof(191, a(ind, n71), rule(212), [uses(190, a(ind, n70))]).
substitution(192, ['X' = ind]).
proof(192, a(ind, n72), rule(215), [uses(191, a(ind, n71))]).
substitution(193, ['X' = ind]).
proof(193, a(ind, n73), rule(218), [uses(192, a(ind, n72))]).
substitution(194, ['X' = ind]).
proof(194, a(ind, n74), rule(221), [uses(193, a(ind, n73))]).
substitution(195, ['X' = ind]).
proof(195, a(ind, n75), rule(224), [uses(194, a(ind, n74))]).
substitution(196, ['X' = ind]).
proof(196, a(ind, n76), rule(227), [uses(195, a(ind, n75))]).
substitution(197, ['X' = ind]).
proof(197, a(ind, n77), rule(230), [uses(196, a(ind, n76))]).
substitution(198, ['X' = ind]).
proof(198, a(ind, n78), rule(233), [uses(197, a(ind, n77))]).
substitution(199, ['X' = ind]).
proof(199, a(ind, n79), rule(236), [uses(198, a(ind, n78))]).
substitution(200, ['X' = ind]).
proof(200, a(ind, n80), rule(239), [uses(199, a(ind, n79))]).
substitution(201, ['X' = ind]).
proof(201, a(ind, n81), rule(242), [uses(200, a(ind, n80))]).
substitution(202, ['X' = ind]).
proof(202, a(ind, n82), rule(245), [uses(201, a(ind, n81))]).
substitution(203, ['X' = ind]).
proof(203, a(ind, n83), rule(248), [uses(202, a(ind, n82))]).
substitution(204, ['X' = ind]).
proof(204, a(ind, n84), rule(251), [uses(203, a(ind, n83))]).
substitution(205, ['X' = ind]).
proof(205, a(ind, n85), rule(254), [uses(204, a(ind, n84))]).
substitution(206, ['X' = ind]).
proof(206, a(ind, n86), rule(257), [uses(205, a(ind, n85))]).
substitution(207, ['X' = ind]).
proof(207, a(ind, n87), rule(260), [uses(206, a(ind, n86))]).
substitution(208, ['X' = ind]).
proof(208, a(ind, n88), rule(263), [uses(207, a(ind, n87))]).
substitution(209, ['X' = ind]).
proof(209, a(ind, n89), rule(266), [uses(208, a(ind, n88))]).
substitution(210, ['X' = ind]).
proof(210, a(ind, n90), rule(269), [uses(209, a(ind, n89))]).
substitution(211, ['X' = ind]).
proof(211, a(ind, n91), rule(272), [uses(210, a(ind, n90))]).
substitution(212, ['X' = ind]).
proof(212, a(ind, n92), rule(275), [uses(211, a(ind, n91))]).
substitution(213, ['X' = ind]).
proof(213, a(ind, n93), rule(278), [uses(212, a(ind, n92))]).
substitution(214, ['X' = ind]).
proof(214, a(ind, n94), rule(281), [uses(213, a(ind, n93))]).
substitution(215, ['X' = ind]).
proof(215, a(ind, n95), rule(284), [uses(214, a(ind, n94))]).
substitution(216, ['X' = ind]).
proof(216, a(ind, n96), rule(287), [uses(215, a(ind, n95))]).
substitution(217, ['X' = ind]).
proof(217, a(ind, n97), rule(290), [uses(216, a(ind, n96))]).
substitution(218, ['X' = ind]).
proof(218, a(ind, n98), rule(293), [uses(217, a(ind, n97))]).
substitution(219, ['X' = ind]).
proof(219, a(ind, n99), rule(296), [uses(218, a(ind, n98))]).
substitution(220, ['X' = ind]).
proof(220, a(ind, n100), rule(299), [uses(219, a(ind, n99))]).
substitution(221, ['X' = ind]).
proof(221, a(ind, a2), rule(302), [uses(220, a(ind, n100))]).
substitution(222, []).
proof(222, holds_result(test, true), rule(303), [uses(221, a(ind, a2))]).
substitution(223, []).
proof(223, solution([]), query, [uses(222, holds_result(test, true))]).
