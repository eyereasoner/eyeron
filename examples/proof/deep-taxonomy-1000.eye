# Eyelang result format 2
query(1, [call(arc(?v0, ?v1))], [binding("check", ?v0), binding("message", ?v1)]).
result(1, complete, 6).
answer(1, [binding("check", check1), binding("message", "C1 OK - the starting classification n0 is present.")]).
why(1, [binding("check", check1), binding("message", "C1 OK - the starting classification n0 is present.")], 4).
answer(1, [binding("check", check2), binding("message", "C2 OK - the first expansion produced n1 together with side labels i1 and j1.")]).
why(1, [binding("check", check2), binding("message", "C2 OK - the first expansion produced n1 together with side labels i1 and j1.")], 8).
answer(1, [binding("check", check3), binding("message", "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches.")]).
why(1, [binding("check", check3), binding("message", "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches.")], 516).
answer(1, [binding("check", check4), binding("message", "C4 OK - the final taxonomy step from n999 to n1000 was completed.")]).
why(1, [binding("check", check4), binding("message", "C4 OK - the final taxonomy step from n999 to n1000 was completed.")], 1014).
answer(1, [binding("check", check5), binding("message", "C5 OK - once n1000 is reached, the terminal class a2 is derived.")]).
why(1, [binding("check", check5), binding("message", "C5 OK - once n1000 is reached, the terminal class a2 is derived.")], 1016).
answer(1, [binding("check", check6), binding("message", "C6 OK - the success flag is raised only after the terminal class a2 is present.")]).
why(1, [binding("check", check6), binding("message", "C6 OK - the success flag is raised only after the terminal class a2 is present.")], 1019).
query(2, [call(holds_result(test, true))], []).
result(2, complete, 1).
answer(2, []).
why(2, [], 2023).
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
clause(302, a(var("x"), n101), [call(a(var("x"), n100))]).
clause(305, a(var("x"), n102), [call(a(var("x"), n101))]).
clause(308, a(var("x"), n103), [call(a(var("x"), n102))]).
clause(311, a(var("x"), n104), [call(a(var("x"), n103))]).
clause(314, a(var("x"), n105), [call(a(var("x"), n104))]).
clause(317, a(var("x"), n106), [call(a(var("x"), n105))]).
clause(320, a(var("x"), n107), [call(a(var("x"), n106))]).
clause(323, a(var("x"), n108), [call(a(var("x"), n107))]).
clause(326, a(var("x"), n109), [call(a(var("x"), n108))]).
clause(329, a(var("x"), n110), [call(a(var("x"), n109))]).
clause(332, a(var("x"), n111), [call(a(var("x"), n110))]).
clause(335, a(var("x"), n112), [call(a(var("x"), n111))]).
clause(338, a(var("x"), n113), [call(a(var("x"), n112))]).
clause(341, a(var("x"), n114), [call(a(var("x"), n113))]).
clause(344, a(var("x"), n115), [call(a(var("x"), n114))]).
clause(347, a(var("x"), n116), [call(a(var("x"), n115))]).
clause(350, a(var("x"), n117), [call(a(var("x"), n116))]).
clause(353, a(var("x"), n118), [call(a(var("x"), n117))]).
clause(356, a(var("x"), n119), [call(a(var("x"), n118))]).
clause(359, a(var("x"), n120), [call(a(var("x"), n119))]).
clause(362, a(var("x"), n121), [call(a(var("x"), n120))]).
clause(365, a(var("x"), n122), [call(a(var("x"), n121))]).
clause(368, a(var("x"), n123), [call(a(var("x"), n122))]).
clause(371, a(var("x"), n124), [call(a(var("x"), n123))]).
clause(374, a(var("x"), n125), [call(a(var("x"), n124))]).
clause(377, a(var("x"), n126), [call(a(var("x"), n125))]).
clause(380, a(var("x"), n127), [call(a(var("x"), n126))]).
clause(383, a(var("x"), n128), [call(a(var("x"), n127))]).
clause(386, a(var("x"), n129), [call(a(var("x"), n128))]).
clause(389, a(var("x"), n130), [call(a(var("x"), n129))]).
clause(392, a(var("x"), n131), [call(a(var("x"), n130))]).
clause(395, a(var("x"), n132), [call(a(var("x"), n131))]).
clause(398, a(var("x"), n133), [call(a(var("x"), n132))]).
clause(401, a(var("x"), n134), [call(a(var("x"), n133))]).
clause(404, a(var("x"), n135), [call(a(var("x"), n134))]).
clause(407, a(var("x"), n136), [call(a(var("x"), n135))]).
clause(410, a(var("x"), n137), [call(a(var("x"), n136))]).
clause(413, a(var("x"), n138), [call(a(var("x"), n137))]).
clause(416, a(var("x"), n139), [call(a(var("x"), n138))]).
clause(419, a(var("x"), n140), [call(a(var("x"), n139))]).
clause(422, a(var("x"), n141), [call(a(var("x"), n140))]).
clause(425, a(var("x"), n142), [call(a(var("x"), n141))]).
clause(428, a(var("x"), n143), [call(a(var("x"), n142))]).
clause(431, a(var("x"), n144), [call(a(var("x"), n143))]).
clause(434, a(var("x"), n145), [call(a(var("x"), n144))]).
clause(437, a(var("x"), n146), [call(a(var("x"), n145))]).
clause(440, a(var("x"), n147), [call(a(var("x"), n146))]).
clause(443, a(var("x"), n148), [call(a(var("x"), n147))]).
clause(446, a(var("x"), n149), [call(a(var("x"), n148))]).
clause(449, a(var("x"), n150), [call(a(var("x"), n149))]).
clause(452, a(var("x"), n151), [call(a(var("x"), n150))]).
clause(455, a(var("x"), n152), [call(a(var("x"), n151))]).
clause(458, a(var("x"), n153), [call(a(var("x"), n152))]).
clause(461, a(var("x"), n154), [call(a(var("x"), n153))]).
clause(464, a(var("x"), n155), [call(a(var("x"), n154))]).
clause(467, a(var("x"), n156), [call(a(var("x"), n155))]).
clause(470, a(var("x"), n157), [call(a(var("x"), n156))]).
clause(473, a(var("x"), n158), [call(a(var("x"), n157))]).
clause(476, a(var("x"), n159), [call(a(var("x"), n158))]).
clause(479, a(var("x"), n160), [call(a(var("x"), n159))]).
clause(482, a(var("x"), n161), [call(a(var("x"), n160))]).
clause(485, a(var("x"), n162), [call(a(var("x"), n161))]).
clause(488, a(var("x"), n163), [call(a(var("x"), n162))]).
clause(491, a(var("x"), n164), [call(a(var("x"), n163))]).
clause(494, a(var("x"), n165), [call(a(var("x"), n164))]).
clause(497, a(var("x"), n166), [call(a(var("x"), n165))]).
clause(500, a(var("x"), n167), [call(a(var("x"), n166))]).
clause(503, a(var("x"), n168), [call(a(var("x"), n167))]).
clause(506, a(var("x"), n169), [call(a(var("x"), n168))]).
clause(509, a(var("x"), n170), [call(a(var("x"), n169))]).
clause(512, a(var("x"), n171), [call(a(var("x"), n170))]).
clause(515, a(var("x"), n172), [call(a(var("x"), n171))]).
clause(518, a(var("x"), n173), [call(a(var("x"), n172))]).
clause(521, a(var("x"), n174), [call(a(var("x"), n173))]).
clause(524, a(var("x"), n175), [call(a(var("x"), n174))]).
clause(527, a(var("x"), n176), [call(a(var("x"), n175))]).
clause(530, a(var("x"), n177), [call(a(var("x"), n176))]).
clause(533, a(var("x"), n178), [call(a(var("x"), n177))]).
clause(536, a(var("x"), n179), [call(a(var("x"), n178))]).
clause(539, a(var("x"), n180), [call(a(var("x"), n179))]).
clause(542, a(var("x"), n181), [call(a(var("x"), n180))]).
clause(545, a(var("x"), n182), [call(a(var("x"), n181))]).
clause(548, a(var("x"), n183), [call(a(var("x"), n182))]).
clause(551, a(var("x"), n184), [call(a(var("x"), n183))]).
clause(554, a(var("x"), n185), [call(a(var("x"), n184))]).
clause(557, a(var("x"), n186), [call(a(var("x"), n185))]).
clause(560, a(var("x"), n187), [call(a(var("x"), n186))]).
clause(563, a(var("x"), n188), [call(a(var("x"), n187))]).
clause(566, a(var("x"), n189), [call(a(var("x"), n188))]).
clause(569, a(var("x"), n190), [call(a(var("x"), n189))]).
clause(572, a(var("x"), n191), [call(a(var("x"), n190))]).
clause(575, a(var("x"), n192), [call(a(var("x"), n191))]).
clause(578, a(var("x"), n193), [call(a(var("x"), n192))]).
clause(581, a(var("x"), n194), [call(a(var("x"), n193))]).
clause(584, a(var("x"), n195), [call(a(var("x"), n194))]).
clause(587, a(var("x"), n196), [call(a(var("x"), n195))]).
clause(590, a(var("x"), n197), [call(a(var("x"), n196))]).
clause(593, a(var("x"), n198), [call(a(var("x"), n197))]).
clause(596, a(var("x"), n199), [call(a(var("x"), n198))]).
clause(599, a(var("x"), n200), [call(a(var("x"), n199))]).
clause(602, a(var("x"), n201), [call(a(var("x"), n200))]).
clause(605, a(var("x"), n202), [call(a(var("x"), n201))]).
clause(608, a(var("x"), n203), [call(a(var("x"), n202))]).
clause(611, a(var("x"), n204), [call(a(var("x"), n203))]).
clause(614, a(var("x"), n205), [call(a(var("x"), n204))]).
clause(617, a(var("x"), n206), [call(a(var("x"), n205))]).
clause(620, a(var("x"), n207), [call(a(var("x"), n206))]).
clause(623, a(var("x"), n208), [call(a(var("x"), n207))]).
clause(626, a(var("x"), n209), [call(a(var("x"), n208))]).
clause(629, a(var("x"), n210), [call(a(var("x"), n209))]).
clause(632, a(var("x"), n211), [call(a(var("x"), n210))]).
clause(635, a(var("x"), n212), [call(a(var("x"), n211))]).
clause(638, a(var("x"), n213), [call(a(var("x"), n212))]).
clause(641, a(var("x"), n214), [call(a(var("x"), n213))]).
clause(644, a(var("x"), n215), [call(a(var("x"), n214))]).
clause(647, a(var("x"), n216), [call(a(var("x"), n215))]).
clause(650, a(var("x"), n217), [call(a(var("x"), n216))]).
clause(653, a(var("x"), n218), [call(a(var("x"), n217))]).
clause(656, a(var("x"), n219), [call(a(var("x"), n218))]).
clause(659, a(var("x"), n220), [call(a(var("x"), n219))]).
clause(662, a(var("x"), n221), [call(a(var("x"), n220))]).
clause(665, a(var("x"), n222), [call(a(var("x"), n221))]).
clause(668, a(var("x"), n223), [call(a(var("x"), n222))]).
clause(671, a(var("x"), n224), [call(a(var("x"), n223))]).
clause(674, a(var("x"), n225), [call(a(var("x"), n224))]).
clause(677, a(var("x"), n226), [call(a(var("x"), n225))]).
clause(680, a(var("x"), n227), [call(a(var("x"), n226))]).
clause(683, a(var("x"), n228), [call(a(var("x"), n227))]).
clause(686, a(var("x"), n229), [call(a(var("x"), n228))]).
clause(689, a(var("x"), n230), [call(a(var("x"), n229))]).
clause(692, a(var("x"), n231), [call(a(var("x"), n230))]).
clause(695, a(var("x"), n232), [call(a(var("x"), n231))]).
clause(698, a(var("x"), n233), [call(a(var("x"), n232))]).
clause(701, a(var("x"), n234), [call(a(var("x"), n233))]).
clause(704, a(var("x"), n235), [call(a(var("x"), n234))]).
clause(707, a(var("x"), n236), [call(a(var("x"), n235))]).
clause(710, a(var("x"), n237), [call(a(var("x"), n236))]).
clause(713, a(var("x"), n238), [call(a(var("x"), n237))]).
clause(716, a(var("x"), n239), [call(a(var("x"), n238))]).
clause(719, a(var("x"), n240), [call(a(var("x"), n239))]).
clause(722, a(var("x"), n241), [call(a(var("x"), n240))]).
clause(725, a(var("x"), n242), [call(a(var("x"), n241))]).
clause(728, a(var("x"), n243), [call(a(var("x"), n242))]).
clause(731, a(var("x"), n244), [call(a(var("x"), n243))]).
clause(734, a(var("x"), n245), [call(a(var("x"), n244))]).
clause(737, a(var("x"), n246), [call(a(var("x"), n245))]).
clause(740, a(var("x"), n247), [call(a(var("x"), n246))]).
clause(743, a(var("x"), n248), [call(a(var("x"), n247))]).
clause(746, a(var("x"), n249), [call(a(var("x"), n248))]).
clause(749, a(var("x"), n250), [call(a(var("x"), n249))]).
clause(752, a(var("x"), n251), [call(a(var("x"), n250))]).
clause(755, a(var("x"), n252), [call(a(var("x"), n251))]).
clause(758, a(var("x"), n253), [call(a(var("x"), n252))]).
clause(761, a(var("x"), n254), [call(a(var("x"), n253))]).
clause(764, a(var("x"), n255), [call(a(var("x"), n254))]).
clause(767, a(var("x"), n256), [call(a(var("x"), n255))]).
clause(770, a(var("x"), n257), [call(a(var("x"), n256))]).
clause(773, a(var("x"), n258), [call(a(var("x"), n257))]).
clause(776, a(var("x"), n259), [call(a(var("x"), n258))]).
clause(779, a(var("x"), n260), [call(a(var("x"), n259))]).
clause(782, a(var("x"), n261), [call(a(var("x"), n260))]).
clause(785, a(var("x"), n262), [call(a(var("x"), n261))]).
clause(788, a(var("x"), n263), [call(a(var("x"), n262))]).
clause(791, a(var("x"), n264), [call(a(var("x"), n263))]).
clause(794, a(var("x"), n265), [call(a(var("x"), n264))]).
clause(797, a(var("x"), n266), [call(a(var("x"), n265))]).
clause(800, a(var("x"), n267), [call(a(var("x"), n266))]).
clause(803, a(var("x"), n268), [call(a(var("x"), n267))]).
clause(806, a(var("x"), n269), [call(a(var("x"), n268))]).
clause(809, a(var("x"), n270), [call(a(var("x"), n269))]).
clause(812, a(var("x"), n271), [call(a(var("x"), n270))]).
clause(815, a(var("x"), n272), [call(a(var("x"), n271))]).
clause(818, a(var("x"), n273), [call(a(var("x"), n272))]).
clause(821, a(var("x"), n274), [call(a(var("x"), n273))]).
clause(824, a(var("x"), n275), [call(a(var("x"), n274))]).
clause(827, a(var("x"), n276), [call(a(var("x"), n275))]).
clause(830, a(var("x"), n277), [call(a(var("x"), n276))]).
clause(833, a(var("x"), n278), [call(a(var("x"), n277))]).
clause(836, a(var("x"), n279), [call(a(var("x"), n278))]).
clause(839, a(var("x"), n280), [call(a(var("x"), n279))]).
clause(842, a(var("x"), n281), [call(a(var("x"), n280))]).
clause(845, a(var("x"), n282), [call(a(var("x"), n281))]).
clause(848, a(var("x"), n283), [call(a(var("x"), n282))]).
clause(851, a(var("x"), n284), [call(a(var("x"), n283))]).
clause(854, a(var("x"), n285), [call(a(var("x"), n284))]).
clause(857, a(var("x"), n286), [call(a(var("x"), n285))]).
clause(860, a(var("x"), n287), [call(a(var("x"), n286))]).
clause(863, a(var("x"), n288), [call(a(var("x"), n287))]).
clause(866, a(var("x"), n289), [call(a(var("x"), n288))]).
clause(869, a(var("x"), n290), [call(a(var("x"), n289))]).
clause(872, a(var("x"), n291), [call(a(var("x"), n290))]).
clause(875, a(var("x"), n292), [call(a(var("x"), n291))]).
clause(878, a(var("x"), n293), [call(a(var("x"), n292))]).
clause(881, a(var("x"), n294), [call(a(var("x"), n293))]).
clause(884, a(var("x"), n295), [call(a(var("x"), n294))]).
clause(887, a(var("x"), n296), [call(a(var("x"), n295))]).
clause(890, a(var("x"), n297), [call(a(var("x"), n296))]).
clause(893, a(var("x"), n298), [call(a(var("x"), n297))]).
clause(896, a(var("x"), n299), [call(a(var("x"), n298))]).
clause(899, a(var("x"), n300), [call(a(var("x"), n299))]).
clause(902, a(var("x"), n301), [call(a(var("x"), n300))]).
clause(905, a(var("x"), n302), [call(a(var("x"), n301))]).
clause(908, a(var("x"), n303), [call(a(var("x"), n302))]).
clause(911, a(var("x"), n304), [call(a(var("x"), n303))]).
clause(914, a(var("x"), n305), [call(a(var("x"), n304))]).
clause(917, a(var("x"), n306), [call(a(var("x"), n305))]).
clause(920, a(var("x"), n307), [call(a(var("x"), n306))]).
clause(923, a(var("x"), n308), [call(a(var("x"), n307))]).
clause(926, a(var("x"), n309), [call(a(var("x"), n308))]).
clause(929, a(var("x"), n310), [call(a(var("x"), n309))]).
clause(932, a(var("x"), n311), [call(a(var("x"), n310))]).
clause(935, a(var("x"), n312), [call(a(var("x"), n311))]).
clause(938, a(var("x"), n313), [call(a(var("x"), n312))]).
clause(941, a(var("x"), n314), [call(a(var("x"), n313))]).
clause(944, a(var("x"), n315), [call(a(var("x"), n314))]).
clause(947, a(var("x"), n316), [call(a(var("x"), n315))]).
clause(950, a(var("x"), n317), [call(a(var("x"), n316))]).
clause(953, a(var("x"), n318), [call(a(var("x"), n317))]).
clause(956, a(var("x"), n319), [call(a(var("x"), n318))]).
clause(959, a(var("x"), n320), [call(a(var("x"), n319))]).
clause(962, a(var("x"), n321), [call(a(var("x"), n320))]).
clause(965, a(var("x"), n322), [call(a(var("x"), n321))]).
clause(968, a(var("x"), n323), [call(a(var("x"), n322))]).
clause(971, a(var("x"), n324), [call(a(var("x"), n323))]).
clause(974, a(var("x"), n325), [call(a(var("x"), n324))]).
clause(977, a(var("x"), n326), [call(a(var("x"), n325))]).
clause(980, a(var("x"), n327), [call(a(var("x"), n326))]).
clause(983, a(var("x"), n328), [call(a(var("x"), n327))]).
clause(986, a(var("x"), n329), [call(a(var("x"), n328))]).
clause(989, a(var("x"), n330), [call(a(var("x"), n329))]).
clause(992, a(var("x"), n331), [call(a(var("x"), n330))]).
clause(995, a(var("x"), n332), [call(a(var("x"), n331))]).
clause(998, a(var("x"), n333), [call(a(var("x"), n332))]).
clause(1001, a(var("x"), n334), [call(a(var("x"), n333))]).
clause(1004, a(var("x"), n335), [call(a(var("x"), n334))]).
clause(1007, a(var("x"), n336), [call(a(var("x"), n335))]).
clause(1010, a(var("x"), n337), [call(a(var("x"), n336))]).
clause(1013, a(var("x"), n338), [call(a(var("x"), n337))]).
clause(1016, a(var("x"), n339), [call(a(var("x"), n338))]).
clause(1019, a(var("x"), n340), [call(a(var("x"), n339))]).
clause(1022, a(var("x"), n341), [call(a(var("x"), n340))]).
clause(1025, a(var("x"), n342), [call(a(var("x"), n341))]).
clause(1028, a(var("x"), n343), [call(a(var("x"), n342))]).
clause(1031, a(var("x"), n344), [call(a(var("x"), n343))]).
clause(1034, a(var("x"), n345), [call(a(var("x"), n344))]).
clause(1037, a(var("x"), n346), [call(a(var("x"), n345))]).
clause(1040, a(var("x"), n347), [call(a(var("x"), n346))]).
clause(1043, a(var("x"), n348), [call(a(var("x"), n347))]).
clause(1046, a(var("x"), n349), [call(a(var("x"), n348))]).
clause(1049, a(var("x"), n350), [call(a(var("x"), n349))]).
clause(1052, a(var("x"), n351), [call(a(var("x"), n350))]).
clause(1055, a(var("x"), n352), [call(a(var("x"), n351))]).
clause(1058, a(var("x"), n353), [call(a(var("x"), n352))]).
clause(1061, a(var("x"), n354), [call(a(var("x"), n353))]).
clause(1064, a(var("x"), n355), [call(a(var("x"), n354))]).
clause(1067, a(var("x"), n356), [call(a(var("x"), n355))]).
clause(1070, a(var("x"), n357), [call(a(var("x"), n356))]).
clause(1073, a(var("x"), n358), [call(a(var("x"), n357))]).
clause(1076, a(var("x"), n359), [call(a(var("x"), n358))]).
clause(1079, a(var("x"), n360), [call(a(var("x"), n359))]).
clause(1082, a(var("x"), n361), [call(a(var("x"), n360))]).
clause(1085, a(var("x"), n362), [call(a(var("x"), n361))]).
clause(1088, a(var("x"), n363), [call(a(var("x"), n362))]).
clause(1091, a(var("x"), n364), [call(a(var("x"), n363))]).
clause(1094, a(var("x"), n365), [call(a(var("x"), n364))]).
clause(1097, a(var("x"), n366), [call(a(var("x"), n365))]).
clause(1100, a(var("x"), n367), [call(a(var("x"), n366))]).
clause(1103, a(var("x"), n368), [call(a(var("x"), n367))]).
clause(1106, a(var("x"), n369), [call(a(var("x"), n368))]).
clause(1109, a(var("x"), n370), [call(a(var("x"), n369))]).
clause(1112, a(var("x"), n371), [call(a(var("x"), n370))]).
clause(1115, a(var("x"), n372), [call(a(var("x"), n371))]).
clause(1118, a(var("x"), n373), [call(a(var("x"), n372))]).
clause(1121, a(var("x"), n374), [call(a(var("x"), n373))]).
clause(1124, a(var("x"), n375), [call(a(var("x"), n374))]).
clause(1127, a(var("x"), n376), [call(a(var("x"), n375))]).
clause(1130, a(var("x"), n377), [call(a(var("x"), n376))]).
clause(1133, a(var("x"), n378), [call(a(var("x"), n377))]).
clause(1136, a(var("x"), n379), [call(a(var("x"), n378))]).
clause(1139, a(var("x"), n380), [call(a(var("x"), n379))]).
clause(1142, a(var("x"), n381), [call(a(var("x"), n380))]).
clause(1145, a(var("x"), n382), [call(a(var("x"), n381))]).
clause(1148, a(var("x"), n383), [call(a(var("x"), n382))]).
clause(1151, a(var("x"), n384), [call(a(var("x"), n383))]).
clause(1154, a(var("x"), n385), [call(a(var("x"), n384))]).
clause(1157, a(var("x"), n386), [call(a(var("x"), n385))]).
clause(1160, a(var("x"), n387), [call(a(var("x"), n386))]).
clause(1163, a(var("x"), n388), [call(a(var("x"), n387))]).
clause(1166, a(var("x"), n389), [call(a(var("x"), n388))]).
clause(1169, a(var("x"), n390), [call(a(var("x"), n389))]).
clause(1172, a(var("x"), n391), [call(a(var("x"), n390))]).
clause(1175, a(var("x"), n392), [call(a(var("x"), n391))]).
clause(1178, a(var("x"), n393), [call(a(var("x"), n392))]).
clause(1181, a(var("x"), n394), [call(a(var("x"), n393))]).
clause(1184, a(var("x"), n395), [call(a(var("x"), n394))]).
clause(1187, a(var("x"), n396), [call(a(var("x"), n395))]).
clause(1190, a(var("x"), n397), [call(a(var("x"), n396))]).
clause(1193, a(var("x"), n398), [call(a(var("x"), n397))]).
clause(1196, a(var("x"), n399), [call(a(var("x"), n398))]).
clause(1199, a(var("x"), n400), [call(a(var("x"), n399))]).
clause(1202, a(var("x"), n401), [call(a(var("x"), n400))]).
clause(1205, a(var("x"), n402), [call(a(var("x"), n401))]).
clause(1208, a(var("x"), n403), [call(a(var("x"), n402))]).
clause(1211, a(var("x"), n404), [call(a(var("x"), n403))]).
clause(1214, a(var("x"), n405), [call(a(var("x"), n404))]).
clause(1217, a(var("x"), n406), [call(a(var("x"), n405))]).
clause(1220, a(var("x"), n407), [call(a(var("x"), n406))]).
clause(1223, a(var("x"), n408), [call(a(var("x"), n407))]).
clause(1226, a(var("x"), n409), [call(a(var("x"), n408))]).
clause(1229, a(var("x"), n410), [call(a(var("x"), n409))]).
clause(1232, a(var("x"), n411), [call(a(var("x"), n410))]).
clause(1235, a(var("x"), n412), [call(a(var("x"), n411))]).
clause(1238, a(var("x"), n413), [call(a(var("x"), n412))]).
clause(1241, a(var("x"), n414), [call(a(var("x"), n413))]).
clause(1244, a(var("x"), n415), [call(a(var("x"), n414))]).
clause(1247, a(var("x"), n416), [call(a(var("x"), n415))]).
clause(1250, a(var("x"), n417), [call(a(var("x"), n416))]).
clause(1253, a(var("x"), n418), [call(a(var("x"), n417))]).
clause(1256, a(var("x"), n419), [call(a(var("x"), n418))]).
clause(1259, a(var("x"), n420), [call(a(var("x"), n419))]).
clause(1262, a(var("x"), n421), [call(a(var("x"), n420))]).
clause(1265, a(var("x"), n422), [call(a(var("x"), n421))]).
clause(1268, a(var("x"), n423), [call(a(var("x"), n422))]).
clause(1271, a(var("x"), n424), [call(a(var("x"), n423))]).
clause(1274, a(var("x"), n425), [call(a(var("x"), n424))]).
clause(1277, a(var("x"), n426), [call(a(var("x"), n425))]).
clause(1280, a(var("x"), n427), [call(a(var("x"), n426))]).
clause(1283, a(var("x"), n428), [call(a(var("x"), n427))]).
clause(1286, a(var("x"), n429), [call(a(var("x"), n428))]).
clause(1289, a(var("x"), n430), [call(a(var("x"), n429))]).
clause(1292, a(var("x"), n431), [call(a(var("x"), n430))]).
clause(1295, a(var("x"), n432), [call(a(var("x"), n431))]).
clause(1298, a(var("x"), n433), [call(a(var("x"), n432))]).
clause(1301, a(var("x"), n434), [call(a(var("x"), n433))]).
clause(1304, a(var("x"), n435), [call(a(var("x"), n434))]).
clause(1307, a(var("x"), n436), [call(a(var("x"), n435))]).
clause(1310, a(var("x"), n437), [call(a(var("x"), n436))]).
clause(1313, a(var("x"), n438), [call(a(var("x"), n437))]).
clause(1316, a(var("x"), n439), [call(a(var("x"), n438))]).
clause(1319, a(var("x"), n440), [call(a(var("x"), n439))]).
clause(1322, a(var("x"), n441), [call(a(var("x"), n440))]).
clause(1325, a(var("x"), n442), [call(a(var("x"), n441))]).
clause(1328, a(var("x"), n443), [call(a(var("x"), n442))]).
clause(1331, a(var("x"), n444), [call(a(var("x"), n443))]).
clause(1334, a(var("x"), n445), [call(a(var("x"), n444))]).
clause(1337, a(var("x"), n446), [call(a(var("x"), n445))]).
clause(1340, a(var("x"), n447), [call(a(var("x"), n446))]).
clause(1343, a(var("x"), n448), [call(a(var("x"), n447))]).
clause(1346, a(var("x"), n449), [call(a(var("x"), n448))]).
clause(1349, a(var("x"), n450), [call(a(var("x"), n449))]).
clause(1352, a(var("x"), n451), [call(a(var("x"), n450))]).
clause(1355, a(var("x"), n452), [call(a(var("x"), n451))]).
clause(1358, a(var("x"), n453), [call(a(var("x"), n452))]).
clause(1361, a(var("x"), n454), [call(a(var("x"), n453))]).
clause(1364, a(var("x"), n455), [call(a(var("x"), n454))]).
clause(1367, a(var("x"), n456), [call(a(var("x"), n455))]).
clause(1370, a(var("x"), n457), [call(a(var("x"), n456))]).
clause(1373, a(var("x"), n458), [call(a(var("x"), n457))]).
clause(1376, a(var("x"), n459), [call(a(var("x"), n458))]).
clause(1379, a(var("x"), n460), [call(a(var("x"), n459))]).
clause(1382, a(var("x"), n461), [call(a(var("x"), n460))]).
clause(1385, a(var("x"), n462), [call(a(var("x"), n461))]).
clause(1388, a(var("x"), n463), [call(a(var("x"), n462))]).
clause(1391, a(var("x"), n464), [call(a(var("x"), n463))]).
clause(1394, a(var("x"), n465), [call(a(var("x"), n464))]).
clause(1397, a(var("x"), n466), [call(a(var("x"), n465))]).
clause(1400, a(var("x"), n467), [call(a(var("x"), n466))]).
clause(1403, a(var("x"), n468), [call(a(var("x"), n467))]).
clause(1406, a(var("x"), n469), [call(a(var("x"), n468))]).
clause(1409, a(var("x"), n470), [call(a(var("x"), n469))]).
clause(1412, a(var("x"), n471), [call(a(var("x"), n470))]).
clause(1415, a(var("x"), n472), [call(a(var("x"), n471))]).
clause(1418, a(var("x"), n473), [call(a(var("x"), n472))]).
clause(1421, a(var("x"), n474), [call(a(var("x"), n473))]).
clause(1424, a(var("x"), n475), [call(a(var("x"), n474))]).
clause(1427, a(var("x"), n476), [call(a(var("x"), n475))]).
clause(1430, a(var("x"), n477), [call(a(var("x"), n476))]).
clause(1433, a(var("x"), n478), [call(a(var("x"), n477))]).
clause(1436, a(var("x"), n479), [call(a(var("x"), n478))]).
clause(1439, a(var("x"), n480), [call(a(var("x"), n479))]).
clause(1442, a(var("x"), n481), [call(a(var("x"), n480))]).
clause(1445, a(var("x"), n482), [call(a(var("x"), n481))]).
clause(1448, a(var("x"), n483), [call(a(var("x"), n482))]).
clause(1451, a(var("x"), n484), [call(a(var("x"), n483))]).
clause(1454, a(var("x"), n485), [call(a(var("x"), n484))]).
clause(1457, a(var("x"), n486), [call(a(var("x"), n485))]).
clause(1460, a(var("x"), n487), [call(a(var("x"), n486))]).
clause(1463, a(var("x"), n488), [call(a(var("x"), n487))]).
clause(1466, a(var("x"), n489), [call(a(var("x"), n488))]).
clause(1469, a(var("x"), n490), [call(a(var("x"), n489))]).
clause(1472, a(var("x"), n491), [call(a(var("x"), n490))]).
clause(1475, a(var("x"), n492), [call(a(var("x"), n491))]).
clause(1478, a(var("x"), n493), [call(a(var("x"), n492))]).
clause(1481, a(var("x"), n494), [call(a(var("x"), n493))]).
clause(1484, a(var("x"), n495), [call(a(var("x"), n494))]).
clause(1487, a(var("x"), n496), [call(a(var("x"), n495))]).
clause(1490, a(var("x"), n497), [call(a(var("x"), n496))]).
clause(1493, a(var("x"), n498), [call(a(var("x"), n497))]).
clause(1496, a(var("x"), n499), [call(a(var("x"), n498))]).
clause(1499, a(var("x"), n500), [call(a(var("x"), n499))]).
clause(1500, a(var("x"), i500), [call(a(var("x"), n499))]).
clause(1501, a(var("x"), j500), [call(a(var("x"), n499))]).
clause(1502, a(var("x"), n501), [call(a(var("x"), n500))]).
clause(1505, a(var("x"), n502), [call(a(var("x"), n501))]).
clause(1508, a(var("x"), n503), [call(a(var("x"), n502))]).
clause(1511, a(var("x"), n504), [call(a(var("x"), n503))]).
clause(1514, a(var("x"), n505), [call(a(var("x"), n504))]).
clause(1517, a(var("x"), n506), [call(a(var("x"), n505))]).
clause(1520, a(var("x"), n507), [call(a(var("x"), n506))]).
clause(1523, a(var("x"), n508), [call(a(var("x"), n507))]).
clause(1526, a(var("x"), n509), [call(a(var("x"), n508))]).
clause(1529, a(var("x"), n510), [call(a(var("x"), n509))]).
clause(1532, a(var("x"), n511), [call(a(var("x"), n510))]).
clause(1535, a(var("x"), n512), [call(a(var("x"), n511))]).
clause(1538, a(var("x"), n513), [call(a(var("x"), n512))]).
clause(1541, a(var("x"), n514), [call(a(var("x"), n513))]).
clause(1544, a(var("x"), n515), [call(a(var("x"), n514))]).
clause(1547, a(var("x"), n516), [call(a(var("x"), n515))]).
clause(1550, a(var("x"), n517), [call(a(var("x"), n516))]).
clause(1553, a(var("x"), n518), [call(a(var("x"), n517))]).
clause(1556, a(var("x"), n519), [call(a(var("x"), n518))]).
clause(1559, a(var("x"), n520), [call(a(var("x"), n519))]).
clause(1562, a(var("x"), n521), [call(a(var("x"), n520))]).
clause(1565, a(var("x"), n522), [call(a(var("x"), n521))]).
clause(1568, a(var("x"), n523), [call(a(var("x"), n522))]).
clause(1571, a(var("x"), n524), [call(a(var("x"), n523))]).
clause(1574, a(var("x"), n525), [call(a(var("x"), n524))]).
clause(1577, a(var("x"), n526), [call(a(var("x"), n525))]).
clause(1580, a(var("x"), n527), [call(a(var("x"), n526))]).
clause(1583, a(var("x"), n528), [call(a(var("x"), n527))]).
clause(1586, a(var("x"), n529), [call(a(var("x"), n528))]).
clause(1589, a(var("x"), n530), [call(a(var("x"), n529))]).
clause(1592, a(var("x"), n531), [call(a(var("x"), n530))]).
clause(1595, a(var("x"), n532), [call(a(var("x"), n531))]).
clause(1598, a(var("x"), n533), [call(a(var("x"), n532))]).
clause(1601, a(var("x"), n534), [call(a(var("x"), n533))]).
clause(1604, a(var("x"), n535), [call(a(var("x"), n534))]).
clause(1607, a(var("x"), n536), [call(a(var("x"), n535))]).
clause(1610, a(var("x"), n537), [call(a(var("x"), n536))]).
clause(1613, a(var("x"), n538), [call(a(var("x"), n537))]).
clause(1616, a(var("x"), n539), [call(a(var("x"), n538))]).
clause(1619, a(var("x"), n540), [call(a(var("x"), n539))]).
clause(1622, a(var("x"), n541), [call(a(var("x"), n540))]).
clause(1625, a(var("x"), n542), [call(a(var("x"), n541))]).
clause(1628, a(var("x"), n543), [call(a(var("x"), n542))]).
clause(1631, a(var("x"), n544), [call(a(var("x"), n543))]).
clause(1634, a(var("x"), n545), [call(a(var("x"), n544))]).
clause(1637, a(var("x"), n546), [call(a(var("x"), n545))]).
clause(1640, a(var("x"), n547), [call(a(var("x"), n546))]).
clause(1643, a(var("x"), n548), [call(a(var("x"), n547))]).
clause(1646, a(var("x"), n549), [call(a(var("x"), n548))]).
clause(1649, a(var("x"), n550), [call(a(var("x"), n549))]).
clause(1652, a(var("x"), n551), [call(a(var("x"), n550))]).
clause(1655, a(var("x"), n552), [call(a(var("x"), n551))]).
clause(1658, a(var("x"), n553), [call(a(var("x"), n552))]).
clause(1661, a(var("x"), n554), [call(a(var("x"), n553))]).
clause(1664, a(var("x"), n555), [call(a(var("x"), n554))]).
clause(1667, a(var("x"), n556), [call(a(var("x"), n555))]).
clause(1670, a(var("x"), n557), [call(a(var("x"), n556))]).
clause(1673, a(var("x"), n558), [call(a(var("x"), n557))]).
clause(1676, a(var("x"), n559), [call(a(var("x"), n558))]).
clause(1679, a(var("x"), n560), [call(a(var("x"), n559))]).
clause(1682, a(var("x"), n561), [call(a(var("x"), n560))]).
clause(1685, a(var("x"), n562), [call(a(var("x"), n561))]).
clause(1688, a(var("x"), n563), [call(a(var("x"), n562))]).
clause(1691, a(var("x"), n564), [call(a(var("x"), n563))]).
clause(1694, a(var("x"), n565), [call(a(var("x"), n564))]).
clause(1697, a(var("x"), n566), [call(a(var("x"), n565))]).
clause(1700, a(var("x"), n567), [call(a(var("x"), n566))]).
clause(1703, a(var("x"), n568), [call(a(var("x"), n567))]).
clause(1706, a(var("x"), n569), [call(a(var("x"), n568))]).
clause(1709, a(var("x"), n570), [call(a(var("x"), n569))]).
clause(1712, a(var("x"), n571), [call(a(var("x"), n570))]).
clause(1715, a(var("x"), n572), [call(a(var("x"), n571))]).
clause(1718, a(var("x"), n573), [call(a(var("x"), n572))]).
clause(1721, a(var("x"), n574), [call(a(var("x"), n573))]).
clause(1724, a(var("x"), n575), [call(a(var("x"), n574))]).
clause(1727, a(var("x"), n576), [call(a(var("x"), n575))]).
clause(1730, a(var("x"), n577), [call(a(var("x"), n576))]).
clause(1733, a(var("x"), n578), [call(a(var("x"), n577))]).
clause(1736, a(var("x"), n579), [call(a(var("x"), n578))]).
clause(1739, a(var("x"), n580), [call(a(var("x"), n579))]).
clause(1742, a(var("x"), n581), [call(a(var("x"), n580))]).
clause(1745, a(var("x"), n582), [call(a(var("x"), n581))]).
clause(1748, a(var("x"), n583), [call(a(var("x"), n582))]).
clause(1751, a(var("x"), n584), [call(a(var("x"), n583))]).
clause(1754, a(var("x"), n585), [call(a(var("x"), n584))]).
clause(1757, a(var("x"), n586), [call(a(var("x"), n585))]).
clause(1760, a(var("x"), n587), [call(a(var("x"), n586))]).
clause(1763, a(var("x"), n588), [call(a(var("x"), n587))]).
clause(1766, a(var("x"), n589), [call(a(var("x"), n588))]).
clause(1769, a(var("x"), n590), [call(a(var("x"), n589))]).
clause(1772, a(var("x"), n591), [call(a(var("x"), n590))]).
clause(1775, a(var("x"), n592), [call(a(var("x"), n591))]).
clause(1778, a(var("x"), n593), [call(a(var("x"), n592))]).
clause(1781, a(var("x"), n594), [call(a(var("x"), n593))]).
clause(1784, a(var("x"), n595), [call(a(var("x"), n594))]).
clause(1787, a(var("x"), n596), [call(a(var("x"), n595))]).
clause(1790, a(var("x"), n597), [call(a(var("x"), n596))]).
clause(1793, a(var("x"), n598), [call(a(var("x"), n597))]).
clause(1796, a(var("x"), n599), [call(a(var("x"), n598))]).
clause(1799, a(var("x"), n600), [call(a(var("x"), n599))]).
clause(1802, a(var("x"), n601), [call(a(var("x"), n600))]).
clause(1805, a(var("x"), n602), [call(a(var("x"), n601))]).
clause(1808, a(var("x"), n603), [call(a(var("x"), n602))]).
clause(1811, a(var("x"), n604), [call(a(var("x"), n603))]).
clause(1814, a(var("x"), n605), [call(a(var("x"), n604))]).
clause(1817, a(var("x"), n606), [call(a(var("x"), n605))]).
clause(1820, a(var("x"), n607), [call(a(var("x"), n606))]).
clause(1823, a(var("x"), n608), [call(a(var("x"), n607))]).
clause(1826, a(var("x"), n609), [call(a(var("x"), n608))]).
clause(1829, a(var("x"), n610), [call(a(var("x"), n609))]).
clause(1832, a(var("x"), n611), [call(a(var("x"), n610))]).
clause(1835, a(var("x"), n612), [call(a(var("x"), n611))]).
clause(1838, a(var("x"), n613), [call(a(var("x"), n612))]).
clause(1841, a(var("x"), n614), [call(a(var("x"), n613))]).
clause(1844, a(var("x"), n615), [call(a(var("x"), n614))]).
clause(1847, a(var("x"), n616), [call(a(var("x"), n615))]).
clause(1850, a(var("x"), n617), [call(a(var("x"), n616))]).
clause(1853, a(var("x"), n618), [call(a(var("x"), n617))]).
clause(1856, a(var("x"), n619), [call(a(var("x"), n618))]).
clause(1859, a(var("x"), n620), [call(a(var("x"), n619))]).
clause(1862, a(var("x"), n621), [call(a(var("x"), n620))]).
clause(1865, a(var("x"), n622), [call(a(var("x"), n621))]).
clause(1868, a(var("x"), n623), [call(a(var("x"), n622))]).
clause(1871, a(var("x"), n624), [call(a(var("x"), n623))]).
clause(1874, a(var("x"), n625), [call(a(var("x"), n624))]).
clause(1877, a(var("x"), n626), [call(a(var("x"), n625))]).
clause(1880, a(var("x"), n627), [call(a(var("x"), n626))]).
clause(1883, a(var("x"), n628), [call(a(var("x"), n627))]).
clause(1886, a(var("x"), n629), [call(a(var("x"), n628))]).
clause(1889, a(var("x"), n630), [call(a(var("x"), n629))]).
clause(1892, a(var("x"), n631), [call(a(var("x"), n630))]).
clause(1895, a(var("x"), n632), [call(a(var("x"), n631))]).
clause(1898, a(var("x"), n633), [call(a(var("x"), n632))]).
clause(1901, a(var("x"), n634), [call(a(var("x"), n633))]).
clause(1904, a(var("x"), n635), [call(a(var("x"), n634))]).
clause(1907, a(var("x"), n636), [call(a(var("x"), n635))]).
clause(1910, a(var("x"), n637), [call(a(var("x"), n636))]).
clause(1913, a(var("x"), n638), [call(a(var("x"), n637))]).
clause(1916, a(var("x"), n639), [call(a(var("x"), n638))]).
clause(1919, a(var("x"), n640), [call(a(var("x"), n639))]).
clause(1922, a(var("x"), n641), [call(a(var("x"), n640))]).
clause(1925, a(var("x"), n642), [call(a(var("x"), n641))]).
clause(1928, a(var("x"), n643), [call(a(var("x"), n642))]).
clause(1931, a(var("x"), n644), [call(a(var("x"), n643))]).
clause(1934, a(var("x"), n645), [call(a(var("x"), n644))]).
clause(1937, a(var("x"), n646), [call(a(var("x"), n645))]).
clause(1940, a(var("x"), n647), [call(a(var("x"), n646))]).
clause(1943, a(var("x"), n648), [call(a(var("x"), n647))]).
clause(1946, a(var("x"), n649), [call(a(var("x"), n648))]).
clause(1949, a(var("x"), n650), [call(a(var("x"), n649))]).
clause(1952, a(var("x"), n651), [call(a(var("x"), n650))]).
clause(1955, a(var("x"), n652), [call(a(var("x"), n651))]).
clause(1958, a(var("x"), n653), [call(a(var("x"), n652))]).
clause(1961, a(var("x"), n654), [call(a(var("x"), n653))]).
clause(1964, a(var("x"), n655), [call(a(var("x"), n654))]).
clause(1967, a(var("x"), n656), [call(a(var("x"), n655))]).
clause(1970, a(var("x"), n657), [call(a(var("x"), n656))]).
clause(1973, a(var("x"), n658), [call(a(var("x"), n657))]).
clause(1976, a(var("x"), n659), [call(a(var("x"), n658))]).
clause(1979, a(var("x"), n660), [call(a(var("x"), n659))]).
clause(1982, a(var("x"), n661), [call(a(var("x"), n660))]).
clause(1985, a(var("x"), n662), [call(a(var("x"), n661))]).
clause(1988, a(var("x"), n663), [call(a(var("x"), n662))]).
clause(1991, a(var("x"), n664), [call(a(var("x"), n663))]).
clause(1994, a(var("x"), n665), [call(a(var("x"), n664))]).
clause(1997, a(var("x"), n666), [call(a(var("x"), n665))]).
clause(2000, a(var("x"), n667), [call(a(var("x"), n666))]).
clause(2003, a(var("x"), n668), [call(a(var("x"), n667))]).
clause(2006, a(var("x"), n669), [call(a(var("x"), n668))]).
clause(2009, a(var("x"), n670), [call(a(var("x"), n669))]).
clause(2012, a(var("x"), n671), [call(a(var("x"), n670))]).
clause(2015, a(var("x"), n672), [call(a(var("x"), n671))]).
clause(2018, a(var("x"), n673), [call(a(var("x"), n672))]).
clause(2021, a(var("x"), n674), [call(a(var("x"), n673))]).
clause(2024, a(var("x"), n675), [call(a(var("x"), n674))]).
clause(2027, a(var("x"), n676), [call(a(var("x"), n675))]).
clause(2030, a(var("x"), n677), [call(a(var("x"), n676))]).
clause(2033, a(var("x"), n678), [call(a(var("x"), n677))]).
clause(2036, a(var("x"), n679), [call(a(var("x"), n678))]).
clause(2039, a(var("x"), n680), [call(a(var("x"), n679))]).
clause(2042, a(var("x"), n681), [call(a(var("x"), n680))]).
clause(2045, a(var("x"), n682), [call(a(var("x"), n681))]).
clause(2048, a(var("x"), n683), [call(a(var("x"), n682))]).
clause(2051, a(var("x"), n684), [call(a(var("x"), n683))]).
clause(2054, a(var("x"), n685), [call(a(var("x"), n684))]).
clause(2057, a(var("x"), n686), [call(a(var("x"), n685))]).
clause(2060, a(var("x"), n687), [call(a(var("x"), n686))]).
clause(2063, a(var("x"), n688), [call(a(var("x"), n687))]).
clause(2066, a(var("x"), n689), [call(a(var("x"), n688))]).
clause(2069, a(var("x"), n690), [call(a(var("x"), n689))]).
clause(2072, a(var("x"), n691), [call(a(var("x"), n690))]).
clause(2075, a(var("x"), n692), [call(a(var("x"), n691))]).
clause(2078, a(var("x"), n693), [call(a(var("x"), n692))]).
clause(2081, a(var("x"), n694), [call(a(var("x"), n693))]).
clause(2084, a(var("x"), n695), [call(a(var("x"), n694))]).
clause(2087, a(var("x"), n696), [call(a(var("x"), n695))]).
clause(2090, a(var("x"), n697), [call(a(var("x"), n696))]).
clause(2093, a(var("x"), n698), [call(a(var("x"), n697))]).
clause(2096, a(var("x"), n699), [call(a(var("x"), n698))]).
clause(2099, a(var("x"), n700), [call(a(var("x"), n699))]).
clause(2102, a(var("x"), n701), [call(a(var("x"), n700))]).
clause(2105, a(var("x"), n702), [call(a(var("x"), n701))]).
clause(2108, a(var("x"), n703), [call(a(var("x"), n702))]).
clause(2111, a(var("x"), n704), [call(a(var("x"), n703))]).
clause(2114, a(var("x"), n705), [call(a(var("x"), n704))]).
clause(2117, a(var("x"), n706), [call(a(var("x"), n705))]).
clause(2120, a(var("x"), n707), [call(a(var("x"), n706))]).
clause(2123, a(var("x"), n708), [call(a(var("x"), n707))]).
clause(2126, a(var("x"), n709), [call(a(var("x"), n708))]).
clause(2129, a(var("x"), n710), [call(a(var("x"), n709))]).
clause(2132, a(var("x"), n711), [call(a(var("x"), n710))]).
clause(2135, a(var("x"), n712), [call(a(var("x"), n711))]).
clause(2138, a(var("x"), n713), [call(a(var("x"), n712))]).
clause(2141, a(var("x"), n714), [call(a(var("x"), n713))]).
clause(2144, a(var("x"), n715), [call(a(var("x"), n714))]).
clause(2147, a(var("x"), n716), [call(a(var("x"), n715))]).
clause(2150, a(var("x"), n717), [call(a(var("x"), n716))]).
clause(2153, a(var("x"), n718), [call(a(var("x"), n717))]).
clause(2156, a(var("x"), n719), [call(a(var("x"), n718))]).
clause(2159, a(var("x"), n720), [call(a(var("x"), n719))]).
clause(2162, a(var("x"), n721), [call(a(var("x"), n720))]).
clause(2165, a(var("x"), n722), [call(a(var("x"), n721))]).
clause(2168, a(var("x"), n723), [call(a(var("x"), n722))]).
clause(2171, a(var("x"), n724), [call(a(var("x"), n723))]).
clause(2174, a(var("x"), n725), [call(a(var("x"), n724))]).
clause(2177, a(var("x"), n726), [call(a(var("x"), n725))]).
clause(2180, a(var("x"), n727), [call(a(var("x"), n726))]).
clause(2183, a(var("x"), n728), [call(a(var("x"), n727))]).
clause(2186, a(var("x"), n729), [call(a(var("x"), n728))]).
clause(2189, a(var("x"), n730), [call(a(var("x"), n729))]).
clause(2192, a(var("x"), n731), [call(a(var("x"), n730))]).
clause(2195, a(var("x"), n732), [call(a(var("x"), n731))]).
clause(2198, a(var("x"), n733), [call(a(var("x"), n732))]).
clause(2201, a(var("x"), n734), [call(a(var("x"), n733))]).
clause(2204, a(var("x"), n735), [call(a(var("x"), n734))]).
clause(2207, a(var("x"), n736), [call(a(var("x"), n735))]).
clause(2210, a(var("x"), n737), [call(a(var("x"), n736))]).
clause(2213, a(var("x"), n738), [call(a(var("x"), n737))]).
clause(2216, a(var("x"), n739), [call(a(var("x"), n738))]).
clause(2219, a(var("x"), n740), [call(a(var("x"), n739))]).
clause(2222, a(var("x"), n741), [call(a(var("x"), n740))]).
clause(2225, a(var("x"), n742), [call(a(var("x"), n741))]).
clause(2228, a(var("x"), n743), [call(a(var("x"), n742))]).
clause(2231, a(var("x"), n744), [call(a(var("x"), n743))]).
clause(2234, a(var("x"), n745), [call(a(var("x"), n744))]).
clause(2237, a(var("x"), n746), [call(a(var("x"), n745))]).
clause(2240, a(var("x"), n747), [call(a(var("x"), n746))]).
clause(2243, a(var("x"), n748), [call(a(var("x"), n747))]).
clause(2246, a(var("x"), n749), [call(a(var("x"), n748))]).
clause(2249, a(var("x"), n750), [call(a(var("x"), n749))]).
clause(2252, a(var("x"), n751), [call(a(var("x"), n750))]).
clause(2255, a(var("x"), n752), [call(a(var("x"), n751))]).
clause(2258, a(var("x"), n753), [call(a(var("x"), n752))]).
clause(2261, a(var("x"), n754), [call(a(var("x"), n753))]).
clause(2264, a(var("x"), n755), [call(a(var("x"), n754))]).
clause(2267, a(var("x"), n756), [call(a(var("x"), n755))]).
clause(2270, a(var("x"), n757), [call(a(var("x"), n756))]).
clause(2273, a(var("x"), n758), [call(a(var("x"), n757))]).
clause(2276, a(var("x"), n759), [call(a(var("x"), n758))]).
clause(2279, a(var("x"), n760), [call(a(var("x"), n759))]).
clause(2282, a(var("x"), n761), [call(a(var("x"), n760))]).
clause(2285, a(var("x"), n762), [call(a(var("x"), n761))]).
clause(2288, a(var("x"), n763), [call(a(var("x"), n762))]).
clause(2291, a(var("x"), n764), [call(a(var("x"), n763))]).
clause(2294, a(var("x"), n765), [call(a(var("x"), n764))]).
clause(2297, a(var("x"), n766), [call(a(var("x"), n765))]).
clause(2300, a(var("x"), n767), [call(a(var("x"), n766))]).
clause(2303, a(var("x"), n768), [call(a(var("x"), n767))]).
clause(2306, a(var("x"), n769), [call(a(var("x"), n768))]).
clause(2309, a(var("x"), n770), [call(a(var("x"), n769))]).
clause(2312, a(var("x"), n771), [call(a(var("x"), n770))]).
clause(2315, a(var("x"), n772), [call(a(var("x"), n771))]).
clause(2318, a(var("x"), n773), [call(a(var("x"), n772))]).
clause(2321, a(var("x"), n774), [call(a(var("x"), n773))]).
clause(2324, a(var("x"), n775), [call(a(var("x"), n774))]).
clause(2327, a(var("x"), n776), [call(a(var("x"), n775))]).
clause(2330, a(var("x"), n777), [call(a(var("x"), n776))]).
clause(2333, a(var("x"), n778), [call(a(var("x"), n777))]).
clause(2336, a(var("x"), n779), [call(a(var("x"), n778))]).
clause(2339, a(var("x"), n780), [call(a(var("x"), n779))]).
clause(2342, a(var("x"), n781), [call(a(var("x"), n780))]).
clause(2345, a(var("x"), n782), [call(a(var("x"), n781))]).
clause(2348, a(var("x"), n783), [call(a(var("x"), n782))]).
clause(2351, a(var("x"), n784), [call(a(var("x"), n783))]).
clause(2354, a(var("x"), n785), [call(a(var("x"), n784))]).
clause(2357, a(var("x"), n786), [call(a(var("x"), n785))]).
clause(2360, a(var("x"), n787), [call(a(var("x"), n786))]).
clause(2363, a(var("x"), n788), [call(a(var("x"), n787))]).
clause(2366, a(var("x"), n789), [call(a(var("x"), n788))]).
clause(2369, a(var("x"), n790), [call(a(var("x"), n789))]).
clause(2372, a(var("x"), n791), [call(a(var("x"), n790))]).
clause(2375, a(var("x"), n792), [call(a(var("x"), n791))]).
clause(2378, a(var("x"), n793), [call(a(var("x"), n792))]).
clause(2381, a(var("x"), n794), [call(a(var("x"), n793))]).
clause(2384, a(var("x"), n795), [call(a(var("x"), n794))]).
clause(2387, a(var("x"), n796), [call(a(var("x"), n795))]).
clause(2390, a(var("x"), n797), [call(a(var("x"), n796))]).
clause(2393, a(var("x"), n798), [call(a(var("x"), n797))]).
clause(2396, a(var("x"), n799), [call(a(var("x"), n798))]).
clause(2399, a(var("x"), n800), [call(a(var("x"), n799))]).
clause(2402, a(var("x"), n801), [call(a(var("x"), n800))]).
clause(2405, a(var("x"), n802), [call(a(var("x"), n801))]).
clause(2408, a(var("x"), n803), [call(a(var("x"), n802))]).
clause(2411, a(var("x"), n804), [call(a(var("x"), n803))]).
clause(2414, a(var("x"), n805), [call(a(var("x"), n804))]).
clause(2417, a(var("x"), n806), [call(a(var("x"), n805))]).
clause(2420, a(var("x"), n807), [call(a(var("x"), n806))]).
clause(2423, a(var("x"), n808), [call(a(var("x"), n807))]).
clause(2426, a(var("x"), n809), [call(a(var("x"), n808))]).
clause(2429, a(var("x"), n810), [call(a(var("x"), n809))]).
clause(2432, a(var("x"), n811), [call(a(var("x"), n810))]).
clause(2435, a(var("x"), n812), [call(a(var("x"), n811))]).
clause(2438, a(var("x"), n813), [call(a(var("x"), n812))]).
clause(2441, a(var("x"), n814), [call(a(var("x"), n813))]).
clause(2444, a(var("x"), n815), [call(a(var("x"), n814))]).
clause(2447, a(var("x"), n816), [call(a(var("x"), n815))]).
clause(2450, a(var("x"), n817), [call(a(var("x"), n816))]).
clause(2453, a(var("x"), n818), [call(a(var("x"), n817))]).
clause(2456, a(var("x"), n819), [call(a(var("x"), n818))]).
clause(2459, a(var("x"), n820), [call(a(var("x"), n819))]).
clause(2462, a(var("x"), n821), [call(a(var("x"), n820))]).
clause(2465, a(var("x"), n822), [call(a(var("x"), n821))]).
clause(2468, a(var("x"), n823), [call(a(var("x"), n822))]).
clause(2471, a(var("x"), n824), [call(a(var("x"), n823))]).
clause(2474, a(var("x"), n825), [call(a(var("x"), n824))]).
clause(2477, a(var("x"), n826), [call(a(var("x"), n825))]).
clause(2480, a(var("x"), n827), [call(a(var("x"), n826))]).
clause(2483, a(var("x"), n828), [call(a(var("x"), n827))]).
clause(2486, a(var("x"), n829), [call(a(var("x"), n828))]).
clause(2489, a(var("x"), n830), [call(a(var("x"), n829))]).
clause(2492, a(var("x"), n831), [call(a(var("x"), n830))]).
clause(2495, a(var("x"), n832), [call(a(var("x"), n831))]).
clause(2498, a(var("x"), n833), [call(a(var("x"), n832))]).
clause(2501, a(var("x"), n834), [call(a(var("x"), n833))]).
clause(2504, a(var("x"), n835), [call(a(var("x"), n834))]).
clause(2507, a(var("x"), n836), [call(a(var("x"), n835))]).
clause(2510, a(var("x"), n837), [call(a(var("x"), n836))]).
clause(2513, a(var("x"), n838), [call(a(var("x"), n837))]).
clause(2516, a(var("x"), n839), [call(a(var("x"), n838))]).
clause(2519, a(var("x"), n840), [call(a(var("x"), n839))]).
clause(2522, a(var("x"), n841), [call(a(var("x"), n840))]).
clause(2525, a(var("x"), n842), [call(a(var("x"), n841))]).
clause(2528, a(var("x"), n843), [call(a(var("x"), n842))]).
clause(2531, a(var("x"), n844), [call(a(var("x"), n843))]).
clause(2534, a(var("x"), n845), [call(a(var("x"), n844))]).
clause(2537, a(var("x"), n846), [call(a(var("x"), n845))]).
clause(2540, a(var("x"), n847), [call(a(var("x"), n846))]).
clause(2543, a(var("x"), n848), [call(a(var("x"), n847))]).
clause(2546, a(var("x"), n849), [call(a(var("x"), n848))]).
clause(2549, a(var("x"), n850), [call(a(var("x"), n849))]).
clause(2552, a(var("x"), n851), [call(a(var("x"), n850))]).
clause(2555, a(var("x"), n852), [call(a(var("x"), n851))]).
clause(2558, a(var("x"), n853), [call(a(var("x"), n852))]).
clause(2561, a(var("x"), n854), [call(a(var("x"), n853))]).
clause(2564, a(var("x"), n855), [call(a(var("x"), n854))]).
clause(2567, a(var("x"), n856), [call(a(var("x"), n855))]).
clause(2570, a(var("x"), n857), [call(a(var("x"), n856))]).
clause(2573, a(var("x"), n858), [call(a(var("x"), n857))]).
clause(2576, a(var("x"), n859), [call(a(var("x"), n858))]).
clause(2579, a(var("x"), n860), [call(a(var("x"), n859))]).
clause(2582, a(var("x"), n861), [call(a(var("x"), n860))]).
clause(2585, a(var("x"), n862), [call(a(var("x"), n861))]).
clause(2588, a(var("x"), n863), [call(a(var("x"), n862))]).
clause(2591, a(var("x"), n864), [call(a(var("x"), n863))]).
clause(2594, a(var("x"), n865), [call(a(var("x"), n864))]).
clause(2597, a(var("x"), n866), [call(a(var("x"), n865))]).
clause(2600, a(var("x"), n867), [call(a(var("x"), n866))]).
clause(2603, a(var("x"), n868), [call(a(var("x"), n867))]).
clause(2606, a(var("x"), n869), [call(a(var("x"), n868))]).
clause(2609, a(var("x"), n870), [call(a(var("x"), n869))]).
clause(2612, a(var("x"), n871), [call(a(var("x"), n870))]).
clause(2615, a(var("x"), n872), [call(a(var("x"), n871))]).
clause(2618, a(var("x"), n873), [call(a(var("x"), n872))]).
clause(2621, a(var("x"), n874), [call(a(var("x"), n873))]).
clause(2624, a(var("x"), n875), [call(a(var("x"), n874))]).
clause(2627, a(var("x"), n876), [call(a(var("x"), n875))]).
clause(2630, a(var("x"), n877), [call(a(var("x"), n876))]).
clause(2633, a(var("x"), n878), [call(a(var("x"), n877))]).
clause(2636, a(var("x"), n879), [call(a(var("x"), n878))]).
clause(2639, a(var("x"), n880), [call(a(var("x"), n879))]).
clause(2642, a(var("x"), n881), [call(a(var("x"), n880))]).
clause(2645, a(var("x"), n882), [call(a(var("x"), n881))]).
clause(2648, a(var("x"), n883), [call(a(var("x"), n882))]).
clause(2651, a(var("x"), n884), [call(a(var("x"), n883))]).
clause(2654, a(var("x"), n885), [call(a(var("x"), n884))]).
clause(2657, a(var("x"), n886), [call(a(var("x"), n885))]).
clause(2660, a(var("x"), n887), [call(a(var("x"), n886))]).
clause(2663, a(var("x"), n888), [call(a(var("x"), n887))]).
clause(2666, a(var("x"), n889), [call(a(var("x"), n888))]).
clause(2669, a(var("x"), n890), [call(a(var("x"), n889))]).
clause(2672, a(var("x"), n891), [call(a(var("x"), n890))]).
clause(2675, a(var("x"), n892), [call(a(var("x"), n891))]).
clause(2678, a(var("x"), n893), [call(a(var("x"), n892))]).
clause(2681, a(var("x"), n894), [call(a(var("x"), n893))]).
clause(2684, a(var("x"), n895), [call(a(var("x"), n894))]).
clause(2687, a(var("x"), n896), [call(a(var("x"), n895))]).
clause(2690, a(var("x"), n897), [call(a(var("x"), n896))]).
clause(2693, a(var("x"), n898), [call(a(var("x"), n897))]).
clause(2696, a(var("x"), n899), [call(a(var("x"), n898))]).
clause(2699, a(var("x"), n900), [call(a(var("x"), n899))]).
clause(2702, a(var("x"), n901), [call(a(var("x"), n900))]).
clause(2705, a(var("x"), n902), [call(a(var("x"), n901))]).
clause(2708, a(var("x"), n903), [call(a(var("x"), n902))]).
clause(2711, a(var("x"), n904), [call(a(var("x"), n903))]).
clause(2714, a(var("x"), n905), [call(a(var("x"), n904))]).
clause(2717, a(var("x"), n906), [call(a(var("x"), n905))]).
clause(2720, a(var("x"), n907), [call(a(var("x"), n906))]).
clause(2723, a(var("x"), n908), [call(a(var("x"), n907))]).
clause(2726, a(var("x"), n909), [call(a(var("x"), n908))]).
clause(2729, a(var("x"), n910), [call(a(var("x"), n909))]).
clause(2732, a(var("x"), n911), [call(a(var("x"), n910))]).
clause(2735, a(var("x"), n912), [call(a(var("x"), n911))]).
clause(2738, a(var("x"), n913), [call(a(var("x"), n912))]).
clause(2741, a(var("x"), n914), [call(a(var("x"), n913))]).
clause(2744, a(var("x"), n915), [call(a(var("x"), n914))]).
clause(2747, a(var("x"), n916), [call(a(var("x"), n915))]).
clause(2750, a(var("x"), n917), [call(a(var("x"), n916))]).
clause(2753, a(var("x"), n918), [call(a(var("x"), n917))]).
clause(2756, a(var("x"), n919), [call(a(var("x"), n918))]).
clause(2759, a(var("x"), n920), [call(a(var("x"), n919))]).
clause(2762, a(var("x"), n921), [call(a(var("x"), n920))]).
clause(2765, a(var("x"), n922), [call(a(var("x"), n921))]).
clause(2768, a(var("x"), n923), [call(a(var("x"), n922))]).
clause(2771, a(var("x"), n924), [call(a(var("x"), n923))]).
clause(2774, a(var("x"), n925), [call(a(var("x"), n924))]).
clause(2777, a(var("x"), n926), [call(a(var("x"), n925))]).
clause(2780, a(var("x"), n927), [call(a(var("x"), n926))]).
clause(2783, a(var("x"), n928), [call(a(var("x"), n927))]).
clause(2786, a(var("x"), n929), [call(a(var("x"), n928))]).
clause(2789, a(var("x"), n930), [call(a(var("x"), n929))]).
clause(2792, a(var("x"), n931), [call(a(var("x"), n930))]).
clause(2795, a(var("x"), n932), [call(a(var("x"), n931))]).
clause(2798, a(var("x"), n933), [call(a(var("x"), n932))]).
clause(2801, a(var("x"), n934), [call(a(var("x"), n933))]).
clause(2804, a(var("x"), n935), [call(a(var("x"), n934))]).
clause(2807, a(var("x"), n936), [call(a(var("x"), n935))]).
clause(2810, a(var("x"), n937), [call(a(var("x"), n936))]).
clause(2813, a(var("x"), n938), [call(a(var("x"), n937))]).
clause(2816, a(var("x"), n939), [call(a(var("x"), n938))]).
clause(2819, a(var("x"), n940), [call(a(var("x"), n939))]).
clause(2822, a(var("x"), n941), [call(a(var("x"), n940))]).
clause(2825, a(var("x"), n942), [call(a(var("x"), n941))]).
clause(2828, a(var("x"), n943), [call(a(var("x"), n942))]).
clause(2831, a(var("x"), n944), [call(a(var("x"), n943))]).
clause(2834, a(var("x"), n945), [call(a(var("x"), n944))]).
clause(2837, a(var("x"), n946), [call(a(var("x"), n945))]).
clause(2840, a(var("x"), n947), [call(a(var("x"), n946))]).
clause(2843, a(var("x"), n948), [call(a(var("x"), n947))]).
clause(2846, a(var("x"), n949), [call(a(var("x"), n948))]).
clause(2849, a(var("x"), n950), [call(a(var("x"), n949))]).
clause(2852, a(var("x"), n951), [call(a(var("x"), n950))]).
clause(2855, a(var("x"), n952), [call(a(var("x"), n951))]).
clause(2858, a(var("x"), n953), [call(a(var("x"), n952))]).
clause(2861, a(var("x"), n954), [call(a(var("x"), n953))]).
clause(2864, a(var("x"), n955), [call(a(var("x"), n954))]).
clause(2867, a(var("x"), n956), [call(a(var("x"), n955))]).
clause(2870, a(var("x"), n957), [call(a(var("x"), n956))]).
clause(2873, a(var("x"), n958), [call(a(var("x"), n957))]).
clause(2876, a(var("x"), n959), [call(a(var("x"), n958))]).
clause(2879, a(var("x"), n960), [call(a(var("x"), n959))]).
clause(2882, a(var("x"), n961), [call(a(var("x"), n960))]).
clause(2885, a(var("x"), n962), [call(a(var("x"), n961))]).
clause(2888, a(var("x"), n963), [call(a(var("x"), n962))]).
clause(2891, a(var("x"), n964), [call(a(var("x"), n963))]).
clause(2894, a(var("x"), n965), [call(a(var("x"), n964))]).
clause(2897, a(var("x"), n966), [call(a(var("x"), n965))]).
clause(2900, a(var("x"), n967), [call(a(var("x"), n966))]).
clause(2903, a(var("x"), n968), [call(a(var("x"), n967))]).
clause(2906, a(var("x"), n969), [call(a(var("x"), n968))]).
clause(2909, a(var("x"), n970), [call(a(var("x"), n969))]).
clause(2912, a(var("x"), n971), [call(a(var("x"), n970))]).
clause(2915, a(var("x"), n972), [call(a(var("x"), n971))]).
clause(2918, a(var("x"), n973), [call(a(var("x"), n972))]).
clause(2921, a(var("x"), n974), [call(a(var("x"), n973))]).
clause(2924, a(var("x"), n975), [call(a(var("x"), n974))]).
clause(2927, a(var("x"), n976), [call(a(var("x"), n975))]).
clause(2930, a(var("x"), n977), [call(a(var("x"), n976))]).
clause(2933, a(var("x"), n978), [call(a(var("x"), n977))]).
clause(2936, a(var("x"), n979), [call(a(var("x"), n978))]).
clause(2939, a(var("x"), n980), [call(a(var("x"), n979))]).
clause(2942, a(var("x"), n981), [call(a(var("x"), n980))]).
clause(2945, a(var("x"), n982), [call(a(var("x"), n981))]).
clause(2948, a(var("x"), n983), [call(a(var("x"), n982))]).
clause(2951, a(var("x"), n984), [call(a(var("x"), n983))]).
clause(2954, a(var("x"), n985), [call(a(var("x"), n984))]).
clause(2957, a(var("x"), n986), [call(a(var("x"), n985))]).
clause(2960, a(var("x"), n987), [call(a(var("x"), n986))]).
clause(2963, a(var("x"), n988), [call(a(var("x"), n987))]).
clause(2966, a(var("x"), n989), [call(a(var("x"), n988))]).
clause(2969, a(var("x"), n990), [call(a(var("x"), n989))]).
clause(2972, a(var("x"), n991), [call(a(var("x"), n990))]).
clause(2975, a(var("x"), n992), [call(a(var("x"), n991))]).
clause(2978, a(var("x"), n993), [call(a(var("x"), n992))]).
clause(2981, a(var("x"), n994), [call(a(var("x"), n993))]).
clause(2984, a(var("x"), n995), [call(a(var("x"), n994))]).
clause(2987, a(var("x"), n996), [call(a(var("x"), n995))]).
clause(2990, a(var("x"), n997), [call(a(var("x"), n996))]).
clause(2993, a(var("x"), n998), [call(a(var("x"), n997))]).
clause(2996, a(var("x"), n999), [call(a(var("x"), n998))]).
clause(2999, a(var("x"), n1000), [call(a(var("x"), n999))]).
clause(3002, a(var("x"), a2), [call(a(var("x"), n1000))]).
clause(3003, holds_result(test, true), [call(a(ind, a2))]).
clause(3004, arc(check1, "C1 OK - the starting classification n0 is present."), [call(a(ind, n0))]).
clause(3005, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."), [call(a(ind, n1)), call(a(ind, i1)), call(a(ind, j1))]).
clause(3006, arc(check3, "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches."), [call(a(ind, n500)), call(a(ind, i500)), call(a(ind, j500))]).
clause(3007, arc(check4, "C4 OK - the final taxonomy step from n999 to n1000 was completed."), [call(a(ind, n999)), call(a(ind, n1000))]).
clause(3008, arc(check5, "C5 OK - once n1000 is reached, the terminal class a2 is derived."), [call(a(ind, n1000)), call(a(ind, a2))]).
clause(3009, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."), [call(a(ind, a2)), call(holds_result(test, true))]).
substitution(1, []).
proof(1, a(ind, n0), rule(1), []).
substitution(2, [binding("x", ind)]).
proof(2, a(ind, n1), rule(2), [uses(1, a(ind, n0))]).
substitution(3, []).
proof(3, arc(check1, "C1 OK - the starting classification n0 is present."), rule(3004), [uses(1, a(ind, n0))]).
substitution(4, [binding("check", check1), binding("message", "C1 OK - the starting classification n0 is present.")]).
proof(4, solution([check1, "C1 OK - the starting classification n0 is present."]), query, [uses(3, arc(check1, "C1 OK - the starting classification n0 is present."))]).
substitution(5, [binding("x", ind)]).
proof(5, a(ind, i1), rule(3), [uses(1, a(ind, n0))]).
substitution(6, [binding("x", ind)]).
proof(6, a(ind, j1), rule(4), [uses(1, a(ind, n0))]).
substitution(7, []).
proof(7, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."), rule(3005), [uses(2, a(ind, n1)), uses(5, a(ind, i1)), uses(6, a(ind, j1))]).
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
proof(59, a(ind, n52), rule(155), [uses(58, a(ind, n51))]).
substitution(60, [binding("x", ind)]).
proof(60, a(ind, n53), rule(158), [uses(59, a(ind, n52))]).
substitution(61, [binding("x", ind)]).
proof(61, a(ind, n54), rule(161), [uses(60, a(ind, n53))]).
substitution(62, [binding("x", ind)]).
proof(62, a(ind, n55), rule(164), [uses(61, a(ind, n54))]).
substitution(63, [binding("x", ind)]).
proof(63, a(ind, n56), rule(167), [uses(62, a(ind, n55))]).
substitution(64, [binding("x", ind)]).
proof(64, a(ind, n57), rule(170), [uses(63, a(ind, n56))]).
substitution(65, [binding("x", ind)]).
proof(65, a(ind, n58), rule(173), [uses(64, a(ind, n57))]).
substitution(66, [binding("x", ind)]).
proof(66, a(ind, n59), rule(176), [uses(65, a(ind, n58))]).
substitution(67, [binding("x", ind)]).
proof(67, a(ind, n60), rule(179), [uses(66, a(ind, n59))]).
substitution(68, [binding("x", ind)]).
proof(68, a(ind, n61), rule(182), [uses(67, a(ind, n60))]).
substitution(69, [binding("x", ind)]).
proof(69, a(ind, n62), rule(185), [uses(68, a(ind, n61))]).
substitution(70, [binding("x", ind)]).
proof(70, a(ind, n63), rule(188), [uses(69, a(ind, n62))]).
substitution(71, [binding("x", ind)]).
proof(71, a(ind, n64), rule(191), [uses(70, a(ind, n63))]).
substitution(72, [binding("x", ind)]).
proof(72, a(ind, n65), rule(194), [uses(71, a(ind, n64))]).
substitution(73, [binding("x", ind)]).
proof(73, a(ind, n66), rule(197), [uses(72, a(ind, n65))]).
substitution(74, [binding("x", ind)]).
proof(74, a(ind, n67), rule(200), [uses(73, a(ind, n66))]).
substitution(75, [binding("x", ind)]).
proof(75, a(ind, n68), rule(203), [uses(74, a(ind, n67))]).
substitution(76, [binding("x", ind)]).
proof(76, a(ind, n69), rule(206), [uses(75, a(ind, n68))]).
substitution(77, [binding("x", ind)]).
proof(77, a(ind, n70), rule(209), [uses(76, a(ind, n69))]).
substitution(78, [binding("x", ind)]).
proof(78, a(ind, n71), rule(212), [uses(77, a(ind, n70))]).
substitution(79, [binding("x", ind)]).
proof(79, a(ind, n72), rule(215), [uses(78, a(ind, n71))]).
substitution(80, [binding("x", ind)]).
proof(80, a(ind, n73), rule(218), [uses(79, a(ind, n72))]).
substitution(81, [binding("x", ind)]).
proof(81, a(ind, n74), rule(221), [uses(80, a(ind, n73))]).
substitution(82, [binding("x", ind)]).
proof(82, a(ind, n75), rule(224), [uses(81, a(ind, n74))]).
substitution(83, [binding("x", ind)]).
proof(83, a(ind, n76), rule(227), [uses(82, a(ind, n75))]).
substitution(84, [binding("x", ind)]).
proof(84, a(ind, n77), rule(230), [uses(83, a(ind, n76))]).
substitution(85, [binding("x", ind)]).
proof(85, a(ind, n78), rule(233), [uses(84, a(ind, n77))]).
substitution(86, [binding("x", ind)]).
proof(86, a(ind, n79), rule(236), [uses(85, a(ind, n78))]).
substitution(87, [binding("x", ind)]).
proof(87, a(ind, n80), rule(239), [uses(86, a(ind, n79))]).
substitution(88, [binding("x", ind)]).
proof(88, a(ind, n81), rule(242), [uses(87, a(ind, n80))]).
substitution(89, [binding("x", ind)]).
proof(89, a(ind, n82), rule(245), [uses(88, a(ind, n81))]).
substitution(90, [binding("x", ind)]).
proof(90, a(ind, n83), rule(248), [uses(89, a(ind, n82))]).
substitution(91, [binding("x", ind)]).
proof(91, a(ind, n84), rule(251), [uses(90, a(ind, n83))]).
substitution(92, [binding("x", ind)]).
proof(92, a(ind, n85), rule(254), [uses(91, a(ind, n84))]).
substitution(93, [binding("x", ind)]).
proof(93, a(ind, n86), rule(257), [uses(92, a(ind, n85))]).
substitution(94, [binding("x", ind)]).
proof(94, a(ind, n87), rule(260), [uses(93, a(ind, n86))]).
substitution(95, [binding("x", ind)]).
proof(95, a(ind, n88), rule(263), [uses(94, a(ind, n87))]).
substitution(96, [binding("x", ind)]).
proof(96, a(ind, n89), rule(266), [uses(95, a(ind, n88))]).
substitution(97, [binding("x", ind)]).
proof(97, a(ind, n90), rule(269), [uses(96, a(ind, n89))]).
substitution(98, [binding("x", ind)]).
proof(98, a(ind, n91), rule(272), [uses(97, a(ind, n90))]).
substitution(99, [binding("x", ind)]).
proof(99, a(ind, n92), rule(275), [uses(98, a(ind, n91))]).
substitution(100, [binding("x", ind)]).
proof(100, a(ind, n93), rule(278), [uses(99, a(ind, n92))]).
substitution(101, [binding("x", ind)]).
proof(101, a(ind, n94), rule(281), [uses(100, a(ind, n93))]).
substitution(102, [binding("x", ind)]).
proof(102, a(ind, n95), rule(284), [uses(101, a(ind, n94))]).
substitution(103, [binding("x", ind)]).
proof(103, a(ind, n96), rule(287), [uses(102, a(ind, n95))]).
substitution(104, [binding("x", ind)]).
proof(104, a(ind, n97), rule(290), [uses(103, a(ind, n96))]).
substitution(105, [binding("x", ind)]).
proof(105, a(ind, n98), rule(293), [uses(104, a(ind, n97))]).
substitution(106, [binding("x", ind)]).
proof(106, a(ind, n99), rule(296), [uses(105, a(ind, n98))]).
substitution(107, [binding("x", ind)]).
proof(107, a(ind, n100), rule(299), [uses(106, a(ind, n99))]).
substitution(108, [binding("x", ind)]).
proof(108, a(ind, n101), rule(302), [uses(107, a(ind, n100))]).
substitution(109, [binding("x", ind)]).
proof(109, a(ind, n102), rule(305), [uses(108, a(ind, n101))]).
substitution(110, [binding("x", ind)]).
proof(110, a(ind, n103), rule(308), [uses(109, a(ind, n102))]).
substitution(111, [binding("x", ind)]).
proof(111, a(ind, n104), rule(311), [uses(110, a(ind, n103))]).
substitution(112, [binding("x", ind)]).
proof(112, a(ind, n105), rule(314), [uses(111, a(ind, n104))]).
substitution(113, [binding("x", ind)]).
proof(113, a(ind, n106), rule(317), [uses(112, a(ind, n105))]).
substitution(114, [binding("x", ind)]).
proof(114, a(ind, n107), rule(320), [uses(113, a(ind, n106))]).
substitution(115, [binding("x", ind)]).
proof(115, a(ind, n108), rule(323), [uses(114, a(ind, n107))]).
substitution(116, [binding("x", ind)]).
proof(116, a(ind, n109), rule(326), [uses(115, a(ind, n108))]).
substitution(117, [binding("x", ind)]).
proof(117, a(ind, n110), rule(329), [uses(116, a(ind, n109))]).
substitution(118, [binding("x", ind)]).
proof(118, a(ind, n111), rule(332), [uses(117, a(ind, n110))]).
substitution(119, [binding("x", ind)]).
proof(119, a(ind, n112), rule(335), [uses(118, a(ind, n111))]).
substitution(120, [binding("x", ind)]).
proof(120, a(ind, n113), rule(338), [uses(119, a(ind, n112))]).
substitution(121, [binding("x", ind)]).
proof(121, a(ind, n114), rule(341), [uses(120, a(ind, n113))]).
substitution(122, [binding("x", ind)]).
proof(122, a(ind, n115), rule(344), [uses(121, a(ind, n114))]).
substitution(123, [binding("x", ind)]).
proof(123, a(ind, n116), rule(347), [uses(122, a(ind, n115))]).
substitution(124, [binding("x", ind)]).
proof(124, a(ind, n117), rule(350), [uses(123, a(ind, n116))]).
substitution(125, [binding("x", ind)]).
proof(125, a(ind, n118), rule(353), [uses(124, a(ind, n117))]).
substitution(126, [binding("x", ind)]).
proof(126, a(ind, n119), rule(356), [uses(125, a(ind, n118))]).
substitution(127, [binding("x", ind)]).
proof(127, a(ind, n120), rule(359), [uses(126, a(ind, n119))]).
substitution(128, [binding("x", ind)]).
proof(128, a(ind, n121), rule(362), [uses(127, a(ind, n120))]).
substitution(129, [binding("x", ind)]).
proof(129, a(ind, n122), rule(365), [uses(128, a(ind, n121))]).
substitution(130, [binding("x", ind)]).
proof(130, a(ind, n123), rule(368), [uses(129, a(ind, n122))]).
substitution(131, [binding("x", ind)]).
proof(131, a(ind, n124), rule(371), [uses(130, a(ind, n123))]).
substitution(132, [binding("x", ind)]).
proof(132, a(ind, n125), rule(374), [uses(131, a(ind, n124))]).
substitution(133, [binding("x", ind)]).
proof(133, a(ind, n126), rule(377), [uses(132, a(ind, n125))]).
substitution(134, [binding("x", ind)]).
proof(134, a(ind, n127), rule(380), [uses(133, a(ind, n126))]).
substitution(135, [binding("x", ind)]).
proof(135, a(ind, n128), rule(383), [uses(134, a(ind, n127))]).
substitution(136, [binding("x", ind)]).
proof(136, a(ind, n129), rule(386), [uses(135, a(ind, n128))]).
substitution(137, [binding("x", ind)]).
proof(137, a(ind, n130), rule(389), [uses(136, a(ind, n129))]).
substitution(138, [binding("x", ind)]).
proof(138, a(ind, n131), rule(392), [uses(137, a(ind, n130))]).
substitution(139, [binding("x", ind)]).
proof(139, a(ind, n132), rule(395), [uses(138, a(ind, n131))]).
substitution(140, [binding("x", ind)]).
proof(140, a(ind, n133), rule(398), [uses(139, a(ind, n132))]).
substitution(141, [binding("x", ind)]).
proof(141, a(ind, n134), rule(401), [uses(140, a(ind, n133))]).
substitution(142, [binding("x", ind)]).
proof(142, a(ind, n135), rule(404), [uses(141, a(ind, n134))]).
substitution(143, [binding("x", ind)]).
proof(143, a(ind, n136), rule(407), [uses(142, a(ind, n135))]).
substitution(144, [binding("x", ind)]).
proof(144, a(ind, n137), rule(410), [uses(143, a(ind, n136))]).
substitution(145, [binding("x", ind)]).
proof(145, a(ind, n138), rule(413), [uses(144, a(ind, n137))]).
substitution(146, [binding("x", ind)]).
proof(146, a(ind, n139), rule(416), [uses(145, a(ind, n138))]).
substitution(147, [binding("x", ind)]).
proof(147, a(ind, n140), rule(419), [uses(146, a(ind, n139))]).
substitution(148, [binding("x", ind)]).
proof(148, a(ind, n141), rule(422), [uses(147, a(ind, n140))]).
substitution(149, [binding("x", ind)]).
proof(149, a(ind, n142), rule(425), [uses(148, a(ind, n141))]).
substitution(150, [binding("x", ind)]).
proof(150, a(ind, n143), rule(428), [uses(149, a(ind, n142))]).
substitution(151, [binding("x", ind)]).
proof(151, a(ind, n144), rule(431), [uses(150, a(ind, n143))]).
substitution(152, [binding("x", ind)]).
proof(152, a(ind, n145), rule(434), [uses(151, a(ind, n144))]).
substitution(153, [binding("x", ind)]).
proof(153, a(ind, n146), rule(437), [uses(152, a(ind, n145))]).
substitution(154, [binding("x", ind)]).
proof(154, a(ind, n147), rule(440), [uses(153, a(ind, n146))]).
substitution(155, [binding("x", ind)]).
proof(155, a(ind, n148), rule(443), [uses(154, a(ind, n147))]).
substitution(156, [binding("x", ind)]).
proof(156, a(ind, n149), rule(446), [uses(155, a(ind, n148))]).
substitution(157, [binding("x", ind)]).
proof(157, a(ind, n150), rule(449), [uses(156, a(ind, n149))]).
substitution(158, [binding("x", ind)]).
proof(158, a(ind, n151), rule(452), [uses(157, a(ind, n150))]).
substitution(159, [binding("x", ind)]).
proof(159, a(ind, n152), rule(455), [uses(158, a(ind, n151))]).
substitution(160, [binding("x", ind)]).
proof(160, a(ind, n153), rule(458), [uses(159, a(ind, n152))]).
substitution(161, [binding("x", ind)]).
proof(161, a(ind, n154), rule(461), [uses(160, a(ind, n153))]).
substitution(162, [binding("x", ind)]).
proof(162, a(ind, n155), rule(464), [uses(161, a(ind, n154))]).
substitution(163, [binding("x", ind)]).
proof(163, a(ind, n156), rule(467), [uses(162, a(ind, n155))]).
substitution(164, [binding("x", ind)]).
proof(164, a(ind, n157), rule(470), [uses(163, a(ind, n156))]).
substitution(165, [binding("x", ind)]).
proof(165, a(ind, n158), rule(473), [uses(164, a(ind, n157))]).
substitution(166, [binding("x", ind)]).
proof(166, a(ind, n159), rule(476), [uses(165, a(ind, n158))]).
substitution(167, [binding("x", ind)]).
proof(167, a(ind, n160), rule(479), [uses(166, a(ind, n159))]).
substitution(168, [binding("x", ind)]).
proof(168, a(ind, n161), rule(482), [uses(167, a(ind, n160))]).
substitution(169, [binding("x", ind)]).
proof(169, a(ind, n162), rule(485), [uses(168, a(ind, n161))]).
substitution(170, [binding("x", ind)]).
proof(170, a(ind, n163), rule(488), [uses(169, a(ind, n162))]).
substitution(171, [binding("x", ind)]).
proof(171, a(ind, n164), rule(491), [uses(170, a(ind, n163))]).
substitution(172, [binding("x", ind)]).
proof(172, a(ind, n165), rule(494), [uses(171, a(ind, n164))]).
substitution(173, [binding("x", ind)]).
proof(173, a(ind, n166), rule(497), [uses(172, a(ind, n165))]).
substitution(174, [binding("x", ind)]).
proof(174, a(ind, n167), rule(500), [uses(173, a(ind, n166))]).
substitution(175, [binding("x", ind)]).
proof(175, a(ind, n168), rule(503), [uses(174, a(ind, n167))]).
substitution(176, [binding("x", ind)]).
proof(176, a(ind, n169), rule(506), [uses(175, a(ind, n168))]).
substitution(177, [binding("x", ind)]).
proof(177, a(ind, n170), rule(509), [uses(176, a(ind, n169))]).
substitution(178, [binding("x", ind)]).
proof(178, a(ind, n171), rule(512), [uses(177, a(ind, n170))]).
substitution(179, [binding("x", ind)]).
proof(179, a(ind, n172), rule(515), [uses(178, a(ind, n171))]).
substitution(180, [binding("x", ind)]).
proof(180, a(ind, n173), rule(518), [uses(179, a(ind, n172))]).
substitution(181, [binding("x", ind)]).
proof(181, a(ind, n174), rule(521), [uses(180, a(ind, n173))]).
substitution(182, [binding("x", ind)]).
proof(182, a(ind, n175), rule(524), [uses(181, a(ind, n174))]).
substitution(183, [binding("x", ind)]).
proof(183, a(ind, n176), rule(527), [uses(182, a(ind, n175))]).
substitution(184, [binding("x", ind)]).
proof(184, a(ind, n177), rule(530), [uses(183, a(ind, n176))]).
substitution(185, [binding("x", ind)]).
proof(185, a(ind, n178), rule(533), [uses(184, a(ind, n177))]).
substitution(186, [binding("x", ind)]).
proof(186, a(ind, n179), rule(536), [uses(185, a(ind, n178))]).
substitution(187, [binding("x", ind)]).
proof(187, a(ind, n180), rule(539), [uses(186, a(ind, n179))]).
substitution(188, [binding("x", ind)]).
proof(188, a(ind, n181), rule(542), [uses(187, a(ind, n180))]).
substitution(189, [binding("x", ind)]).
proof(189, a(ind, n182), rule(545), [uses(188, a(ind, n181))]).
substitution(190, [binding("x", ind)]).
proof(190, a(ind, n183), rule(548), [uses(189, a(ind, n182))]).
substitution(191, [binding("x", ind)]).
proof(191, a(ind, n184), rule(551), [uses(190, a(ind, n183))]).
substitution(192, [binding("x", ind)]).
proof(192, a(ind, n185), rule(554), [uses(191, a(ind, n184))]).
substitution(193, [binding("x", ind)]).
proof(193, a(ind, n186), rule(557), [uses(192, a(ind, n185))]).
substitution(194, [binding("x", ind)]).
proof(194, a(ind, n187), rule(560), [uses(193, a(ind, n186))]).
substitution(195, [binding("x", ind)]).
proof(195, a(ind, n188), rule(563), [uses(194, a(ind, n187))]).
substitution(196, [binding("x", ind)]).
proof(196, a(ind, n189), rule(566), [uses(195, a(ind, n188))]).
substitution(197, [binding("x", ind)]).
proof(197, a(ind, n190), rule(569), [uses(196, a(ind, n189))]).
substitution(198, [binding("x", ind)]).
proof(198, a(ind, n191), rule(572), [uses(197, a(ind, n190))]).
substitution(199, [binding("x", ind)]).
proof(199, a(ind, n192), rule(575), [uses(198, a(ind, n191))]).
substitution(200, [binding("x", ind)]).
proof(200, a(ind, n193), rule(578), [uses(199, a(ind, n192))]).
substitution(201, [binding("x", ind)]).
proof(201, a(ind, n194), rule(581), [uses(200, a(ind, n193))]).
substitution(202, [binding("x", ind)]).
proof(202, a(ind, n195), rule(584), [uses(201, a(ind, n194))]).
substitution(203, [binding("x", ind)]).
proof(203, a(ind, n196), rule(587), [uses(202, a(ind, n195))]).
substitution(204, [binding("x", ind)]).
proof(204, a(ind, n197), rule(590), [uses(203, a(ind, n196))]).
substitution(205, [binding("x", ind)]).
proof(205, a(ind, n198), rule(593), [uses(204, a(ind, n197))]).
substitution(206, [binding("x", ind)]).
proof(206, a(ind, n199), rule(596), [uses(205, a(ind, n198))]).
substitution(207, [binding("x", ind)]).
proof(207, a(ind, n200), rule(599), [uses(206, a(ind, n199))]).
substitution(208, [binding("x", ind)]).
proof(208, a(ind, n201), rule(602), [uses(207, a(ind, n200))]).
substitution(209, [binding("x", ind)]).
proof(209, a(ind, n202), rule(605), [uses(208, a(ind, n201))]).
substitution(210, [binding("x", ind)]).
proof(210, a(ind, n203), rule(608), [uses(209, a(ind, n202))]).
substitution(211, [binding("x", ind)]).
proof(211, a(ind, n204), rule(611), [uses(210, a(ind, n203))]).
substitution(212, [binding("x", ind)]).
proof(212, a(ind, n205), rule(614), [uses(211, a(ind, n204))]).
substitution(213, [binding("x", ind)]).
proof(213, a(ind, n206), rule(617), [uses(212, a(ind, n205))]).
substitution(214, [binding("x", ind)]).
proof(214, a(ind, n207), rule(620), [uses(213, a(ind, n206))]).
substitution(215, [binding("x", ind)]).
proof(215, a(ind, n208), rule(623), [uses(214, a(ind, n207))]).
substitution(216, [binding("x", ind)]).
proof(216, a(ind, n209), rule(626), [uses(215, a(ind, n208))]).
substitution(217, [binding("x", ind)]).
proof(217, a(ind, n210), rule(629), [uses(216, a(ind, n209))]).
substitution(218, [binding("x", ind)]).
proof(218, a(ind, n211), rule(632), [uses(217, a(ind, n210))]).
substitution(219, [binding("x", ind)]).
proof(219, a(ind, n212), rule(635), [uses(218, a(ind, n211))]).
substitution(220, [binding("x", ind)]).
proof(220, a(ind, n213), rule(638), [uses(219, a(ind, n212))]).
substitution(221, [binding("x", ind)]).
proof(221, a(ind, n214), rule(641), [uses(220, a(ind, n213))]).
substitution(222, [binding("x", ind)]).
proof(222, a(ind, n215), rule(644), [uses(221, a(ind, n214))]).
substitution(223, [binding("x", ind)]).
proof(223, a(ind, n216), rule(647), [uses(222, a(ind, n215))]).
substitution(224, [binding("x", ind)]).
proof(224, a(ind, n217), rule(650), [uses(223, a(ind, n216))]).
substitution(225, [binding("x", ind)]).
proof(225, a(ind, n218), rule(653), [uses(224, a(ind, n217))]).
substitution(226, [binding("x", ind)]).
proof(226, a(ind, n219), rule(656), [uses(225, a(ind, n218))]).
substitution(227, [binding("x", ind)]).
proof(227, a(ind, n220), rule(659), [uses(226, a(ind, n219))]).
substitution(228, [binding("x", ind)]).
proof(228, a(ind, n221), rule(662), [uses(227, a(ind, n220))]).
substitution(229, [binding("x", ind)]).
proof(229, a(ind, n222), rule(665), [uses(228, a(ind, n221))]).
substitution(230, [binding("x", ind)]).
proof(230, a(ind, n223), rule(668), [uses(229, a(ind, n222))]).
substitution(231, [binding("x", ind)]).
proof(231, a(ind, n224), rule(671), [uses(230, a(ind, n223))]).
substitution(232, [binding("x", ind)]).
proof(232, a(ind, n225), rule(674), [uses(231, a(ind, n224))]).
substitution(233, [binding("x", ind)]).
proof(233, a(ind, n226), rule(677), [uses(232, a(ind, n225))]).
substitution(234, [binding("x", ind)]).
proof(234, a(ind, n227), rule(680), [uses(233, a(ind, n226))]).
substitution(235, [binding("x", ind)]).
proof(235, a(ind, n228), rule(683), [uses(234, a(ind, n227))]).
substitution(236, [binding("x", ind)]).
proof(236, a(ind, n229), rule(686), [uses(235, a(ind, n228))]).
substitution(237, [binding("x", ind)]).
proof(237, a(ind, n230), rule(689), [uses(236, a(ind, n229))]).
substitution(238, [binding("x", ind)]).
proof(238, a(ind, n231), rule(692), [uses(237, a(ind, n230))]).
substitution(239, [binding("x", ind)]).
proof(239, a(ind, n232), rule(695), [uses(238, a(ind, n231))]).
substitution(240, [binding("x", ind)]).
proof(240, a(ind, n233), rule(698), [uses(239, a(ind, n232))]).
substitution(241, [binding("x", ind)]).
proof(241, a(ind, n234), rule(701), [uses(240, a(ind, n233))]).
substitution(242, [binding("x", ind)]).
proof(242, a(ind, n235), rule(704), [uses(241, a(ind, n234))]).
substitution(243, [binding("x", ind)]).
proof(243, a(ind, n236), rule(707), [uses(242, a(ind, n235))]).
substitution(244, [binding("x", ind)]).
proof(244, a(ind, n237), rule(710), [uses(243, a(ind, n236))]).
substitution(245, [binding("x", ind)]).
proof(245, a(ind, n238), rule(713), [uses(244, a(ind, n237))]).
substitution(246, [binding("x", ind)]).
proof(246, a(ind, n239), rule(716), [uses(245, a(ind, n238))]).
substitution(247, [binding("x", ind)]).
proof(247, a(ind, n240), rule(719), [uses(246, a(ind, n239))]).
substitution(248, [binding("x", ind)]).
proof(248, a(ind, n241), rule(722), [uses(247, a(ind, n240))]).
substitution(249, [binding("x", ind)]).
proof(249, a(ind, n242), rule(725), [uses(248, a(ind, n241))]).
substitution(250, [binding("x", ind)]).
proof(250, a(ind, n243), rule(728), [uses(249, a(ind, n242))]).
substitution(251, [binding("x", ind)]).
proof(251, a(ind, n244), rule(731), [uses(250, a(ind, n243))]).
substitution(252, [binding("x", ind)]).
proof(252, a(ind, n245), rule(734), [uses(251, a(ind, n244))]).
substitution(253, [binding("x", ind)]).
proof(253, a(ind, n246), rule(737), [uses(252, a(ind, n245))]).
substitution(254, [binding("x", ind)]).
proof(254, a(ind, n247), rule(740), [uses(253, a(ind, n246))]).
substitution(255, [binding("x", ind)]).
proof(255, a(ind, n248), rule(743), [uses(254, a(ind, n247))]).
substitution(256, [binding("x", ind)]).
proof(256, a(ind, n249), rule(746), [uses(255, a(ind, n248))]).
substitution(257, [binding("x", ind)]).
proof(257, a(ind, n250), rule(749), [uses(256, a(ind, n249))]).
substitution(258, [binding("x", ind)]).
proof(258, a(ind, n251), rule(752), [uses(257, a(ind, n250))]).
substitution(259, [binding("x", ind)]).
proof(259, a(ind, n252), rule(755), [uses(258, a(ind, n251))]).
substitution(260, [binding("x", ind)]).
proof(260, a(ind, n253), rule(758), [uses(259, a(ind, n252))]).
substitution(261, [binding("x", ind)]).
proof(261, a(ind, n254), rule(761), [uses(260, a(ind, n253))]).
substitution(262, [binding("x", ind)]).
proof(262, a(ind, n255), rule(764), [uses(261, a(ind, n254))]).
substitution(263, [binding("x", ind)]).
proof(263, a(ind, n256), rule(767), [uses(262, a(ind, n255))]).
substitution(264, [binding("x", ind)]).
proof(264, a(ind, n257), rule(770), [uses(263, a(ind, n256))]).
substitution(265, [binding("x", ind)]).
proof(265, a(ind, n258), rule(773), [uses(264, a(ind, n257))]).
substitution(266, [binding("x", ind)]).
proof(266, a(ind, n259), rule(776), [uses(265, a(ind, n258))]).
substitution(267, [binding("x", ind)]).
proof(267, a(ind, n260), rule(779), [uses(266, a(ind, n259))]).
substitution(268, [binding("x", ind)]).
proof(268, a(ind, n261), rule(782), [uses(267, a(ind, n260))]).
substitution(269, [binding("x", ind)]).
proof(269, a(ind, n262), rule(785), [uses(268, a(ind, n261))]).
substitution(270, [binding("x", ind)]).
proof(270, a(ind, n263), rule(788), [uses(269, a(ind, n262))]).
substitution(271, [binding("x", ind)]).
proof(271, a(ind, n264), rule(791), [uses(270, a(ind, n263))]).
substitution(272, [binding("x", ind)]).
proof(272, a(ind, n265), rule(794), [uses(271, a(ind, n264))]).
substitution(273, [binding("x", ind)]).
proof(273, a(ind, n266), rule(797), [uses(272, a(ind, n265))]).
substitution(274, [binding("x", ind)]).
proof(274, a(ind, n267), rule(800), [uses(273, a(ind, n266))]).
substitution(275, [binding("x", ind)]).
proof(275, a(ind, n268), rule(803), [uses(274, a(ind, n267))]).
substitution(276, [binding("x", ind)]).
proof(276, a(ind, n269), rule(806), [uses(275, a(ind, n268))]).
substitution(277, [binding("x", ind)]).
proof(277, a(ind, n270), rule(809), [uses(276, a(ind, n269))]).
substitution(278, [binding("x", ind)]).
proof(278, a(ind, n271), rule(812), [uses(277, a(ind, n270))]).
substitution(279, [binding("x", ind)]).
proof(279, a(ind, n272), rule(815), [uses(278, a(ind, n271))]).
substitution(280, [binding("x", ind)]).
proof(280, a(ind, n273), rule(818), [uses(279, a(ind, n272))]).
substitution(281, [binding("x", ind)]).
proof(281, a(ind, n274), rule(821), [uses(280, a(ind, n273))]).
substitution(282, [binding("x", ind)]).
proof(282, a(ind, n275), rule(824), [uses(281, a(ind, n274))]).
substitution(283, [binding("x", ind)]).
proof(283, a(ind, n276), rule(827), [uses(282, a(ind, n275))]).
substitution(284, [binding("x", ind)]).
proof(284, a(ind, n277), rule(830), [uses(283, a(ind, n276))]).
substitution(285, [binding("x", ind)]).
proof(285, a(ind, n278), rule(833), [uses(284, a(ind, n277))]).
substitution(286, [binding("x", ind)]).
proof(286, a(ind, n279), rule(836), [uses(285, a(ind, n278))]).
substitution(287, [binding("x", ind)]).
proof(287, a(ind, n280), rule(839), [uses(286, a(ind, n279))]).
substitution(288, [binding("x", ind)]).
proof(288, a(ind, n281), rule(842), [uses(287, a(ind, n280))]).
substitution(289, [binding("x", ind)]).
proof(289, a(ind, n282), rule(845), [uses(288, a(ind, n281))]).
substitution(290, [binding("x", ind)]).
proof(290, a(ind, n283), rule(848), [uses(289, a(ind, n282))]).
substitution(291, [binding("x", ind)]).
proof(291, a(ind, n284), rule(851), [uses(290, a(ind, n283))]).
substitution(292, [binding("x", ind)]).
proof(292, a(ind, n285), rule(854), [uses(291, a(ind, n284))]).
substitution(293, [binding("x", ind)]).
proof(293, a(ind, n286), rule(857), [uses(292, a(ind, n285))]).
substitution(294, [binding("x", ind)]).
proof(294, a(ind, n287), rule(860), [uses(293, a(ind, n286))]).
substitution(295, [binding("x", ind)]).
proof(295, a(ind, n288), rule(863), [uses(294, a(ind, n287))]).
substitution(296, [binding("x", ind)]).
proof(296, a(ind, n289), rule(866), [uses(295, a(ind, n288))]).
substitution(297, [binding("x", ind)]).
proof(297, a(ind, n290), rule(869), [uses(296, a(ind, n289))]).
substitution(298, [binding("x", ind)]).
proof(298, a(ind, n291), rule(872), [uses(297, a(ind, n290))]).
substitution(299, [binding("x", ind)]).
proof(299, a(ind, n292), rule(875), [uses(298, a(ind, n291))]).
substitution(300, [binding("x", ind)]).
proof(300, a(ind, n293), rule(878), [uses(299, a(ind, n292))]).
substitution(301, [binding("x", ind)]).
proof(301, a(ind, n294), rule(881), [uses(300, a(ind, n293))]).
substitution(302, [binding("x", ind)]).
proof(302, a(ind, n295), rule(884), [uses(301, a(ind, n294))]).
substitution(303, [binding("x", ind)]).
proof(303, a(ind, n296), rule(887), [uses(302, a(ind, n295))]).
substitution(304, [binding("x", ind)]).
proof(304, a(ind, n297), rule(890), [uses(303, a(ind, n296))]).
substitution(305, [binding("x", ind)]).
proof(305, a(ind, n298), rule(893), [uses(304, a(ind, n297))]).
substitution(306, [binding("x", ind)]).
proof(306, a(ind, n299), rule(896), [uses(305, a(ind, n298))]).
substitution(307, [binding("x", ind)]).
proof(307, a(ind, n300), rule(899), [uses(306, a(ind, n299))]).
substitution(308, [binding("x", ind)]).
proof(308, a(ind, n301), rule(902), [uses(307, a(ind, n300))]).
substitution(309, [binding("x", ind)]).
proof(309, a(ind, n302), rule(905), [uses(308, a(ind, n301))]).
substitution(310, [binding("x", ind)]).
proof(310, a(ind, n303), rule(908), [uses(309, a(ind, n302))]).
substitution(311, [binding("x", ind)]).
proof(311, a(ind, n304), rule(911), [uses(310, a(ind, n303))]).
substitution(312, [binding("x", ind)]).
proof(312, a(ind, n305), rule(914), [uses(311, a(ind, n304))]).
substitution(313, [binding("x", ind)]).
proof(313, a(ind, n306), rule(917), [uses(312, a(ind, n305))]).
substitution(314, [binding("x", ind)]).
proof(314, a(ind, n307), rule(920), [uses(313, a(ind, n306))]).
substitution(315, [binding("x", ind)]).
proof(315, a(ind, n308), rule(923), [uses(314, a(ind, n307))]).
substitution(316, [binding("x", ind)]).
proof(316, a(ind, n309), rule(926), [uses(315, a(ind, n308))]).
substitution(317, [binding("x", ind)]).
proof(317, a(ind, n310), rule(929), [uses(316, a(ind, n309))]).
substitution(318, [binding("x", ind)]).
proof(318, a(ind, n311), rule(932), [uses(317, a(ind, n310))]).
substitution(319, [binding("x", ind)]).
proof(319, a(ind, n312), rule(935), [uses(318, a(ind, n311))]).
substitution(320, [binding("x", ind)]).
proof(320, a(ind, n313), rule(938), [uses(319, a(ind, n312))]).
substitution(321, [binding("x", ind)]).
proof(321, a(ind, n314), rule(941), [uses(320, a(ind, n313))]).
substitution(322, [binding("x", ind)]).
proof(322, a(ind, n315), rule(944), [uses(321, a(ind, n314))]).
substitution(323, [binding("x", ind)]).
proof(323, a(ind, n316), rule(947), [uses(322, a(ind, n315))]).
substitution(324, [binding("x", ind)]).
proof(324, a(ind, n317), rule(950), [uses(323, a(ind, n316))]).
substitution(325, [binding("x", ind)]).
proof(325, a(ind, n318), rule(953), [uses(324, a(ind, n317))]).
substitution(326, [binding("x", ind)]).
proof(326, a(ind, n319), rule(956), [uses(325, a(ind, n318))]).
substitution(327, [binding("x", ind)]).
proof(327, a(ind, n320), rule(959), [uses(326, a(ind, n319))]).
substitution(328, [binding("x", ind)]).
proof(328, a(ind, n321), rule(962), [uses(327, a(ind, n320))]).
substitution(329, [binding("x", ind)]).
proof(329, a(ind, n322), rule(965), [uses(328, a(ind, n321))]).
substitution(330, [binding("x", ind)]).
proof(330, a(ind, n323), rule(968), [uses(329, a(ind, n322))]).
substitution(331, [binding("x", ind)]).
proof(331, a(ind, n324), rule(971), [uses(330, a(ind, n323))]).
substitution(332, [binding("x", ind)]).
proof(332, a(ind, n325), rule(974), [uses(331, a(ind, n324))]).
substitution(333, [binding("x", ind)]).
proof(333, a(ind, n326), rule(977), [uses(332, a(ind, n325))]).
substitution(334, [binding("x", ind)]).
proof(334, a(ind, n327), rule(980), [uses(333, a(ind, n326))]).
substitution(335, [binding("x", ind)]).
proof(335, a(ind, n328), rule(983), [uses(334, a(ind, n327))]).
substitution(336, [binding("x", ind)]).
proof(336, a(ind, n329), rule(986), [uses(335, a(ind, n328))]).
substitution(337, [binding("x", ind)]).
proof(337, a(ind, n330), rule(989), [uses(336, a(ind, n329))]).
substitution(338, [binding("x", ind)]).
proof(338, a(ind, n331), rule(992), [uses(337, a(ind, n330))]).
substitution(339, [binding("x", ind)]).
proof(339, a(ind, n332), rule(995), [uses(338, a(ind, n331))]).
substitution(340, [binding("x", ind)]).
proof(340, a(ind, n333), rule(998), [uses(339, a(ind, n332))]).
substitution(341, [binding("x", ind)]).
proof(341, a(ind, n334), rule(1001), [uses(340, a(ind, n333))]).
substitution(342, [binding("x", ind)]).
proof(342, a(ind, n335), rule(1004), [uses(341, a(ind, n334))]).
substitution(343, [binding("x", ind)]).
proof(343, a(ind, n336), rule(1007), [uses(342, a(ind, n335))]).
substitution(344, [binding("x", ind)]).
proof(344, a(ind, n337), rule(1010), [uses(343, a(ind, n336))]).
substitution(345, [binding("x", ind)]).
proof(345, a(ind, n338), rule(1013), [uses(344, a(ind, n337))]).
substitution(346, [binding("x", ind)]).
proof(346, a(ind, n339), rule(1016), [uses(345, a(ind, n338))]).
substitution(347, [binding("x", ind)]).
proof(347, a(ind, n340), rule(1019), [uses(346, a(ind, n339))]).
substitution(348, [binding("x", ind)]).
proof(348, a(ind, n341), rule(1022), [uses(347, a(ind, n340))]).
substitution(349, [binding("x", ind)]).
proof(349, a(ind, n342), rule(1025), [uses(348, a(ind, n341))]).
substitution(350, [binding("x", ind)]).
proof(350, a(ind, n343), rule(1028), [uses(349, a(ind, n342))]).
substitution(351, [binding("x", ind)]).
proof(351, a(ind, n344), rule(1031), [uses(350, a(ind, n343))]).
substitution(352, [binding("x", ind)]).
proof(352, a(ind, n345), rule(1034), [uses(351, a(ind, n344))]).
substitution(353, [binding("x", ind)]).
proof(353, a(ind, n346), rule(1037), [uses(352, a(ind, n345))]).
substitution(354, [binding("x", ind)]).
proof(354, a(ind, n347), rule(1040), [uses(353, a(ind, n346))]).
substitution(355, [binding("x", ind)]).
proof(355, a(ind, n348), rule(1043), [uses(354, a(ind, n347))]).
substitution(356, [binding("x", ind)]).
proof(356, a(ind, n349), rule(1046), [uses(355, a(ind, n348))]).
substitution(357, [binding("x", ind)]).
proof(357, a(ind, n350), rule(1049), [uses(356, a(ind, n349))]).
substitution(358, [binding("x", ind)]).
proof(358, a(ind, n351), rule(1052), [uses(357, a(ind, n350))]).
substitution(359, [binding("x", ind)]).
proof(359, a(ind, n352), rule(1055), [uses(358, a(ind, n351))]).
substitution(360, [binding("x", ind)]).
proof(360, a(ind, n353), rule(1058), [uses(359, a(ind, n352))]).
substitution(361, [binding("x", ind)]).
proof(361, a(ind, n354), rule(1061), [uses(360, a(ind, n353))]).
substitution(362, [binding("x", ind)]).
proof(362, a(ind, n355), rule(1064), [uses(361, a(ind, n354))]).
substitution(363, [binding("x", ind)]).
proof(363, a(ind, n356), rule(1067), [uses(362, a(ind, n355))]).
substitution(364, [binding("x", ind)]).
proof(364, a(ind, n357), rule(1070), [uses(363, a(ind, n356))]).
substitution(365, [binding("x", ind)]).
proof(365, a(ind, n358), rule(1073), [uses(364, a(ind, n357))]).
substitution(366, [binding("x", ind)]).
proof(366, a(ind, n359), rule(1076), [uses(365, a(ind, n358))]).
substitution(367, [binding("x", ind)]).
proof(367, a(ind, n360), rule(1079), [uses(366, a(ind, n359))]).
substitution(368, [binding("x", ind)]).
proof(368, a(ind, n361), rule(1082), [uses(367, a(ind, n360))]).
substitution(369, [binding("x", ind)]).
proof(369, a(ind, n362), rule(1085), [uses(368, a(ind, n361))]).
substitution(370, [binding("x", ind)]).
proof(370, a(ind, n363), rule(1088), [uses(369, a(ind, n362))]).
substitution(371, [binding("x", ind)]).
proof(371, a(ind, n364), rule(1091), [uses(370, a(ind, n363))]).
substitution(372, [binding("x", ind)]).
proof(372, a(ind, n365), rule(1094), [uses(371, a(ind, n364))]).
substitution(373, [binding("x", ind)]).
proof(373, a(ind, n366), rule(1097), [uses(372, a(ind, n365))]).
substitution(374, [binding("x", ind)]).
proof(374, a(ind, n367), rule(1100), [uses(373, a(ind, n366))]).
substitution(375, [binding("x", ind)]).
proof(375, a(ind, n368), rule(1103), [uses(374, a(ind, n367))]).
substitution(376, [binding("x", ind)]).
proof(376, a(ind, n369), rule(1106), [uses(375, a(ind, n368))]).
substitution(377, [binding("x", ind)]).
proof(377, a(ind, n370), rule(1109), [uses(376, a(ind, n369))]).
substitution(378, [binding("x", ind)]).
proof(378, a(ind, n371), rule(1112), [uses(377, a(ind, n370))]).
substitution(379, [binding("x", ind)]).
proof(379, a(ind, n372), rule(1115), [uses(378, a(ind, n371))]).
substitution(380, [binding("x", ind)]).
proof(380, a(ind, n373), rule(1118), [uses(379, a(ind, n372))]).
substitution(381, [binding("x", ind)]).
proof(381, a(ind, n374), rule(1121), [uses(380, a(ind, n373))]).
substitution(382, [binding("x", ind)]).
proof(382, a(ind, n375), rule(1124), [uses(381, a(ind, n374))]).
substitution(383, [binding("x", ind)]).
proof(383, a(ind, n376), rule(1127), [uses(382, a(ind, n375))]).
substitution(384, [binding("x", ind)]).
proof(384, a(ind, n377), rule(1130), [uses(383, a(ind, n376))]).
substitution(385, [binding("x", ind)]).
proof(385, a(ind, n378), rule(1133), [uses(384, a(ind, n377))]).
substitution(386, [binding("x", ind)]).
proof(386, a(ind, n379), rule(1136), [uses(385, a(ind, n378))]).
substitution(387, [binding("x", ind)]).
proof(387, a(ind, n380), rule(1139), [uses(386, a(ind, n379))]).
substitution(388, [binding("x", ind)]).
proof(388, a(ind, n381), rule(1142), [uses(387, a(ind, n380))]).
substitution(389, [binding("x", ind)]).
proof(389, a(ind, n382), rule(1145), [uses(388, a(ind, n381))]).
substitution(390, [binding("x", ind)]).
proof(390, a(ind, n383), rule(1148), [uses(389, a(ind, n382))]).
substitution(391, [binding("x", ind)]).
proof(391, a(ind, n384), rule(1151), [uses(390, a(ind, n383))]).
substitution(392, [binding("x", ind)]).
proof(392, a(ind, n385), rule(1154), [uses(391, a(ind, n384))]).
substitution(393, [binding("x", ind)]).
proof(393, a(ind, n386), rule(1157), [uses(392, a(ind, n385))]).
substitution(394, [binding("x", ind)]).
proof(394, a(ind, n387), rule(1160), [uses(393, a(ind, n386))]).
substitution(395, [binding("x", ind)]).
proof(395, a(ind, n388), rule(1163), [uses(394, a(ind, n387))]).
substitution(396, [binding("x", ind)]).
proof(396, a(ind, n389), rule(1166), [uses(395, a(ind, n388))]).
substitution(397, [binding("x", ind)]).
proof(397, a(ind, n390), rule(1169), [uses(396, a(ind, n389))]).
substitution(398, [binding("x", ind)]).
proof(398, a(ind, n391), rule(1172), [uses(397, a(ind, n390))]).
substitution(399, [binding("x", ind)]).
proof(399, a(ind, n392), rule(1175), [uses(398, a(ind, n391))]).
substitution(400, [binding("x", ind)]).
proof(400, a(ind, n393), rule(1178), [uses(399, a(ind, n392))]).
substitution(401, [binding("x", ind)]).
proof(401, a(ind, n394), rule(1181), [uses(400, a(ind, n393))]).
substitution(402, [binding("x", ind)]).
proof(402, a(ind, n395), rule(1184), [uses(401, a(ind, n394))]).
substitution(403, [binding("x", ind)]).
proof(403, a(ind, n396), rule(1187), [uses(402, a(ind, n395))]).
substitution(404, [binding("x", ind)]).
proof(404, a(ind, n397), rule(1190), [uses(403, a(ind, n396))]).
substitution(405, [binding("x", ind)]).
proof(405, a(ind, n398), rule(1193), [uses(404, a(ind, n397))]).
substitution(406, [binding("x", ind)]).
proof(406, a(ind, n399), rule(1196), [uses(405, a(ind, n398))]).
substitution(407, [binding("x", ind)]).
proof(407, a(ind, n400), rule(1199), [uses(406, a(ind, n399))]).
substitution(408, [binding("x", ind)]).
proof(408, a(ind, n401), rule(1202), [uses(407, a(ind, n400))]).
substitution(409, [binding("x", ind)]).
proof(409, a(ind, n402), rule(1205), [uses(408, a(ind, n401))]).
substitution(410, [binding("x", ind)]).
proof(410, a(ind, n403), rule(1208), [uses(409, a(ind, n402))]).
substitution(411, [binding("x", ind)]).
proof(411, a(ind, n404), rule(1211), [uses(410, a(ind, n403))]).
substitution(412, [binding("x", ind)]).
proof(412, a(ind, n405), rule(1214), [uses(411, a(ind, n404))]).
substitution(413, [binding("x", ind)]).
proof(413, a(ind, n406), rule(1217), [uses(412, a(ind, n405))]).
substitution(414, [binding("x", ind)]).
proof(414, a(ind, n407), rule(1220), [uses(413, a(ind, n406))]).
substitution(415, [binding("x", ind)]).
proof(415, a(ind, n408), rule(1223), [uses(414, a(ind, n407))]).
substitution(416, [binding("x", ind)]).
proof(416, a(ind, n409), rule(1226), [uses(415, a(ind, n408))]).
substitution(417, [binding("x", ind)]).
proof(417, a(ind, n410), rule(1229), [uses(416, a(ind, n409))]).
substitution(418, [binding("x", ind)]).
proof(418, a(ind, n411), rule(1232), [uses(417, a(ind, n410))]).
substitution(419, [binding("x", ind)]).
proof(419, a(ind, n412), rule(1235), [uses(418, a(ind, n411))]).
substitution(420, [binding("x", ind)]).
proof(420, a(ind, n413), rule(1238), [uses(419, a(ind, n412))]).
substitution(421, [binding("x", ind)]).
proof(421, a(ind, n414), rule(1241), [uses(420, a(ind, n413))]).
substitution(422, [binding("x", ind)]).
proof(422, a(ind, n415), rule(1244), [uses(421, a(ind, n414))]).
substitution(423, [binding("x", ind)]).
proof(423, a(ind, n416), rule(1247), [uses(422, a(ind, n415))]).
substitution(424, [binding("x", ind)]).
proof(424, a(ind, n417), rule(1250), [uses(423, a(ind, n416))]).
substitution(425, [binding("x", ind)]).
proof(425, a(ind, n418), rule(1253), [uses(424, a(ind, n417))]).
substitution(426, [binding("x", ind)]).
proof(426, a(ind, n419), rule(1256), [uses(425, a(ind, n418))]).
substitution(427, [binding("x", ind)]).
proof(427, a(ind, n420), rule(1259), [uses(426, a(ind, n419))]).
substitution(428, [binding("x", ind)]).
proof(428, a(ind, n421), rule(1262), [uses(427, a(ind, n420))]).
substitution(429, [binding("x", ind)]).
proof(429, a(ind, n422), rule(1265), [uses(428, a(ind, n421))]).
substitution(430, [binding("x", ind)]).
proof(430, a(ind, n423), rule(1268), [uses(429, a(ind, n422))]).
substitution(431, [binding("x", ind)]).
proof(431, a(ind, n424), rule(1271), [uses(430, a(ind, n423))]).
substitution(432, [binding("x", ind)]).
proof(432, a(ind, n425), rule(1274), [uses(431, a(ind, n424))]).
substitution(433, [binding("x", ind)]).
proof(433, a(ind, n426), rule(1277), [uses(432, a(ind, n425))]).
substitution(434, [binding("x", ind)]).
proof(434, a(ind, n427), rule(1280), [uses(433, a(ind, n426))]).
substitution(435, [binding("x", ind)]).
proof(435, a(ind, n428), rule(1283), [uses(434, a(ind, n427))]).
substitution(436, [binding("x", ind)]).
proof(436, a(ind, n429), rule(1286), [uses(435, a(ind, n428))]).
substitution(437, [binding("x", ind)]).
proof(437, a(ind, n430), rule(1289), [uses(436, a(ind, n429))]).
substitution(438, [binding("x", ind)]).
proof(438, a(ind, n431), rule(1292), [uses(437, a(ind, n430))]).
substitution(439, [binding("x", ind)]).
proof(439, a(ind, n432), rule(1295), [uses(438, a(ind, n431))]).
substitution(440, [binding("x", ind)]).
proof(440, a(ind, n433), rule(1298), [uses(439, a(ind, n432))]).
substitution(441, [binding("x", ind)]).
proof(441, a(ind, n434), rule(1301), [uses(440, a(ind, n433))]).
substitution(442, [binding("x", ind)]).
proof(442, a(ind, n435), rule(1304), [uses(441, a(ind, n434))]).
substitution(443, [binding("x", ind)]).
proof(443, a(ind, n436), rule(1307), [uses(442, a(ind, n435))]).
substitution(444, [binding("x", ind)]).
proof(444, a(ind, n437), rule(1310), [uses(443, a(ind, n436))]).
substitution(445, [binding("x", ind)]).
proof(445, a(ind, n438), rule(1313), [uses(444, a(ind, n437))]).
substitution(446, [binding("x", ind)]).
proof(446, a(ind, n439), rule(1316), [uses(445, a(ind, n438))]).
substitution(447, [binding("x", ind)]).
proof(447, a(ind, n440), rule(1319), [uses(446, a(ind, n439))]).
substitution(448, [binding("x", ind)]).
proof(448, a(ind, n441), rule(1322), [uses(447, a(ind, n440))]).
substitution(449, [binding("x", ind)]).
proof(449, a(ind, n442), rule(1325), [uses(448, a(ind, n441))]).
substitution(450, [binding("x", ind)]).
proof(450, a(ind, n443), rule(1328), [uses(449, a(ind, n442))]).
substitution(451, [binding("x", ind)]).
proof(451, a(ind, n444), rule(1331), [uses(450, a(ind, n443))]).
substitution(452, [binding("x", ind)]).
proof(452, a(ind, n445), rule(1334), [uses(451, a(ind, n444))]).
substitution(453, [binding("x", ind)]).
proof(453, a(ind, n446), rule(1337), [uses(452, a(ind, n445))]).
substitution(454, [binding("x", ind)]).
proof(454, a(ind, n447), rule(1340), [uses(453, a(ind, n446))]).
substitution(455, [binding("x", ind)]).
proof(455, a(ind, n448), rule(1343), [uses(454, a(ind, n447))]).
substitution(456, [binding("x", ind)]).
proof(456, a(ind, n449), rule(1346), [uses(455, a(ind, n448))]).
substitution(457, [binding("x", ind)]).
proof(457, a(ind, n450), rule(1349), [uses(456, a(ind, n449))]).
substitution(458, [binding("x", ind)]).
proof(458, a(ind, n451), rule(1352), [uses(457, a(ind, n450))]).
substitution(459, [binding("x", ind)]).
proof(459, a(ind, n452), rule(1355), [uses(458, a(ind, n451))]).
substitution(460, [binding("x", ind)]).
proof(460, a(ind, n453), rule(1358), [uses(459, a(ind, n452))]).
substitution(461, [binding("x", ind)]).
proof(461, a(ind, n454), rule(1361), [uses(460, a(ind, n453))]).
substitution(462, [binding("x", ind)]).
proof(462, a(ind, n455), rule(1364), [uses(461, a(ind, n454))]).
substitution(463, [binding("x", ind)]).
proof(463, a(ind, n456), rule(1367), [uses(462, a(ind, n455))]).
substitution(464, [binding("x", ind)]).
proof(464, a(ind, n457), rule(1370), [uses(463, a(ind, n456))]).
substitution(465, [binding("x", ind)]).
proof(465, a(ind, n458), rule(1373), [uses(464, a(ind, n457))]).
substitution(466, [binding("x", ind)]).
proof(466, a(ind, n459), rule(1376), [uses(465, a(ind, n458))]).
substitution(467, [binding("x", ind)]).
proof(467, a(ind, n460), rule(1379), [uses(466, a(ind, n459))]).
substitution(468, [binding("x", ind)]).
proof(468, a(ind, n461), rule(1382), [uses(467, a(ind, n460))]).
substitution(469, [binding("x", ind)]).
proof(469, a(ind, n462), rule(1385), [uses(468, a(ind, n461))]).
substitution(470, [binding("x", ind)]).
proof(470, a(ind, n463), rule(1388), [uses(469, a(ind, n462))]).
substitution(471, [binding("x", ind)]).
proof(471, a(ind, n464), rule(1391), [uses(470, a(ind, n463))]).
substitution(472, [binding("x", ind)]).
proof(472, a(ind, n465), rule(1394), [uses(471, a(ind, n464))]).
substitution(473, [binding("x", ind)]).
proof(473, a(ind, n466), rule(1397), [uses(472, a(ind, n465))]).
substitution(474, [binding("x", ind)]).
proof(474, a(ind, n467), rule(1400), [uses(473, a(ind, n466))]).
substitution(475, [binding("x", ind)]).
proof(475, a(ind, n468), rule(1403), [uses(474, a(ind, n467))]).
substitution(476, [binding("x", ind)]).
proof(476, a(ind, n469), rule(1406), [uses(475, a(ind, n468))]).
substitution(477, [binding("x", ind)]).
proof(477, a(ind, n470), rule(1409), [uses(476, a(ind, n469))]).
substitution(478, [binding("x", ind)]).
proof(478, a(ind, n471), rule(1412), [uses(477, a(ind, n470))]).
substitution(479, [binding("x", ind)]).
proof(479, a(ind, n472), rule(1415), [uses(478, a(ind, n471))]).
substitution(480, [binding("x", ind)]).
proof(480, a(ind, n473), rule(1418), [uses(479, a(ind, n472))]).
substitution(481, [binding("x", ind)]).
proof(481, a(ind, n474), rule(1421), [uses(480, a(ind, n473))]).
substitution(482, [binding("x", ind)]).
proof(482, a(ind, n475), rule(1424), [uses(481, a(ind, n474))]).
substitution(483, [binding("x", ind)]).
proof(483, a(ind, n476), rule(1427), [uses(482, a(ind, n475))]).
substitution(484, [binding("x", ind)]).
proof(484, a(ind, n477), rule(1430), [uses(483, a(ind, n476))]).
substitution(485, [binding("x", ind)]).
proof(485, a(ind, n478), rule(1433), [uses(484, a(ind, n477))]).
substitution(486, [binding("x", ind)]).
proof(486, a(ind, n479), rule(1436), [uses(485, a(ind, n478))]).
substitution(487, [binding("x", ind)]).
proof(487, a(ind, n480), rule(1439), [uses(486, a(ind, n479))]).
substitution(488, [binding("x", ind)]).
proof(488, a(ind, n481), rule(1442), [uses(487, a(ind, n480))]).
substitution(489, [binding("x", ind)]).
proof(489, a(ind, n482), rule(1445), [uses(488, a(ind, n481))]).
substitution(490, [binding("x", ind)]).
proof(490, a(ind, n483), rule(1448), [uses(489, a(ind, n482))]).
substitution(491, [binding("x", ind)]).
proof(491, a(ind, n484), rule(1451), [uses(490, a(ind, n483))]).
substitution(492, [binding("x", ind)]).
proof(492, a(ind, n485), rule(1454), [uses(491, a(ind, n484))]).
substitution(493, [binding("x", ind)]).
proof(493, a(ind, n486), rule(1457), [uses(492, a(ind, n485))]).
substitution(494, [binding("x", ind)]).
proof(494, a(ind, n487), rule(1460), [uses(493, a(ind, n486))]).
substitution(495, [binding("x", ind)]).
proof(495, a(ind, n488), rule(1463), [uses(494, a(ind, n487))]).
substitution(496, [binding("x", ind)]).
proof(496, a(ind, n489), rule(1466), [uses(495, a(ind, n488))]).
substitution(497, [binding("x", ind)]).
proof(497, a(ind, n490), rule(1469), [uses(496, a(ind, n489))]).
substitution(498, [binding("x", ind)]).
proof(498, a(ind, n491), rule(1472), [uses(497, a(ind, n490))]).
substitution(499, [binding("x", ind)]).
proof(499, a(ind, n492), rule(1475), [uses(498, a(ind, n491))]).
substitution(500, [binding("x", ind)]).
proof(500, a(ind, n493), rule(1478), [uses(499, a(ind, n492))]).
substitution(501, [binding("x", ind)]).
proof(501, a(ind, n494), rule(1481), [uses(500, a(ind, n493))]).
substitution(502, [binding("x", ind)]).
proof(502, a(ind, n495), rule(1484), [uses(501, a(ind, n494))]).
substitution(503, [binding("x", ind)]).
proof(503, a(ind, n496), rule(1487), [uses(502, a(ind, n495))]).
substitution(504, [binding("x", ind)]).
proof(504, a(ind, n497), rule(1490), [uses(503, a(ind, n496))]).
substitution(505, [binding("x", ind)]).
proof(505, a(ind, n498), rule(1493), [uses(504, a(ind, n497))]).
substitution(506, [binding("x", ind)]).
proof(506, a(ind, n499), rule(1496), [uses(505, a(ind, n498))]).
substitution(507, [binding("x", ind)]).
proof(507, a(ind, n500), rule(1499), [uses(506, a(ind, n499))]).
substitution(508, [binding("x", ind)]).
proof(508, a(ind, n501), rule(1502), [uses(507, a(ind, n500))]).
substitution(509, [binding("x", ind)]).
proof(509, a(ind, i500), rule(1500), [uses(506, a(ind, n499))]).
substitution(510, [binding("x", ind)]).
proof(510, a(ind, n502), rule(1505), [uses(508, a(ind, n501))]).
substitution(511, [binding("x", ind)]).
proof(511, a(ind, n503), rule(1508), [uses(510, a(ind, n502))]).
substitution(512, [binding("x", ind)]).
proof(512, a(ind, j500), rule(1501), [uses(506, a(ind, n499))]).
substitution(513, [binding("x", ind)]).
proof(513, a(ind, n504), rule(1511), [uses(511, a(ind, n503))]).
substitution(514, []).
proof(514, arc(check3, "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches."), rule(3006), [uses(507, a(ind, n500)), uses(509, a(ind, i500)), uses(512, a(ind, j500))]).
substitution(515, [binding("x", ind)]).
proof(515, a(ind, n505), rule(1514), [uses(513, a(ind, n504))]).
substitution(516, [binding("check", check3), binding("message", "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches.")]).
proof(516, solution([check3, "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches."]), query, [uses(514, arc(check3, "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches."))]).
substitution(517, [binding("x", ind)]).
proof(517, a(ind, n506), rule(1517), [uses(515, a(ind, n505))]).
substitution(518, [binding("x", ind)]).
proof(518, a(ind, n507), rule(1520), [uses(517, a(ind, n506))]).
substitution(519, [binding("x", ind)]).
proof(519, a(ind, n508), rule(1523), [uses(518, a(ind, n507))]).
substitution(520, [binding("x", ind)]).
proof(520, a(ind, n509), rule(1526), [uses(519, a(ind, n508))]).
substitution(521, [binding("x", ind)]).
proof(521, a(ind, n510), rule(1529), [uses(520, a(ind, n509))]).
substitution(522, [binding("x", ind)]).
proof(522, a(ind, n511), rule(1532), [uses(521, a(ind, n510))]).
substitution(523, [binding("x", ind)]).
proof(523, a(ind, n512), rule(1535), [uses(522, a(ind, n511))]).
substitution(524, [binding("x", ind)]).
proof(524, a(ind, n513), rule(1538), [uses(523, a(ind, n512))]).
substitution(525, [binding("x", ind)]).
proof(525, a(ind, n514), rule(1541), [uses(524, a(ind, n513))]).
substitution(526, [binding("x", ind)]).
proof(526, a(ind, n515), rule(1544), [uses(525, a(ind, n514))]).
substitution(527, [binding("x", ind)]).
proof(527, a(ind, n516), rule(1547), [uses(526, a(ind, n515))]).
substitution(528, [binding("x", ind)]).
proof(528, a(ind, n517), rule(1550), [uses(527, a(ind, n516))]).
substitution(529, [binding("x", ind)]).
proof(529, a(ind, n518), rule(1553), [uses(528, a(ind, n517))]).
substitution(530, [binding("x", ind)]).
proof(530, a(ind, n519), rule(1556), [uses(529, a(ind, n518))]).
substitution(531, [binding("x", ind)]).
proof(531, a(ind, n520), rule(1559), [uses(530, a(ind, n519))]).
substitution(532, [binding("x", ind)]).
proof(532, a(ind, n521), rule(1562), [uses(531, a(ind, n520))]).
substitution(533, [binding("x", ind)]).
proof(533, a(ind, n522), rule(1565), [uses(532, a(ind, n521))]).
substitution(534, [binding("x", ind)]).
proof(534, a(ind, n523), rule(1568), [uses(533, a(ind, n522))]).
substitution(535, [binding("x", ind)]).
proof(535, a(ind, n524), rule(1571), [uses(534, a(ind, n523))]).
substitution(536, [binding("x", ind)]).
proof(536, a(ind, n525), rule(1574), [uses(535, a(ind, n524))]).
substitution(537, [binding("x", ind)]).
proof(537, a(ind, n526), rule(1577), [uses(536, a(ind, n525))]).
substitution(538, [binding("x", ind)]).
proof(538, a(ind, n527), rule(1580), [uses(537, a(ind, n526))]).
substitution(539, [binding("x", ind)]).
proof(539, a(ind, n528), rule(1583), [uses(538, a(ind, n527))]).
substitution(540, [binding("x", ind)]).
proof(540, a(ind, n529), rule(1586), [uses(539, a(ind, n528))]).
substitution(541, [binding("x", ind)]).
proof(541, a(ind, n530), rule(1589), [uses(540, a(ind, n529))]).
substitution(542, [binding("x", ind)]).
proof(542, a(ind, n531), rule(1592), [uses(541, a(ind, n530))]).
substitution(543, [binding("x", ind)]).
proof(543, a(ind, n532), rule(1595), [uses(542, a(ind, n531))]).
substitution(544, [binding("x", ind)]).
proof(544, a(ind, n533), rule(1598), [uses(543, a(ind, n532))]).
substitution(545, [binding("x", ind)]).
proof(545, a(ind, n534), rule(1601), [uses(544, a(ind, n533))]).
substitution(546, [binding("x", ind)]).
proof(546, a(ind, n535), rule(1604), [uses(545, a(ind, n534))]).
substitution(547, [binding("x", ind)]).
proof(547, a(ind, n536), rule(1607), [uses(546, a(ind, n535))]).
substitution(548, [binding("x", ind)]).
proof(548, a(ind, n537), rule(1610), [uses(547, a(ind, n536))]).
substitution(549, [binding("x", ind)]).
proof(549, a(ind, n538), rule(1613), [uses(548, a(ind, n537))]).
substitution(550, [binding("x", ind)]).
proof(550, a(ind, n539), rule(1616), [uses(549, a(ind, n538))]).
substitution(551, [binding("x", ind)]).
proof(551, a(ind, n540), rule(1619), [uses(550, a(ind, n539))]).
substitution(552, [binding("x", ind)]).
proof(552, a(ind, n541), rule(1622), [uses(551, a(ind, n540))]).
substitution(553, [binding("x", ind)]).
proof(553, a(ind, n542), rule(1625), [uses(552, a(ind, n541))]).
substitution(554, [binding("x", ind)]).
proof(554, a(ind, n543), rule(1628), [uses(553, a(ind, n542))]).
substitution(555, [binding("x", ind)]).
proof(555, a(ind, n544), rule(1631), [uses(554, a(ind, n543))]).
substitution(556, [binding("x", ind)]).
proof(556, a(ind, n545), rule(1634), [uses(555, a(ind, n544))]).
substitution(557, [binding("x", ind)]).
proof(557, a(ind, n546), rule(1637), [uses(556, a(ind, n545))]).
substitution(558, [binding("x", ind)]).
proof(558, a(ind, n547), rule(1640), [uses(557, a(ind, n546))]).
substitution(559, [binding("x", ind)]).
proof(559, a(ind, n548), rule(1643), [uses(558, a(ind, n547))]).
substitution(560, [binding("x", ind)]).
proof(560, a(ind, n549), rule(1646), [uses(559, a(ind, n548))]).
substitution(561, [binding("x", ind)]).
proof(561, a(ind, n550), rule(1649), [uses(560, a(ind, n549))]).
substitution(562, [binding("x", ind)]).
proof(562, a(ind, n551), rule(1652), [uses(561, a(ind, n550))]).
substitution(563, [binding("x", ind)]).
proof(563, a(ind, n552), rule(1655), [uses(562, a(ind, n551))]).
substitution(564, [binding("x", ind)]).
proof(564, a(ind, n553), rule(1658), [uses(563, a(ind, n552))]).
substitution(565, [binding("x", ind)]).
proof(565, a(ind, n554), rule(1661), [uses(564, a(ind, n553))]).
substitution(566, [binding("x", ind)]).
proof(566, a(ind, n555), rule(1664), [uses(565, a(ind, n554))]).
substitution(567, [binding("x", ind)]).
proof(567, a(ind, n556), rule(1667), [uses(566, a(ind, n555))]).
substitution(568, [binding("x", ind)]).
proof(568, a(ind, n557), rule(1670), [uses(567, a(ind, n556))]).
substitution(569, [binding("x", ind)]).
proof(569, a(ind, n558), rule(1673), [uses(568, a(ind, n557))]).
substitution(570, [binding("x", ind)]).
proof(570, a(ind, n559), rule(1676), [uses(569, a(ind, n558))]).
substitution(571, [binding("x", ind)]).
proof(571, a(ind, n560), rule(1679), [uses(570, a(ind, n559))]).
substitution(572, [binding("x", ind)]).
proof(572, a(ind, n561), rule(1682), [uses(571, a(ind, n560))]).
substitution(573, [binding("x", ind)]).
proof(573, a(ind, n562), rule(1685), [uses(572, a(ind, n561))]).
substitution(574, [binding("x", ind)]).
proof(574, a(ind, n563), rule(1688), [uses(573, a(ind, n562))]).
substitution(575, [binding("x", ind)]).
proof(575, a(ind, n564), rule(1691), [uses(574, a(ind, n563))]).
substitution(576, [binding("x", ind)]).
proof(576, a(ind, n565), rule(1694), [uses(575, a(ind, n564))]).
substitution(577, [binding("x", ind)]).
proof(577, a(ind, n566), rule(1697), [uses(576, a(ind, n565))]).
substitution(578, [binding("x", ind)]).
proof(578, a(ind, n567), rule(1700), [uses(577, a(ind, n566))]).
substitution(579, [binding("x", ind)]).
proof(579, a(ind, n568), rule(1703), [uses(578, a(ind, n567))]).
substitution(580, [binding("x", ind)]).
proof(580, a(ind, n569), rule(1706), [uses(579, a(ind, n568))]).
substitution(581, [binding("x", ind)]).
proof(581, a(ind, n570), rule(1709), [uses(580, a(ind, n569))]).
substitution(582, [binding("x", ind)]).
proof(582, a(ind, n571), rule(1712), [uses(581, a(ind, n570))]).
substitution(583, [binding("x", ind)]).
proof(583, a(ind, n572), rule(1715), [uses(582, a(ind, n571))]).
substitution(584, [binding("x", ind)]).
proof(584, a(ind, n573), rule(1718), [uses(583, a(ind, n572))]).
substitution(585, [binding("x", ind)]).
proof(585, a(ind, n574), rule(1721), [uses(584, a(ind, n573))]).
substitution(586, [binding("x", ind)]).
proof(586, a(ind, n575), rule(1724), [uses(585, a(ind, n574))]).
substitution(587, [binding("x", ind)]).
proof(587, a(ind, n576), rule(1727), [uses(586, a(ind, n575))]).
substitution(588, [binding("x", ind)]).
proof(588, a(ind, n577), rule(1730), [uses(587, a(ind, n576))]).
substitution(589, [binding("x", ind)]).
proof(589, a(ind, n578), rule(1733), [uses(588, a(ind, n577))]).
substitution(590, [binding("x", ind)]).
proof(590, a(ind, n579), rule(1736), [uses(589, a(ind, n578))]).
substitution(591, [binding("x", ind)]).
proof(591, a(ind, n580), rule(1739), [uses(590, a(ind, n579))]).
substitution(592, [binding("x", ind)]).
proof(592, a(ind, n581), rule(1742), [uses(591, a(ind, n580))]).
substitution(593, [binding("x", ind)]).
proof(593, a(ind, n582), rule(1745), [uses(592, a(ind, n581))]).
substitution(594, [binding("x", ind)]).
proof(594, a(ind, n583), rule(1748), [uses(593, a(ind, n582))]).
substitution(595, [binding("x", ind)]).
proof(595, a(ind, n584), rule(1751), [uses(594, a(ind, n583))]).
substitution(596, [binding("x", ind)]).
proof(596, a(ind, n585), rule(1754), [uses(595, a(ind, n584))]).
substitution(597, [binding("x", ind)]).
proof(597, a(ind, n586), rule(1757), [uses(596, a(ind, n585))]).
substitution(598, [binding("x", ind)]).
proof(598, a(ind, n587), rule(1760), [uses(597, a(ind, n586))]).
substitution(599, [binding("x", ind)]).
proof(599, a(ind, n588), rule(1763), [uses(598, a(ind, n587))]).
substitution(600, [binding("x", ind)]).
proof(600, a(ind, n589), rule(1766), [uses(599, a(ind, n588))]).
substitution(601, [binding("x", ind)]).
proof(601, a(ind, n590), rule(1769), [uses(600, a(ind, n589))]).
substitution(602, [binding("x", ind)]).
proof(602, a(ind, n591), rule(1772), [uses(601, a(ind, n590))]).
substitution(603, [binding("x", ind)]).
proof(603, a(ind, n592), rule(1775), [uses(602, a(ind, n591))]).
substitution(604, [binding("x", ind)]).
proof(604, a(ind, n593), rule(1778), [uses(603, a(ind, n592))]).
substitution(605, [binding("x", ind)]).
proof(605, a(ind, n594), rule(1781), [uses(604, a(ind, n593))]).
substitution(606, [binding("x", ind)]).
proof(606, a(ind, n595), rule(1784), [uses(605, a(ind, n594))]).
substitution(607, [binding("x", ind)]).
proof(607, a(ind, n596), rule(1787), [uses(606, a(ind, n595))]).
substitution(608, [binding("x", ind)]).
proof(608, a(ind, n597), rule(1790), [uses(607, a(ind, n596))]).
substitution(609, [binding("x", ind)]).
proof(609, a(ind, n598), rule(1793), [uses(608, a(ind, n597))]).
substitution(610, [binding("x", ind)]).
proof(610, a(ind, n599), rule(1796), [uses(609, a(ind, n598))]).
substitution(611, [binding("x", ind)]).
proof(611, a(ind, n600), rule(1799), [uses(610, a(ind, n599))]).
substitution(612, [binding("x", ind)]).
proof(612, a(ind, n601), rule(1802), [uses(611, a(ind, n600))]).
substitution(613, [binding("x", ind)]).
proof(613, a(ind, n602), rule(1805), [uses(612, a(ind, n601))]).
substitution(614, [binding("x", ind)]).
proof(614, a(ind, n603), rule(1808), [uses(613, a(ind, n602))]).
substitution(615, [binding("x", ind)]).
proof(615, a(ind, n604), rule(1811), [uses(614, a(ind, n603))]).
substitution(616, [binding("x", ind)]).
proof(616, a(ind, n605), rule(1814), [uses(615, a(ind, n604))]).
substitution(617, [binding("x", ind)]).
proof(617, a(ind, n606), rule(1817), [uses(616, a(ind, n605))]).
substitution(618, [binding("x", ind)]).
proof(618, a(ind, n607), rule(1820), [uses(617, a(ind, n606))]).
substitution(619, [binding("x", ind)]).
proof(619, a(ind, n608), rule(1823), [uses(618, a(ind, n607))]).
substitution(620, [binding("x", ind)]).
proof(620, a(ind, n609), rule(1826), [uses(619, a(ind, n608))]).
substitution(621, [binding("x", ind)]).
proof(621, a(ind, n610), rule(1829), [uses(620, a(ind, n609))]).
substitution(622, [binding("x", ind)]).
proof(622, a(ind, n611), rule(1832), [uses(621, a(ind, n610))]).
substitution(623, [binding("x", ind)]).
proof(623, a(ind, n612), rule(1835), [uses(622, a(ind, n611))]).
substitution(624, [binding("x", ind)]).
proof(624, a(ind, n613), rule(1838), [uses(623, a(ind, n612))]).
substitution(625, [binding("x", ind)]).
proof(625, a(ind, n614), rule(1841), [uses(624, a(ind, n613))]).
substitution(626, [binding("x", ind)]).
proof(626, a(ind, n615), rule(1844), [uses(625, a(ind, n614))]).
substitution(627, [binding("x", ind)]).
proof(627, a(ind, n616), rule(1847), [uses(626, a(ind, n615))]).
substitution(628, [binding("x", ind)]).
proof(628, a(ind, n617), rule(1850), [uses(627, a(ind, n616))]).
substitution(629, [binding("x", ind)]).
proof(629, a(ind, n618), rule(1853), [uses(628, a(ind, n617))]).
substitution(630, [binding("x", ind)]).
proof(630, a(ind, n619), rule(1856), [uses(629, a(ind, n618))]).
substitution(631, [binding("x", ind)]).
proof(631, a(ind, n620), rule(1859), [uses(630, a(ind, n619))]).
substitution(632, [binding("x", ind)]).
proof(632, a(ind, n621), rule(1862), [uses(631, a(ind, n620))]).
substitution(633, [binding("x", ind)]).
proof(633, a(ind, n622), rule(1865), [uses(632, a(ind, n621))]).
substitution(634, [binding("x", ind)]).
proof(634, a(ind, n623), rule(1868), [uses(633, a(ind, n622))]).
substitution(635, [binding("x", ind)]).
proof(635, a(ind, n624), rule(1871), [uses(634, a(ind, n623))]).
substitution(636, [binding("x", ind)]).
proof(636, a(ind, n625), rule(1874), [uses(635, a(ind, n624))]).
substitution(637, [binding("x", ind)]).
proof(637, a(ind, n626), rule(1877), [uses(636, a(ind, n625))]).
substitution(638, [binding("x", ind)]).
proof(638, a(ind, n627), rule(1880), [uses(637, a(ind, n626))]).
substitution(639, [binding("x", ind)]).
proof(639, a(ind, n628), rule(1883), [uses(638, a(ind, n627))]).
substitution(640, [binding("x", ind)]).
proof(640, a(ind, n629), rule(1886), [uses(639, a(ind, n628))]).
substitution(641, [binding("x", ind)]).
proof(641, a(ind, n630), rule(1889), [uses(640, a(ind, n629))]).
substitution(642, [binding("x", ind)]).
proof(642, a(ind, n631), rule(1892), [uses(641, a(ind, n630))]).
substitution(643, [binding("x", ind)]).
proof(643, a(ind, n632), rule(1895), [uses(642, a(ind, n631))]).
substitution(644, [binding("x", ind)]).
proof(644, a(ind, n633), rule(1898), [uses(643, a(ind, n632))]).
substitution(645, [binding("x", ind)]).
proof(645, a(ind, n634), rule(1901), [uses(644, a(ind, n633))]).
substitution(646, [binding("x", ind)]).
proof(646, a(ind, n635), rule(1904), [uses(645, a(ind, n634))]).
substitution(647, [binding("x", ind)]).
proof(647, a(ind, n636), rule(1907), [uses(646, a(ind, n635))]).
substitution(648, [binding("x", ind)]).
proof(648, a(ind, n637), rule(1910), [uses(647, a(ind, n636))]).
substitution(649, [binding("x", ind)]).
proof(649, a(ind, n638), rule(1913), [uses(648, a(ind, n637))]).
substitution(650, [binding("x", ind)]).
proof(650, a(ind, n639), rule(1916), [uses(649, a(ind, n638))]).
substitution(651, [binding("x", ind)]).
proof(651, a(ind, n640), rule(1919), [uses(650, a(ind, n639))]).
substitution(652, [binding("x", ind)]).
proof(652, a(ind, n641), rule(1922), [uses(651, a(ind, n640))]).
substitution(653, [binding("x", ind)]).
proof(653, a(ind, n642), rule(1925), [uses(652, a(ind, n641))]).
substitution(654, [binding("x", ind)]).
proof(654, a(ind, n643), rule(1928), [uses(653, a(ind, n642))]).
substitution(655, [binding("x", ind)]).
proof(655, a(ind, n644), rule(1931), [uses(654, a(ind, n643))]).
substitution(656, [binding("x", ind)]).
proof(656, a(ind, n645), rule(1934), [uses(655, a(ind, n644))]).
substitution(657, [binding("x", ind)]).
proof(657, a(ind, n646), rule(1937), [uses(656, a(ind, n645))]).
substitution(658, [binding("x", ind)]).
proof(658, a(ind, n647), rule(1940), [uses(657, a(ind, n646))]).
substitution(659, [binding("x", ind)]).
proof(659, a(ind, n648), rule(1943), [uses(658, a(ind, n647))]).
substitution(660, [binding("x", ind)]).
proof(660, a(ind, n649), rule(1946), [uses(659, a(ind, n648))]).
substitution(661, [binding("x", ind)]).
proof(661, a(ind, n650), rule(1949), [uses(660, a(ind, n649))]).
substitution(662, [binding("x", ind)]).
proof(662, a(ind, n651), rule(1952), [uses(661, a(ind, n650))]).
substitution(663, [binding("x", ind)]).
proof(663, a(ind, n652), rule(1955), [uses(662, a(ind, n651))]).
substitution(664, [binding("x", ind)]).
proof(664, a(ind, n653), rule(1958), [uses(663, a(ind, n652))]).
substitution(665, [binding("x", ind)]).
proof(665, a(ind, n654), rule(1961), [uses(664, a(ind, n653))]).
substitution(666, [binding("x", ind)]).
proof(666, a(ind, n655), rule(1964), [uses(665, a(ind, n654))]).
substitution(667, [binding("x", ind)]).
proof(667, a(ind, n656), rule(1967), [uses(666, a(ind, n655))]).
substitution(668, [binding("x", ind)]).
proof(668, a(ind, n657), rule(1970), [uses(667, a(ind, n656))]).
substitution(669, [binding("x", ind)]).
proof(669, a(ind, n658), rule(1973), [uses(668, a(ind, n657))]).
substitution(670, [binding("x", ind)]).
proof(670, a(ind, n659), rule(1976), [uses(669, a(ind, n658))]).
substitution(671, [binding("x", ind)]).
proof(671, a(ind, n660), rule(1979), [uses(670, a(ind, n659))]).
substitution(672, [binding("x", ind)]).
proof(672, a(ind, n661), rule(1982), [uses(671, a(ind, n660))]).
substitution(673, [binding("x", ind)]).
proof(673, a(ind, n662), rule(1985), [uses(672, a(ind, n661))]).
substitution(674, [binding("x", ind)]).
proof(674, a(ind, n663), rule(1988), [uses(673, a(ind, n662))]).
substitution(675, [binding("x", ind)]).
proof(675, a(ind, n664), rule(1991), [uses(674, a(ind, n663))]).
substitution(676, [binding("x", ind)]).
proof(676, a(ind, n665), rule(1994), [uses(675, a(ind, n664))]).
substitution(677, [binding("x", ind)]).
proof(677, a(ind, n666), rule(1997), [uses(676, a(ind, n665))]).
substitution(678, [binding("x", ind)]).
proof(678, a(ind, n667), rule(2000), [uses(677, a(ind, n666))]).
substitution(679, [binding("x", ind)]).
proof(679, a(ind, n668), rule(2003), [uses(678, a(ind, n667))]).
substitution(680, [binding("x", ind)]).
proof(680, a(ind, n669), rule(2006), [uses(679, a(ind, n668))]).
substitution(681, [binding("x", ind)]).
proof(681, a(ind, n670), rule(2009), [uses(680, a(ind, n669))]).
substitution(682, [binding("x", ind)]).
proof(682, a(ind, n671), rule(2012), [uses(681, a(ind, n670))]).
substitution(683, [binding("x", ind)]).
proof(683, a(ind, n672), rule(2015), [uses(682, a(ind, n671))]).
substitution(684, [binding("x", ind)]).
proof(684, a(ind, n673), rule(2018), [uses(683, a(ind, n672))]).
substitution(685, [binding("x", ind)]).
proof(685, a(ind, n674), rule(2021), [uses(684, a(ind, n673))]).
substitution(686, [binding("x", ind)]).
proof(686, a(ind, n675), rule(2024), [uses(685, a(ind, n674))]).
substitution(687, [binding("x", ind)]).
proof(687, a(ind, n676), rule(2027), [uses(686, a(ind, n675))]).
substitution(688, [binding("x", ind)]).
proof(688, a(ind, n677), rule(2030), [uses(687, a(ind, n676))]).
substitution(689, [binding("x", ind)]).
proof(689, a(ind, n678), rule(2033), [uses(688, a(ind, n677))]).
substitution(690, [binding("x", ind)]).
proof(690, a(ind, n679), rule(2036), [uses(689, a(ind, n678))]).
substitution(691, [binding("x", ind)]).
proof(691, a(ind, n680), rule(2039), [uses(690, a(ind, n679))]).
substitution(692, [binding("x", ind)]).
proof(692, a(ind, n681), rule(2042), [uses(691, a(ind, n680))]).
substitution(693, [binding("x", ind)]).
proof(693, a(ind, n682), rule(2045), [uses(692, a(ind, n681))]).
substitution(694, [binding("x", ind)]).
proof(694, a(ind, n683), rule(2048), [uses(693, a(ind, n682))]).
substitution(695, [binding("x", ind)]).
proof(695, a(ind, n684), rule(2051), [uses(694, a(ind, n683))]).
substitution(696, [binding("x", ind)]).
proof(696, a(ind, n685), rule(2054), [uses(695, a(ind, n684))]).
substitution(697, [binding("x", ind)]).
proof(697, a(ind, n686), rule(2057), [uses(696, a(ind, n685))]).
substitution(698, [binding("x", ind)]).
proof(698, a(ind, n687), rule(2060), [uses(697, a(ind, n686))]).
substitution(699, [binding("x", ind)]).
proof(699, a(ind, n688), rule(2063), [uses(698, a(ind, n687))]).
substitution(700, [binding("x", ind)]).
proof(700, a(ind, n689), rule(2066), [uses(699, a(ind, n688))]).
substitution(701, [binding("x", ind)]).
proof(701, a(ind, n690), rule(2069), [uses(700, a(ind, n689))]).
substitution(702, [binding("x", ind)]).
proof(702, a(ind, n691), rule(2072), [uses(701, a(ind, n690))]).
substitution(703, [binding("x", ind)]).
proof(703, a(ind, n692), rule(2075), [uses(702, a(ind, n691))]).
substitution(704, [binding("x", ind)]).
proof(704, a(ind, n693), rule(2078), [uses(703, a(ind, n692))]).
substitution(705, [binding("x", ind)]).
proof(705, a(ind, n694), rule(2081), [uses(704, a(ind, n693))]).
substitution(706, [binding("x", ind)]).
proof(706, a(ind, n695), rule(2084), [uses(705, a(ind, n694))]).
substitution(707, [binding("x", ind)]).
proof(707, a(ind, n696), rule(2087), [uses(706, a(ind, n695))]).
substitution(708, [binding("x", ind)]).
proof(708, a(ind, n697), rule(2090), [uses(707, a(ind, n696))]).
substitution(709, [binding("x", ind)]).
proof(709, a(ind, n698), rule(2093), [uses(708, a(ind, n697))]).
substitution(710, [binding("x", ind)]).
proof(710, a(ind, n699), rule(2096), [uses(709, a(ind, n698))]).
substitution(711, [binding("x", ind)]).
proof(711, a(ind, n700), rule(2099), [uses(710, a(ind, n699))]).
substitution(712, [binding("x", ind)]).
proof(712, a(ind, n701), rule(2102), [uses(711, a(ind, n700))]).
substitution(713, [binding("x", ind)]).
proof(713, a(ind, n702), rule(2105), [uses(712, a(ind, n701))]).
substitution(714, [binding("x", ind)]).
proof(714, a(ind, n703), rule(2108), [uses(713, a(ind, n702))]).
substitution(715, [binding("x", ind)]).
proof(715, a(ind, n704), rule(2111), [uses(714, a(ind, n703))]).
substitution(716, [binding("x", ind)]).
proof(716, a(ind, n705), rule(2114), [uses(715, a(ind, n704))]).
substitution(717, [binding("x", ind)]).
proof(717, a(ind, n706), rule(2117), [uses(716, a(ind, n705))]).
substitution(718, [binding("x", ind)]).
proof(718, a(ind, n707), rule(2120), [uses(717, a(ind, n706))]).
substitution(719, [binding("x", ind)]).
proof(719, a(ind, n708), rule(2123), [uses(718, a(ind, n707))]).
substitution(720, [binding("x", ind)]).
proof(720, a(ind, n709), rule(2126), [uses(719, a(ind, n708))]).
substitution(721, [binding("x", ind)]).
proof(721, a(ind, n710), rule(2129), [uses(720, a(ind, n709))]).
substitution(722, [binding("x", ind)]).
proof(722, a(ind, n711), rule(2132), [uses(721, a(ind, n710))]).
substitution(723, [binding("x", ind)]).
proof(723, a(ind, n712), rule(2135), [uses(722, a(ind, n711))]).
substitution(724, [binding("x", ind)]).
proof(724, a(ind, n713), rule(2138), [uses(723, a(ind, n712))]).
substitution(725, [binding("x", ind)]).
proof(725, a(ind, n714), rule(2141), [uses(724, a(ind, n713))]).
substitution(726, [binding("x", ind)]).
proof(726, a(ind, n715), rule(2144), [uses(725, a(ind, n714))]).
substitution(727, [binding("x", ind)]).
proof(727, a(ind, n716), rule(2147), [uses(726, a(ind, n715))]).
substitution(728, [binding("x", ind)]).
proof(728, a(ind, n717), rule(2150), [uses(727, a(ind, n716))]).
substitution(729, [binding("x", ind)]).
proof(729, a(ind, n718), rule(2153), [uses(728, a(ind, n717))]).
substitution(730, [binding("x", ind)]).
proof(730, a(ind, n719), rule(2156), [uses(729, a(ind, n718))]).
substitution(731, [binding("x", ind)]).
proof(731, a(ind, n720), rule(2159), [uses(730, a(ind, n719))]).
substitution(732, [binding("x", ind)]).
proof(732, a(ind, n721), rule(2162), [uses(731, a(ind, n720))]).
substitution(733, [binding("x", ind)]).
proof(733, a(ind, n722), rule(2165), [uses(732, a(ind, n721))]).
substitution(734, [binding("x", ind)]).
proof(734, a(ind, n723), rule(2168), [uses(733, a(ind, n722))]).
substitution(735, [binding("x", ind)]).
proof(735, a(ind, n724), rule(2171), [uses(734, a(ind, n723))]).
substitution(736, [binding("x", ind)]).
proof(736, a(ind, n725), rule(2174), [uses(735, a(ind, n724))]).
substitution(737, [binding("x", ind)]).
proof(737, a(ind, n726), rule(2177), [uses(736, a(ind, n725))]).
substitution(738, [binding("x", ind)]).
proof(738, a(ind, n727), rule(2180), [uses(737, a(ind, n726))]).
substitution(739, [binding("x", ind)]).
proof(739, a(ind, n728), rule(2183), [uses(738, a(ind, n727))]).
substitution(740, [binding("x", ind)]).
proof(740, a(ind, n729), rule(2186), [uses(739, a(ind, n728))]).
substitution(741, [binding("x", ind)]).
proof(741, a(ind, n730), rule(2189), [uses(740, a(ind, n729))]).
substitution(742, [binding("x", ind)]).
proof(742, a(ind, n731), rule(2192), [uses(741, a(ind, n730))]).
substitution(743, [binding("x", ind)]).
proof(743, a(ind, n732), rule(2195), [uses(742, a(ind, n731))]).
substitution(744, [binding("x", ind)]).
proof(744, a(ind, n733), rule(2198), [uses(743, a(ind, n732))]).
substitution(745, [binding("x", ind)]).
proof(745, a(ind, n734), rule(2201), [uses(744, a(ind, n733))]).
substitution(746, [binding("x", ind)]).
proof(746, a(ind, n735), rule(2204), [uses(745, a(ind, n734))]).
substitution(747, [binding("x", ind)]).
proof(747, a(ind, n736), rule(2207), [uses(746, a(ind, n735))]).
substitution(748, [binding("x", ind)]).
proof(748, a(ind, n737), rule(2210), [uses(747, a(ind, n736))]).
substitution(749, [binding("x", ind)]).
proof(749, a(ind, n738), rule(2213), [uses(748, a(ind, n737))]).
substitution(750, [binding("x", ind)]).
proof(750, a(ind, n739), rule(2216), [uses(749, a(ind, n738))]).
substitution(751, [binding("x", ind)]).
proof(751, a(ind, n740), rule(2219), [uses(750, a(ind, n739))]).
substitution(752, [binding("x", ind)]).
proof(752, a(ind, n741), rule(2222), [uses(751, a(ind, n740))]).
substitution(753, [binding("x", ind)]).
proof(753, a(ind, n742), rule(2225), [uses(752, a(ind, n741))]).
substitution(754, [binding("x", ind)]).
proof(754, a(ind, n743), rule(2228), [uses(753, a(ind, n742))]).
substitution(755, [binding("x", ind)]).
proof(755, a(ind, n744), rule(2231), [uses(754, a(ind, n743))]).
substitution(756, [binding("x", ind)]).
proof(756, a(ind, n745), rule(2234), [uses(755, a(ind, n744))]).
substitution(757, [binding("x", ind)]).
proof(757, a(ind, n746), rule(2237), [uses(756, a(ind, n745))]).
substitution(758, [binding("x", ind)]).
proof(758, a(ind, n747), rule(2240), [uses(757, a(ind, n746))]).
substitution(759, [binding("x", ind)]).
proof(759, a(ind, n748), rule(2243), [uses(758, a(ind, n747))]).
substitution(760, [binding("x", ind)]).
proof(760, a(ind, n749), rule(2246), [uses(759, a(ind, n748))]).
substitution(761, [binding("x", ind)]).
proof(761, a(ind, n750), rule(2249), [uses(760, a(ind, n749))]).
substitution(762, [binding("x", ind)]).
proof(762, a(ind, n751), rule(2252), [uses(761, a(ind, n750))]).
substitution(763, [binding("x", ind)]).
proof(763, a(ind, n752), rule(2255), [uses(762, a(ind, n751))]).
substitution(764, [binding("x", ind)]).
proof(764, a(ind, n753), rule(2258), [uses(763, a(ind, n752))]).
substitution(765, [binding("x", ind)]).
proof(765, a(ind, n754), rule(2261), [uses(764, a(ind, n753))]).
substitution(766, [binding("x", ind)]).
proof(766, a(ind, n755), rule(2264), [uses(765, a(ind, n754))]).
substitution(767, [binding("x", ind)]).
proof(767, a(ind, n756), rule(2267), [uses(766, a(ind, n755))]).
substitution(768, [binding("x", ind)]).
proof(768, a(ind, n757), rule(2270), [uses(767, a(ind, n756))]).
substitution(769, [binding("x", ind)]).
proof(769, a(ind, n758), rule(2273), [uses(768, a(ind, n757))]).
substitution(770, [binding("x", ind)]).
proof(770, a(ind, n759), rule(2276), [uses(769, a(ind, n758))]).
substitution(771, [binding("x", ind)]).
proof(771, a(ind, n760), rule(2279), [uses(770, a(ind, n759))]).
substitution(772, [binding("x", ind)]).
proof(772, a(ind, n761), rule(2282), [uses(771, a(ind, n760))]).
substitution(773, [binding("x", ind)]).
proof(773, a(ind, n762), rule(2285), [uses(772, a(ind, n761))]).
substitution(774, [binding("x", ind)]).
proof(774, a(ind, n763), rule(2288), [uses(773, a(ind, n762))]).
substitution(775, [binding("x", ind)]).
proof(775, a(ind, n764), rule(2291), [uses(774, a(ind, n763))]).
substitution(776, [binding("x", ind)]).
proof(776, a(ind, n765), rule(2294), [uses(775, a(ind, n764))]).
substitution(777, [binding("x", ind)]).
proof(777, a(ind, n766), rule(2297), [uses(776, a(ind, n765))]).
substitution(778, [binding("x", ind)]).
proof(778, a(ind, n767), rule(2300), [uses(777, a(ind, n766))]).
substitution(779, [binding("x", ind)]).
proof(779, a(ind, n768), rule(2303), [uses(778, a(ind, n767))]).
substitution(780, [binding("x", ind)]).
proof(780, a(ind, n769), rule(2306), [uses(779, a(ind, n768))]).
substitution(781, [binding("x", ind)]).
proof(781, a(ind, n770), rule(2309), [uses(780, a(ind, n769))]).
substitution(782, [binding("x", ind)]).
proof(782, a(ind, n771), rule(2312), [uses(781, a(ind, n770))]).
substitution(783, [binding("x", ind)]).
proof(783, a(ind, n772), rule(2315), [uses(782, a(ind, n771))]).
substitution(784, [binding("x", ind)]).
proof(784, a(ind, n773), rule(2318), [uses(783, a(ind, n772))]).
substitution(785, [binding("x", ind)]).
proof(785, a(ind, n774), rule(2321), [uses(784, a(ind, n773))]).
substitution(786, [binding("x", ind)]).
proof(786, a(ind, n775), rule(2324), [uses(785, a(ind, n774))]).
substitution(787, [binding("x", ind)]).
proof(787, a(ind, n776), rule(2327), [uses(786, a(ind, n775))]).
substitution(788, [binding("x", ind)]).
proof(788, a(ind, n777), rule(2330), [uses(787, a(ind, n776))]).
substitution(789, [binding("x", ind)]).
proof(789, a(ind, n778), rule(2333), [uses(788, a(ind, n777))]).
substitution(790, [binding("x", ind)]).
proof(790, a(ind, n779), rule(2336), [uses(789, a(ind, n778))]).
substitution(791, [binding("x", ind)]).
proof(791, a(ind, n780), rule(2339), [uses(790, a(ind, n779))]).
substitution(792, [binding("x", ind)]).
proof(792, a(ind, n781), rule(2342), [uses(791, a(ind, n780))]).
substitution(793, [binding("x", ind)]).
proof(793, a(ind, n782), rule(2345), [uses(792, a(ind, n781))]).
substitution(794, [binding("x", ind)]).
proof(794, a(ind, n783), rule(2348), [uses(793, a(ind, n782))]).
substitution(795, [binding("x", ind)]).
proof(795, a(ind, n784), rule(2351), [uses(794, a(ind, n783))]).
substitution(796, [binding("x", ind)]).
proof(796, a(ind, n785), rule(2354), [uses(795, a(ind, n784))]).
substitution(797, [binding("x", ind)]).
proof(797, a(ind, n786), rule(2357), [uses(796, a(ind, n785))]).
substitution(798, [binding("x", ind)]).
proof(798, a(ind, n787), rule(2360), [uses(797, a(ind, n786))]).
substitution(799, [binding("x", ind)]).
proof(799, a(ind, n788), rule(2363), [uses(798, a(ind, n787))]).
substitution(800, [binding("x", ind)]).
proof(800, a(ind, n789), rule(2366), [uses(799, a(ind, n788))]).
substitution(801, [binding("x", ind)]).
proof(801, a(ind, n790), rule(2369), [uses(800, a(ind, n789))]).
substitution(802, [binding("x", ind)]).
proof(802, a(ind, n791), rule(2372), [uses(801, a(ind, n790))]).
substitution(803, [binding("x", ind)]).
proof(803, a(ind, n792), rule(2375), [uses(802, a(ind, n791))]).
substitution(804, [binding("x", ind)]).
proof(804, a(ind, n793), rule(2378), [uses(803, a(ind, n792))]).
substitution(805, [binding("x", ind)]).
proof(805, a(ind, n794), rule(2381), [uses(804, a(ind, n793))]).
substitution(806, [binding("x", ind)]).
proof(806, a(ind, n795), rule(2384), [uses(805, a(ind, n794))]).
substitution(807, [binding("x", ind)]).
proof(807, a(ind, n796), rule(2387), [uses(806, a(ind, n795))]).
substitution(808, [binding("x", ind)]).
proof(808, a(ind, n797), rule(2390), [uses(807, a(ind, n796))]).
substitution(809, [binding("x", ind)]).
proof(809, a(ind, n798), rule(2393), [uses(808, a(ind, n797))]).
substitution(810, [binding("x", ind)]).
proof(810, a(ind, n799), rule(2396), [uses(809, a(ind, n798))]).
substitution(811, [binding("x", ind)]).
proof(811, a(ind, n800), rule(2399), [uses(810, a(ind, n799))]).
substitution(812, [binding("x", ind)]).
proof(812, a(ind, n801), rule(2402), [uses(811, a(ind, n800))]).
substitution(813, [binding("x", ind)]).
proof(813, a(ind, n802), rule(2405), [uses(812, a(ind, n801))]).
substitution(814, [binding("x", ind)]).
proof(814, a(ind, n803), rule(2408), [uses(813, a(ind, n802))]).
substitution(815, [binding("x", ind)]).
proof(815, a(ind, n804), rule(2411), [uses(814, a(ind, n803))]).
substitution(816, [binding("x", ind)]).
proof(816, a(ind, n805), rule(2414), [uses(815, a(ind, n804))]).
substitution(817, [binding("x", ind)]).
proof(817, a(ind, n806), rule(2417), [uses(816, a(ind, n805))]).
substitution(818, [binding("x", ind)]).
proof(818, a(ind, n807), rule(2420), [uses(817, a(ind, n806))]).
substitution(819, [binding("x", ind)]).
proof(819, a(ind, n808), rule(2423), [uses(818, a(ind, n807))]).
substitution(820, [binding("x", ind)]).
proof(820, a(ind, n809), rule(2426), [uses(819, a(ind, n808))]).
substitution(821, [binding("x", ind)]).
proof(821, a(ind, n810), rule(2429), [uses(820, a(ind, n809))]).
substitution(822, [binding("x", ind)]).
proof(822, a(ind, n811), rule(2432), [uses(821, a(ind, n810))]).
substitution(823, [binding("x", ind)]).
proof(823, a(ind, n812), rule(2435), [uses(822, a(ind, n811))]).
substitution(824, [binding("x", ind)]).
proof(824, a(ind, n813), rule(2438), [uses(823, a(ind, n812))]).
substitution(825, [binding("x", ind)]).
proof(825, a(ind, n814), rule(2441), [uses(824, a(ind, n813))]).
substitution(826, [binding("x", ind)]).
proof(826, a(ind, n815), rule(2444), [uses(825, a(ind, n814))]).
substitution(827, [binding("x", ind)]).
proof(827, a(ind, n816), rule(2447), [uses(826, a(ind, n815))]).
substitution(828, [binding("x", ind)]).
proof(828, a(ind, n817), rule(2450), [uses(827, a(ind, n816))]).
substitution(829, [binding("x", ind)]).
proof(829, a(ind, n818), rule(2453), [uses(828, a(ind, n817))]).
substitution(830, [binding("x", ind)]).
proof(830, a(ind, n819), rule(2456), [uses(829, a(ind, n818))]).
substitution(831, [binding("x", ind)]).
proof(831, a(ind, n820), rule(2459), [uses(830, a(ind, n819))]).
substitution(832, [binding("x", ind)]).
proof(832, a(ind, n821), rule(2462), [uses(831, a(ind, n820))]).
substitution(833, [binding("x", ind)]).
proof(833, a(ind, n822), rule(2465), [uses(832, a(ind, n821))]).
substitution(834, [binding("x", ind)]).
proof(834, a(ind, n823), rule(2468), [uses(833, a(ind, n822))]).
substitution(835, [binding("x", ind)]).
proof(835, a(ind, n824), rule(2471), [uses(834, a(ind, n823))]).
substitution(836, [binding("x", ind)]).
proof(836, a(ind, n825), rule(2474), [uses(835, a(ind, n824))]).
substitution(837, [binding("x", ind)]).
proof(837, a(ind, n826), rule(2477), [uses(836, a(ind, n825))]).
substitution(838, [binding("x", ind)]).
proof(838, a(ind, n827), rule(2480), [uses(837, a(ind, n826))]).
substitution(839, [binding("x", ind)]).
proof(839, a(ind, n828), rule(2483), [uses(838, a(ind, n827))]).
substitution(840, [binding("x", ind)]).
proof(840, a(ind, n829), rule(2486), [uses(839, a(ind, n828))]).
substitution(841, [binding("x", ind)]).
proof(841, a(ind, n830), rule(2489), [uses(840, a(ind, n829))]).
substitution(842, [binding("x", ind)]).
proof(842, a(ind, n831), rule(2492), [uses(841, a(ind, n830))]).
substitution(843, [binding("x", ind)]).
proof(843, a(ind, n832), rule(2495), [uses(842, a(ind, n831))]).
substitution(844, [binding("x", ind)]).
proof(844, a(ind, n833), rule(2498), [uses(843, a(ind, n832))]).
substitution(845, [binding("x", ind)]).
proof(845, a(ind, n834), rule(2501), [uses(844, a(ind, n833))]).
substitution(846, [binding("x", ind)]).
proof(846, a(ind, n835), rule(2504), [uses(845, a(ind, n834))]).
substitution(847, [binding("x", ind)]).
proof(847, a(ind, n836), rule(2507), [uses(846, a(ind, n835))]).
substitution(848, [binding("x", ind)]).
proof(848, a(ind, n837), rule(2510), [uses(847, a(ind, n836))]).
substitution(849, [binding("x", ind)]).
proof(849, a(ind, n838), rule(2513), [uses(848, a(ind, n837))]).
substitution(850, [binding("x", ind)]).
proof(850, a(ind, n839), rule(2516), [uses(849, a(ind, n838))]).
substitution(851, [binding("x", ind)]).
proof(851, a(ind, n840), rule(2519), [uses(850, a(ind, n839))]).
substitution(852, [binding("x", ind)]).
proof(852, a(ind, n841), rule(2522), [uses(851, a(ind, n840))]).
substitution(853, [binding("x", ind)]).
proof(853, a(ind, n842), rule(2525), [uses(852, a(ind, n841))]).
substitution(854, [binding("x", ind)]).
proof(854, a(ind, n843), rule(2528), [uses(853, a(ind, n842))]).
substitution(855, [binding("x", ind)]).
proof(855, a(ind, n844), rule(2531), [uses(854, a(ind, n843))]).
substitution(856, [binding("x", ind)]).
proof(856, a(ind, n845), rule(2534), [uses(855, a(ind, n844))]).
substitution(857, [binding("x", ind)]).
proof(857, a(ind, n846), rule(2537), [uses(856, a(ind, n845))]).
substitution(858, [binding("x", ind)]).
proof(858, a(ind, n847), rule(2540), [uses(857, a(ind, n846))]).
substitution(859, [binding("x", ind)]).
proof(859, a(ind, n848), rule(2543), [uses(858, a(ind, n847))]).
substitution(860, [binding("x", ind)]).
proof(860, a(ind, n849), rule(2546), [uses(859, a(ind, n848))]).
substitution(861, [binding("x", ind)]).
proof(861, a(ind, n850), rule(2549), [uses(860, a(ind, n849))]).
substitution(862, [binding("x", ind)]).
proof(862, a(ind, n851), rule(2552), [uses(861, a(ind, n850))]).
substitution(863, [binding("x", ind)]).
proof(863, a(ind, n852), rule(2555), [uses(862, a(ind, n851))]).
substitution(864, [binding("x", ind)]).
proof(864, a(ind, n853), rule(2558), [uses(863, a(ind, n852))]).
substitution(865, [binding("x", ind)]).
proof(865, a(ind, n854), rule(2561), [uses(864, a(ind, n853))]).
substitution(866, [binding("x", ind)]).
proof(866, a(ind, n855), rule(2564), [uses(865, a(ind, n854))]).
substitution(867, [binding("x", ind)]).
proof(867, a(ind, n856), rule(2567), [uses(866, a(ind, n855))]).
substitution(868, [binding("x", ind)]).
proof(868, a(ind, n857), rule(2570), [uses(867, a(ind, n856))]).
substitution(869, [binding("x", ind)]).
proof(869, a(ind, n858), rule(2573), [uses(868, a(ind, n857))]).
substitution(870, [binding("x", ind)]).
proof(870, a(ind, n859), rule(2576), [uses(869, a(ind, n858))]).
substitution(871, [binding("x", ind)]).
proof(871, a(ind, n860), rule(2579), [uses(870, a(ind, n859))]).
substitution(872, [binding("x", ind)]).
proof(872, a(ind, n861), rule(2582), [uses(871, a(ind, n860))]).
substitution(873, [binding("x", ind)]).
proof(873, a(ind, n862), rule(2585), [uses(872, a(ind, n861))]).
substitution(874, [binding("x", ind)]).
proof(874, a(ind, n863), rule(2588), [uses(873, a(ind, n862))]).
substitution(875, [binding("x", ind)]).
proof(875, a(ind, n864), rule(2591), [uses(874, a(ind, n863))]).
substitution(876, [binding("x", ind)]).
proof(876, a(ind, n865), rule(2594), [uses(875, a(ind, n864))]).
substitution(877, [binding("x", ind)]).
proof(877, a(ind, n866), rule(2597), [uses(876, a(ind, n865))]).
substitution(878, [binding("x", ind)]).
proof(878, a(ind, n867), rule(2600), [uses(877, a(ind, n866))]).
substitution(879, [binding("x", ind)]).
proof(879, a(ind, n868), rule(2603), [uses(878, a(ind, n867))]).
substitution(880, [binding("x", ind)]).
proof(880, a(ind, n869), rule(2606), [uses(879, a(ind, n868))]).
substitution(881, [binding("x", ind)]).
proof(881, a(ind, n870), rule(2609), [uses(880, a(ind, n869))]).
substitution(882, [binding("x", ind)]).
proof(882, a(ind, n871), rule(2612), [uses(881, a(ind, n870))]).
substitution(883, [binding("x", ind)]).
proof(883, a(ind, n872), rule(2615), [uses(882, a(ind, n871))]).
substitution(884, [binding("x", ind)]).
proof(884, a(ind, n873), rule(2618), [uses(883, a(ind, n872))]).
substitution(885, [binding("x", ind)]).
proof(885, a(ind, n874), rule(2621), [uses(884, a(ind, n873))]).
substitution(886, [binding("x", ind)]).
proof(886, a(ind, n875), rule(2624), [uses(885, a(ind, n874))]).
substitution(887, [binding("x", ind)]).
proof(887, a(ind, n876), rule(2627), [uses(886, a(ind, n875))]).
substitution(888, [binding("x", ind)]).
proof(888, a(ind, n877), rule(2630), [uses(887, a(ind, n876))]).
substitution(889, [binding("x", ind)]).
proof(889, a(ind, n878), rule(2633), [uses(888, a(ind, n877))]).
substitution(890, [binding("x", ind)]).
proof(890, a(ind, n879), rule(2636), [uses(889, a(ind, n878))]).
substitution(891, [binding("x", ind)]).
proof(891, a(ind, n880), rule(2639), [uses(890, a(ind, n879))]).
substitution(892, [binding("x", ind)]).
proof(892, a(ind, n881), rule(2642), [uses(891, a(ind, n880))]).
substitution(893, [binding("x", ind)]).
proof(893, a(ind, n882), rule(2645), [uses(892, a(ind, n881))]).
substitution(894, [binding("x", ind)]).
proof(894, a(ind, n883), rule(2648), [uses(893, a(ind, n882))]).
substitution(895, [binding("x", ind)]).
proof(895, a(ind, n884), rule(2651), [uses(894, a(ind, n883))]).
substitution(896, [binding("x", ind)]).
proof(896, a(ind, n885), rule(2654), [uses(895, a(ind, n884))]).
substitution(897, [binding("x", ind)]).
proof(897, a(ind, n886), rule(2657), [uses(896, a(ind, n885))]).
substitution(898, [binding("x", ind)]).
proof(898, a(ind, n887), rule(2660), [uses(897, a(ind, n886))]).
substitution(899, [binding("x", ind)]).
proof(899, a(ind, n888), rule(2663), [uses(898, a(ind, n887))]).
substitution(900, [binding("x", ind)]).
proof(900, a(ind, n889), rule(2666), [uses(899, a(ind, n888))]).
substitution(901, [binding("x", ind)]).
proof(901, a(ind, n890), rule(2669), [uses(900, a(ind, n889))]).
substitution(902, [binding("x", ind)]).
proof(902, a(ind, n891), rule(2672), [uses(901, a(ind, n890))]).
substitution(903, [binding("x", ind)]).
proof(903, a(ind, n892), rule(2675), [uses(902, a(ind, n891))]).
substitution(904, [binding("x", ind)]).
proof(904, a(ind, n893), rule(2678), [uses(903, a(ind, n892))]).
substitution(905, [binding("x", ind)]).
proof(905, a(ind, n894), rule(2681), [uses(904, a(ind, n893))]).
substitution(906, [binding("x", ind)]).
proof(906, a(ind, n895), rule(2684), [uses(905, a(ind, n894))]).
substitution(907, [binding("x", ind)]).
proof(907, a(ind, n896), rule(2687), [uses(906, a(ind, n895))]).
substitution(908, [binding("x", ind)]).
proof(908, a(ind, n897), rule(2690), [uses(907, a(ind, n896))]).
substitution(909, [binding("x", ind)]).
proof(909, a(ind, n898), rule(2693), [uses(908, a(ind, n897))]).
substitution(910, [binding("x", ind)]).
proof(910, a(ind, n899), rule(2696), [uses(909, a(ind, n898))]).
substitution(911, [binding("x", ind)]).
proof(911, a(ind, n900), rule(2699), [uses(910, a(ind, n899))]).
substitution(912, [binding("x", ind)]).
proof(912, a(ind, n901), rule(2702), [uses(911, a(ind, n900))]).
substitution(913, [binding("x", ind)]).
proof(913, a(ind, n902), rule(2705), [uses(912, a(ind, n901))]).
substitution(914, [binding("x", ind)]).
proof(914, a(ind, n903), rule(2708), [uses(913, a(ind, n902))]).
substitution(915, [binding("x", ind)]).
proof(915, a(ind, n904), rule(2711), [uses(914, a(ind, n903))]).
substitution(916, [binding("x", ind)]).
proof(916, a(ind, n905), rule(2714), [uses(915, a(ind, n904))]).
substitution(917, [binding("x", ind)]).
proof(917, a(ind, n906), rule(2717), [uses(916, a(ind, n905))]).
substitution(918, [binding("x", ind)]).
proof(918, a(ind, n907), rule(2720), [uses(917, a(ind, n906))]).
substitution(919, [binding("x", ind)]).
proof(919, a(ind, n908), rule(2723), [uses(918, a(ind, n907))]).
substitution(920, [binding("x", ind)]).
proof(920, a(ind, n909), rule(2726), [uses(919, a(ind, n908))]).
substitution(921, [binding("x", ind)]).
proof(921, a(ind, n910), rule(2729), [uses(920, a(ind, n909))]).
substitution(922, [binding("x", ind)]).
proof(922, a(ind, n911), rule(2732), [uses(921, a(ind, n910))]).
substitution(923, [binding("x", ind)]).
proof(923, a(ind, n912), rule(2735), [uses(922, a(ind, n911))]).
substitution(924, [binding("x", ind)]).
proof(924, a(ind, n913), rule(2738), [uses(923, a(ind, n912))]).
substitution(925, [binding("x", ind)]).
proof(925, a(ind, n914), rule(2741), [uses(924, a(ind, n913))]).
substitution(926, [binding("x", ind)]).
proof(926, a(ind, n915), rule(2744), [uses(925, a(ind, n914))]).
substitution(927, [binding("x", ind)]).
proof(927, a(ind, n916), rule(2747), [uses(926, a(ind, n915))]).
substitution(928, [binding("x", ind)]).
proof(928, a(ind, n917), rule(2750), [uses(927, a(ind, n916))]).
substitution(929, [binding("x", ind)]).
proof(929, a(ind, n918), rule(2753), [uses(928, a(ind, n917))]).
substitution(930, [binding("x", ind)]).
proof(930, a(ind, n919), rule(2756), [uses(929, a(ind, n918))]).
substitution(931, [binding("x", ind)]).
proof(931, a(ind, n920), rule(2759), [uses(930, a(ind, n919))]).
substitution(932, [binding("x", ind)]).
proof(932, a(ind, n921), rule(2762), [uses(931, a(ind, n920))]).
substitution(933, [binding("x", ind)]).
proof(933, a(ind, n922), rule(2765), [uses(932, a(ind, n921))]).
substitution(934, [binding("x", ind)]).
proof(934, a(ind, n923), rule(2768), [uses(933, a(ind, n922))]).
substitution(935, [binding("x", ind)]).
proof(935, a(ind, n924), rule(2771), [uses(934, a(ind, n923))]).
substitution(936, [binding("x", ind)]).
proof(936, a(ind, n925), rule(2774), [uses(935, a(ind, n924))]).
substitution(937, [binding("x", ind)]).
proof(937, a(ind, n926), rule(2777), [uses(936, a(ind, n925))]).
substitution(938, [binding("x", ind)]).
proof(938, a(ind, n927), rule(2780), [uses(937, a(ind, n926))]).
substitution(939, [binding("x", ind)]).
proof(939, a(ind, n928), rule(2783), [uses(938, a(ind, n927))]).
substitution(940, [binding("x", ind)]).
proof(940, a(ind, n929), rule(2786), [uses(939, a(ind, n928))]).
substitution(941, [binding("x", ind)]).
proof(941, a(ind, n930), rule(2789), [uses(940, a(ind, n929))]).
substitution(942, [binding("x", ind)]).
proof(942, a(ind, n931), rule(2792), [uses(941, a(ind, n930))]).
substitution(943, [binding("x", ind)]).
proof(943, a(ind, n932), rule(2795), [uses(942, a(ind, n931))]).
substitution(944, [binding("x", ind)]).
proof(944, a(ind, n933), rule(2798), [uses(943, a(ind, n932))]).
substitution(945, [binding("x", ind)]).
proof(945, a(ind, n934), rule(2801), [uses(944, a(ind, n933))]).
substitution(946, [binding("x", ind)]).
proof(946, a(ind, n935), rule(2804), [uses(945, a(ind, n934))]).
substitution(947, [binding("x", ind)]).
proof(947, a(ind, n936), rule(2807), [uses(946, a(ind, n935))]).
substitution(948, [binding("x", ind)]).
proof(948, a(ind, n937), rule(2810), [uses(947, a(ind, n936))]).
substitution(949, [binding("x", ind)]).
proof(949, a(ind, n938), rule(2813), [uses(948, a(ind, n937))]).
substitution(950, [binding("x", ind)]).
proof(950, a(ind, n939), rule(2816), [uses(949, a(ind, n938))]).
substitution(951, [binding("x", ind)]).
proof(951, a(ind, n940), rule(2819), [uses(950, a(ind, n939))]).
substitution(952, [binding("x", ind)]).
proof(952, a(ind, n941), rule(2822), [uses(951, a(ind, n940))]).
substitution(953, [binding("x", ind)]).
proof(953, a(ind, n942), rule(2825), [uses(952, a(ind, n941))]).
substitution(954, [binding("x", ind)]).
proof(954, a(ind, n943), rule(2828), [uses(953, a(ind, n942))]).
substitution(955, [binding("x", ind)]).
proof(955, a(ind, n944), rule(2831), [uses(954, a(ind, n943))]).
substitution(956, [binding("x", ind)]).
proof(956, a(ind, n945), rule(2834), [uses(955, a(ind, n944))]).
substitution(957, [binding("x", ind)]).
proof(957, a(ind, n946), rule(2837), [uses(956, a(ind, n945))]).
substitution(958, [binding("x", ind)]).
proof(958, a(ind, n947), rule(2840), [uses(957, a(ind, n946))]).
substitution(959, [binding("x", ind)]).
proof(959, a(ind, n948), rule(2843), [uses(958, a(ind, n947))]).
substitution(960, [binding("x", ind)]).
proof(960, a(ind, n949), rule(2846), [uses(959, a(ind, n948))]).
substitution(961, [binding("x", ind)]).
proof(961, a(ind, n950), rule(2849), [uses(960, a(ind, n949))]).
substitution(962, [binding("x", ind)]).
proof(962, a(ind, n951), rule(2852), [uses(961, a(ind, n950))]).
substitution(963, [binding("x", ind)]).
proof(963, a(ind, n952), rule(2855), [uses(962, a(ind, n951))]).
substitution(964, [binding("x", ind)]).
proof(964, a(ind, n953), rule(2858), [uses(963, a(ind, n952))]).
substitution(965, [binding("x", ind)]).
proof(965, a(ind, n954), rule(2861), [uses(964, a(ind, n953))]).
substitution(966, [binding("x", ind)]).
proof(966, a(ind, n955), rule(2864), [uses(965, a(ind, n954))]).
substitution(967, [binding("x", ind)]).
proof(967, a(ind, n956), rule(2867), [uses(966, a(ind, n955))]).
substitution(968, [binding("x", ind)]).
proof(968, a(ind, n957), rule(2870), [uses(967, a(ind, n956))]).
substitution(969, [binding("x", ind)]).
proof(969, a(ind, n958), rule(2873), [uses(968, a(ind, n957))]).
substitution(970, [binding("x", ind)]).
proof(970, a(ind, n959), rule(2876), [uses(969, a(ind, n958))]).
substitution(971, [binding("x", ind)]).
proof(971, a(ind, n960), rule(2879), [uses(970, a(ind, n959))]).
substitution(972, [binding("x", ind)]).
proof(972, a(ind, n961), rule(2882), [uses(971, a(ind, n960))]).
substitution(973, [binding("x", ind)]).
proof(973, a(ind, n962), rule(2885), [uses(972, a(ind, n961))]).
substitution(974, [binding("x", ind)]).
proof(974, a(ind, n963), rule(2888), [uses(973, a(ind, n962))]).
substitution(975, [binding("x", ind)]).
proof(975, a(ind, n964), rule(2891), [uses(974, a(ind, n963))]).
substitution(976, [binding("x", ind)]).
proof(976, a(ind, n965), rule(2894), [uses(975, a(ind, n964))]).
substitution(977, [binding("x", ind)]).
proof(977, a(ind, n966), rule(2897), [uses(976, a(ind, n965))]).
substitution(978, [binding("x", ind)]).
proof(978, a(ind, n967), rule(2900), [uses(977, a(ind, n966))]).
substitution(979, [binding("x", ind)]).
proof(979, a(ind, n968), rule(2903), [uses(978, a(ind, n967))]).
substitution(980, [binding("x", ind)]).
proof(980, a(ind, n969), rule(2906), [uses(979, a(ind, n968))]).
substitution(981, [binding("x", ind)]).
proof(981, a(ind, n970), rule(2909), [uses(980, a(ind, n969))]).
substitution(982, [binding("x", ind)]).
proof(982, a(ind, n971), rule(2912), [uses(981, a(ind, n970))]).
substitution(983, [binding("x", ind)]).
proof(983, a(ind, n972), rule(2915), [uses(982, a(ind, n971))]).
substitution(984, [binding("x", ind)]).
proof(984, a(ind, n973), rule(2918), [uses(983, a(ind, n972))]).
substitution(985, [binding("x", ind)]).
proof(985, a(ind, n974), rule(2921), [uses(984, a(ind, n973))]).
substitution(986, [binding("x", ind)]).
proof(986, a(ind, n975), rule(2924), [uses(985, a(ind, n974))]).
substitution(987, [binding("x", ind)]).
proof(987, a(ind, n976), rule(2927), [uses(986, a(ind, n975))]).
substitution(988, [binding("x", ind)]).
proof(988, a(ind, n977), rule(2930), [uses(987, a(ind, n976))]).
substitution(989, [binding("x", ind)]).
proof(989, a(ind, n978), rule(2933), [uses(988, a(ind, n977))]).
substitution(990, [binding("x", ind)]).
proof(990, a(ind, n979), rule(2936), [uses(989, a(ind, n978))]).
substitution(991, [binding("x", ind)]).
proof(991, a(ind, n980), rule(2939), [uses(990, a(ind, n979))]).
substitution(992, [binding("x", ind)]).
proof(992, a(ind, n981), rule(2942), [uses(991, a(ind, n980))]).
substitution(993, [binding("x", ind)]).
proof(993, a(ind, n982), rule(2945), [uses(992, a(ind, n981))]).
substitution(994, [binding("x", ind)]).
proof(994, a(ind, n983), rule(2948), [uses(993, a(ind, n982))]).
substitution(995, [binding("x", ind)]).
proof(995, a(ind, n984), rule(2951), [uses(994, a(ind, n983))]).
substitution(996, [binding("x", ind)]).
proof(996, a(ind, n985), rule(2954), [uses(995, a(ind, n984))]).
substitution(997, [binding("x", ind)]).
proof(997, a(ind, n986), rule(2957), [uses(996, a(ind, n985))]).
substitution(998, [binding("x", ind)]).
proof(998, a(ind, n987), rule(2960), [uses(997, a(ind, n986))]).
substitution(999, [binding("x", ind)]).
proof(999, a(ind, n988), rule(2963), [uses(998, a(ind, n987))]).
substitution(1000, [binding("x", ind)]).
proof(1000, a(ind, n989), rule(2966), [uses(999, a(ind, n988))]).
substitution(1001, [binding("x", ind)]).
proof(1001, a(ind, n990), rule(2969), [uses(1000, a(ind, n989))]).
substitution(1002, [binding("x", ind)]).
proof(1002, a(ind, n991), rule(2972), [uses(1001, a(ind, n990))]).
substitution(1003, [binding("x", ind)]).
proof(1003, a(ind, n992), rule(2975), [uses(1002, a(ind, n991))]).
substitution(1004, [binding("x", ind)]).
proof(1004, a(ind, n993), rule(2978), [uses(1003, a(ind, n992))]).
substitution(1005, [binding("x", ind)]).
proof(1005, a(ind, n994), rule(2981), [uses(1004, a(ind, n993))]).
substitution(1006, [binding("x", ind)]).
proof(1006, a(ind, n995), rule(2984), [uses(1005, a(ind, n994))]).
substitution(1007, [binding("x", ind)]).
proof(1007, a(ind, n996), rule(2987), [uses(1006, a(ind, n995))]).
substitution(1008, [binding("x", ind)]).
proof(1008, a(ind, n997), rule(2990), [uses(1007, a(ind, n996))]).
substitution(1009, [binding("x", ind)]).
proof(1009, a(ind, n998), rule(2993), [uses(1008, a(ind, n997))]).
substitution(1010, [binding("x", ind)]).
proof(1010, a(ind, n999), rule(2996), [uses(1009, a(ind, n998))]).
substitution(1011, [binding("x", ind)]).
proof(1011, a(ind, n1000), rule(2999), [uses(1010, a(ind, n999))]).
substitution(1012, []).
proof(1012, arc(check4, "C4 OK - the final taxonomy step from n999 to n1000 was completed."), rule(3007), [uses(1010, a(ind, n999)), uses(1011, a(ind, n1000))]).
substitution(1013, [binding("x", ind)]).
proof(1013, a(ind, a2), rule(3002), [uses(1011, a(ind, n1000))]).
substitution(1014, [binding("check", check4), binding("message", "C4 OK - the final taxonomy step from n999 to n1000 was completed.")]).
proof(1014, solution([check4, "C4 OK - the final taxonomy step from n999 to n1000 was completed."]), query, [uses(1012, arc(check4, "C4 OK - the final taxonomy step from n999 to n1000 was completed."))]).
substitution(1015, []).
proof(1015, arc(check5, "C5 OK - once n1000 is reached, the terminal class a2 is derived."), rule(3008), [uses(1011, a(ind, n1000)), uses(1013, a(ind, a2))]).
substitution(1016, [binding("check", check5), binding("message", "C5 OK - once n1000 is reached, the terminal class a2 is derived.")]).
proof(1016, solution([check5, "C5 OK - once n1000 is reached, the terminal class a2 is derived."]), query, [uses(1015, arc(check5, "C5 OK - once n1000 is reached, the terminal class a2 is derived."))]).
substitution(1017, []).
proof(1017, holds_result(test, true), rule(3003), [uses(1013, a(ind, a2))]).
substitution(1018, []).
proof(1018, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."), rule(3009), [uses(1013, a(ind, a2)), uses(1017, holds_result(test, true))]).
substitution(1019, [binding("check", check6), binding("message", "C6 OK - the success flag is raised only after the terminal class a2 is present.")]).
proof(1019, solution([check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."]), query, [uses(1018, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."))]).
substitution(1020, []).
proof(1020, a(ind, n0), rule(1), []).
substitution(1021, [binding("x", ind)]).
proof(1021, a(ind, n1), rule(2), [uses(1020, a(ind, n0))]).
substitution(1022, [binding("x", ind)]).
proof(1022, a(ind, n2), rule(5), [uses(1021, a(ind, n1))]).
substitution(1023, [binding("x", ind)]).
proof(1023, a(ind, n3), rule(8), [uses(1022, a(ind, n2))]).
substitution(1024, [binding("x", ind)]).
proof(1024, a(ind, n4), rule(11), [uses(1023, a(ind, n3))]).
substitution(1025, [binding("x", ind)]).
proof(1025, a(ind, n5), rule(14), [uses(1024, a(ind, n4))]).
substitution(1026, [binding("x", ind)]).
proof(1026, a(ind, n6), rule(17), [uses(1025, a(ind, n5))]).
substitution(1027, [binding("x", ind)]).
proof(1027, a(ind, n7), rule(20), [uses(1026, a(ind, n6))]).
substitution(1028, [binding("x", ind)]).
proof(1028, a(ind, n8), rule(23), [uses(1027, a(ind, n7))]).
substitution(1029, [binding("x", ind)]).
proof(1029, a(ind, n9), rule(26), [uses(1028, a(ind, n8))]).
substitution(1030, [binding("x", ind)]).
proof(1030, a(ind, n10), rule(29), [uses(1029, a(ind, n9))]).
substitution(1031, [binding("x", ind)]).
proof(1031, a(ind, n11), rule(32), [uses(1030, a(ind, n10))]).
substitution(1032, [binding("x", ind)]).
proof(1032, a(ind, n12), rule(35), [uses(1031, a(ind, n11))]).
substitution(1033, [binding("x", ind)]).
proof(1033, a(ind, n13), rule(38), [uses(1032, a(ind, n12))]).
substitution(1034, [binding("x", ind)]).
proof(1034, a(ind, n14), rule(41), [uses(1033, a(ind, n13))]).
substitution(1035, [binding("x", ind)]).
proof(1035, a(ind, n15), rule(44), [uses(1034, a(ind, n14))]).
substitution(1036, [binding("x", ind)]).
proof(1036, a(ind, n16), rule(47), [uses(1035, a(ind, n15))]).
substitution(1037, [binding("x", ind)]).
proof(1037, a(ind, n17), rule(50), [uses(1036, a(ind, n16))]).
substitution(1038, [binding("x", ind)]).
proof(1038, a(ind, n18), rule(53), [uses(1037, a(ind, n17))]).
substitution(1039, [binding("x", ind)]).
proof(1039, a(ind, n19), rule(56), [uses(1038, a(ind, n18))]).
substitution(1040, [binding("x", ind)]).
proof(1040, a(ind, n20), rule(59), [uses(1039, a(ind, n19))]).
substitution(1041, [binding("x", ind)]).
proof(1041, a(ind, n21), rule(62), [uses(1040, a(ind, n20))]).
substitution(1042, [binding("x", ind)]).
proof(1042, a(ind, n22), rule(65), [uses(1041, a(ind, n21))]).
substitution(1043, [binding("x", ind)]).
proof(1043, a(ind, n23), rule(68), [uses(1042, a(ind, n22))]).
substitution(1044, [binding("x", ind)]).
proof(1044, a(ind, n24), rule(71), [uses(1043, a(ind, n23))]).
substitution(1045, [binding("x", ind)]).
proof(1045, a(ind, n25), rule(74), [uses(1044, a(ind, n24))]).
substitution(1046, [binding("x", ind)]).
proof(1046, a(ind, n26), rule(77), [uses(1045, a(ind, n25))]).
substitution(1047, [binding("x", ind)]).
proof(1047, a(ind, n27), rule(80), [uses(1046, a(ind, n26))]).
substitution(1048, [binding("x", ind)]).
proof(1048, a(ind, n28), rule(83), [uses(1047, a(ind, n27))]).
substitution(1049, [binding("x", ind)]).
proof(1049, a(ind, n29), rule(86), [uses(1048, a(ind, n28))]).
substitution(1050, [binding("x", ind)]).
proof(1050, a(ind, n30), rule(89), [uses(1049, a(ind, n29))]).
substitution(1051, [binding("x", ind)]).
proof(1051, a(ind, n31), rule(92), [uses(1050, a(ind, n30))]).
substitution(1052, [binding("x", ind)]).
proof(1052, a(ind, n32), rule(95), [uses(1051, a(ind, n31))]).
substitution(1053, [binding("x", ind)]).
proof(1053, a(ind, n33), rule(98), [uses(1052, a(ind, n32))]).
substitution(1054, [binding("x", ind)]).
proof(1054, a(ind, n34), rule(101), [uses(1053, a(ind, n33))]).
substitution(1055, [binding("x", ind)]).
proof(1055, a(ind, n35), rule(104), [uses(1054, a(ind, n34))]).
substitution(1056, [binding("x", ind)]).
proof(1056, a(ind, n36), rule(107), [uses(1055, a(ind, n35))]).
substitution(1057, [binding("x", ind)]).
proof(1057, a(ind, n37), rule(110), [uses(1056, a(ind, n36))]).
substitution(1058, [binding("x", ind)]).
proof(1058, a(ind, n38), rule(113), [uses(1057, a(ind, n37))]).
substitution(1059, [binding("x", ind)]).
proof(1059, a(ind, n39), rule(116), [uses(1058, a(ind, n38))]).
substitution(1060, [binding("x", ind)]).
proof(1060, a(ind, n40), rule(119), [uses(1059, a(ind, n39))]).
substitution(1061, [binding("x", ind)]).
proof(1061, a(ind, n41), rule(122), [uses(1060, a(ind, n40))]).
substitution(1062, [binding("x", ind)]).
proof(1062, a(ind, n42), rule(125), [uses(1061, a(ind, n41))]).
substitution(1063, [binding("x", ind)]).
proof(1063, a(ind, n43), rule(128), [uses(1062, a(ind, n42))]).
substitution(1064, [binding("x", ind)]).
proof(1064, a(ind, n44), rule(131), [uses(1063, a(ind, n43))]).
substitution(1065, [binding("x", ind)]).
proof(1065, a(ind, n45), rule(134), [uses(1064, a(ind, n44))]).
substitution(1066, [binding("x", ind)]).
proof(1066, a(ind, n46), rule(137), [uses(1065, a(ind, n45))]).
substitution(1067, [binding("x", ind)]).
proof(1067, a(ind, n47), rule(140), [uses(1066, a(ind, n46))]).
substitution(1068, [binding("x", ind)]).
proof(1068, a(ind, n48), rule(143), [uses(1067, a(ind, n47))]).
substitution(1069, [binding("x", ind)]).
proof(1069, a(ind, n49), rule(146), [uses(1068, a(ind, n48))]).
substitution(1070, [binding("x", ind)]).
proof(1070, a(ind, n50), rule(149), [uses(1069, a(ind, n49))]).
substitution(1071, [binding("x", ind)]).
proof(1071, a(ind, n51), rule(152), [uses(1070, a(ind, n50))]).
substitution(1072, [binding("x", ind)]).
proof(1072, a(ind, n52), rule(155), [uses(1071, a(ind, n51))]).
substitution(1073, [binding("x", ind)]).
proof(1073, a(ind, n53), rule(158), [uses(1072, a(ind, n52))]).
substitution(1074, [binding("x", ind)]).
proof(1074, a(ind, n54), rule(161), [uses(1073, a(ind, n53))]).
substitution(1075, [binding("x", ind)]).
proof(1075, a(ind, n55), rule(164), [uses(1074, a(ind, n54))]).
substitution(1076, [binding("x", ind)]).
proof(1076, a(ind, n56), rule(167), [uses(1075, a(ind, n55))]).
substitution(1077, [binding("x", ind)]).
proof(1077, a(ind, n57), rule(170), [uses(1076, a(ind, n56))]).
substitution(1078, [binding("x", ind)]).
proof(1078, a(ind, n58), rule(173), [uses(1077, a(ind, n57))]).
substitution(1079, [binding("x", ind)]).
proof(1079, a(ind, n59), rule(176), [uses(1078, a(ind, n58))]).
substitution(1080, [binding("x", ind)]).
proof(1080, a(ind, n60), rule(179), [uses(1079, a(ind, n59))]).
substitution(1081, [binding("x", ind)]).
proof(1081, a(ind, n61), rule(182), [uses(1080, a(ind, n60))]).
substitution(1082, [binding("x", ind)]).
proof(1082, a(ind, n62), rule(185), [uses(1081, a(ind, n61))]).
substitution(1083, [binding("x", ind)]).
proof(1083, a(ind, n63), rule(188), [uses(1082, a(ind, n62))]).
substitution(1084, [binding("x", ind)]).
proof(1084, a(ind, n64), rule(191), [uses(1083, a(ind, n63))]).
substitution(1085, [binding("x", ind)]).
proof(1085, a(ind, n65), rule(194), [uses(1084, a(ind, n64))]).
substitution(1086, [binding("x", ind)]).
proof(1086, a(ind, n66), rule(197), [uses(1085, a(ind, n65))]).
substitution(1087, [binding("x", ind)]).
proof(1087, a(ind, n67), rule(200), [uses(1086, a(ind, n66))]).
substitution(1088, [binding("x", ind)]).
proof(1088, a(ind, n68), rule(203), [uses(1087, a(ind, n67))]).
substitution(1089, [binding("x", ind)]).
proof(1089, a(ind, n69), rule(206), [uses(1088, a(ind, n68))]).
substitution(1090, [binding("x", ind)]).
proof(1090, a(ind, n70), rule(209), [uses(1089, a(ind, n69))]).
substitution(1091, [binding("x", ind)]).
proof(1091, a(ind, n71), rule(212), [uses(1090, a(ind, n70))]).
substitution(1092, [binding("x", ind)]).
proof(1092, a(ind, n72), rule(215), [uses(1091, a(ind, n71))]).
substitution(1093, [binding("x", ind)]).
proof(1093, a(ind, n73), rule(218), [uses(1092, a(ind, n72))]).
substitution(1094, [binding("x", ind)]).
proof(1094, a(ind, n74), rule(221), [uses(1093, a(ind, n73))]).
substitution(1095, [binding("x", ind)]).
proof(1095, a(ind, n75), rule(224), [uses(1094, a(ind, n74))]).
substitution(1096, [binding("x", ind)]).
proof(1096, a(ind, n76), rule(227), [uses(1095, a(ind, n75))]).
substitution(1097, [binding("x", ind)]).
proof(1097, a(ind, n77), rule(230), [uses(1096, a(ind, n76))]).
substitution(1098, [binding("x", ind)]).
proof(1098, a(ind, n78), rule(233), [uses(1097, a(ind, n77))]).
substitution(1099, [binding("x", ind)]).
proof(1099, a(ind, n79), rule(236), [uses(1098, a(ind, n78))]).
substitution(1100, [binding("x", ind)]).
proof(1100, a(ind, n80), rule(239), [uses(1099, a(ind, n79))]).
substitution(1101, [binding("x", ind)]).
proof(1101, a(ind, n81), rule(242), [uses(1100, a(ind, n80))]).
substitution(1102, [binding("x", ind)]).
proof(1102, a(ind, n82), rule(245), [uses(1101, a(ind, n81))]).
substitution(1103, [binding("x", ind)]).
proof(1103, a(ind, n83), rule(248), [uses(1102, a(ind, n82))]).
substitution(1104, [binding("x", ind)]).
proof(1104, a(ind, n84), rule(251), [uses(1103, a(ind, n83))]).
substitution(1105, [binding("x", ind)]).
proof(1105, a(ind, n85), rule(254), [uses(1104, a(ind, n84))]).
substitution(1106, [binding("x", ind)]).
proof(1106, a(ind, n86), rule(257), [uses(1105, a(ind, n85))]).
substitution(1107, [binding("x", ind)]).
proof(1107, a(ind, n87), rule(260), [uses(1106, a(ind, n86))]).
substitution(1108, [binding("x", ind)]).
proof(1108, a(ind, n88), rule(263), [uses(1107, a(ind, n87))]).
substitution(1109, [binding("x", ind)]).
proof(1109, a(ind, n89), rule(266), [uses(1108, a(ind, n88))]).
substitution(1110, [binding("x", ind)]).
proof(1110, a(ind, n90), rule(269), [uses(1109, a(ind, n89))]).
substitution(1111, [binding("x", ind)]).
proof(1111, a(ind, n91), rule(272), [uses(1110, a(ind, n90))]).
substitution(1112, [binding("x", ind)]).
proof(1112, a(ind, n92), rule(275), [uses(1111, a(ind, n91))]).
substitution(1113, [binding("x", ind)]).
proof(1113, a(ind, n93), rule(278), [uses(1112, a(ind, n92))]).
substitution(1114, [binding("x", ind)]).
proof(1114, a(ind, n94), rule(281), [uses(1113, a(ind, n93))]).
substitution(1115, [binding("x", ind)]).
proof(1115, a(ind, n95), rule(284), [uses(1114, a(ind, n94))]).
substitution(1116, [binding("x", ind)]).
proof(1116, a(ind, n96), rule(287), [uses(1115, a(ind, n95))]).
substitution(1117, [binding("x", ind)]).
proof(1117, a(ind, n97), rule(290), [uses(1116, a(ind, n96))]).
substitution(1118, [binding("x", ind)]).
proof(1118, a(ind, n98), rule(293), [uses(1117, a(ind, n97))]).
substitution(1119, [binding("x", ind)]).
proof(1119, a(ind, n99), rule(296), [uses(1118, a(ind, n98))]).
substitution(1120, [binding("x", ind)]).
proof(1120, a(ind, n100), rule(299), [uses(1119, a(ind, n99))]).
substitution(1121, [binding("x", ind)]).
proof(1121, a(ind, n101), rule(302), [uses(1120, a(ind, n100))]).
substitution(1122, [binding("x", ind)]).
proof(1122, a(ind, n102), rule(305), [uses(1121, a(ind, n101))]).
substitution(1123, [binding("x", ind)]).
proof(1123, a(ind, n103), rule(308), [uses(1122, a(ind, n102))]).
substitution(1124, [binding("x", ind)]).
proof(1124, a(ind, n104), rule(311), [uses(1123, a(ind, n103))]).
substitution(1125, [binding("x", ind)]).
proof(1125, a(ind, n105), rule(314), [uses(1124, a(ind, n104))]).
substitution(1126, [binding("x", ind)]).
proof(1126, a(ind, n106), rule(317), [uses(1125, a(ind, n105))]).
substitution(1127, [binding("x", ind)]).
proof(1127, a(ind, n107), rule(320), [uses(1126, a(ind, n106))]).
substitution(1128, [binding("x", ind)]).
proof(1128, a(ind, n108), rule(323), [uses(1127, a(ind, n107))]).
substitution(1129, [binding("x", ind)]).
proof(1129, a(ind, n109), rule(326), [uses(1128, a(ind, n108))]).
substitution(1130, [binding("x", ind)]).
proof(1130, a(ind, n110), rule(329), [uses(1129, a(ind, n109))]).
substitution(1131, [binding("x", ind)]).
proof(1131, a(ind, n111), rule(332), [uses(1130, a(ind, n110))]).
substitution(1132, [binding("x", ind)]).
proof(1132, a(ind, n112), rule(335), [uses(1131, a(ind, n111))]).
substitution(1133, [binding("x", ind)]).
proof(1133, a(ind, n113), rule(338), [uses(1132, a(ind, n112))]).
substitution(1134, [binding("x", ind)]).
proof(1134, a(ind, n114), rule(341), [uses(1133, a(ind, n113))]).
substitution(1135, [binding("x", ind)]).
proof(1135, a(ind, n115), rule(344), [uses(1134, a(ind, n114))]).
substitution(1136, [binding("x", ind)]).
proof(1136, a(ind, n116), rule(347), [uses(1135, a(ind, n115))]).
substitution(1137, [binding("x", ind)]).
proof(1137, a(ind, n117), rule(350), [uses(1136, a(ind, n116))]).
substitution(1138, [binding("x", ind)]).
proof(1138, a(ind, n118), rule(353), [uses(1137, a(ind, n117))]).
substitution(1139, [binding("x", ind)]).
proof(1139, a(ind, n119), rule(356), [uses(1138, a(ind, n118))]).
substitution(1140, [binding("x", ind)]).
proof(1140, a(ind, n120), rule(359), [uses(1139, a(ind, n119))]).
substitution(1141, [binding("x", ind)]).
proof(1141, a(ind, n121), rule(362), [uses(1140, a(ind, n120))]).
substitution(1142, [binding("x", ind)]).
proof(1142, a(ind, n122), rule(365), [uses(1141, a(ind, n121))]).
substitution(1143, [binding("x", ind)]).
proof(1143, a(ind, n123), rule(368), [uses(1142, a(ind, n122))]).
substitution(1144, [binding("x", ind)]).
proof(1144, a(ind, n124), rule(371), [uses(1143, a(ind, n123))]).
substitution(1145, [binding("x", ind)]).
proof(1145, a(ind, n125), rule(374), [uses(1144, a(ind, n124))]).
substitution(1146, [binding("x", ind)]).
proof(1146, a(ind, n126), rule(377), [uses(1145, a(ind, n125))]).
substitution(1147, [binding("x", ind)]).
proof(1147, a(ind, n127), rule(380), [uses(1146, a(ind, n126))]).
substitution(1148, [binding("x", ind)]).
proof(1148, a(ind, n128), rule(383), [uses(1147, a(ind, n127))]).
substitution(1149, [binding("x", ind)]).
proof(1149, a(ind, n129), rule(386), [uses(1148, a(ind, n128))]).
substitution(1150, [binding("x", ind)]).
proof(1150, a(ind, n130), rule(389), [uses(1149, a(ind, n129))]).
substitution(1151, [binding("x", ind)]).
proof(1151, a(ind, n131), rule(392), [uses(1150, a(ind, n130))]).
substitution(1152, [binding("x", ind)]).
proof(1152, a(ind, n132), rule(395), [uses(1151, a(ind, n131))]).
substitution(1153, [binding("x", ind)]).
proof(1153, a(ind, n133), rule(398), [uses(1152, a(ind, n132))]).
substitution(1154, [binding("x", ind)]).
proof(1154, a(ind, n134), rule(401), [uses(1153, a(ind, n133))]).
substitution(1155, [binding("x", ind)]).
proof(1155, a(ind, n135), rule(404), [uses(1154, a(ind, n134))]).
substitution(1156, [binding("x", ind)]).
proof(1156, a(ind, n136), rule(407), [uses(1155, a(ind, n135))]).
substitution(1157, [binding("x", ind)]).
proof(1157, a(ind, n137), rule(410), [uses(1156, a(ind, n136))]).
substitution(1158, [binding("x", ind)]).
proof(1158, a(ind, n138), rule(413), [uses(1157, a(ind, n137))]).
substitution(1159, [binding("x", ind)]).
proof(1159, a(ind, n139), rule(416), [uses(1158, a(ind, n138))]).
substitution(1160, [binding("x", ind)]).
proof(1160, a(ind, n140), rule(419), [uses(1159, a(ind, n139))]).
substitution(1161, [binding("x", ind)]).
proof(1161, a(ind, n141), rule(422), [uses(1160, a(ind, n140))]).
substitution(1162, [binding("x", ind)]).
proof(1162, a(ind, n142), rule(425), [uses(1161, a(ind, n141))]).
substitution(1163, [binding("x", ind)]).
proof(1163, a(ind, n143), rule(428), [uses(1162, a(ind, n142))]).
substitution(1164, [binding("x", ind)]).
proof(1164, a(ind, n144), rule(431), [uses(1163, a(ind, n143))]).
substitution(1165, [binding("x", ind)]).
proof(1165, a(ind, n145), rule(434), [uses(1164, a(ind, n144))]).
substitution(1166, [binding("x", ind)]).
proof(1166, a(ind, n146), rule(437), [uses(1165, a(ind, n145))]).
substitution(1167, [binding("x", ind)]).
proof(1167, a(ind, n147), rule(440), [uses(1166, a(ind, n146))]).
substitution(1168, [binding("x", ind)]).
proof(1168, a(ind, n148), rule(443), [uses(1167, a(ind, n147))]).
substitution(1169, [binding("x", ind)]).
proof(1169, a(ind, n149), rule(446), [uses(1168, a(ind, n148))]).
substitution(1170, [binding("x", ind)]).
proof(1170, a(ind, n150), rule(449), [uses(1169, a(ind, n149))]).
substitution(1171, [binding("x", ind)]).
proof(1171, a(ind, n151), rule(452), [uses(1170, a(ind, n150))]).
substitution(1172, [binding("x", ind)]).
proof(1172, a(ind, n152), rule(455), [uses(1171, a(ind, n151))]).
substitution(1173, [binding("x", ind)]).
proof(1173, a(ind, n153), rule(458), [uses(1172, a(ind, n152))]).
substitution(1174, [binding("x", ind)]).
proof(1174, a(ind, n154), rule(461), [uses(1173, a(ind, n153))]).
substitution(1175, [binding("x", ind)]).
proof(1175, a(ind, n155), rule(464), [uses(1174, a(ind, n154))]).
substitution(1176, [binding("x", ind)]).
proof(1176, a(ind, n156), rule(467), [uses(1175, a(ind, n155))]).
substitution(1177, [binding("x", ind)]).
proof(1177, a(ind, n157), rule(470), [uses(1176, a(ind, n156))]).
substitution(1178, [binding("x", ind)]).
proof(1178, a(ind, n158), rule(473), [uses(1177, a(ind, n157))]).
substitution(1179, [binding("x", ind)]).
proof(1179, a(ind, n159), rule(476), [uses(1178, a(ind, n158))]).
substitution(1180, [binding("x", ind)]).
proof(1180, a(ind, n160), rule(479), [uses(1179, a(ind, n159))]).
substitution(1181, [binding("x", ind)]).
proof(1181, a(ind, n161), rule(482), [uses(1180, a(ind, n160))]).
substitution(1182, [binding("x", ind)]).
proof(1182, a(ind, n162), rule(485), [uses(1181, a(ind, n161))]).
substitution(1183, [binding("x", ind)]).
proof(1183, a(ind, n163), rule(488), [uses(1182, a(ind, n162))]).
substitution(1184, [binding("x", ind)]).
proof(1184, a(ind, n164), rule(491), [uses(1183, a(ind, n163))]).
substitution(1185, [binding("x", ind)]).
proof(1185, a(ind, n165), rule(494), [uses(1184, a(ind, n164))]).
substitution(1186, [binding("x", ind)]).
proof(1186, a(ind, n166), rule(497), [uses(1185, a(ind, n165))]).
substitution(1187, [binding("x", ind)]).
proof(1187, a(ind, n167), rule(500), [uses(1186, a(ind, n166))]).
substitution(1188, [binding("x", ind)]).
proof(1188, a(ind, n168), rule(503), [uses(1187, a(ind, n167))]).
substitution(1189, [binding("x", ind)]).
proof(1189, a(ind, n169), rule(506), [uses(1188, a(ind, n168))]).
substitution(1190, [binding("x", ind)]).
proof(1190, a(ind, n170), rule(509), [uses(1189, a(ind, n169))]).
substitution(1191, [binding("x", ind)]).
proof(1191, a(ind, n171), rule(512), [uses(1190, a(ind, n170))]).
substitution(1192, [binding("x", ind)]).
proof(1192, a(ind, n172), rule(515), [uses(1191, a(ind, n171))]).
substitution(1193, [binding("x", ind)]).
proof(1193, a(ind, n173), rule(518), [uses(1192, a(ind, n172))]).
substitution(1194, [binding("x", ind)]).
proof(1194, a(ind, n174), rule(521), [uses(1193, a(ind, n173))]).
substitution(1195, [binding("x", ind)]).
proof(1195, a(ind, n175), rule(524), [uses(1194, a(ind, n174))]).
substitution(1196, [binding("x", ind)]).
proof(1196, a(ind, n176), rule(527), [uses(1195, a(ind, n175))]).
substitution(1197, [binding("x", ind)]).
proof(1197, a(ind, n177), rule(530), [uses(1196, a(ind, n176))]).
substitution(1198, [binding("x", ind)]).
proof(1198, a(ind, n178), rule(533), [uses(1197, a(ind, n177))]).
substitution(1199, [binding("x", ind)]).
proof(1199, a(ind, n179), rule(536), [uses(1198, a(ind, n178))]).
substitution(1200, [binding("x", ind)]).
proof(1200, a(ind, n180), rule(539), [uses(1199, a(ind, n179))]).
substitution(1201, [binding("x", ind)]).
proof(1201, a(ind, n181), rule(542), [uses(1200, a(ind, n180))]).
substitution(1202, [binding("x", ind)]).
proof(1202, a(ind, n182), rule(545), [uses(1201, a(ind, n181))]).
substitution(1203, [binding("x", ind)]).
proof(1203, a(ind, n183), rule(548), [uses(1202, a(ind, n182))]).
substitution(1204, [binding("x", ind)]).
proof(1204, a(ind, n184), rule(551), [uses(1203, a(ind, n183))]).
substitution(1205, [binding("x", ind)]).
proof(1205, a(ind, n185), rule(554), [uses(1204, a(ind, n184))]).
substitution(1206, [binding("x", ind)]).
proof(1206, a(ind, n186), rule(557), [uses(1205, a(ind, n185))]).
substitution(1207, [binding("x", ind)]).
proof(1207, a(ind, n187), rule(560), [uses(1206, a(ind, n186))]).
substitution(1208, [binding("x", ind)]).
proof(1208, a(ind, n188), rule(563), [uses(1207, a(ind, n187))]).
substitution(1209, [binding("x", ind)]).
proof(1209, a(ind, n189), rule(566), [uses(1208, a(ind, n188))]).
substitution(1210, [binding("x", ind)]).
proof(1210, a(ind, n190), rule(569), [uses(1209, a(ind, n189))]).
substitution(1211, [binding("x", ind)]).
proof(1211, a(ind, n191), rule(572), [uses(1210, a(ind, n190))]).
substitution(1212, [binding("x", ind)]).
proof(1212, a(ind, n192), rule(575), [uses(1211, a(ind, n191))]).
substitution(1213, [binding("x", ind)]).
proof(1213, a(ind, n193), rule(578), [uses(1212, a(ind, n192))]).
substitution(1214, [binding("x", ind)]).
proof(1214, a(ind, n194), rule(581), [uses(1213, a(ind, n193))]).
substitution(1215, [binding("x", ind)]).
proof(1215, a(ind, n195), rule(584), [uses(1214, a(ind, n194))]).
substitution(1216, [binding("x", ind)]).
proof(1216, a(ind, n196), rule(587), [uses(1215, a(ind, n195))]).
substitution(1217, [binding("x", ind)]).
proof(1217, a(ind, n197), rule(590), [uses(1216, a(ind, n196))]).
substitution(1218, [binding("x", ind)]).
proof(1218, a(ind, n198), rule(593), [uses(1217, a(ind, n197))]).
substitution(1219, [binding("x", ind)]).
proof(1219, a(ind, n199), rule(596), [uses(1218, a(ind, n198))]).
substitution(1220, [binding("x", ind)]).
proof(1220, a(ind, n200), rule(599), [uses(1219, a(ind, n199))]).
substitution(1221, [binding("x", ind)]).
proof(1221, a(ind, n201), rule(602), [uses(1220, a(ind, n200))]).
substitution(1222, [binding("x", ind)]).
proof(1222, a(ind, n202), rule(605), [uses(1221, a(ind, n201))]).
substitution(1223, [binding("x", ind)]).
proof(1223, a(ind, n203), rule(608), [uses(1222, a(ind, n202))]).
substitution(1224, [binding("x", ind)]).
proof(1224, a(ind, n204), rule(611), [uses(1223, a(ind, n203))]).
substitution(1225, [binding("x", ind)]).
proof(1225, a(ind, n205), rule(614), [uses(1224, a(ind, n204))]).
substitution(1226, [binding("x", ind)]).
proof(1226, a(ind, n206), rule(617), [uses(1225, a(ind, n205))]).
substitution(1227, [binding("x", ind)]).
proof(1227, a(ind, n207), rule(620), [uses(1226, a(ind, n206))]).
substitution(1228, [binding("x", ind)]).
proof(1228, a(ind, n208), rule(623), [uses(1227, a(ind, n207))]).
substitution(1229, [binding("x", ind)]).
proof(1229, a(ind, n209), rule(626), [uses(1228, a(ind, n208))]).
substitution(1230, [binding("x", ind)]).
proof(1230, a(ind, n210), rule(629), [uses(1229, a(ind, n209))]).
substitution(1231, [binding("x", ind)]).
proof(1231, a(ind, n211), rule(632), [uses(1230, a(ind, n210))]).
substitution(1232, [binding("x", ind)]).
proof(1232, a(ind, n212), rule(635), [uses(1231, a(ind, n211))]).
substitution(1233, [binding("x", ind)]).
proof(1233, a(ind, n213), rule(638), [uses(1232, a(ind, n212))]).
substitution(1234, [binding("x", ind)]).
proof(1234, a(ind, n214), rule(641), [uses(1233, a(ind, n213))]).
substitution(1235, [binding("x", ind)]).
proof(1235, a(ind, n215), rule(644), [uses(1234, a(ind, n214))]).
substitution(1236, [binding("x", ind)]).
proof(1236, a(ind, n216), rule(647), [uses(1235, a(ind, n215))]).
substitution(1237, [binding("x", ind)]).
proof(1237, a(ind, n217), rule(650), [uses(1236, a(ind, n216))]).
substitution(1238, [binding("x", ind)]).
proof(1238, a(ind, n218), rule(653), [uses(1237, a(ind, n217))]).
substitution(1239, [binding("x", ind)]).
proof(1239, a(ind, n219), rule(656), [uses(1238, a(ind, n218))]).
substitution(1240, [binding("x", ind)]).
proof(1240, a(ind, n220), rule(659), [uses(1239, a(ind, n219))]).
substitution(1241, [binding("x", ind)]).
proof(1241, a(ind, n221), rule(662), [uses(1240, a(ind, n220))]).
substitution(1242, [binding("x", ind)]).
proof(1242, a(ind, n222), rule(665), [uses(1241, a(ind, n221))]).
substitution(1243, [binding("x", ind)]).
proof(1243, a(ind, n223), rule(668), [uses(1242, a(ind, n222))]).
substitution(1244, [binding("x", ind)]).
proof(1244, a(ind, n224), rule(671), [uses(1243, a(ind, n223))]).
substitution(1245, [binding("x", ind)]).
proof(1245, a(ind, n225), rule(674), [uses(1244, a(ind, n224))]).
substitution(1246, [binding("x", ind)]).
proof(1246, a(ind, n226), rule(677), [uses(1245, a(ind, n225))]).
substitution(1247, [binding("x", ind)]).
proof(1247, a(ind, n227), rule(680), [uses(1246, a(ind, n226))]).
substitution(1248, [binding("x", ind)]).
proof(1248, a(ind, n228), rule(683), [uses(1247, a(ind, n227))]).
substitution(1249, [binding("x", ind)]).
proof(1249, a(ind, n229), rule(686), [uses(1248, a(ind, n228))]).
substitution(1250, [binding("x", ind)]).
proof(1250, a(ind, n230), rule(689), [uses(1249, a(ind, n229))]).
substitution(1251, [binding("x", ind)]).
proof(1251, a(ind, n231), rule(692), [uses(1250, a(ind, n230))]).
substitution(1252, [binding("x", ind)]).
proof(1252, a(ind, n232), rule(695), [uses(1251, a(ind, n231))]).
substitution(1253, [binding("x", ind)]).
proof(1253, a(ind, n233), rule(698), [uses(1252, a(ind, n232))]).
substitution(1254, [binding("x", ind)]).
proof(1254, a(ind, n234), rule(701), [uses(1253, a(ind, n233))]).
substitution(1255, [binding("x", ind)]).
proof(1255, a(ind, n235), rule(704), [uses(1254, a(ind, n234))]).
substitution(1256, [binding("x", ind)]).
proof(1256, a(ind, n236), rule(707), [uses(1255, a(ind, n235))]).
substitution(1257, [binding("x", ind)]).
proof(1257, a(ind, n237), rule(710), [uses(1256, a(ind, n236))]).
substitution(1258, [binding("x", ind)]).
proof(1258, a(ind, n238), rule(713), [uses(1257, a(ind, n237))]).
substitution(1259, [binding("x", ind)]).
proof(1259, a(ind, n239), rule(716), [uses(1258, a(ind, n238))]).
substitution(1260, [binding("x", ind)]).
proof(1260, a(ind, n240), rule(719), [uses(1259, a(ind, n239))]).
substitution(1261, [binding("x", ind)]).
proof(1261, a(ind, n241), rule(722), [uses(1260, a(ind, n240))]).
substitution(1262, [binding("x", ind)]).
proof(1262, a(ind, n242), rule(725), [uses(1261, a(ind, n241))]).
substitution(1263, [binding("x", ind)]).
proof(1263, a(ind, n243), rule(728), [uses(1262, a(ind, n242))]).
substitution(1264, [binding("x", ind)]).
proof(1264, a(ind, n244), rule(731), [uses(1263, a(ind, n243))]).
substitution(1265, [binding("x", ind)]).
proof(1265, a(ind, n245), rule(734), [uses(1264, a(ind, n244))]).
substitution(1266, [binding("x", ind)]).
proof(1266, a(ind, n246), rule(737), [uses(1265, a(ind, n245))]).
substitution(1267, [binding("x", ind)]).
proof(1267, a(ind, n247), rule(740), [uses(1266, a(ind, n246))]).
substitution(1268, [binding("x", ind)]).
proof(1268, a(ind, n248), rule(743), [uses(1267, a(ind, n247))]).
substitution(1269, [binding("x", ind)]).
proof(1269, a(ind, n249), rule(746), [uses(1268, a(ind, n248))]).
substitution(1270, [binding("x", ind)]).
proof(1270, a(ind, n250), rule(749), [uses(1269, a(ind, n249))]).
substitution(1271, [binding("x", ind)]).
proof(1271, a(ind, n251), rule(752), [uses(1270, a(ind, n250))]).
substitution(1272, [binding("x", ind)]).
proof(1272, a(ind, n252), rule(755), [uses(1271, a(ind, n251))]).
substitution(1273, [binding("x", ind)]).
proof(1273, a(ind, n253), rule(758), [uses(1272, a(ind, n252))]).
substitution(1274, [binding("x", ind)]).
proof(1274, a(ind, n254), rule(761), [uses(1273, a(ind, n253))]).
substitution(1275, [binding("x", ind)]).
proof(1275, a(ind, n255), rule(764), [uses(1274, a(ind, n254))]).
substitution(1276, [binding("x", ind)]).
proof(1276, a(ind, n256), rule(767), [uses(1275, a(ind, n255))]).
substitution(1277, [binding("x", ind)]).
proof(1277, a(ind, n257), rule(770), [uses(1276, a(ind, n256))]).
substitution(1278, [binding("x", ind)]).
proof(1278, a(ind, n258), rule(773), [uses(1277, a(ind, n257))]).
substitution(1279, [binding("x", ind)]).
proof(1279, a(ind, n259), rule(776), [uses(1278, a(ind, n258))]).
substitution(1280, [binding("x", ind)]).
proof(1280, a(ind, n260), rule(779), [uses(1279, a(ind, n259))]).
substitution(1281, [binding("x", ind)]).
proof(1281, a(ind, n261), rule(782), [uses(1280, a(ind, n260))]).
substitution(1282, [binding("x", ind)]).
proof(1282, a(ind, n262), rule(785), [uses(1281, a(ind, n261))]).
substitution(1283, [binding("x", ind)]).
proof(1283, a(ind, n263), rule(788), [uses(1282, a(ind, n262))]).
substitution(1284, [binding("x", ind)]).
proof(1284, a(ind, n264), rule(791), [uses(1283, a(ind, n263))]).
substitution(1285, [binding("x", ind)]).
proof(1285, a(ind, n265), rule(794), [uses(1284, a(ind, n264))]).
substitution(1286, [binding("x", ind)]).
proof(1286, a(ind, n266), rule(797), [uses(1285, a(ind, n265))]).
substitution(1287, [binding("x", ind)]).
proof(1287, a(ind, n267), rule(800), [uses(1286, a(ind, n266))]).
substitution(1288, [binding("x", ind)]).
proof(1288, a(ind, n268), rule(803), [uses(1287, a(ind, n267))]).
substitution(1289, [binding("x", ind)]).
proof(1289, a(ind, n269), rule(806), [uses(1288, a(ind, n268))]).
substitution(1290, [binding("x", ind)]).
proof(1290, a(ind, n270), rule(809), [uses(1289, a(ind, n269))]).
substitution(1291, [binding("x", ind)]).
proof(1291, a(ind, n271), rule(812), [uses(1290, a(ind, n270))]).
substitution(1292, [binding("x", ind)]).
proof(1292, a(ind, n272), rule(815), [uses(1291, a(ind, n271))]).
substitution(1293, [binding("x", ind)]).
proof(1293, a(ind, n273), rule(818), [uses(1292, a(ind, n272))]).
substitution(1294, [binding("x", ind)]).
proof(1294, a(ind, n274), rule(821), [uses(1293, a(ind, n273))]).
substitution(1295, [binding("x", ind)]).
proof(1295, a(ind, n275), rule(824), [uses(1294, a(ind, n274))]).
substitution(1296, [binding("x", ind)]).
proof(1296, a(ind, n276), rule(827), [uses(1295, a(ind, n275))]).
substitution(1297, [binding("x", ind)]).
proof(1297, a(ind, n277), rule(830), [uses(1296, a(ind, n276))]).
substitution(1298, [binding("x", ind)]).
proof(1298, a(ind, n278), rule(833), [uses(1297, a(ind, n277))]).
substitution(1299, [binding("x", ind)]).
proof(1299, a(ind, n279), rule(836), [uses(1298, a(ind, n278))]).
substitution(1300, [binding("x", ind)]).
proof(1300, a(ind, n280), rule(839), [uses(1299, a(ind, n279))]).
substitution(1301, [binding("x", ind)]).
proof(1301, a(ind, n281), rule(842), [uses(1300, a(ind, n280))]).
substitution(1302, [binding("x", ind)]).
proof(1302, a(ind, n282), rule(845), [uses(1301, a(ind, n281))]).
substitution(1303, [binding("x", ind)]).
proof(1303, a(ind, n283), rule(848), [uses(1302, a(ind, n282))]).
substitution(1304, [binding("x", ind)]).
proof(1304, a(ind, n284), rule(851), [uses(1303, a(ind, n283))]).
substitution(1305, [binding("x", ind)]).
proof(1305, a(ind, n285), rule(854), [uses(1304, a(ind, n284))]).
substitution(1306, [binding("x", ind)]).
proof(1306, a(ind, n286), rule(857), [uses(1305, a(ind, n285))]).
substitution(1307, [binding("x", ind)]).
proof(1307, a(ind, n287), rule(860), [uses(1306, a(ind, n286))]).
substitution(1308, [binding("x", ind)]).
proof(1308, a(ind, n288), rule(863), [uses(1307, a(ind, n287))]).
substitution(1309, [binding("x", ind)]).
proof(1309, a(ind, n289), rule(866), [uses(1308, a(ind, n288))]).
substitution(1310, [binding("x", ind)]).
proof(1310, a(ind, n290), rule(869), [uses(1309, a(ind, n289))]).
substitution(1311, [binding("x", ind)]).
proof(1311, a(ind, n291), rule(872), [uses(1310, a(ind, n290))]).
substitution(1312, [binding("x", ind)]).
proof(1312, a(ind, n292), rule(875), [uses(1311, a(ind, n291))]).
substitution(1313, [binding("x", ind)]).
proof(1313, a(ind, n293), rule(878), [uses(1312, a(ind, n292))]).
substitution(1314, [binding("x", ind)]).
proof(1314, a(ind, n294), rule(881), [uses(1313, a(ind, n293))]).
substitution(1315, [binding("x", ind)]).
proof(1315, a(ind, n295), rule(884), [uses(1314, a(ind, n294))]).
substitution(1316, [binding("x", ind)]).
proof(1316, a(ind, n296), rule(887), [uses(1315, a(ind, n295))]).
substitution(1317, [binding("x", ind)]).
proof(1317, a(ind, n297), rule(890), [uses(1316, a(ind, n296))]).
substitution(1318, [binding("x", ind)]).
proof(1318, a(ind, n298), rule(893), [uses(1317, a(ind, n297))]).
substitution(1319, [binding("x", ind)]).
proof(1319, a(ind, n299), rule(896), [uses(1318, a(ind, n298))]).
substitution(1320, [binding("x", ind)]).
proof(1320, a(ind, n300), rule(899), [uses(1319, a(ind, n299))]).
substitution(1321, [binding("x", ind)]).
proof(1321, a(ind, n301), rule(902), [uses(1320, a(ind, n300))]).
substitution(1322, [binding("x", ind)]).
proof(1322, a(ind, n302), rule(905), [uses(1321, a(ind, n301))]).
substitution(1323, [binding("x", ind)]).
proof(1323, a(ind, n303), rule(908), [uses(1322, a(ind, n302))]).
substitution(1324, [binding("x", ind)]).
proof(1324, a(ind, n304), rule(911), [uses(1323, a(ind, n303))]).
substitution(1325, [binding("x", ind)]).
proof(1325, a(ind, n305), rule(914), [uses(1324, a(ind, n304))]).
substitution(1326, [binding("x", ind)]).
proof(1326, a(ind, n306), rule(917), [uses(1325, a(ind, n305))]).
substitution(1327, [binding("x", ind)]).
proof(1327, a(ind, n307), rule(920), [uses(1326, a(ind, n306))]).
substitution(1328, [binding("x", ind)]).
proof(1328, a(ind, n308), rule(923), [uses(1327, a(ind, n307))]).
substitution(1329, [binding("x", ind)]).
proof(1329, a(ind, n309), rule(926), [uses(1328, a(ind, n308))]).
substitution(1330, [binding("x", ind)]).
proof(1330, a(ind, n310), rule(929), [uses(1329, a(ind, n309))]).
substitution(1331, [binding("x", ind)]).
proof(1331, a(ind, n311), rule(932), [uses(1330, a(ind, n310))]).
substitution(1332, [binding("x", ind)]).
proof(1332, a(ind, n312), rule(935), [uses(1331, a(ind, n311))]).
substitution(1333, [binding("x", ind)]).
proof(1333, a(ind, n313), rule(938), [uses(1332, a(ind, n312))]).
substitution(1334, [binding("x", ind)]).
proof(1334, a(ind, n314), rule(941), [uses(1333, a(ind, n313))]).
substitution(1335, [binding("x", ind)]).
proof(1335, a(ind, n315), rule(944), [uses(1334, a(ind, n314))]).
substitution(1336, [binding("x", ind)]).
proof(1336, a(ind, n316), rule(947), [uses(1335, a(ind, n315))]).
substitution(1337, [binding("x", ind)]).
proof(1337, a(ind, n317), rule(950), [uses(1336, a(ind, n316))]).
substitution(1338, [binding("x", ind)]).
proof(1338, a(ind, n318), rule(953), [uses(1337, a(ind, n317))]).
substitution(1339, [binding("x", ind)]).
proof(1339, a(ind, n319), rule(956), [uses(1338, a(ind, n318))]).
substitution(1340, [binding("x", ind)]).
proof(1340, a(ind, n320), rule(959), [uses(1339, a(ind, n319))]).
substitution(1341, [binding("x", ind)]).
proof(1341, a(ind, n321), rule(962), [uses(1340, a(ind, n320))]).
substitution(1342, [binding("x", ind)]).
proof(1342, a(ind, n322), rule(965), [uses(1341, a(ind, n321))]).
substitution(1343, [binding("x", ind)]).
proof(1343, a(ind, n323), rule(968), [uses(1342, a(ind, n322))]).
substitution(1344, [binding("x", ind)]).
proof(1344, a(ind, n324), rule(971), [uses(1343, a(ind, n323))]).
substitution(1345, [binding("x", ind)]).
proof(1345, a(ind, n325), rule(974), [uses(1344, a(ind, n324))]).
substitution(1346, [binding("x", ind)]).
proof(1346, a(ind, n326), rule(977), [uses(1345, a(ind, n325))]).
substitution(1347, [binding("x", ind)]).
proof(1347, a(ind, n327), rule(980), [uses(1346, a(ind, n326))]).
substitution(1348, [binding("x", ind)]).
proof(1348, a(ind, n328), rule(983), [uses(1347, a(ind, n327))]).
substitution(1349, [binding("x", ind)]).
proof(1349, a(ind, n329), rule(986), [uses(1348, a(ind, n328))]).
substitution(1350, [binding("x", ind)]).
proof(1350, a(ind, n330), rule(989), [uses(1349, a(ind, n329))]).
substitution(1351, [binding("x", ind)]).
proof(1351, a(ind, n331), rule(992), [uses(1350, a(ind, n330))]).
substitution(1352, [binding("x", ind)]).
proof(1352, a(ind, n332), rule(995), [uses(1351, a(ind, n331))]).
substitution(1353, [binding("x", ind)]).
proof(1353, a(ind, n333), rule(998), [uses(1352, a(ind, n332))]).
substitution(1354, [binding("x", ind)]).
proof(1354, a(ind, n334), rule(1001), [uses(1353, a(ind, n333))]).
substitution(1355, [binding("x", ind)]).
proof(1355, a(ind, n335), rule(1004), [uses(1354, a(ind, n334))]).
substitution(1356, [binding("x", ind)]).
proof(1356, a(ind, n336), rule(1007), [uses(1355, a(ind, n335))]).
substitution(1357, [binding("x", ind)]).
proof(1357, a(ind, n337), rule(1010), [uses(1356, a(ind, n336))]).
substitution(1358, [binding("x", ind)]).
proof(1358, a(ind, n338), rule(1013), [uses(1357, a(ind, n337))]).
substitution(1359, [binding("x", ind)]).
proof(1359, a(ind, n339), rule(1016), [uses(1358, a(ind, n338))]).
substitution(1360, [binding("x", ind)]).
proof(1360, a(ind, n340), rule(1019), [uses(1359, a(ind, n339))]).
substitution(1361, [binding("x", ind)]).
proof(1361, a(ind, n341), rule(1022), [uses(1360, a(ind, n340))]).
substitution(1362, [binding("x", ind)]).
proof(1362, a(ind, n342), rule(1025), [uses(1361, a(ind, n341))]).
substitution(1363, [binding("x", ind)]).
proof(1363, a(ind, n343), rule(1028), [uses(1362, a(ind, n342))]).
substitution(1364, [binding("x", ind)]).
proof(1364, a(ind, n344), rule(1031), [uses(1363, a(ind, n343))]).
substitution(1365, [binding("x", ind)]).
proof(1365, a(ind, n345), rule(1034), [uses(1364, a(ind, n344))]).
substitution(1366, [binding("x", ind)]).
proof(1366, a(ind, n346), rule(1037), [uses(1365, a(ind, n345))]).
substitution(1367, [binding("x", ind)]).
proof(1367, a(ind, n347), rule(1040), [uses(1366, a(ind, n346))]).
substitution(1368, [binding("x", ind)]).
proof(1368, a(ind, n348), rule(1043), [uses(1367, a(ind, n347))]).
substitution(1369, [binding("x", ind)]).
proof(1369, a(ind, n349), rule(1046), [uses(1368, a(ind, n348))]).
substitution(1370, [binding("x", ind)]).
proof(1370, a(ind, n350), rule(1049), [uses(1369, a(ind, n349))]).
substitution(1371, [binding("x", ind)]).
proof(1371, a(ind, n351), rule(1052), [uses(1370, a(ind, n350))]).
substitution(1372, [binding("x", ind)]).
proof(1372, a(ind, n352), rule(1055), [uses(1371, a(ind, n351))]).
substitution(1373, [binding("x", ind)]).
proof(1373, a(ind, n353), rule(1058), [uses(1372, a(ind, n352))]).
substitution(1374, [binding("x", ind)]).
proof(1374, a(ind, n354), rule(1061), [uses(1373, a(ind, n353))]).
substitution(1375, [binding("x", ind)]).
proof(1375, a(ind, n355), rule(1064), [uses(1374, a(ind, n354))]).
substitution(1376, [binding("x", ind)]).
proof(1376, a(ind, n356), rule(1067), [uses(1375, a(ind, n355))]).
substitution(1377, [binding("x", ind)]).
proof(1377, a(ind, n357), rule(1070), [uses(1376, a(ind, n356))]).
substitution(1378, [binding("x", ind)]).
proof(1378, a(ind, n358), rule(1073), [uses(1377, a(ind, n357))]).
substitution(1379, [binding("x", ind)]).
proof(1379, a(ind, n359), rule(1076), [uses(1378, a(ind, n358))]).
substitution(1380, [binding("x", ind)]).
proof(1380, a(ind, n360), rule(1079), [uses(1379, a(ind, n359))]).
substitution(1381, [binding("x", ind)]).
proof(1381, a(ind, n361), rule(1082), [uses(1380, a(ind, n360))]).
substitution(1382, [binding("x", ind)]).
proof(1382, a(ind, n362), rule(1085), [uses(1381, a(ind, n361))]).
substitution(1383, [binding("x", ind)]).
proof(1383, a(ind, n363), rule(1088), [uses(1382, a(ind, n362))]).
substitution(1384, [binding("x", ind)]).
proof(1384, a(ind, n364), rule(1091), [uses(1383, a(ind, n363))]).
substitution(1385, [binding("x", ind)]).
proof(1385, a(ind, n365), rule(1094), [uses(1384, a(ind, n364))]).
substitution(1386, [binding("x", ind)]).
proof(1386, a(ind, n366), rule(1097), [uses(1385, a(ind, n365))]).
substitution(1387, [binding("x", ind)]).
proof(1387, a(ind, n367), rule(1100), [uses(1386, a(ind, n366))]).
substitution(1388, [binding("x", ind)]).
proof(1388, a(ind, n368), rule(1103), [uses(1387, a(ind, n367))]).
substitution(1389, [binding("x", ind)]).
proof(1389, a(ind, n369), rule(1106), [uses(1388, a(ind, n368))]).
substitution(1390, [binding("x", ind)]).
proof(1390, a(ind, n370), rule(1109), [uses(1389, a(ind, n369))]).
substitution(1391, [binding("x", ind)]).
proof(1391, a(ind, n371), rule(1112), [uses(1390, a(ind, n370))]).
substitution(1392, [binding("x", ind)]).
proof(1392, a(ind, n372), rule(1115), [uses(1391, a(ind, n371))]).
substitution(1393, [binding("x", ind)]).
proof(1393, a(ind, n373), rule(1118), [uses(1392, a(ind, n372))]).
substitution(1394, [binding("x", ind)]).
proof(1394, a(ind, n374), rule(1121), [uses(1393, a(ind, n373))]).
substitution(1395, [binding("x", ind)]).
proof(1395, a(ind, n375), rule(1124), [uses(1394, a(ind, n374))]).
substitution(1396, [binding("x", ind)]).
proof(1396, a(ind, n376), rule(1127), [uses(1395, a(ind, n375))]).
substitution(1397, [binding("x", ind)]).
proof(1397, a(ind, n377), rule(1130), [uses(1396, a(ind, n376))]).
substitution(1398, [binding("x", ind)]).
proof(1398, a(ind, n378), rule(1133), [uses(1397, a(ind, n377))]).
substitution(1399, [binding("x", ind)]).
proof(1399, a(ind, n379), rule(1136), [uses(1398, a(ind, n378))]).
substitution(1400, [binding("x", ind)]).
proof(1400, a(ind, n380), rule(1139), [uses(1399, a(ind, n379))]).
substitution(1401, [binding("x", ind)]).
proof(1401, a(ind, n381), rule(1142), [uses(1400, a(ind, n380))]).
substitution(1402, [binding("x", ind)]).
proof(1402, a(ind, n382), rule(1145), [uses(1401, a(ind, n381))]).
substitution(1403, [binding("x", ind)]).
proof(1403, a(ind, n383), rule(1148), [uses(1402, a(ind, n382))]).
substitution(1404, [binding("x", ind)]).
proof(1404, a(ind, n384), rule(1151), [uses(1403, a(ind, n383))]).
substitution(1405, [binding("x", ind)]).
proof(1405, a(ind, n385), rule(1154), [uses(1404, a(ind, n384))]).
substitution(1406, [binding("x", ind)]).
proof(1406, a(ind, n386), rule(1157), [uses(1405, a(ind, n385))]).
substitution(1407, [binding("x", ind)]).
proof(1407, a(ind, n387), rule(1160), [uses(1406, a(ind, n386))]).
substitution(1408, [binding("x", ind)]).
proof(1408, a(ind, n388), rule(1163), [uses(1407, a(ind, n387))]).
substitution(1409, [binding("x", ind)]).
proof(1409, a(ind, n389), rule(1166), [uses(1408, a(ind, n388))]).
substitution(1410, [binding("x", ind)]).
proof(1410, a(ind, n390), rule(1169), [uses(1409, a(ind, n389))]).
substitution(1411, [binding("x", ind)]).
proof(1411, a(ind, n391), rule(1172), [uses(1410, a(ind, n390))]).
substitution(1412, [binding("x", ind)]).
proof(1412, a(ind, n392), rule(1175), [uses(1411, a(ind, n391))]).
substitution(1413, [binding("x", ind)]).
proof(1413, a(ind, n393), rule(1178), [uses(1412, a(ind, n392))]).
substitution(1414, [binding("x", ind)]).
proof(1414, a(ind, n394), rule(1181), [uses(1413, a(ind, n393))]).
substitution(1415, [binding("x", ind)]).
proof(1415, a(ind, n395), rule(1184), [uses(1414, a(ind, n394))]).
substitution(1416, [binding("x", ind)]).
proof(1416, a(ind, n396), rule(1187), [uses(1415, a(ind, n395))]).
substitution(1417, [binding("x", ind)]).
proof(1417, a(ind, n397), rule(1190), [uses(1416, a(ind, n396))]).
substitution(1418, [binding("x", ind)]).
proof(1418, a(ind, n398), rule(1193), [uses(1417, a(ind, n397))]).
substitution(1419, [binding("x", ind)]).
proof(1419, a(ind, n399), rule(1196), [uses(1418, a(ind, n398))]).
substitution(1420, [binding("x", ind)]).
proof(1420, a(ind, n400), rule(1199), [uses(1419, a(ind, n399))]).
substitution(1421, [binding("x", ind)]).
proof(1421, a(ind, n401), rule(1202), [uses(1420, a(ind, n400))]).
substitution(1422, [binding("x", ind)]).
proof(1422, a(ind, n402), rule(1205), [uses(1421, a(ind, n401))]).
substitution(1423, [binding("x", ind)]).
proof(1423, a(ind, n403), rule(1208), [uses(1422, a(ind, n402))]).
substitution(1424, [binding("x", ind)]).
proof(1424, a(ind, n404), rule(1211), [uses(1423, a(ind, n403))]).
substitution(1425, [binding("x", ind)]).
proof(1425, a(ind, n405), rule(1214), [uses(1424, a(ind, n404))]).
substitution(1426, [binding("x", ind)]).
proof(1426, a(ind, n406), rule(1217), [uses(1425, a(ind, n405))]).
substitution(1427, [binding("x", ind)]).
proof(1427, a(ind, n407), rule(1220), [uses(1426, a(ind, n406))]).
substitution(1428, [binding("x", ind)]).
proof(1428, a(ind, n408), rule(1223), [uses(1427, a(ind, n407))]).
substitution(1429, [binding("x", ind)]).
proof(1429, a(ind, n409), rule(1226), [uses(1428, a(ind, n408))]).
substitution(1430, [binding("x", ind)]).
proof(1430, a(ind, n410), rule(1229), [uses(1429, a(ind, n409))]).
substitution(1431, [binding("x", ind)]).
proof(1431, a(ind, n411), rule(1232), [uses(1430, a(ind, n410))]).
substitution(1432, [binding("x", ind)]).
proof(1432, a(ind, n412), rule(1235), [uses(1431, a(ind, n411))]).
substitution(1433, [binding("x", ind)]).
proof(1433, a(ind, n413), rule(1238), [uses(1432, a(ind, n412))]).
substitution(1434, [binding("x", ind)]).
proof(1434, a(ind, n414), rule(1241), [uses(1433, a(ind, n413))]).
substitution(1435, [binding("x", ind)]).
proof(1435, a(ind, n415), rule(1244), [uses(1434, a(ind, n414))]).
substitution(1436, [binding("x", ind)]).
proof(1436, a(ind, n416), rule(1247), [uses(1435, a(ind, n415))]).
substitution(1437, [binding("x", ind)]).
proof(1437, a(ind, n417), rule(1250), [uses(1436, a(ind, n416))]).
substitution(1438, [binding("x", ind)]).
proof(1438, a(ind, n418), rule(1253), [uses(1437, a(ind, n417))]).
substitution(1439, [binding("x", ind)]).
proof(1439, a(ind, n419), rule(1256), [uses(1438, a(ind, n418))]).
substitution(1440, [binding("x", ind)]).
proof(1440, a(ind, n420), rule(1259), [uses(1439, a(ind, n419))]).
substitution(1441, [binding("x", ind)]).
proof(1441, a(ind, n421), rule(1262), [uses(1440, a(ind, n420))]).
substitution(1442, [binding("x", ind)]).
proof(1442, a(ind, n422), rule(1265), [uses(1441, a(ind, n421))]).
substitution(1443, [binding("x", ind)]).
proof(1443, a(ind, n423), rule(1268), [uses(1442, a(ind, n422))]).
substitution(1444, [binding("x", ind)]).
proof(1444, a(ind, n424), rule(1271), [uses(1443, a(ind, n423))]).
substitution(1445, [binding("x", ind)]).
proof(1445, a(ind, n425), rule(1274), [uses(1444, a(ind, n424))]).
substitution(1446, [binding("x", ind)]).
proof(1446, a(ind, n426), rule(1277), [uses(1445, a(ind, n425))]).
substitution(1447, [binding("x", ind)]).
proof(1447, a(ind, n427), rule(1280), [uses(1446, a(ind, n426))]).
substitution(1448, [binding("x", ind)]).
proof(1448, a(ind, n428), rule(1283), [uses(1447, a(ind, n427))]).
substitution(1449, [binding("x", ind)]).
proof(1449, a(ind, n429), rule(1286), [uses(1448, a(ind, n428))]).
substitution(1450, [binding("x", ind)]).
proof(1450, a(ind, n430), rule(1289), [uses(1449, a(ind, n429))]).
substitution(1451, [binding("x", ind)]).
proof(1451, a(ind, n431), rule(1292), [uses(1450, a(ind, n430))]).
substitution(1452, [binding("x", ind)]).
proof(1452, a(ind, n432), rule(1295), [uses(1451, a(ind, n431))]).
substitution(1453, [binding("x", ind)]).
proof(1453, a(ind, n433), rule(1298), [uses(1452, a(ind, n432))]).
substitution(1454, [binding("x", ind)]).
proof(1454, a(ind, n434), rule(1301), [uses(1453, a(ind, n433))]).
substitution(1455, [binding("x", ind)]).
proof(1455, a(ind, n435), rule(1304), [uses(1454, a(ind, n434))]).
substitution(1456, [binding("x", ind)]).
proof(1456, a(ind, n436), rule(1307), [uses(1455, a(ind, n435))]).
substitution(1457, [binding("x", ind)]).
proof(1457, a(ind, n437), rule(1310), [uses(1456, a(ind, n436))]).
substitution(1458, [binding("x", ind)]).
proof(1458, a(ind, n438), rule(1313), [uses(1457, a(ind, n437))]).
substitution(1459, [binding("x", ind)]).
proof(1459, a(ind, n439), rule(1316), [uses(1458, a(ind, n438))]).
substitution(1460, [binding("x", ind)]).
proof(1460, a(ind, n440), rule(1319), [uses(1459, a(ind, n439))]).
substitution(1461, [binding("x", ind)]).
proof(1461, a(ind, n441), rule(1322), [uses(1460, a(ind, n440))]).
substitution(1462, [binding("x", ind)]).
proof(1462, a(ind, n442), rule(1325), [uses(1461, a(ind, n441))]).
substitution(1463, [binding("x", ind)]).
proof(1463, a(ind, n443), rule(1328), [uses(1462, a(ind, n442))]).
substitution(1464, [binding("x", ind)]).
proof(1464, a(ind, n444), rule(1331), [uses(1463, a(ind, n443))]).
substitution(1465, [binding("x", ind)]).
proof(1465, a(ind, n445), rule(1334), [uses(1464, a(ind, n444))]).
substitution(1466, [binding("x", ind)]).
proof(1466, a(ind, n446), rule(1337), [uses(1465, a(ind, n445))]).
substitution(1467, [binding("x", ind)]).
proof(1467, a(ind, n447), rule(1340), [uses(1466, a(ind, n446))]).
substitution(1468, [binding("x", ind)]).
proof(1468, a(ind, n448), rule(1343), [uses(1467, a(ind, n447))]).
substitution(1469, [binding("x", ind)]).
proof(1469, a(ind, n449), rule(1346), [uses(1468, a(ind, n448))]).
substitution(1470, [binding("x", ind)]).
proof(1470, a(ind, n450), rule(1349), [uses(1469, a(ind, n449))]).
substitution(1471, [binding("x", ind)]).
proof(1471, a(ind, n451), rule(1352), [uses(1470, a(ind, n450))]).
substitution(1472, [binding("x", ind)]).
proof(1472, a(ind, n452), rule(1355), [uses(1471, a(ind, n451))]).
substitution(1473, [binding("x", ind)]).
proof(1473, a(ind, n453), rule(1358), [uses(1472, a(ind, n452))]).
substitution(1474, [binding("x", ind)]).
proof(1474, a(ind, n454), rule(1361), [uses(1473, a(ind, n453))]).
substitution(1475, [binding("x", ind)]).
proof(1475, a(ind, n455), rule(1364), [uses(1474, a(ind, n454))]).
substitution(1476, [binding("x", ind)]).
proof(1476, a(ind, n456), rule(1367), [uses(1475, a(ind, n455))]).
substitution(1477, [binding("x", ind)]).
proof(1477, a(ind, n457), rule(1370), [uses(1476, a(ind, n456))]).
substitution(1478, [binding("x", ind)]).
proof(1478, a(ind, n458), rule(1373), [uses(1477, a(ind, n457))]).
substitution(1479, [binding("x", ind)]).
proof(1479, a(ind, n459), rule(1376), [uses(1478, a(ind, n458))]).
substitution(1480, [binding("x", ind)]).
proof(1480, a(ind, n460), rule(1379), [uses(1479, a(ind, n459))]).
substitution(1481, [binding("x", ind)]).
proof(1481, a(ind, n461), rule(1382), [uses(1480, a(ind, n460))]).
substitution(1482, [binding("x", ind)]).
proof(1482, a(ind, n462), rule(1385), [uses(1481, a(ind, n461))]).
substitution(1483, [binding("x", ind)]).
proof(1483, a(ind, n463), rule(1388), [uses(1482, a(ind, n462))]).
substitution(1484, [binding("x", ind)]).
proof(1484, a(ind, n464), rule(1391), [uses(1483, a(ind, n463))]).
substitution(1485, [binding("x", ind)]).
proof(1485, a(ind, n465), rule(1394), [uses(1484, a(ind, n464))]).
substitution(1486, [binding("x", ind)]).
proof(1486, a(ind, n466), rule(1397), [uses(1485, a(ind, n465))]).
substitution(1487, [binding("x", ind)]).
proof(1487, a(ind, n467), rule(1400), [uses(1486, a(ind, n466))]).
substitution(1488, [binding("x", ind)]).
proof(1488, a(ind, n468), rule(1403), [uses(1487, a(ind, n467))]).
substitution(1489, [binding("x", ind)]).
proof(1489, a(ind, n469), rule(1406), [uses(1488, a(ind, n468))]).
substitution(1490, [binding("x", ind)]).
proof(1490, a(ind, n470), rule(1409), [uses(1489, a(ind, n469))]).
substitution(1491, [binding("x", ind)]).
proof(1491, a(ind, n471), rule(1412), [uses(1490, a(ind, n470))]).
substitution(1492, [binding("x", ind)]).
proof(1492, a(ind, n472), rule(1415), [uses(1491, a(ind, n471))]).
substitution(1493, [binding("x", ind)]).
proof(1493, a(ind, n473), rule(1418), [uses(1492, a(ind, n472))]).
substitution(1494, [binding("x", ind)]).
proof(1494, a(ind, n474), rule(1421), [uses(1493, a(ind, n473))]).
substitution(1495, [binding("x", ind)]).
proof(1495, a(ind, n475), rule(1424), [uses(1494, a(ind, n474))]).
substitution(1496, [binding("x", ind)]).
proof(1496, a(ind, n476), rule(1427), [uses(1495, a(ind, n475))]).
substitution(1497, [binding("x", ind)]).
proof(1497, a(ind, n477), rule(1430), [uses(1496, a(ind, n476))]).
substitution(1498, [binding("x", ind)]).
proof(1498, a(ind, n478), rule(1433), [uses(1497, a(ind, n477))]).
substitution(1499, [binding("x", ind)]).
proof(1499, a(ind, n479), rule(1436), [uses(1498, a(ind, n478))]).
substitution(1500, [binding("x", ind)]).
proof(1500, a(ind, n480), rule(1439), [uses(1499, a(ind, n479))]).
substitution(1501, [binding("x", ind)]).
proof(1501, a(ind, n481), rule(1442), [uses(1500, a(ind, n480))]).
substitution(1502, [binding("x", ind)]).
proof(1502, a(ind, n482), rule(1445), [uses(1501, a(ind, n481))]).
substitution(1503, [binding("x", ind)]).
proof(1503, a(ind, n483), rule(1448), [uses(1502, a(ind, n482))]).
substitution(1504, [binding("x", ind)]).
proof(1504, a(ind, n484), rule(1451), [uses(1503, a(ind, n483))]).
substitution(1505, [binding("x", ind)]).
proof(1505, a(ind, n485), rule(1454), [uses(1504, a(ind, n484))]).
substitution(1506, [binding("x", ind)]).
proof(1506, a(ind, n486), rule(1457), [uses(1505, a(ind, n485))]).
substitution(1507, [binding("x", ind)]).
proof(1507, a(ind, n487), rule(1460), [uses(1506, a(ind, n486))]).
substitution(1508, [binding("x", ind)]).
proof(1508, a(ind, n488), rule(1463), [uses(1507, a(ind, n487))]).
substitution(1509, [binding("x", ind)]).
proof(1509, a(ind, n489), rule(1466), [uses(1508, a(ind, n488))]).
substitution(1510, [binding("x", ind)]).
proof(1510, a(ind, n490), rule(1469), [uses(1509, a(ind, n489))]).
substitution(1511, [binding("x", ind)]).
proof(1511, a(ind, n491), rule(1472), [uses(1510, a(ind, n490))]).
substitution(1512, [binding("x", ind)]).
proof(1512, a(ind, n492), rule(1475), [uses(1511, a(ind, n491))]).
substitution(1513, [binding("x", ind)]).
proof(1513, a(ind, n493), rule(1478), [uses(1512, a(ind, n492))]).
substitution(1514, [binding("x", ind)]).
proof(1514, a(ind, n494), rule(1481), [uses(1513, a(ind, n493))]).
substitution(1515, [binding("x", ind)]).
proof(1515, a(ind, n495), rule(1484), [uses(1514, a(ind, n494))]).
substitution(1516, [binding("x", ind)]).
proof(1516, a(ind, n496), rule(1487), [uses(1515, a(ind, n495))]).
substitution(1517, [binding("x", ind)]).
proof(1517, a(ind, n497), rule(1490), [uses(1516, a(ind, n496))]).
substitution(1518, [binding("x", ind)]).
proof(1518, a(ind, n498), rule(1493), [uses(1517, a(ind, n497))]).
substitution(1519, [binding("x", ind)]).
proof(1519, a(ind, n499), rule(1496), [uses(1518, a(ind, n498))]).
substitution(1520, [binding("x", ind)]).
proof(1520, a(ind, n500), rule(1499), [uses(1519, a(ind, n499))]).
substitution(1521, [binding("x", ind)]).
proof(1521, a(ind, n501), rule(1502), [uses(1520, a(ind, n500))]).
substitution(1522, [binding("x", ind)]).
proof(1522, a(ind, n502), rule(1505), [uses(1521, a(ind, n501))]).
substitution(1523, [binding("x", ind)]).
proof(1523, a(ind, n503), rule(1508), [uses(1522, a(ind, n502))]).
substitution(1524, [binding("x", ind)]).
proof(1524, a(ind, n504), rule(1511), [uses(1523, a(ind, n503))]).
substitution(1525, [binding("x", ind)]).
proof(1525, a(ind, n505), rule(1514), [uses(1524, a(ind, n504))]).
substitution(1526, [binding("x", ind)]).
proof(1526, a(ind, n506), rule(1517), [uses(1525, a(ind, n505))]).
substitution(1527, [binding("x", ind)]).
proof(1527, a(ind, n507), rule(1520), [uses(1526, a(ind, n506))]).
substitution(1528, [binding("x", ind)]).
proof(1528, a(ind, n508), rule(1523), [uses(1527, a(ind, n507))]).
substitution(1529, [binding("x", ind)]).
proof(1529, a(ind, n509), rule(1526), [uses(1528, a(ind, n508))]).
substitution(1530, [binding("x", ind)]).
proof(1530, a(ind, n510), rule(1529), [uses(1529, a(ind, n509))]).
substitution(1531, [binding("x", ind)]).
proof(1531, a(ind, n511), rule(1532), [uses(1530, a(ind, n510))]).
substitution(1532, [binding("x", ind)]).
proof(1532, a(ind, n512), rule(1535), [uses(1531, a(ind, n511))]).
substitution(1533, [binding("x", ind)]).
proof(1533, a(ind, n513), rule(1538), [uses(1532, a(ind, n512))]).
substitution(1534, [binding("x", ind)]).
proof(1534, a(ind, n514), rule(1541), [uses(1533, a(ind, n513))]).
substitution(1535, [binding("x", ind)]).
proof(1535, a(ind, n515), rule(1544), [uses(1534, a(ind, n514))]).
substitution(1536, [binding("x", ind)]).
proof(1536, a(ind, n516), rule(1547), [uses(1535, a(ind, n515))]).
substitution(1537, [binding("x", ind)]).
proof(1537, a(ind, n517), rule(1550), [uses(1536, a(ind, n516))]).
substitution(1538, [binding("x", ind)]).
proof(1538, a(ind, n518), rule(1553), [uses(1537, a(ind, n517))]).
substitution(1539, [binding("x", ind)]).
proof(1539, a(ind, n519), rule(1556), [uses(1538, a(ind, n518))]).
substitution(1540, [binding("x", ind)]).
proof(1540, a(ind, n520), rule(1559), [uses(1539, a(ind, n519))]).
substitution(1541, [binding("x", ind)]).
proof(1541, a(ind, n521), rule(1562), [uses(1540, a(ind, n520))]).
substitution(1542, [binding("x", ind)]).
proof(1542, a(ind, n522), rule(1565), [uses(1541, a(ind, n521))]).
substitution(1543, [binding("x", ind)]).
proof(1543, a(ind, n523), rule(1568), [uses(1542, a(ind, n522))]).
substitution(1544, [binding("x", ind)]).
proof(1544, a(ind, n524), rule(1571), [uses(1543, a(ind, n523))]).
substitution(1545, [binding("x", ind)]).
proof(1545, a(ind, n525), rule(1574), [uses(1544, a(ind, n524))]).
substitution(1546, [binding("x", ind)]).
proof(1546, a(ind, n526), rule(1577), [uses(1545, a(ind, n525))]).
substitution(1547, [binding("x", ind)]).
proof(1547, a(ind, n527), rule(1580), [uses(1546, a(ind, n526))]).
substitution(1548, [binding("x", ind)]).
proof(1548, a(ind, n528), rule(1583), [uses(1547, a(ind, n527))]).
substitution(1549, [binding("x", ind)]).
proof(1549, a(ind, n529), rule(1586), [uses(1548, a(ind, n528))]).
substitution(1550, [binding("x", ind)]).
proof(1550, a(ind, n530), rule(1589), [uses(1549, a(ind, n529))]).
substitution(1551, [binding("x", ind)]).
proof(1551, a(ind, n531), rule(1592), [uses(1550, a(ind, n530))]).
substitution(1552, [binding("x", ind)]).
proof(1552, a(ind, n532), rule(1595), [uses(1551, a(ind, n531))]).
substitution(1553, [binding("x", ind)]).
proof(1553, a(ind, n533), rule(1598), [uses(1552, a(ind, n532))]).
substitution(1554, [binding("x", ind)]).
proof(1554, a(ind, n534), rule(1601), [uses(1553, a(ind, n533))]).
substitution(1555, [binding("x", ind)]).
proof(1555, a(ind, n535), rule(1604), [uses(1554, a(ind, n534))]).
substitution(1556, [binding("x", ind)]).
proof(1556, a(ind, n536), rule(1607), [uses(1555, a(ind, n535))]).
substitution(1557, [binding("x", ind)]).
proof(1557, a(ind, n537), rule(1610), [uses(1556, a(ind, n536))]).
substitution(1558, [binding("x", ind)]).
proof(1558, a(ind, n538), rule(1613), [uses(1557, a(ind, n537))]).
substitution(1559, [binding("x", ind)]).
proof(1559, a(ind, n539), rule(1616), [uses(1558, a(ind, n538))]).
substitution(1560, [binding("x", ind)]).
proof(1560, a(ind, n540), rule(1619), [uses(1559, a(ind, n539))]).
substitution(1561, [binding("x", ind)]).
proof(1561, a(ind, n541), rule(1622), [uses(1560, a(ind, n540))]).
substitution(1562, [binding("x", ind)]).
proof(1562, a(ind, n542), rule(1625), [uses(1561, a(ind, n541))]).
substitution(1563, [binding("x", ind)]).
proof(1563, a(ind, n543), rule(1628), [uses(1562, a(ind, n542))]).
substitution(1564, [binding("x", ind)]).
proof(1564, a(ind, n544), rule(1631), [uses(1563, a(ind, n543))]).
substitution(1565, [binding("x", ind)]).
proof(1565, a(ind, n545), rule(1634), [uses(1564, a(ind, n544))]).
substitution(1566, [binding("x", ind)]).
proof(1566, a(ind, n546), rule(1637), [uses(1565, a(ind, n545))]).
substitution(1567, [binding("x", ind)]).
proof(1567, a(ind, n547), rule(1640), [uses(1566, a(ind, n546))]).
substitution(1568, [binding("x", ind)]).
proof(1568, a(ind, n548), rule(1643), [uses(1567, a(ind, n547))]).
substitution(1569, [binding("x", ind)]).
proof(1569, a(ind, n549), rule(1646), [uses(1568, a(ind, n548))]).
substitution(1570, [binding("x", ind)]).
proof(1570, a(ind, n550), rule(1649), [uses(1569, a(ind, n549))]).
substitution(1571, [binding("x", ind)]).
proof(1571, a(ind, n551), rule(1652), [uses(1570, a(ind, n550))]).
substitution(1572, [binding("x", ind)]).
proof(1572, a(ind, n552), rule(1655), [uses(1571, a(ind, n551))]).
substitution(1573, [binding("x", ind)]).
proof(1573, a(ind, n553), rule(1658), [uses(1572, a(ind, n552))]).
substitution(1574, [binding("x", ind)]).
proof(1574, a(ind, n554), rule(1661), [uses(1573, a(ind, n553))]).
substitution(1575, [binding("x", ind)]).
proof(1575, a(ind, n555), rule(1664), [uses(1574, a(ind, n554))]).
substitution(1576, [binding("x", ind)]).
proof(1576, a(ind, n556), rule(1667), [uses(1575, a(ind, n555))]).
substitution(1577, [binding("x", ind)]).
proof(1577, a(ind, n557), rule(1670), [uses(1576, a(ind, n556))]).
substitution(1578, [binding("x", ind)]).
proof(1578, a(ind, n558), rule(1673), [uses(1577, a(ind, n557))]).
substitution(1579, [binding("x", ind)]).
proof(1579, a(ind, n559), rule(1676), [uses(1578, a(ind, n558))]).
substitution(1580, [binding("x", ind)]).
proof(1580, a(ind, n560), rule(1679), [uses(1579, a(ind, n559))]).
substitution(1581, [binding("x", ind)]).
proof(1581, a(ind, n561), rule(1682), [uses(1580, a(ind, n560))]).
substitution(1582, [binding("x", ind)]).
proof(1582, a(ind, n562), rule(1685), [uses(1581, a(ind, n561))]).
substitution(1583, [binding("x", ind)]).
proof(1583, a(ind, n563), rule(1688), [uses(1582, a(ind, n562))]).
substitution(1584, [binding("x", ind)]).
proof(1584, a(ind, n564), rule(1691), [uses(1583, a(ind, n563))]).
substitution(1585, [binding("x", ind)]).
proof(1585, a(ind, n565), rule(1694), [uses(1584, a(ind, n564))]).
substitution(1586, [binding("x", ind)]).
proof(1586, a(ind, n566), rule(1697), [uses(1585, a(ind, n565))]).
substitution(1587, [binding("x", ind)]).
proof(1587, a(ind, n567), rule(1700), [uses(1586, a(ind, n566))]).
substitution(1588, [binding("x", ind)]).
proof(1588, a(ind, n568), rule(1703), [uses(1587, a(ind, n567))]).
substitution(1589, [binding("x", ind)]).
proof(1589, a(ind, n569), rule(1706), [uses(1588, a(ind, n568))]).
substitution(1590, [binding("x", ind)]).
proof(1590, a(ind, n570), rule(1709), [uses(1589, a(ind, n569))]).
substitution(1591, [binding("x", ind)]).
proof(1591, a(ind, n571), rule(1712), [uses(1590, a(ind, n570))]).
substitution(1592, [binding("x", ind)]).
proof(1592, a(ind, n572), rule(1715), [uses(1591, a(ind, n571))]).
substitution(1593, [binding("x", ind)]).
proof(1593, a(ind, n573), rule(1718), [uses(1592, a(ind, n572))]).
substitution(1594, [binding("x", ind)]).
proof(1594, a(ind, n574), rule(1721), [uses(1593, a(ind, n573))]).
substitution(1595, [binding("x", ind)]).
proof(1595, a(ind, n575), rule(1724), [uses(1594, a(ind, n574))]).
substitution(1596, [binding("x", ind)]).
proof(1596, a(ind, n576), rule(1727), [uses(1595, a(ind, n575))]).
substitution(1597, [binding("x", ind)]).
proof(1597, a(ind, n577), rule(1730), [uses(1596, a(ind, n576))]).
substitution(1598, [binding("x", ind)]).
proof(1598, a(ind, n578), rule(1733), [uses(1597, a(ind, n577))]).
substitution(1599, [binding("x", ind)]).
proof(1599, a(ind, n579), rule(1736), [uses(1598, a(ind, n578))]).
substitution(1600, [binding("x", ind)]).
proof(1600, a(ind, n580), rule(1739), [uses(1599, a(ind, n579))]).
substitution(1601, [binding("x", ind)]).
proof(1601, a(ind, n581), rule(1742), [uses(1600, a(ind, n580))]).
substitution(1602, [binding("x", ind)]).
proof(1602, a(ind, n582), rule(1745), [uses(1601, a(ind, n581))]).
substitution(1603, [binding("x", ind)]).
proof(1603, a(ind, n583), rule(1748), [uses(1602, a(ind, n582))]).
substitution(1604, [binding("x", ind)]).
proof(1604, a(ind, n584), rule(1751), [uses(1603, a(ind, n583))]).
substitution(1605, [binding("x", ind)]).
proof(1605, a(ind, n585), rule(1754), [uses(1604, a(ind, n584))]).
substitution(1606, [binding("x", ind)]).
proof(1606, a(ind, n586), rule(1757), [uses(1605, a(ind, n585))]).
substitution(1607, [binding("x", ind)]).
proof(1607, a(ind, n587), rule(1760), [uses(1606, a(ind, n586))]).
substitution(1608, [binding("x", ind)]).
proof(1608, a(ind, n588), rule(1763), [uses(1607, a(ind, n587))]).
substitution(1609, [binding("x", ind)]).
proof(1609, a(ind, n589), rule(1766), [uses(1608, a(ind, n588))]).
substitution(1610, [binding("x", ind)]).
proof(1610, a(ind, n590), rule(1769), [uses(1609, a(ind, n589))]).
substitution(1611, [binding("x", ind)]).
proof(1611, a(ind, n591), rule(1772), [uses(1610, a(ind, n590))]).
substitution(1612, [binding("x", ind)]).
proof(1612, a(ind, n592), rule(1775), [uses(1611, a(ind, n591))]).
substitution(1613, [binding("x", ind)]).
proof(1613, a(ind, n593), rule(1778), [uses(1612, a(ind, n592))]).
substitution(1614, [binding("x", ind)]).
proof(1614, a(ind, n594), rule(1781), [uses(1613, a(ind, n593))]).
substitution(1615, [binding("x", ind)]).
proof(1615, a(ind, n595), rule(1784), [uses(1614, a(ind, n594))]).
substitution(1616, [binding("x", ind)]).
proof(1616, a(ind, n596), rule(1787), [uses(1615, a(ind, n595))]).
substitution(1617, [binding("x", ind)]).
proof(1617, a(ind, n597), rule(1790), [uses(1616, a(ind, n596))]).
substitution(1618, [binding("x", ind)]).
proof(1618, a(ind, n598), rule(1793), [uses(1617, a(ind, n597))]).
substitution(1619, [binding("x", ind)]).
proof(1619, a(ind, n599), rule(1796), [uses(1618, a(ind, n598))]).
substitution(1620, [binding("x", ind)]).
proof(1620, a(ind, n600), rule(1799), [uses(1619, a(ind, n599))]).
substitution(1621, [binding("x", ind)]).
proof(1621, a(ind, n601), rule(1802), [uses(1620, a(ind, n600))]).
substitution(1622, [binding("x", ind)]).
proof(1622, a(ind, n602), rule(1805), [uses(1621, a(ind, n601))]).
substitution(1623, [binding("x", ind)]).
proof(1623, a(ind, n603), rule(1808), [uses(1622, a(ind, n602))]).
substitution(1624, [binding("x", ind)]).
proof(1624, a(ind, n604), rule(1811), [uses(1623, a(ind, n603))]).
substitution(1625, [binding("x", ind)]).
proof(1625, a(ind, n605), rule(1814), [uses(1624, a(ind, n604))]).
substitution(1626, [binding("x", ind)]).
proof(1626, a(ind, n606), rule(1817), [uses(1625, a(ind, n605))]).
substitution(1627, [binding("x", ind)]).
proof(1627, a(ind, n607), rule(1820), [uses(1626, a(ind, n606))]).
substitution(1628, [binding("x", ind)]).
proof(1628, a(ind, n608), rule(1823), [uses(1627, a(ind, n607))]).
substitution(1629, [binding("x", ind)]).
proof(1629, a(ind, n609), rule(1826), [uses(1628, a(ind, n608))]).
substitution(1630, [binding("x", ind)]).
proof(1630, a(ind, n610), rule(1829), [uses(1629, a(ind, n609))]).
substitution(1631, [binding("x", ind)]).
proof(1631, a(ind, n611), rule(1832), [uses(1630, a(ind, n610))]).
substitution(1632, [binding("x", ind)]).
proof(1632, a(ind, n612), rule(1835), [uses(1631, a(ind, n611))]).
substitution(1633, [binding("x", ind)]).
proof(1633, a(ind, n613), rule(1838), [uses(1632, a(ind, n612))]).
substitution(1634, [binding("x", ind)]).
proof(1634, a(ind, n614), rule(1841), [uses(1633, a(ind, n613))]).
substitution(1635, [binding("x", ind)]).
proof(1635, a(ind, n615), rule(1844), [uses(1634, a(ind, n614))]).
substitution(1636, [binding("x", ind)]).
proof(1636, a(ind, n616), rule(1847), [uses(1635, a(ind, n615))]).
substitution(1637, [binding("x", ind)]).
proof(1637, a(ind, n617), rule(1850), [uses(1636, a(ind, n616))]).
substitution(1638, [binding("x", ind)]).
proof(1638, a(ind, n618), rule(1853), [uses(1637, a(ind, n617))]).
substitution(1639, [binding("x", ind)]).
proof(1639, a(ind, n619), rule(1856), [uses(1638, a(ind, n618))]).
substitution(1640, [binding("x", ind)]).
proof(1640, a(ind, n620), rule(1859), [uses(1639, a(ind, n619))]).
substitution(1641, [binding("x", ind)]).
proof(1641, a(ind, n621), rule(1862), [uses(1640, a(ind, n620))]).
substitution(1642, [binding("x", ind)]).
proof(1642, a(ind, n622), rule(1865), [uses(1641, a(ind, n621))]).
substitution(1643, [binding("x", ind)]).
proof(1643, a(ind, n623), rule(1868), [uses(1642, a(ind, n622))]).
substitution(1644, [binding("x", ind)]).
proof(1644, a(ind, n624), rule(1871), [uses(1643, a(ind, n623))]).
substitution(1645, [binding("x", ind)]).
proof(1645, a(ind, n625), rule(1874), [uses(1644, a(ind, n624))]).
substitution(1646, [binding("x", ind)]).
proof(1646, a(ind, n626), rule(1877), [uses(1645, a(ind, n625))]).
substitution(1647, [binding("x", ind)]).
proof(1647, a(ind, n627), rule(1880), [uses(1646, a(ind, n626))]).
substitution(1648, [binding("x", ind)]).
proof(1648, a(ind, n628), rule(1883), [uses(1647, a(ind, n627))]).
substitution(1649, [binding("x", ind)]).
proof(1649, a(ind, n629), rule(1886), [uses(1648, a(ind, n628))]).
substitution(1650, [binding("x", ind)]).
proof(1650, a(ind, n630), rule(1889), [uses(1649, a(ind, n629))]).
substitution(1651, [binding("x", ind)]).
proof(1651, a(ind, n631), rule(1892), [uses(1650, a(ind, n630))]).
substitution(1652, [binding("x", ind)]).
proof(1652, a(ind, n632), rule(1895), [uses(1651, a(ind, n631))]).
substitution(1653, [binding("x", ind)]).
proof(1653, a(ind, n633), rule(1898), [uses(1652, a(ind, n632))]).
substitution(1654, [binding("x", ind)]).
proof(1654, a(ind, n634), rule(1901), [uses(1653, a(ind, n633))]).
substitution(1655, [binding("x", ind)]).
proof(1655, a(ind, n635), rule(1904), [uses(1654, a(ind, n634))]).
substitution(1656, [binding("x", ind)]).
proof(1656, a(ind, n636), rule(1907), [uses(1655, a(ind, n635))]).
substitution(1657, [binding("x", ind)]).
proof(1657, a(ind, n637), rule(1910), [uses(1656, a(ind, n636))]).
substitution(1658, [binding("x", ind)]).
proof(1658, a(ind, n638), rule(1913), [uses(1657, a(ind, n637))]).
substitution(1659, [binding("x", ind)]).
proof(1659, a(ind, n639), rule(1916), [uses(1658, a(ind, n638))]).
substitution(1660, [binding("x", ind)]).
proof(1660, a(ind, n640), rule(1919), [uses(1659, a(ind, n639))]).
substitution(1661, [binding("x", ind)]).
proof(1661, a(ind, n641), rule(1922), [uses(1660, a(ind, n640))]).
substitution(1662, [binding("x", ind)]).
proof(1662, a(ind, n642), rule(1925), [uses(1661, a(ind, n641))]).
substitution(1663, [binding("x", ind)]).
proof(1663, a(ind, n643), rule(1928), [uses(1662, a(ind, n642))]).
substitution(1664, [binding("x", ind)]).
proof(1664, a(ind, n644), rule(1931), [uses(1663, a(ind, n643))]).
substitution(1665, [binding("x", ind)]).
proof(1665, a(ind, n645), rule(1934), [uses(1664, a(ind, n644))]).
substitution(1666, [binding("x", ind)]).
proof(1666, a(ind, n646), rule(1937), [uses(1665, a(ind, n645))]).
substitution(1667, [binding("x", ind)]).
proof(1667, a(ind, n647), rule(1940), [uses(1666, a(ind, n646))]).
substitution(1668, [binding("x", ind)]).
proof(1668, a(ind, n648), rule(1943), [uses(1667, a(ind, n647))]).
substitution(1669, [binding("x", ind)]).
proof(1669, a(ind, n649), rule(1946), [uses(1668, a(ind, n648))]).
substitution(1670, [binding("x", ind)]).
proof(1670, a(ind, n650), rule(1949), [uses(1669, a(ind, n649))]).
substitution(1671, [binding("x", ind)]).
proof(1671, a(ind, n651), rule(1952), [uses(1670, a(ind, n650))]).
substitution(1672, [binding("x", ind)]).
proof(1672, a(ind, n652), rule(1955), [uses(1671, a(ind, n651))]).
substitution(1673, [binding("x", ind)]).
proof(1673, a(ind, n653), rule(1958), [uses(1672, a(ind, n652))]).
substitution(1674, [binding("x", ind)]).
proof(1674, a(ind, n654), rule(1961), [uses(1673, a(ind, n653))]).
substitution(1675, [binding("x", ind)]).
proof(1675, a(ind, n655), rule(1964), [uses(1674, a(ind, n654))]).
substitution(1676, [binding("x", ind)]).
proof(1676, a(ind, n656), rule(1967), [uses(1675, a(ind, n655))]).
substitution(1677, [binding("x", ind)]).
proof(1677, a(ind, n657), rule(1970), [uses(1676, a(ind, n656))]).
substitution(1678, [binding("x", ind)]).
proof(1678, a(ind, n658), rule(1973), [uses(1677, a(ind, n657))]).
substitution(1679, [binding("x", ind)]).
proof(1679, a(ind, n659), rule(1976), [uses(1678, a(ind, n658))]).
substitution(1680, [binding("x", ind)]).
proof(1680, a(ind, n660), rule(1979), [uses(1679, a(ind, n659))]).
substitution(1681, [binding("x", ind)]).
proof(1681, a(ind, n661), rule(1982), [uses(1680, a(ind, n660))]).
substitution(1682, [binding("x", ind)]).
proof(1682, a(ind, n662), rule(1985), [uses(1681, a(ind, n661))]).
substitution(1683, [binding("x", ind)]).
proof(1683, a(ind, n663), rule(1988), [uses(1682, a(ind, n662))]).
substitution(1684, [binding("x", ind)]).
proof(1684, a(ind, n664), rule(1991), [uses(1683, a(ind, n663))]).
substitution(1685, [binding("x", ind)]).
proof(1685, a(ind, n665), rule(1994), [uses(1684, a(ind, n664))]).
substitution(1686, [binding("x", ind)]).
proof(1686, a(ind, n666), rule(1997), [uses(1685, a(ind, n665))]).
substitution(1687, [binding("x", ind)]).
proof(1687, a(ind, n667), rule(2000), [uses(1686, a(ind, n666))]).
substitution(1688, [binding("x", ind)]).
proof(1688, a(ind, n668), rule(2003), [uses(1687, a(ind, n667))]).
substitution(1689, [binding("x", ind)]).
proof(1689, a(ind, n669), rule(2006), [uses(1688, a(ind, n668))]).
substitution(1690, [binding("x", ind)]).
proof(1690, a(ind, n670), rule(2009), [uses(1689, a(ind, n669))]).
substitution(1691, [binding("x", ind)]).
proof(1691, a(ind, n671), rule(2012), [uses(1690, a(ind, n670))]).
substitution(1692, [binding("x", ind)]).
proof(1692, a(ind, n672), rule(2015), [uses(1691, a(ind, n671))]).
substitution(1693, [binding("x", ind)]).
proof(1693, a(ind, n673), rule(2018), [uses(1692, a(ind, n672))]).
substitution(1694, [binding("x", ind)]).
proof(1694, a(ind, n674), rule(2021), [uses(1693, a(ind, n673))]).
substitution(1695, [binding("x", ind)]).
proof(1695, a(ind, n675), rule(2024), [uses(1694, a(ind, n674))]).
substitution(1696, [binding("x", ind)]).
proof(1696, a(ind, n676), rule(2027), [uses(1695, a(ind, n675))]).
substitution(1697, [binding("x", ind)]).
proof(1697, a(ind, n677), rule(2030), [uses(1696, a(ind, n676))]).
substitution(1698, [binding("x", ind)]).
proof(1698, a(ind, n678), rule(2033), [uses(1697, a(ind, n677))]).
substitution(1699, [binding("x", ind)]).
proof(1699, a(ind, n679), rule(2036), [uses(1698, a(ind, n678))]).
substitution(1700, [binding("x", ind)]).
proof(1700, a(ind, n680), rule(2039), [uses(1699, a(ind, n679))]).
substitution(1701, [binding("x", ind)]).
proof(1701, a(ind, n681), rule(2042), [uses(1700, a(ind, n680))]).
substitution(1702, [binding("x", ind)]).
proof(1702, a(ind, n682), rule(2045), [uses(1701, a(ind, n681))]).
substitution(1703, [binding("x", ind)]).
proof(1703, a(ind, n683), rule(2048), [uses(1702, a(ind, n682))]).
substitution(1704, [binding("x", ind)]).
proof(1704, a(ind, n684), rule(2051), [uses(1703, a(ind, n683))]).
substitution(1705, [binding("x", ind)]).
proof(1705, a(ind, n685), rule(2054), [uses(1704, a(ind, n684))]).
substitution(1706, [binding("x", ind)]).
proof(1706, a(ind, n686), rule(2057), [uses(1705, a(ind, n685))]).
substitution(1707, [binding("x", ind)]).
proof(1707, a(ind, n687), rule(2060), [uses(1706, a(ind, n686))]).
substitution(1708, [binding("x", ind)]).
proof(1708, a(ind, n688), rule(2063), [uses(1707, a(ind, n687))]).
substitution(1709, [binding("x", ind)]).
proof(1709, a(ind, n689), rule(2066), [uses(1708, a(ind, n688))]).
substitution(1710, [binding("x", ind)]).
proof(1710, a(ind, n690), rule(2069), [uses(1709, a(ind, n689))]).
substitution(1711, [binding("x", ind)]).
proof(1711, a(ind, n691), rule(2072), [uses(1710, a(ind, n690))]).
substitution(1712, [binding("x", ind)]).
proof(1712, a(ind, n692), rule(2075), [uses(1711, a(ind, n691))]).
substitution(1713, [binding("x", ind)]).
proof(1713, a(ind, n693), rule(2078), [uses(1712, a(ind, n692))]).
substitution(1714, [binding("x", ind)]).
proof(1714, a(ind, n694), rule(2081), [uses(1713, a(ind, n693))]).
substitution(1715, [binding("x", ind)]).
proof(1715, a(ind, n695), rule(2084), [uses(1714, a(ind, n694))]).
substitution(1716, [binding("x", ind)]).
proof(1716, a(ind, n696), rule(2087), [uses(1715, a(ind, n695))]).
substitution(1717, [binding("x", ind)]).
proof(1717, a(ind, n697), rule(2090), [uses(1716, a(ind, n696))]).
substitution(1718, [binding("x", ind)]).
proof(1718, a(ind, n698), rule(2093), [uses(1717, a(ind, n697))]).
substitution(1719, [binding("x", ind)]).
proof(1719, a(ind, n699), rule(2096), [uses(1718, a(ind, n698))]).
substitution(1720, [binding("x", ind)]).
proof(1720, a(ind, n700), rule(2099), [uses(1719, a(ind, n699))]).
substitution(1721, [binding("x", ind)]).
proof(1721, a(ind, n701), rule(2102), [uses(1720, a(ind, n700))]).
substitution(1722, [binding("x", ind)]).
proof(1722, a(ind, n702), rule(2105), [uses(1721, a(ind, n701))]).
substitution(1723, [binding("x", ind)]).
proof(1723, a(ind, n703), rule(2108), [uses(1722, a(ind, n702))]).
substitution(1724, [binding("x", ind)]).
proof(1724, a(ind, n704), rule(2111), [uses(1723, a(ind, n703))]).
substitution(1725, [binding("x", ind)]).
proof(1725, a(ind, n705), rule(2114), [uses(1724, a(ind, n704))]).
substitution(1726, [binding("x", ind)]).
proof(1726, a(ind, n706), rule(2117), [uses(1725, a(ind, n705))]).
substitution(1727, [binding("x", ind)]).
proof(1727, a(ind, n707), rule(2120), [uses(1726, a(ind, n706))]).
substitution(1728, [binding("x", ind)]).
proof(1728, a(ind, n708), rule(2123), [uses(1727, a(ind, n707))]).
substitution(1729, [binding("x", ind)]).
proof(1729, a(ind, n709), rule(2126), [uses(1728, a(ind, n708))]).
substitution(1730, [binding("x", ind)]).
proof(1730, a(ind, n710), rule(2129), [uses(1729, a(ind, n709))]).
substitution(1731, [binding("x", ind)]).
proof(1731, a(ind, n711), rule(2132), [uses(1730, a(ind, n710))]).
substitution(1732, [binding("x", ind)]).
proof(1732, a(ind, n712), rule(2135), [uses(1731, a(ind, n711))]).
substitution(1733, [binding("x", ind)]).
proof(1733, a(ind, n713), rule(2138), [uses(1732, a(ind, n712))]).
substitution(1734, [binding("x", ind)]).
proof(1734, a(ind, n714), rule(2141), [uses(1733, a(ind, n713))]).
substitution(1735, [binding("x", ind)]).
proof(1735, a(ind, n715), rule(2144), [uses(1734, a(ind, n714))]).
substitution(1736, [binding("x", ind)]).
proof(1736, a(ind, n716), rule(2147), [uses(1735, a(ind, n715))]).
substitution(1737, [binding("x", ind)]).
proof(1737, a(ind, n717), rule(2150), [uses(1736, a(ind, n716))]).
substitution(1738, [binding("x", ind)]).
proof(1738, a(ind, n718), rule(2153), [uses(1737, a(ind, n717))]).
substitution(1739, [binding("x", ind)]).
proof(1739, a(ind, n719), rule(2156), [uses(1738, a(ind, n718))]).
substitution(1740, [binding("x", ind)]).
proof(1740, a(ind, n720), rule(2159), [uses(1739, a(ind, n719))]).
substitution(1741, [binding("x", ind)]).
proof(1741, a(ind, n721), rule(2162), [uses(1740, a(ind, n720))]).
substitution(1742, [binding("x", ind)]).
proof(1742, a(ind, n722), rule(2165), [uses(1741, a(ind, n721))]).
substitution(1743, [binding("x", ind)]).
proof(1743, a(ind, n723), rule(2168), [uses(1742, a(ind, n722))]).
substitution(1744, [binding("x", ind)]).
proof(1744, a(ind, n724), rule(2171), [uses(1743, a(ind, n723))]).
substitution(1745, [binding("x", ind)]).
proof(1745, a(ind, n725), rule(2174), [uses(1744, a(ind, n724))]).
substitution(1746, [binding("x", ind)]).
proof(1746, a(ind, n726), rule(2177), [uses(1745, a(ind, n725))]).
substitution(1747, [binding("x", ind)]).
proof(1747, a(ind, n727), rule(2180), [uses(1746, a(ind, n726))]).
substitution(1748, [binding("x", ind)]).
proof(1748, a(ind, n728), rule(2183), [uses(1747, a(ind, n727))]).
substitution(1749, [binding("x", ind)]).
proof(1749, a(ind, n729), rule(2186), [uses(1748, a(ind, n728))]).
substitution(1750, [binding("x", ind)]).
proof(1750, a(ind, n730), rule(2189), [uses(1749, a(ind, n729))]).
substitution(1751, [binding("x", ind)]).
proof(1751, a(ind, n731), rule(2192), [uses(1750, a(ind, n730))]).
substitution(1752, [binding("x", ind)]).
proof(1752, a(ind, n732), rule(2195), [uses(1751, a(ind, n731))]).
substitution(1753, [binding("x", ind)]).
proof(1753, a(ind, n733), rule(2198), [uses(1752, a(ind, n732))]).
substitution(1754, [binding("x", ind)]).
proof(1754, a(ind, n734), rule(2201), [uses(1753, a(ind, n733))]).
substitution(1755, [binding("x", ind)]).
proof(1755, a(ind, n735), rule(2204), [uses(1754, a(ind, n734))]).
substitution(1756, [binding("x", ind)]).
proof(1756, a(ind, n736), rule(2207), [uses(1755, a(ind, n735))]).
substitution(1757, [binding("x", ind)]).
proof(1757, a(ind, n737), rule(2210), [uses(1756, a(ind, n736))]).
substitution(1758, [binding("x", ind)]).
proof(1758, a(ind, n738), rule(2213), [uses(1757, a(ind, n737))]).
substitution(1759, [binding("x", ind)]).
proof(1759, a(ind, n739), rule(2216), [uses(1758, a(ind, n738))]).
substitution(1760, [binding("x", ind)]).
proof(1760, a(ind, n740), rule(2219), [uses(1759, a(ind, n739))]).
substitution(1761, [binding("x", ind)]).
proof(1761, a(ind, n741), rule(2222), [uses(1760, a(ind, n740))]).
substitution(1762, [binding("x", ind)]).
proof(1762, a(ind, n742), rule(2225), [uses(1761, a(ind, n741))]).
substitution(1763, [binding("x", ind)]).
proof(1763, a(ind, n743), rule(2228), [uses(1762, a(ind, n742))]).
substitution(1764, [binding("x", ind)]).
proof(1764, a(ind, n744), rule(2231), [uses(1763, a(ind, n743))]).
substitution(1765, [binding("x", ind)]).
proof(1765, a(ind, n745), rule(2234), [uses(1764, a(ind, n744))]).
substitution(1766, [binding("x", ind)]).
proof(1766, a(ind, n746), rule(2237), [uses(1765, a(ind, n745))]).
substitution(1767, [binding("x", ind)]).
proof(1767, a(ind, n747), rule(2240), [uses(1766, a(ind, n746))]).
substitution(1768, [binding("x", ind)]).
proof(1768, a(ind, n748), rule(2243), [uses(1767, a(ind, n747))]).
substitution(1769, [binding("x", ind)]).
proof(1769, a(ind, n749), rule(2246), [uses(1768, a(ind, n748))]).
substitution(1770, [binding("x", ind)]).
proof(1770, a(ind, n750), rule(2249), [uses(1769, a(ind, n749))]).
substitution(1771, [binding("x", ind)]).
proof(1771, a(ind, n751), rule(2252), [uses(1770, a(ind, n750))]).
substitution(1772, [binding("x", ind)]).
proof(1772, a(ind, n752), rule(2255), [uses(1771, a(ind, n751))]).
substitution(1773, [binding("x", ind)]).
proof(1773, a(ind, n753), rule(2258), [uses(1772, a(ind, n752))]).
substitution(1774, [binding("x", ind)]).
proof(1774, a(ind, n754), rule(2261), [uses(1773, a(ind, n753))]).
substitution(1775, [binding("x", ind)]).
proof(1775, a(ind, n755), rule(2264), [uses(1774, a(ind, n754))]).
substitution(1776, [binding("x", ind)]).
proof(1776, a(ind, n756), rule(2267), [uses(1775, a(ind, n755))]).
substitution(1777, [binding("x", ind)]).
proof(1777, a(ind, n757), rule(2270), [uses(1776, a(ind, n756))]).
substitution(1778, [binding("x", ind)]).
proof(1778, a(ind, n758), rule(2273), [uses(1777, a(ind, n757))]).
substitution(1779, [binding("x", ind)]).
proof(1779, a(ind, n759), rule(2276), [uses(1778, a(ind, n758))]).
substitution(1780, [binding("x", ind)]).
proof(1780, a(ind, n760), rule(2279), [uses(1779, a(ind, n759))]).
substitution(1781, [binding("x", ind)]).
proof(1781, a(ind, n761), rule(2282), [uses(1780, a(ind, n760))]).
substitution(1782, [binding("x", ind)]).
proof(1782, a(ind, n762), rule(2285), [uses(1781, a(ind, n761))]).
substitution(1783, [binding("x", ind)]).
proof(1783, a(ind, n763), rule(2288), [uses(1782, a(ind, n762))]).
substitution(1784, [binding("x", ind)]).
proof(1784, a(ind, n764), rule(2291), [uses(1783, a(ind, n763))]).
substitution(1785, [binding("x", ind)]).
proof(1785, a(ind, n765), rule(2294), [uses(1784, a(ind, n764))]).
substitution(1786, [binding("x", ind)]).
proof(1786, a(ind, n766), rule(2297), [uses(1785, a(ind, n765))]).
substitution(1787, [binding("x", ind)]).
proof(1787, a(ind, n767), rule(2300), [uses(1786, a(ind, n766))]).
substitution(1788, [binding("x", ind)]).
proof(1788, a(ind, n768), rule(2303), [uses(1787, a(ind, n767))]).
substitution(1789, [binding("x", ind)]).
proof(1789, a(ind, n769), rule(2306), [uses(1788, a(ind, n768))]).
substitution(1790, [binding("x", ind)]).
proof(1790, a(ind, n770), rule(2309), [uses(1789, a(ind, n769))]).
substitution(1791, [binding("x", ind)]).
proof(1791, a(ind, n771), rule(2312), [uses(1790, a(ind, n770))]).
substitution(1792, [binding("x", ind)]).
proof(1792, a(ind, n772), rule(2315), [uses(1791, a(ind, n771))]).
substitution(1793, [binding("x", ind)]).
proof(1793, a(ind, n773), rule(2318), [uses(1792, a(ind, n772))]).
substitution(1794, [binding("x", ind)]).
proof(1794, a(ind, n774), rule(2321), [uses(1793, a(ind, n773))]).
substitution(1795, [binding("x", ind)]).
proof(1795, a(ind, n775), rule(2324), [uses(1794, a(ind, n774))]).
substitution(1796, [binding("x", ind)]).
proof(1796, a(ind, n776), rule(2327), [uses(1795, a(ind, n775))]).
substitution(1797, [binding("x", ind)]).
proof(1797, a(ind, n777), rule(2330), [uses(1796, a(ind, n776))]).
substitution(1798, [binding("x", ind)]).
proof(1798, a(ind, n778), rule(2333), [uses(1797, a(ind, n777))]).
substitution(1799, [binding("x", ind)]).
proof(1799, a(ind, n779), rule(2336), [uses(1798, a(ind, n778))]).
substitution(1800, [binding("x", ind)]).
proof(1800, a(ind, n780), rule(2339), [uses(1799, a(ind, n779))]).
substitution(1801, [binding("x", ind)]).
proof(1801, a(ind, n781), rule(2342), [uses(1800, a(ind, n780))]).
substitution(1802, [binding("x", ind)]).
proof(1802, a(ind, n782), rule(2345), [uses(1801, a(ind, n781))]).
substitution(1803, [binding("x", ind)]).
proof(1803, a(ind, n783), rule(2348), [uses(1802, a(ind, n782))]).
substitution(1804, [binding("x", ind)]).
proof(1804, a(ind, n784), rule(2351), [uses(1803, a(ind, n783))]).
substitution(1805, [binding("x", ind)]).
proof(1805, a(ind, n785), rule(2354), [uses(1804, a(ind, n784))]).
substitution(1806, [binding("x", ind)]).
proof(1806, a(ind, n786), rule(2357), [uses(1805, a(ind, n785))]).
substitution(1807, [binding("x", ind)]).
proof(1807, a(ind, n787), rule(2360), [uses(1806, a(ind, n786))]).
substitution(1808, [binding("x", ind)]).
proof(1808, a(ind, n788), rule(2363), [uses(1807, a(ind, n787))]).
substitution(1809, [binding("x", ind)]).
proof(1809, a(ind, n789), rule(2366), [uses(1808, a(ind, n788))]).
substitution(1810, [binding("x", ind)]).
proof(1810, a(ind, n790), rule(2369), [uses(1809, a(ind, n789))]).
substitution(1811, [binding("x", ind)]).
proof(1811, a(ind, n791), rule(2372), [uses(1810, a(ind, n790))]).
substitution(1812, [binding("x", ind)]).
proof(1812, a(ind, n792), rule(2375), [uses(1811, a(ind, n791))]).
substitution(1813, [binding("x", ind)]).
proof(1813, a(ind, n793), rule(2378), [uses(1812, a(ind, n792))]).
substitution(1814, [binding("x", ind)]).
proof(1814, a(ind, n794), rule(2381), [uses(1813, a(ind, n793))]).
substitution(1815, [binding("x", ind)]).
proof(1815, a(ind, n795), rule(2384), [uses(1814, a(ind, n794))]).
substitution(1816, [binding("x", ind)]).
proof(1816, a(ind, n796), rule(2387), [uses(1815, a(ind, n795))]).
substitution(1817, [binding("x", ind)]).
proof(1817, a(ind, n797), rule(2390), [uses(1816, a(ind, n796))]).
substitution(1818, [binding("x", ind)]).
proof(1818, a(ind, n798), rule(2393), [uses(1817, a(ind, n797))]).
substitution(1819, [binding("x", ind)]).
proof(1819, a(ind, n799), rule(2396), [uses(1818, a(ind, n798))]).
substitution(1820, [binding("x", ind)]).
proof(1820, a(ind, n800), rule(2399), [uses(1819, a(ind, n799))]).
substitution(1821, [binding("x", ind)]).
proof(1821, a(ind, n801), rule(2402), [uses(1820, a(ind, n800))]).
substitution(1822, [binding("x", ind)]).
proof(1822, a(ind, n802), rule(2405), [uses(1821, a(ind, n801))]).
substitution(1823, [binding("x", ind)]).
proof(1823, a(ind, n803), rule(2408), [uses(1822, a(ind, n802))]).
substitution(1824, [binding("x", ind)]).
proof(1824, a(ind, n804), rule(2411), [uses(1823, a(ind, n803))]).
substitution(1825, [binding("x", ind)]).
proof(1825, a(ind, n805), rule(2414), [uses(1824, a(ind, n804))]).
substitution(1826, [binding("x", ind)]).
proof(1826, a(ind, n806), rule(2417), [uses(1825, a(ind, n805))]).
substitution(1827, [binding("x", ind)]).
proof(1827, a(ind, n807), rule(2420), [uses(1826, a(ind, n806))]).
substitution(1828, [binding("x", ind)]).
proof(1828, a(ind, n808), rule(2423), [uses(1827, a(ind, n807))]).
substitution(1829, [binding("x", ind)]).
proof(1829, a(ind, n809), rule(2426), [uses(1828, a(ind, n808))]).
substitution(1830, [binding("x", ind)]).
proof(1830, a(ind, n810), rule(2429), [uses(1829, a(ind, n809))]).
substitution(1831, [binding("x", ind)]).
proof(1831, a(ind, n811), rule(2432), [uses(1830, a(ind, n810))]).
substitution(1832, [binding("x", ind)]).
proof(1832, a(ind, n812), rule(2435), [uses(1831, a(ind, n811))]).
substitution(1833, [binding("x", ind)]).
proof(1833, a(ind, n813), rule(2438), [uses(1832, a(ind, n812))]).
substitution(1834, [binding("x", ind)]).
proof(1834, a(ind, n814), rule(2441), [uses(1833, a(ind, n813))]).
substitution(1835, [binding("x", ind)]).
proof(1835, a(ind, n815), rule(2444), [uses(1834, a(ind, n814))]).
substitution(1836, [binding("x", ind)]).
proof(1836, a(ind, n816), rule(2447), [uses(1835, a(ind, n815))]).
substitution(1837, [binding("x", ind)]).
proof(1837, a(ind, n817), rule(2450), [uses(1836, a(ind, n816))]).
substitution(1838, [binding("x", ind)]).
proof(1838, a(ind, n818), rule(2453), [uses(1837, a(ind, n817))]).
substitution(1839, [binding("x", ind)]).
proof(1839, a(ind, n819), rule(2456), [uses(1838, a(ind, n818))]).
substitution(1840, [binding("x", ind)]).
proof(1840, a(ind, n820), rule(2459), [uses(1839, a(ind, n819))]).
substitution(1841, [binding("x", ind)]).
proof(1841, a(ind, n821), rule(2462), [uses(1840, a(ind, n820))]).
substitution(1842, [binding("x", ind)]).
proof(1842, a(ind, n822), rule(2465), [uses(1841, a(ind, n821))]).
substitution(1843, [binding("x", ind)]).
proof(1843, a(ind, n823), rule(2468), [uses(1842, a(ind, n822))]).
substitution(1844, [binding("x", ind)]).
proof(1844, a(ind, n824), rule(2471), [uses(1843, a(ind, n823))]).
substitution(1845, [binding("x", ind)]).
proof(1845, a(ind, n825), rule(2474), [uses(1844, a(ind, n824))]).
substitution(1846, [binding("x", ind)]).
proof(1846, a(ind, n826), rule(2477), [uses(1845, a(ind, n825))]).
substitution(1847, [binding("x", ind)]).
proof(1847, a(ind, n827), rule(2480), [uses(1846, a(ind, n826))]).
substitution(1848, [binding("x", ind)]).
proof(1848, a(ind, n828), rule(2483), [uses(1847, a(ind, n827))]).
substitution(1849, [binding("x", ind)]).
proof(1849, a(ind, n829), rule(2486), [uses(1848, a(ind, n828))]).
substitution(1850, [binding("x", ind)]).
proof(1850, a(ind, n830), rule(2489), [uses(1849, a(ind, n829))]).
substitution(1851, [binding("x", ind)]).
proof(1851, a(ind, n831), rule(2492), [uses(1850, a(ind, n830))]).
substitution(1852, [binding("x", ind)]).
proof(1852, a(ind, n832), rule(2495), [uses(1851, a(ind, n831))]).
substitution(1853, [binding("x", ind)]).
proof(1853, a(ind, n833), rule(2498), [uses(1852, a(ind, n832))]).
substitution(1854, [binding("x", ind)]).
proof(1854, a(ind, n834), rule(2501), [uses(1853, a(ind, n833))]).
substitution(1855, [binding("x", ind)]).
proof(1855, a(ind, n835), rule(2504), [uses(1854, a(ind, n834))]).
substitution(1856, [binding("x", ind)]).
proof(1856, a(ind, n836), rule(2507), [uses(1855, a(ind, n835))]).
substitution(1857, [binding("x", ind)]).
proof(1857, a(ind, n837), rule(2510), [uses(1856, a(ind, n836))]).
substitution(1858, [binding("x", ind)]).
proof(1858, a(ind, n838), rule(2513), [uses(1857, a(ind, n837))]).
substitution(1859, [binding("x", ind)]).
proof(1859, a(ind, n839), rule(2516), [uses(1858, a(ind, n838))]).
substitution(1860, [binding("x", ind)]).
proof(1860, a(ind, n840), rule(2519), [uses(1859, a(ind, n839))]).
substitution(1861, [binding("x", ind)]).
proof(1861, a(ind, n841), rule(2522), [uses(1860, a(ind, n840))]).
substitution(1862, [binding("x", ind)]).
proof(1862, a(ind, n842), rule(2525), [uses(1861, a(ind, n841))]).
substitution(1863, [binding("x", ind)]).
proof(1863, a(ind, n843), rule(2528), [uses(1862, a(ind, n842))]).
substitution(1864, [binding("x", ind)]).
proof(1864, a(ind, n844), rule(2531), [uses(1863, a(ind, n843))]).
substitution(1865, [binding("x", ind)]).
proof(1865, a(ind, n845), rule(2534), [uses(1864, a(ind, n844))]).
substitution(1866, [binding("x", ind)]).
proof(1866, a(ind, n846), rule(2537), [uses(1865, a(ind, n845))]).
substitution(1867, [binding("x", ind)]).
proof(1867, a(ind, n847), rule(2540), [uses(1866, a(ind, n846))]).
substitution(1868, [binding("x", ind)]).
proof(1868, a(ind, n848), rule(2543), [uses(1867, a(ind, n847))]).
substitution(1869, [binding("x", ind)]).
proof(1869, a(ind, n849), rule(2546), [uses(1868, a(ind, n848))]).
substitution(1870, [binding("x", ind)]).
proof(1870, a(ind, n850), rule(2549), [uses(1869, a(ind, n849))]).
substitution(1871, [binding("x", ind)]).
proof(1871, a(ind, n851), rule(2552), [uses(1870, a(ind, n850))]).
substitution(1872, [binding("x", ind)]).
proof(1872, a(ind, n852), rule(2555), [uses(1871, a(ind, n851))]).
substitution(1873, [binding("x", ind)]).
proof(1873, a(ind, n853), rule(2558), [uses(1872, a(ind, n852))]).
substitution(1874, [binding("x", ind)]).
proof(1874, a(ind, n854), rule(2561), [uses(1873, a(ind, n853))]).
substitution(1875, [binding("x", ind)]).
proof(1875, a(ind, n855), rule(2564), [uses(1874, a(ind, n854))]).
substitution(1876, [binding("x", ind)]).
proof(1876, a(ind, n856), rule(2567), [uses(1875, a(ind, n855))]).
substitution(1877, [binding("x", ind)]).
proof(1877, a(ind, n857), rule(2570), [uses(1876, a(ind, n856))]).
substitution(1878, [binding("x", ind)]).
proof(1878, a(ind, n858), rule(2573), [uses(1877, a(ind, n857))]).
substitution(1879, [binding("x", ind)]).
proof(1879, a(ind, n859), rule(2576), [uses(1878, a(ind, n858))]).
substitution(1880, [binding("x", ind)]).
proof(1880, a(ind, n860), rule(2579), [uses(1879, a(ind, n859))]).
substitution(1881, [binding("x", ind)]).
proof(1881, a(ind, n861), rule(2582), [uses(1880, a(ind, n860))]).
substitution(1882, [binding("x", ind)]).
proof(1882, a(ind, n862), rule(2585), [uses(1881, a(ind, n861))]).
substitution(1883, [binding("x", ind)]).
proof(1883, a(ind, n863), rule(2588), [uses(1882, a(ind, n862))]).
substitution(1884, [binding("x", ind)]).
proof(1884, a(ind, n864), rule(2591), [uses(1883, a(ind, n863))]).
substitution(1885, [binding("x", ind)]).
proof(1885, a(ind, n865), rule(2594), [uses(1884, a(ind, n864))]).
substitution(1886, [binding("x", ind)]).
proof(1886, a(ind, n866), rule(2597), [uses(1885, a(ind, n865))]).
substitution(1887, [binding("x", ind)]).
proof(1887, a(ind, n867), rule(2600), [uses(1886, a(ind, n866))]).
substitution(1888, [binding("x", ind)]).
proof(1888, a(ind, n868), rule(2603), [uses(1887, a(ind, n867))]).
substitution(1889, [binding("x", ind)]).
proof(1889, a(ind, n869), rule(2606), [uses(1888, a(ind, n868))]).
substitution(1890, [binding("x", ind)]).
proof(1890, a(ind, n870), rule(2609), [uses(1889, a(ind, n869))]).
substitution(1891, [binding("x", ind)]).
proof(1891, a(ind, n871), rule(2612), [uses(1890, a(ind, n870))]).
substitution(1892, [binding("x", ind)]).
proof(1892, a(ind, n872), rule(2615), [uses(1891, a(ind, n871))]).
substitution(1893, [binding("x", ind)]).
proof(1893, a(ind, n873), rule(2618), [uses(1892, a(ind, n872))]).
substitution(1894, [binding("x", ind)]).
proof(1894, a(ind, n874), rule(2621), [uses(1893, a(ind, n873))]).
substitution(1895, [binding("x", ind)]).
proof(1895, a(ind, n875), rule(2624), [uses(1894, a(ind, n874))]).
substitution(1896, [binding("x", ind)]).
proof(1896, a(ind, n876), rule(2627), [uses(1895, a(ind, n875))]).
substitution(1897, [binding("x", ind)]).
proof(1897, a(ind, n877), rule(2630), [uses(1896, a(ind, n876))]).
substitution(1898, [binding("x", ind)]).
proof(1898, a(ind, n878), rule(2633), [uses(1897, a(ind, n877))]).
substitution(1899, [binding("x", ind)]).
proof(1899, a(ind, n879), rule(2636), [uses(1898, a(ind, n878))]).
substitution(1900, [binding("x", ind)]).
proof(1900, a(ind, n880), rule(2639), [uses(1899, a(ind, n879))]).
substitution(1901, [binding("x", ind)]).
proof(1901, a(ind, n881), rule(2642), [uses(1900, a(ind, n880))]).
substitution(1902, [binding("x", ind)]).
proof(1902, a(ind, n882), rule(2645), [uses(1901, a(ind, n881))]).
substitution(1903, [binding("x", ind)]).
proof(1903, a(ind, n883), rule(2648), [uses(1902, a(ind, n882))]).
substitution(1904, [binding("x", ind)]).
proof(1904, a(ind, n884), rule(2651), [uses(1903, a(ind, n883))]).
substitution(1905, [binding("x", ind)]).
proof(1905, a(ind, n885), rule(2654), [uses(1904, a(ind, n884))]).
substitution(1906, [binding("x", ind)]).
proof(1906, a(ind, n886), rule(2657), [uses(1905, a(ind, n885))]).
substitution(1907, [binding("x", ind)]).
proof(1907, a(ind, n887), rule(2660), [uses(1906, a(ind, n886))]).
substitution(1908, [binding("x", ind)]).
proof(1908, a(ind, n888), rule(2663), [uses(1907, a(ind, n887))]).
substitution(1909, [binding("x", ind)]).
proof(1909, a(ind, n889), rule(2666), [uses(1908, a(ind, n888))]).
substitution(1910, [binding("x", ind)]).
proof(1910, a(ind, n890), rule(2669), [uses(1909, a(ind, n889))]).
substitution(1911, [binding("x", ind)]).
proof(1911, a(ind, n891), rule(2672), [uses(1910, a(ind, n890))]).
substitution(1912, [binding("x", ind)]).
proof(1912, a(ind, n892), rule(2675), [uses(1911, a(ind, n891))]).
substitution(1913, [binding("x", ind)]).
proof(1913, a(ind, n893), rule(2678), [uses(1912, a(ind, n892))]).
substitution(1914, [binding("x", ind)]).
proof(1914, a(ind, n894), rule(2681), [uses(1913, a(ind, n893))]).
substitution(1915, [binding("x", ind)]).
proof(1915, a(ind, n895), rule(2684), [uses(1914, a(ind, n894))]).
substitution(1916, [binding("x", ind)]).
proof(1916, a(ind, n896), rule(2687), [uses(1915, a(ind, n895))]).
substitution(1917, [binding("x", ind)]).
proof(1917, a(ind, n897), rule(2690), [uses(1916, a(ind, n896))]).
substitution(1918, [binding("x", ind)]).
proof(1918, a(ind, n898), rule(2693), [uses(1917, a(ind, n897))]).
substitution(1919, [binding("x", ind)]).
proof(1919, a(ind, n899), rule(2696), [uses(1918, a(ind, n898))]).
substitution(1920, [binding("x", ind)]).
proof(1920, a(ind, n900), rule(2699), [uses(1919, a(ind, n899))]).
substitution(1921, [binding("x", ind)]).
proof(1921, a(ind, n901), rule(2702), [uses(1920, a(ind, n900))]).
substitution(1922, [binding("x", ind)]).
proof(1922, a(ind, n902), rule(2705), [uses(1921, a(ind, n901))]).
substitution(1923, [binding("x", ind)]).
proof(1923, a(ind, n903), rule(2708), [uses(1922, a(ind, n902))]).
substitution(1924, [binding("x", ind)]).
proof(1924, a(ind, n904), rule(2711), [uses(1923, a(ind, n903))]).
substitution(1925, [binding("x", ind)]).
proof(1925, a(ind, n905), rule(2714), [uses(1924, a(ind, n904))]).
substitution(1926, [binding("x", ind)]).
proof(1926, a(ind, n906), rule(2717), [uses(1925, a(ind, n905))]).
substitution(1927, [binding("x", ind)]).
proof(1927, a(ind, n907), rule(2720), [uses(1926, a(ind, n906))]).
substitution(1928, [binding("x", ind)]).
proof(1928, a(ind, n908), rule(2723), [uses(1927, a(ind, n907))]).
substitution(1929, [binding("x", ind)]).
proof(1929, a(ind, n909), rule(2726), [uses(1928, a(ind, n908))]).
substitution(1930, [binding("x", ind)]).
proof(1930, a(ind, n910), rule(2729), [uses(1929, a(ind, n909))]).
substitution(1931, [binding("x", ind)]).
proof(1931, a(ind, n911), rule(2732), [uses(1930, a(ind, n910))]).
substitution(1932, [binding("x", ind)]).
proof(1932, a(ind, n912), rule(2735), [uses(1931, a(ind, n911))]).
substitution(1933, [binding("x", ind)]).
proof(1933, a(ind, n913), rule(2738), [uses(1932, a(ind, n912))]).
substitution(1934, [binding("x", ind)]).
proof(1934, a(ind, n914), rule(2741), [uses(1933, a(ind, n913))]).
substitution(1935, [binding("x", ind)]).
proof(1935, a(ind, n915), rule(2744), [uses(1934, a(ind, n914))]).
substitution(1936, [binding("x", ind)]).
proof(1936, a(ind, n916), rule(2747), [uses(1935, a(ind, n915))]).
substitution(1937, [binding("x", ind)]).
proof(1937, a(ind, n917), rule(2750), [uses(1936, a(ind, n916))]).
substitution(1938, [binding("x", ind)]).
proof(1938, a(ind, n918), rule(2753), [uses(1937, a(ind, n917))]).
substitution(1939, [binding("x", ind)]).
proof(1939, a(ind, n919), rule(2756), [uses(1938, a(ind, n918))]).
substitution(1940, [binding("x", ind)]).
proof(1940, a(ind, n920), rule(2759), [uses(1939, a(ind, n919))]).
substitution(1941, [binding("x", ind)]).
proof(1941, a(ind, n921), rule(2762), [uses(1940, a(ind, n920))]).
substitution(1942, [binding("x", ind)]).
proof(1942, a(ind, n922), rule(2765), [uses(1941, a(ind, n921))]).
substitution(1943, [binding("x", ind)]).
proof(1943, a(ind, n923), rule(2768), [uses(1942, a(ind, n922))]).
substitution(1944, [binding("x", ind)]).
proof(1944, a(ind, n924), rule(2771), [uses(1943, a(ind, n923))]).
substitution(1945, [binding("x", ind)]).
proof(1945, a(ind, n925), rule(2774), [uses(1944, a(ind, n924))]).
substitution(1946, [binding("x", ind)]).
proof(1946, a(ind, n926), rule(2777), [uses(1945, a(ind, n925))]).
substitution(1947, [binding("x", ind)]).
proof(1947, a(ind, n927), rule(2780), [uses(1946, a(ind, n926))]).
substitution(1948, [binding("x", ind)]).
proof(1948, a(ind, n928), rule(2783), [uses(1947, a(ind, n927))]).
substitution(1949, [binding("x", ind)]).
proof(1949, a(ind, n929), rule(2786), [uses(1948, a(ind, n928))]).
substitution(1950, [binding("x", ind)]).
proof(1950, a(ind, n930), rule(2789), [uses(1949, a(ind, n929))]).
substitution(1951, [binding("x", ind)]).
proof(1951, a(ind, n931), rule(2792), [uses(1950, a(ind, n930))]).
substitution(1952, [binding("x", ind)]).
proof(1952, a(ind, n932), rule(2795), [uses(1951, a(ind, n931))]).
substitution(1953, [binding("x", ind)]).
proof(1953, a(ind, n933), rule(2798), [uses(1952, a(ind, n932))]).
substitution(1954, [binding("x", ind)]).
proof(1954, a(ind, n934), rule(2801), [uses(1953, a(ind, n933))]).
substitution(1955, [binding("x", ind)]).
proof(1955, a(ind, n935), rule(2804), [uses(1954, a(ind, n934))]).
substitution(1956, [binding("x", ind)]).
proof(1956, a(ind, n936), rule(2807), [uses(1955, a(ind, n935))]).
substitution(1957, [binding("x", ind)]).
proof(1957, a(ind, n937), rule(2810), [uses(1956, a(ind, n936))]).
substitution(1958, [binding("x", ind)]).
proof(1958, a(ind, n938), rule(2813), [uses(1957, a(ind, n937))]).
substitution(1959, [binding("x", ind)]).
proof(1959, a(ind, n939), rule(2816), [uses(1958, a(ind, n938))]).
substitution(1960, [binding("x", ind)]).
proof(1960, a(ind, n940), rule(2819), [uses(1959, a(ind, n939))]).
substitution(1961, [binding("x", ind)]).
proof(1961, a(ind, n941), rule(2822), [uses(1960, a(ind, n940))]).
substitution(1962, [binding("x", ind)]).
proof(1962, a(ind, n942), rule(2825), [uses(1961, a(ind, n941))]).
substitution(1963, [binding("x", ind)]).
proof(1963, a(ind, n943), rule(2828), [uses(1962, a(ind, n942))]).
substitution(1964, [binding("x", ind)]).
proof(1964, a(ind, n944), rule(2831), [uses(1963, a(ind, n943))]).
substitution(1965, [binding("x", ind)]).
proof(1965, a(ind, n945), rule(2834), [uses(1964, a(ind, n944))]).
substitution(1966, [binding("x", ind)]).
proof(1966, a(ind, n946), rule(2837), [uses(1965, a(ind, n945))]).
substitution(1967, [binding("x", ind)]).
proof(1967, a(ind, n947), rule(2840), [uses(1966, a(ind, n946))]).
substitution(1968, [binding("x", ind)]).
proof(1968, a(ind, n948), rule(2843), [uses(1967, a(ind, n947))]).
substitution(1969, [binding("x", ind)]).
proof(1969, a(ind, n949), rule(2846), [uses(1968, a(ind, n948))]).
substitution(1970, [binding("x", ind)]).
proof(1970, a(ind, n950), rule(2849), [uses(1969, a(ind, n949))]).
substitution(1971, [binding("x", ind)]).
proof(1971, a(ind, n951), rule(2852), [uses(1970, a(ind, n950))]).
substitution(1972, [binding("x", ind)]).
proof(1972, a(ind, n952), rule(2855), [uses(1971, a(ind, n951))]).
substitution(1973, [binding("x", ind)]).
proof(1973, a(ind, n953), rule(2858), [uses(1972, a(ind, n952))]).
substitution(1974, [binding("x", ind)]).
proof(1974, a(ind, n954), rule(2861), [uses(1973, a(ind, n953))]).
substitution(1975, [binding("x", ind)]).
proof(1975, a(ind, n955), rule(2864), [uses(1974, a(ind, n954))]).
substitution(1976, [binding("x", ind)]).
proof(1976, a(ind, n956), rule(2867), [uses(1975, a(ind, n955))]).
substitution(1977, [binding("x", ind)]).
proof(1977, a(ind, n957), rule(2870), [uses(1976, a(ind, n956))]).
substitution(1978, [binding("x", ind)]).
proof(1978, a(ind, n958), rule(2873), [uses(1977, a(ind, n957))]).
substitution(1979, [binding("x", ind)]).
proof(1979, a(ind, n959), rule(2876), [uses(1978, a(ind, n958))]).
substitution(1980, [binding("x", ind)]).
proof(1980, a(ind, n960), rule(2879), [uses(1979, a(ind, n959))]).
substitution(1981, [binding("x", ind)]).
proof(1981, a(ind, n961), rule(2882), [uses(1980, a(ind, n960))]).
substitution(1982, [binding("x", ind)]).
proof(1982, a(ind, n962), rule(2885), [uses(1981, a(ind, n961))]).
substitution(1983, [binding("x", ind)]).
proof(1983, a(ind, n963), rule(2888), [uses(1982, a(ind, n962))]).
substitution(1984, [binding("x", ind)]).
proof(1984, a(ind, n964), rule(2891), [uses(1983, a(ind, n963))]).
substitution(1985, [binding("x", ind)]).
proof(1985, a(ind, n965), rule(2894), [uses(1984, a(ind, n964))]).
substitution(1986, [binding("x", ind)]).
proof(1986, a(ind, n966), rule(2897), [uses(1985, a(ind, n965))]).
substitution(1987, [binding("x", ind)]).
proof(1987, a(ind, n967), rule(2900), [uses(1986, a(ind, n966))]).
substitution(1988, [binding("x", ind)]).
proof(1988, a(ind, n968), rule(2903), [uses(1987, a(ind, n967))]).
substitution(1989, [binding("x", ind)]).
proof(1989, a(ind, n969), rule(2906), [uses(1988, a(ind, n968))]).
substitution(1990, [binding("x", ind)]).
proof(1990, a(ind, n970), rule(2909), [uses(1989, a(ind, n969))]).
substitution(1991, [binding("x", ind)]).
proof(1991, a(ind, n971), rule(2912), [uses(1990, a(ind, n970))]).
substitution(1992, [binding("x", ind)]).
proof(1992, a(ind, n972), rule(2915), [uses(1991, a(ind, n971))]).
substitution(1993, [binding("x", ind)]).
proof(1993, a(ind, n973), rule(2918), [uses(1992, a(ind, n972))]).
substitution(1994, [binding("x", ind)]).
proof(1994, a(ind, n974), rule(2921), [uses(1993, a(ind, n973))]).
substitution(1995, [binding("x", ind)]).
proof(1995, a(ind, n975), rule(2924), [uses(1994, a(ind, n974))]).
substitution(1996, [binding("x", ind)]).
proof(1996, a(ind, n976), rule(2927), [uses(1995, a(ind, n975))]).
substitution(1997, [binding("x", ind)]).
proof(1997, a(ind, n977), rule(2930), [uses(1996, a(ind, n976))]).
substitution(1998, [binding("x", ind)]).
proof(1998, a(ind, n978), rule(2933), [uses(1997, a(ind, n977))]).
substitution(1999, [binding("x", ind)]).
proof(1999, a(ind, n979), rule(2936), [uses(1998, a(ind, n978))]).
substitution(2000, [binding("x", ind)]).
proof(2000, a(ind, n980), rule(2939), [uses(1999, a(ind, n979))]).
substitution(2001, [binding("x", ind)]).
proof(2001, a(ind, n981), rule(2942), [uses(2000, a(ind, n980))]).
substitution(2002, [binding("x", ind)]).
proof(2002, a(ind, n982), rule(2945), [uses(2001, a(ind, n981))]).
substitution(2003, [binding("x", ind)]).
proof(2003, a(ind, n983), rule(2948), [uses(2002, a(ind, n982))]).
substitution(2004, [binding("x", ind)]).
proof(2004, a(ind, n984), rule(2951), [uses(2003, a(ind, n983))]).
substitution(2005, [binding("x", ind)]).
proof(2005, a(ind, n985), rule(2954), [uses(2004, a(ind, n984))]).
substitution(2006, [binding("x", ind)]).
proof(2006, a(ind, n986), rule(2957), [uses(2005, a(ind, n985))]).
substitution(2007, [binding("x", ind)]).
proof(2007, a(ind, n987), rule(2960), [uses(2006, a(ind, n986))]).
substitution(2008, [binding("x", ind)]).
proof(2008, a(ind, n988), rule(2963), [uses(2007, a(ind, n987))]).
substitution(2009, [binding("x", ind)]).
proof(2009, a(ind, n989), rule(2966), [uses(2008, a(ind, n988))]).
substitution(2010, [binding("x", ind)]).
proof(2010, a(ind, n990), rule(2969), [uses(2009, a(ind, n989))]).
substitution(2011, [binding("x", ind)]).
proof(2011, a(ind, n991), rule(2972), [uses(2010, a(ind, n990))]).
substitution(2012, [binding("x", ind)]).
proof(2012, a(ind, n992), rule(2975), [uses(2011, a(ind, n991))]).
substitution(2013, [binding("x", ind)]).
proof(2013, a(ind, n993), rule(2978), [uses(2012, a(ind, n992))]).
substitution(2014, [binding("x", ind)]).
proof(2014, a(ind, n994), rule(2981), [uses(2013, a(ind, n993))]).
substitution(2015, [binding("x", ind)]).
proof(2015, a(ind, n995), rule(2984), [uses(2014, a(ind, n994))]).
substitution(2016, [binding("x", ind)]).
proof(2016, a(ind, n996), rule(2987), [uses(2015, a(ind, n995))]).
substitution(2017, [binding("x", ind)]).
proof(2017, a(ind, n997), rule(2990), [uses(2016, a(ind, n996))]).
substitution(2018, [binding("x", ind)]).
proof(2018, a(ind, n998), rule(2993), [uses(2017, a(ind, n997))]).
substitution(2019, [binding("x", ind)]).
proof(2019, a(ind, n999), rule(2996), [uses(2018, a(ind, n998))]).
substitution(2020, [binding("x", ind)]).
proof(2020, a(ind, n1000), rule(2999), [uses(2019, a(ind, n999))]).
substitution(2021, [binding("x", ind)]).
proof(2021, a(ind, a2), rule(3002), [uses(2020, a(ind, n1000))]).
substitution(2022, []).
proof(2022, holds_result(test, true), rule(3003), [uses(2021, a(ind, a2))]).
substitution(2023, []).
proof(2023, solution([]), query, [uses(2022, holds_result(test, true))]).
