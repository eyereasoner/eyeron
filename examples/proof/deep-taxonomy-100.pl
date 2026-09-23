arc(check1, "C1 OK - the starting classification n0 is present.").
arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1.").
arc(check3,
    "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches.").
arc(check4, "C4 OK - the final taxonomy step from n99 to n100 was completed.").
arc(check5, "C5 OK - once n100 is reached, the terminal class a2 is derived.").
arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present.").
holds_result(test, true).

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
clause(305,
       arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."),
       (a(ind, n1), a(ind, i1), a(ind, j1))).
clause(306,
       arc(check3, "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches."),
       (a(ind, n50), a(ind, i50), a(ind, j50))).
clause(307,
       arc(check4, "C4 OK - the final taxonomy step from n99 to n100 was completed."),
       (a(ind, n99), a(ind, n100))).
clause(308,
       arc(check5, "C5 OK - once n100 is reached, the terminal class a2 is derived."),
       (a(ind, n100), a(ind, a2))).
clause(309,
       arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."),
       (a(ind, a2), holds_result(test, true))).

step(arc(check1, "C1 OK - the starting classification n0 is present."),
     rule(304),
     [],
     [a(ind, n0)]).
step(a(ind, n0), fact(1), [], []).
step(arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."),
     rule(305),
     [],
     [a(ind, n1), a(ind, i1), a(ind, j1)]).
step(a(ind, n1), rule(2), ['X' = ind], [a(ind, n0)]).
step(a(ind, i1), rule(3), ['X' = ind], [a(ind, n0)]).
step(a(ind, j1), rule(4), ['X' = ind], [a(ind, n0)]).
step(arc(check3, "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches."),
     rule(306),
     [],
     [a(ind, n50), a(ind, i50), a(ind, j50)]).
step(a(ind, n50), rule(149), ['X' = ind], [a(ind, n49)]).
step(a(ind, n49), rule(146), ['X' = ind], [a(ind, n48)]).
step(a(ind, n48), rule(143), ['X' = ind], [a(ind, n47)]).
step(a(ind, n47), rule(140), ['X' = ind], [a(ind, n46)]).
step(a(ind, n46), rule(137), ['X' = ind], [a(ind, n45)]).
step(a(ind, n45), rule(134), ['X' = ind], [a(ind, n44)]).
step(a(ind, n44), rule(131), ['X' = ind], [a(ind, n43)]).
step(a(ind, n43), rule(128), ['X' = ind], [a(ind, n42)]).
step(a(ind, n42), rule(125), ['X' = ind], [a(ind, n41)]).
step(a(ind, n41), rule(122), ['X' = ind], [a(ind, n40)]).
step(a(ind, n40), rule(119), ['X' = ind], [a(ind, n39)]).
step(a(ind, n39), rule(116), ['X' = ind], [a(ind, n38)]).
step(a(ind, n38), rule(113), ['X' = ind], [a(ind, n37)]).
step(a(ind, n37), rule(110), ['X' = ind], [a(ind, n36)]).
step(a(ind, n36), rule(107), ['X' = ind], [a(ind, n35)]).
step(a(ind, n35), rule(104), ['X' = ind], [a(ind, n34)]).
step(a(ind, n34), rule(101), ['X' = ind], [a(ind, n33)]).
step(a(ind, n33), rule(98), ['X' = ind], [a(ind, n32)]).
step(a(ind, n32), rule(95), ['X' = ind], [a(ind, n31)]).
step(a(ind, n31), rule(92), ['X' = ind], [a(ind, n30)]).
step(a(ind, n30), rule(89), ['X' = ind], [a(ind, n29)]).
step(a(ind, n29), rule(86), ['X' = ind], [a(ind, n28)]).
step(a(ind, n28), rule(83), ['X' = ind], [a(ind, n27)]).
step(a(ind, n27), rule(80), ['X' = ind], [a(ind, n26)]).
step(a(ind, n26), rule(77), ['X' = ind], [a(ind, n25)]).
step(a(ind, n25), rule(74), ['X' = ind], [a(ind, n24)]).
step(a(ind, n24), rule(71), ['X' = ind], [a(ind, n23)]).
step(a(ind, n23), rule(68), ['X' = ind], [a(ind, n22)]).
step(a(ind, n22), rule(65), ['X' = ind], [a(ind, n21)]).
step(a(ind, n21), rule(62), ['X' = ind], [a(ind, n20)]).
step(a(ind, n20), rule(59), ['X' = ind], [a(ind, n19)]).
step(a(ind, n19), rule(56), ['X' = ind], [a(ind, n18)]).
step(a(ind, n18), rule(53), ['X' = ind], [a(ind, n17)]).
step(a(ind, n17), rule(50), ['X' = ind], [a(ind, n16)]).
step(a(ind, n16), rule(47), ['X' = ind], [a(ind, n15)]).
step(a(ind, n15), rule(44), ['X' = ind], [a(ind, n14)]).
step(a(ind, n14), rule(41), ['X' = ind], [a(ind, n13)]).
step(a(ind, n13), rule(38), ['X' = ind], [a(ind, n12)]).
step(a(ind, n12), rule(35), ['X' = ind], [a(ind, n11)]).
step(a(ind, n11), rule(32), ['X' = ind], [a(ind, n10)]).
step(a(ind, n10), rule(29), ['X' = ind], [a(ind, n9)]).
step(a(ind, n9), rule(26), ['X' = ind], [a(ind, n8)]).
step(a(ind, n8), rule(23), ['X' = ind], [a(ind, n7)]).
step(a(ind, n7), rule(20), ['X' = ind], [a(ind, n6)]).
step(a(ind, n6), rule(17), ['X' = ind], [a(ind, n5)]).
step(a(ind, n5), rule(14), ['X' = ind], [a(ind, n4)]).
step(a(ind, n4), rule(11), ['X' = ind], [a(ind, n3)]).
step(a(ind, n3), rule(8), ['X' = ind], [a(ind, n2)]).
step(a(ind, n2), rule(5), ['X' = ind], [a(ind, n1)]).
step(a(ind, i50), rule(150), ['X' = ind], [a(ind, n49)]).
step(a(ind, j50), rule(151), ['X' = ind], [a(ind, n49)]).
step(arc(check4, "C4 OK - the final taxonomy step from n99 to n100 was completed."),
     rule(307),
     [],
     [a(ind, n99), a(ind, n100)]).
step(a(ind, n99), rule(296), ['X' = ind], [a(ind, n98)]).
step(a(ind, n98), rule(293), ['X' = ind], [a(ind, n97)]).
step(a(ind, n97), rule(290), ['X' = ind], [a(ind, n96)]).
step(a(ind, n96), rule(287), ['X' = ind], [a(ind, n95)]).
step(a(ind, n95), rule(284), ['X' = ind], [a(ind, n94)]).
step(a(ind, n94), rule(281), ['X' = ind], [a(ind, n93)]).
step(a(ind, n93), rule(278), ['X' = ind], [a(ind, n92)]).
step(a(ind, n92), rule(275), ['X' = ind], [a(ind, n91)]).
step(a(ind, n91), rule(272), ['X' = ind], [a(ind, n90)]).
step(a(ind, n90), rule(269), ['X' = ind], [a(ind, n89)]).
step(a(ind, n89), rule(266), ['X' = ind], [a(ind, n88)]).
step(a(ind, n88), rule(263), ['X' = ind], [a(ind, n87)]).
step(a(ind, n87), rule(260), ['X' = ind], [a(ind, n86)]).
step(a(ind, n86), rule(257), ['X' = ind], [a(ind, n85)]).
step(a(ind, n85), rule(254), ['X' = ind], [a(ind, n84)]).
step(a(ind, n84), rule(251), ['X' = ind], [a(ind, n83)]).
step(a(ind, n83), rule(248), ['X' = ind], [a(ind, n82)]).
step(a(ind, n82), rule(245), ['X' = ind], [a(ind, n81)]).
step(a(ind, n81), rule(242), ['X' = ind], [a(ind, n80)]).
step(a(ind, n80), rule(239), ['X' = ind], [a(ind, n79)]).
step(a(ind, n79), rule(236), ['X' = ind], [a(ind, n78)]).
step(a(ind, n78), rule(233), ['X' = ind], [a(ind, n77)]).
step(a(ind, n77), rule(230), ['X' = ind], [a(ind, n76)]).
step(a(ind, n76), rule(227), ['X' = ind], [a(ind, n75)]).
step(a(ind, n75), rule(224), ['X' = ind], [a(ind, n74)]).
step(a(ind, n74), rule(221), ['X' = ind], [a(ind, n73)]).
step(a(ind, n73), rule(218), ['X' = ind], [a(ind, n72)]).
step(a(ind, n72), rule(215), ['X' = ind], [a(ind, n71)]).
step(a(ind, n71), rule(212), ['X' = ind], [a(ind, n70)]).
step(a(ind, n70), rule(209), ['X' = ind], [a(ind, n69)]).
step(a(ind, n69), rule(206), ['X' = ind], [a(ind, n68)]).
step(a(ind, n68), rule(203), ['X' = ind], [a(ind, n67)]).
step(a(ind, n67), rule(200), ['X' = ind], [a(ind, n66)]).
step(a(ind, n66), rule(197), ['X' = ind], [a(ind, n65)]).
step(a(ind, n65), rule(194), ['X' = ind], [a(ind, n64)]).
step(a(ind, n64), rule(191), ['X' = ind], [a(ind, n63)]).
step(a(ind, n63), rule(188), ['X' = ind], [a(ind, n62)]).
step(a(ind, n62), rule(185), ['X' = ind], [a(ind, n61)]).
step(a(ind, n61), rule(182), ['X' = ind], [a(ind, n60)]).
step(a(ind, n60), rule(179), ['X' = ind], [a(ind, n59)]).
step(a(ind, n59), rule(176), ['X' = ind], [a(ind, n58)]).
step(a(ind, n58), rule(173), ['X' = ind], [a(ind, n57)]).
step(a(ind, n57), rule(170), ['X' = ind], [a(ind, n56)]).
step(a(ind, n56), rule(167), ['X' = ind], [a(ind, n55)]).
step(a(ind, n55), rule(164), ['X' = ind], [a(ind, n54)]).
step(a(ind, n54), rule(161), ['X' = ind], [a(ind, n53)]).
step(a(ind, n53), rule(158), ['X' = ind], [a(ind, n52)]).
step(a(ind, n52), rule(155), ['X' = ind], [a(ind, n51)]).
step(a(ind, n51), rule(152), ['X' = ind], [a(ind, n50)]).
step(a(ind, n100), rule(299), ['X' = ind], [a(ind, n99)]).
step(arc(check5, "C5 OK - once n100 is reached, the terminal class a2 is derived."),
     rule(308),
     [],
     [a(ind, n100), a(ind, a2)]).
step(a(ind, a2), rule(302), ['X' = ind], [a(ind, n100)]).
step(arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."),
     rule(309),
     [],
     [a(ind, a2), holds_result(test, true)]).
step(holds_result(test, true), rule(303), [], [a(ind, a2)]).
