% Prolog result format 3
query(1, arc(_0, _1), ['Check' = _0, 'Message' = _1]).
result(1, complete, 6).
answer(1, ['Check' = check1, 'Message' = "C1 OK - the starting classification n0 is present."]).
why(1, ['Check' = check1, 'Message' = "C1 OK - the starting classification n0 is present."], 4).
answer(1, ['Check' = check2, 'Message' = "C2 OK - the first expansion produced n1 together with side labels i1 and j1."]).
why(1, ['Check' = check2, 'Message' = "C2 OK - the first expansion produced n1 together with side labels i1 and j1."], 8).
answer(1, ['Check' = check3, 'Message' = "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches."]).
why(1, ['Check' = check3, 'Message' = "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches."], 516).
answer(1, ['Check' = check4, 'Message' = "C4 OK - the final taxonomy step from n999 to n1000 was completed."]).
why(1, ['Check' = check4, 'Message' = "C4 OK - the final taxonomy step from n999 to n1000 was completed."], 1014).
answer(1, ['Check' = check5, 'Message' = "C5 OK - once n1000 is reached, the terminal class a2 is derived."]).
why(1, ['Check' = check5, 'Message' = "C5 OK - once n1000 is reached, the terminal class a2 is derived."], 1016).
answer(1, ['Check' = check6, 'Message' = "C6 OK - the success flag is raised only after the terminal class a2 is present."]).
why(1, ['Check' = check6, 'Message' = "C6 OK - the success flag is raised only after the terminal class a2 is present."], 1019).
query(2, holds_result(test, true), []).
result(2, complete, 1).
answer(2, []).
why(2, [], 2023).
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
clause(302, a(var('X'), n101), a(var('X'), n100)).
clause(305, a(var('X'), n102), a(var('X'), n101)).
clause(308, a(var('X'), n103), a(var('X'), n102)).
clause(311, a(var('X'), n104), a(var('X'), n103)).
clause(314, a(var('X'), n105), a(var('X'), n104)).
clause(317, a(var('X'), n106), a(var('X'), n105)).
clause(320, a(var('X'), n107), a(var('X'), n106)).
clause(323, a(var('X'), n108), a(var('X'), n107)).
clause(326, a(var('X'), n109), a(var('X'), n108)).
clause(329, a(var('X'), n110), a(var('X'), n109)).
clause(332, a(var('X'), n111), a(var('X'), n110)).
clause(335, a(var('X'), n112), a(var('X'), n111)).
clause(338, a(var('X'), n113), a(var('X'), n112)).
clause(341, a(var('X'), n114), a(var('X'), n113)).
clause(344, a(var('X'), n115), a(var('X'), n114)).
clause(347, a(var('X'), n116), a(var('X'), n115)).
clause(350, a(var('X'), n117), a(var('X'), n116)).
clause(353, a(var('X'), n118), a(var('X'), n117)).
clause(356, a(var('X'), n119), a(var('X'), n118)).
clause(359, a(var('X'), n120), a(var('X'), n119)).
clause(362, a(var('X'), n121), a(var('X'), n120)).
clause(365, a(var('X'), n122), a(var('X'), n121)).
clause(368, a(var('X'), n123), a(var('X'), n122)).
clause(371, a(var('X'), n124), a(var('X'), n123)).
clause(374, a(var('X'), n125), a(var('X'), n124)).
clause(377, a(var('X'), n126), a(var('X'), n125)).
clause(380, a(var('X'), n127), a(var('X'), n126)).
clause(383, a(var('X'), n128), a(var('X'), n127)).
clause(386, a(var('X'), n129), a(var('X'), n128)).
clause(389, a(var('X'), n130), a(var('X'), n129)).
clause(392, a(var('X'), n131), a(var('X'), n130)).
clause(395, a(var('X'), n132), a(var('X'), n131)).
clause(398, a(var('X'), n133), a(var('X'), n132)).
clause(401, a(var('X'), n134), a(var('X'), n133)).
clause(404, a(var('X'), n135), a(var('X'), n134)).
clause(407, a(var('X'), n136), a(var('X'), n135)).
clause(410, a(var('X'), n137), a(var('X'), n136)).
clause(413, a(var('X'), n138), a(var('X'), n137)).
clause(416, a(var('X'), n139), a(var('X'), n138)).
clause(419, a(var('X'), n140), a(var('X'), n139)).
clause(422, a(var('X'), n141), a(var('X'), n140)).
clause(425, a(var('X'), n142), a(var('X'), n141)).
clause(428, a(var('X'), n143), a(var('X'), n142)).
clause(431, a(var('X'), n144), a(var('X'), n143)).
clause(434, a(var('X'), n145), a(var('X'), n144)).
clause(437, a(var('X'), n146), a(var('X'), n145)).
clause(440, a(var('X'), n147), a(var('X'), n146)).
clause(443, a(var('X'), n148), a(var('X'), n147)).
clause(446, a(var('X'), n149), a(var('X'), n148)).
clause(449, a(var('X'), n150), a(var('X'), n149)).
clause(452, a(var('X'), n151), a(var('X'), n150)).
clause(455, a(var('X'), n152), a(var('X'), n151)).
clause(458, a(var('X'), n153), a(var('X'), n152)).
clause(461, a(var('X'), n154), a(var('X'), n153)).
clause(464, a(var('X'), n155), a(var('X'), n154)).
clause(467, a(var('X'), n156), a(var('X'), n155)).
clause(470, a(var('X'), n157), a(var('X'), n156)).
clause(473, a(var('X'), n158), a(var('X'), n157)).
clause(476, a(var('X'), n159), a(var('X'), n158)).
clause(479, a(var('X'), n160), a(var('X'), n159)).
clause(482, a(var('X'), n161), a(var('X'), n160)).
clause(485, a(var('X'), n162), a(var('X'), n161)).
clause(488, a(var('X'), n163), a(var('X'), n162)).
clause(491, a(var('X'), n164), a(var('X'), n163)).
clause(494, a(var('X'), n165), a(var('X'), n164)).
clause(497, a(var('X'), n166), a(var('X'), n165)).
clause(500, a(var('X'), n167), a(var('X'), n166)).
clause(503, a(var('X'), n168), a(var('X'), n167)).
clause(506, a(var('X'), n169), a(var('X'), n168)).
clause(509, a(var('X'), n170), a(var('X'), n169)).
clause(512, a(var('X'), n171), a(var('X'), n170)).
clause(515, a(var('X'), n172), a(var('X'), n171)).
clause(518, a(var('X'), n173), a(var('X'), n172)).
clause(521, a(var('X'), n174), a(var('X'), n173)).
clause(524, a(var('X'), n175), a(var('X'), n174)).
clause(527, a(var('X'), n176), a(var('X'), n175)).
clause(530, a(var('X'), n177), a(var('X'), n176)).
clause(533, a(var('X'), n178), a(var('X'), n177)).
clause(536, a(var('X'), n179), a(var('X'), n178)).
clause(539, a(var('X'), n180), a(var('X'), n179)).
clause(542, a(var('X'), n181), a(var('X'), n180)).
clause(545, a(var('X'), n182), a(var('X'), n181)).
clause(548, a(var('X'), n183), a(var('X'), n182)).
clause(551, a(var('X'), n184), a(var('X'), n183)).
clause(554, a(var('X'), n185), a(var('X'), n184)).
clause(557, a(var('X'), n186), a(var('X'), n185)).
clause(560, a(var('X'), n187), a(var('X'), n186)).
clause(563, a(var('X'), n188), a(var('X'), n187)).
clause(566, a(var('X'), n189), a(var('X'), n188)).
clause(569, a(var('X'), n190), a(var('X'), n189)).
clause(572, a(var('X'), n191), a(var('X'), n190)).
clause(575, a(var('X'), n192), a(var('X'), n191)).
clause(578, a(var('X'), n193), a(var('X'), n192)).
clause(581, a(var('X'), n194), a(var('X'), n193)).
clause(584, a(var('X'), n195), a(var('X'), n194)).
clause(587, a(var('X'), n196), a(var('X'), n195)).
clause(590, a(var('X'), n197), a(var('X'), n196)).
clause(593, a(var('X'), n198), a(var('X'), n197)).
clause(596, a(var('X'), n199), a(var('X'), n198)).
clause(599, a(var('X'), n200), a(var('X'), n199)).
clause(602, a(var('X'), n201), a(var('X'), n200)).
clause(605, a(var('X'), n202), a(var('X'), n201)).
clause(608, a(var('X'), n203), a(var('X'), n202)).
clause(611, a(var('X'), n204), a(var('X'), n203)).
clause(614, a(var('X'), n205), a(var('X'), n204)).
clause(617, a(var('X'), n206), a(var('X'), n205)).
clause(620, a(var('X'), n207), a(var('X'), n206)).
clause(623, a(var('X'), n208), a(var('X'), n207)).
clause(626, a(var('X'), n209), a(var('X'), n208)).
clause(629, a(var('X'), n210), a(var('X'), n209)).
clause(632, a(var('X'), n211), a(var('X'), n210)).
clause(635, a(var('X'), n212), a(var('X'), n211)).
clause(638, a(var('X'), n213), a(var('X'), n212)).
clause(641, a(var('X'), n214), a(var('X'), n213)).
clause(644, a(var('X'), n215), a(var('X'), n214)).
clause(647, a(var('X'), n216), a(var('X'), n215)).
clause(650, a(var('X'), n217), a(var('X'), n216)).
clause(653, a(var('X'), n218), a(var('X'), n217)).
clause(656, a(var('X'), n219), a(var('X'), n218)).
clause(659, a(var('X'), n220), a(var('X'), n219)).
clause(662, a(var('X'), n221), a(var('X'), n220)).
clause(665, a(var('X'), n222), a(var('X'), n221)).
clause(668, a(var('X'), n223), a(var('X'), n222)).
clause(671, a(var('X'), n224), a(var('X'), n223)).
clause(674, a(var('X'), n225), a(var('X'), n224)).
clause(677, a(var('X'), n226), a(var('X'), n225)).
clause(680, a(var('X'), n227), a(var('X'), n226)).
clause(683, a(var('X'), n228), a(var('X'), n227)).
clause(686, a(var('X'), n229), a(var('X'), n228)).
clause(689, a(var('X'), n230), a(var('X'), n229)).
clause(692, a(var('X'), n231), a(var('X'), n230)).
clause(695, a(var('X'), n232), a(var('X'), n231)).
clause(698, a(var('X'), n233), a(var('X'), n232)).
clause(701, a(var('X'), n234), a(var('X'), n233)).
clause(704, a(var('X'), n235), a(var('X'), n234)).
clause(707, a(var('X'), n236), a(var('X'), n235)).
clause(710, a(var('X'), n237), a(var('X'), n236)).
clause(713, a(var('X'), n238), a(var('X'), n237)).
clause(716, a(var('X'), n239), a(var('X'), n238)).
clause(719, a(var('X'), n240), a(var('X'), n239)).
clause(722, a(var('X'), n241), a(var('X'), n240)).
clause(725, a(var('X'), n242), a(var('X'), n241)).
clause(728, a(var('X'), n243), a(var('X'), n242)).
clause(731, a(var('X'), n244), a(var('X'), n243)).
clause(734, a(var('X'), n245), a(var('X'), n244)).
clause(737, a(var('X'), n246), a(var('X'), n245)).
clause(740, a(var('X'), n247), a(var('X'), n246)).
clause(743, a(var('X'), n248), a(var('X'), n247)).
clause(746, a(var('X'), n249), a(var('X'), n248)).
clause(749, a(var('X'), n250), a(var('X'), n249)).
clause(752, a(var('X'), n251), a(var('X'), n250)).
clause(755, a(var('X'), n252), a(var('X'), n251)).
clause(758, a(var('X'), n253), a(var('X'), n252)).
clause(761, a(var('X'), n254), a(var('X'), n253)).
clause(764, a(var('X'), n255), a(var('X'), n254)).
clause(767, a(var('X'), n256), a(var('X'), n255)).
clause(770, a(var('X'), n257), a(var('X'), n256)).
clause(773, a(var('X'), n258), a(var('X'), n257)).
clause(776, a(var('X'), n259), a(var('X'), n258)).
clause(779, a(var('X'), n260), a(var('X'), n259)).
clause(782, a(var('X'), n261), a(var('X'), n260)).
clause(785, a(var('X'), n262), a(var('X'), n261)).
clause(788, a(var('X'), n263), a(var('X'), n262)).
clause(791, a(var('X'), n264), a(var('X'), n263)).
clause(794, a(var('X'), n265), a(var('X'), n264)).
clause(797, a(var('X'), n266), a(var('X'), n265)).
clause(800, a(var('X'), n267), a(var('X'), n266)).
clause(803, a(var('X'), n268), a(var('X'), n267)).
clause(806, a(var('X'), n269), a(var('X'), n268)).
clause(809, a(var('X'), n270), a(var('X'), n269)).
clause(812, a(var('X'), n271), a(var('X'), n270)).
clause(815, a(var('X'), n272), a(var('X'), n271)).
clause(818, a(var('X'), n273), a(var('X'), n272)).
clause(821, a(var('X'), n274), a(var('X'), n273)).
clause(824, a(var('X'), n275), a(var('X'), n274)).
clause(827, a(var('X'), n276), a(var('X'), n275)).
clause(830, a(var('X'), n277), a(var('X'), n276)).
clause(833, a(var('X'), n278), a(var('X'), n277)).
clause(836, a(var('X'), n279), a(var('X'), n278)).
clause(839, a(var('X'), n280), a(var('X'), n279)).
clause(842, a(var('X'), n281), a(var('X'), n280)).
clause(845, a(var('X'), n282), a(var('X'), n281)).
clause(848, a(var('X'), n283), a(var('X'), n282)).
clause(851, a(var('X'), n284), a(var('X'), n283)).
clause(854, a(var('X'), n285), a(var('X'), n284)).
clause(857, a(var('X'), n286), a(var('X'), n285)).
clause(860, a(var('X'), n287), a(var('X'), n286)).
clause(863, a(var('X'), n288), a(var('X'), n287)).
clause(866, a(var('X'), n289), a(var('X'), n288)).
clause(869, a(var('X'), n290), a(var('X'), n289)).
clause(872, a(var('X'), n291), a(var('X'), n290)).
clause(875, a(var('X'), n292), a(var('X'), n291)).
clause(878, a(var('X'), n293), a(var('X'), n292)).
clause(881, a(var('X'), n294), a(var('X'), n293)).
clause(884, a(var('X'), n295), a(var('X'), n294)).
clause(887, a(var('X'), n296), a(var('X'), n295)).
clause(890, a(var('X'), n297), a(var('X'), n296)).
clause(893, a(var('X'), n298), a(var('X'), n297)).
clause(896, a(var('X'), n299), a(var('X'), n298)).
clause(899, a(var('X'), n300), a(var('X'), n299)).
clause(902, a(var('X'), n301), a(var('X'), n300)).
clause(905, a(var('X'), n302), a(var('X'), n301)).
clause(908, a(var('X'), n303), a(var('X'), n302)).
clause(911, a(var('X'), n304), a(var('X'), n303)).
clause(914, a(var('X'), n305), a(var('X'), n304)).
clause(917, a(var('X'), n306), a(var('X'), n305)).
clause(920, a(var('X'), n307), a(var('X'), n306)).
clause(923, a(var('X'), n308), a(var('X'), n307)).
clause(926, a(var('X'), n309), a(var('X'), n308)).
clause(929, a(var('X'), n310), a(var('X'), n309)).
clause(932, a(var('X'), n311), a(var('X'), n310)).
clause(935, a(var('X'), n312), a(var('X'), n311)).
clause(938, a(var('X'), n313), a(var('X'), n312)).
clause(941, a(var('X'), n314), a(var('X'), n313)).
clause(944, a(var('X'), n315), a(var('X'), n314)).
clause(947, a(var('X'), n316), a(var('X'), n315)).
clause(950, a(var('X'), n317), a(var('X'), n316)).
clause(953, a(var('X'), n318), a(var('X'), n317)).
clause(956, a(var('X'), n319), a(var('X'), n318)).
clause(959, a(var('X'), n320), a(var('X'), n319)).
clause(962, a(var('X'), n321), a(var('X'), n320)).
clause(965, a(var('X'), n322), a(var('X'), n321)).
clause(968, a(var('X'), n323), a(var('X'), n322)).
clause(971, a(var('X'), n324), a(var('X'), n323)).
clause(974, a(var('X'), n325), a(var('X'), n324)).
clause(977, a(var('X'), n326), a(var('X'), n325)).
clause(980, a(var('X'), n327), a(var('X'), n326)).
clause(983, a(var('X'), n328), a(var('X'), n327)).
clause(986, a(var('X'), n329), a(var('X'), n328)).
clause(989, a(var('X'), n330), a(var('X'), n329)).
clause(992, a(var('X'), n331), a(var('X'), n330)).
clause(995, a(var('X'), n332), a(var('X'), n331)).
clause(998, a(var('X'), n333), a(var('X'), n332)).
clause(1001, a(var('X'), n334), a(var('X'), n333)).
clause(1004, a(var('X'), n335), a(var('X'), n334)).
clause(1007, a(var('X'), n336), a(var('X'), n335)).
clause(1010, a(var('X'), n337), a(var('X'), n336)).
clause(1013, a(var('X'), n338), a(var('X'), n337)).
clause(1016, a(var('X'), n339), a(var('X'), n338)).
clause(1019, a(var('X'), n340), a(var('X'), n339)).
clause(1022, a(var('X'), n341), a(var('X'), n340)).
clause(1025, a(var('X'), n342), a(var('X'), n341)).
clause(1028, a(var('X'), n343), a(var('X'), n342)).
clause(1031, a(var('X'), n344), a(var('X'), n343)).
clause(1034, a(var('X'), n345), a(var('X'), n344)).
clause(1037, a(var('X'), n346), a(var('X'), n345)).
clause(1040, a(var('X'), n347), a(var('X'), n346)).
clause(1043, a(var('X'), n348), a(var('X'), n347)).
clause(1046, a(var('X'), n349), a(var('X'), n348)).
clause(1049, a(var('X'), n350), a(var('X'), n349)).
clause(1052, a(var('X'), n351), a(var('X'), n350)).
clause(1055, a(var('X'), n352), a(var('X'), n351)).
clause(1058, a(var('X'), n353), a(var('X'), n352)).
clause(1061, a(var('X'), n354), a(var('X'), n353)).
clause(1064, a(var('X'), n355), a(var('X'), n354)).
clause(1067, a(var('X'), n356), a(var('X'), n355)).
clause(1070, a(var('X'), n357), a(var('X'), n356)).
clause(1073, a(var('X'), n358), a(var('X'), n357)).
clause(1076, a(var('X'), n359), a(var('X'), n358)).
clause(1079, a(var('X'), n360), a(var('X'), n359)).
clause(1082, a(var('X'), n361), a(var('X'), n360)).
clause(1085, a(var('X'), n362), a(var('X'), n361)).
clause(1088, a(var('X'), n363), a(var('X'), n362)).
clause(1091, a(var('X'), n364), a(var('X'), n363)).
clause(1094, a(var('X'), n365), a(var('X'), n364)).
clause(1097, a(var('X'), n366), a(var('X'), n365)).
clause(1100, a(var('X'), n367), a(var('X'), n366)).
clause(1103, a(var('X'), n368), a(var('X'), n367)).
clause(1106, a(var('X'), n369), a(var('X'), n368)).
clause(1109, a(var('X'), n370), a(var('X'), n369)).
clause(1112, a(var('X'), n371), a(var('X'), n370)).
clause(1115, a(var('X'), n372), a(var('X'), n371)).
clause(1118, a(var('X'), n373), a(var('X'), n372)).
clause(1121, a(var('X'), n374), a(var('X'), n373)).
clause(1124, a(var('X'), n375), a(var('X'), n374)).
clause(1127, a(var('X'), n376), a(var('X'), n375)).
clause(1130, a(var('X'), n377), a(var('X'), n376)).
clause(1133, a(var('X'), n378), a(var('X'), n377)).
clause(1136, a(var('X'), n379), a(var('X'), n378)).
clause(1139, a(var('X'), n380), a(var('X'), n379)).
clause(1142, a(var('X'), n381), a(var('X'), n380)).
clause(1145, a(var('X'), n382), a(var('X'), n381)).
clause(1148, a(var('X'), n383), a(var('X'), n382)).
clause(1151, a(var('X'), n384), a(var('X'), n383)).
clause(1154, a(var('X'), n385), a(var('X'), n384)).
clause(1157, a(var('X'), n386), a(var('X'), n385)).
clause(1160, a(var('X'), n387), a(var('X'), n386)).
clause(1163, a(var('X'), n388), a(var('X'), n387)).
clause(1166, a(var('X'), n389), a(var('X'), n388)).
clause(1169, a(var('X'), n390), a(var('X'), n389)).
clause(1172, a(var('X'), n391), a(var('X'), n390)).
clause(1175, a(var('X'), n392), a(var('X'), n391)).
clause(1178, a(var('X'), n393), a(var('X'), n392)).
clause(1181, a(var('X'), n394), a(var('X'), n393)).
clause(1184, a(var('X'), n395), a(var('X'), n394)).
clause(1187, a(var('X'), n396), a(var('X'), n395)).
clause(1190, a(var('X'), n397), a(var('X'), n396)).
clause(1193, a(var('X'), n398), a(var('X'), n397)).
clause(1196, a(var('X'), n399), a(var('X'), n398)).
clause(1199, a(var('X'), n400), a(var('X'), n399)).
clause(1202, a(var('X'), n401), a(var('X'), n400)).
clause(1205, a(var('X'), n402), a(var('X'), n401)).
clause(1208, a(var('X'), n403), a(var('X'), n402)).
clause(1211, a(var('X'), n404), a(var('X'), n403)).
clause(1214, a(var('X'), n405), a(var('X'), n404)).
clause(1217, a(var('X'), n406), a(var('X'), n405)).
clause(1220, a(var('X'), n407), a(var('X'), n406)).
clause(1223, a(var('X'), n408), a(var('X'), n407)).
clause(1226, a(var('X'), n409), a(var('X'), n408)).
clause(1229, a(var('X'), n410), a(var('X'), n409)).
clause(1232, a(var('X'), n411), a(var('X'), n410)).
clause(1235, a(var('X'), n412), a(var('X'), n411)).
clause(1238, a(var('X'), n413), a(var('X'), n412)).
clause(1241, a(var('X'), n414), a(var('X'), n413)).
clause(1244, a(var('X'), n415), a(var('X'), n414)).
clause(1247, a(var('X'), n416), a(var('X'), n415)).
clause(1250, a(var('X'), n417), a(var('X'), n416)).
clause(1253, a(var('X'), n418), a(var('X'), n417)).
clause(1256, a(var('X'), n419), a(var('X'), n418)).
clause(1259, a(var('X'), n420), a(var('X'), n419)).
clause(1262, a(var('X'), n421), a(var('X'), n420)).
clause(1265, a(var('X'), n422), a(var('X'), n421)).
clause(1268, a(var('X'), n423), a(var('X'), n422)).
clause(1271, a(var('X'), n424), a(var('X'), n423)).
clause(1274, a(var('X'), n425), a(var('X'), n424)).
clause(1277, a(var('X'), n426), a(var('X'), n425)).
clause(1280, a(var('X'), n427), a(var('X'), n426)).
clause(1283, a(var('X'), n428), a(var('X'), n427)).
clause(1286, a(var('X'), n429), a(var('X'), n428)).
clause(1289, a(var('X'), n430), a(var('X'), n429)).
clause(1292, a(var('X'), n431), a(var('X'), n430)).
clause(1295, a(var('X'), n432), a(var('X'), n431)).
clause(1298, a(var('X'), n433), a(var('X'), n432)).
clause(1301, a(var('X'), n434), a(var('X'), n433)).
clause(1304, a(var('X'), n435), a(var('X'), n434)).
clause(1307, a(var('X'), n436), a(var('X'), n435)).
clause(1310, a(var('X'), n437), a(var('X'), n436)).
clause(1313, a(var('X'), n438), a(var('X'), n437)).
clause(1316, a(var('X'), n439), a(var('X'), n438)).
clause(1319, a(var('X'), n440), a(var('X'), n439)).
clause(1322, a(var('X'), n441), a(var('X'), n440)).
clause(1325, a(var('X'), n442), a(var('X'), n441)).
clause(1328, a(var('X'), n443), a(var('X'), n442)).
clause(1331, a(var('X'), n444), a(var('X'), n443)).
clause(1334, a(var('X'), n445), a(var('X'), n444)).
clause(1337, a(var('X'), n446), a(var('X'), n445)).
clause(1340, a(var('X'), n447), a(var('X'), n446)).
clause(1343, a(var('X'), n448), a(var('X'), n447)).
clause(1346, a(var('X'), n449), a(var('X'), n448)).
clause(1349, a(var('X'), n450), a(var('X'), n449)).
clause(1352, a(var('X'), n451), a(var('X'), n450)).
clause(1355, a(var('X'), n452), a(var('X'), n451)).
clause(1358, a(var('X'), n453), a(var('X'), n452)).
clause(1361, a(var('X'), n454), a(var('X'), n453)).
clause(1364, a(var('X'), n455), a(var('X'), n454)).
clause(1367, a(var('X'), n456), a(var('X'), n455)).
clause(1370, a(var('X'), n457), a(var('X'), n456)).
clause(1373, a(var('X'), n458), a(var('X'), n457)).
clause(1376, a(var('X'), n459), a(var('X'), n458)).
clause(1379, a(var('X'), n460), a(var('X'), n459)).
clause(1382, a(var('X'), n461), a(var('X'), n460)).
clause(1385, a(var('X'), n462), a(var('X'), n461)).
clause(1388, a(var('X'), n463), a(var('X'), n462)).
clause(1391, a(var('X'), n464), a(var('X'), n463)).
clause(1394, a(var('X'), n465), a(var('X'), n464)).
clause(1397, a(var('X'), n466), a(var('X'), n465)).
clause(1400, a(var('X'), n467), a(var('X'), n466)).
clause(1403, a(var('X'), n468), a(var('X'), n467)).
clause(1406, a(var('X'), n469), a(var('X'), n468)).
clause(1409, a(var('X'), n470), a(var('X'), n469)).
clause(1412, a(var('X'), n471), a(var('X'), n470)).
clause(1415, a(var('X'), n472), a(var('X'), n471)).
clause(1418, a(var('X'), n473), a(var('X'), n472)).
clause(1421, a(var('X'), n474), a(var('X'), n473)).
clause(1424, a(var('X'), n475), a(var('X'), n474)).
clause(1427, a(var('X'), n476), a(var('X'), n475)).
clause(1430, a(var('X'), n477), a(var('X'), n476)).
clause(1433, a(var('X'), n478), a(var('X'), n477)).
clause(1436, a(var('X'), n479), a(var('X'), n478)).
clause(1439, a(var('X'), n480), a(var('X'), n479)).
clause(1442, a(var('X'), n481), a(var('X'), n480)).
clause(1445, a(var('X'), n482), a(var('X'), n481)).
clause(1448, a(var('X'), n483), a(var('X'), n482)).
clause(1451, a(var('X'), n484), a(var('X'), n483)).
clause(1454, a(var('X'), n485), a(var('X'), n484)).
clause(1457, a(var('X'), n486), a(var('X'), n485)).
clause(1460, a(var('X'), n487), a(var('X'), n486)).
clause(1463, a(var('X'), n488), a(var('X'), n487)).
clause(1466, a(var('X'), n489), a(var('X'), n488)).
clause(1469, a(var('X'), n490), a(var('X'), n489)).
clause(1472, a(var('X'), n491), a(var('X'), n490)).
clause(1475, a(var('X'), n492), a(var('X'), n491)).
clause(1478, a(var('X'), n493), a(var('X'), n492)).
clause(1481, a(var('X'), n494), a(var('X'), n493)).
clause(1484, a(var('X'), n495), a(var('X'), n494)).
clause(1487, a(var('X'), n496), a(var('X'), n495)).
clause(1490, a(var('X'), n497), a(var('X'), n496)).
clause(1493, a(var('X'), n498), a(var('X'), n497)).
clause(1496, a(var('X'), n499), a(var('X'), n498)).
clause(1499, a(var('X'), n500), a(var('X'), n499)).
clause(1500, a(var('X'), i500), a(var('X'), n499)).
clause(1501, a(var('X'), j500), a(var('X'), n499)).
clause(1502, a(var('X'), n501), a(var('X'), n500)).
clause(1505, a(var('X'), n502), a(var('X'), n501)).
clause(1508, a(var('X'), n503), a(var('X'), n502)).
clause(1511, a(var('X'), n504), a(var('X'), n503)).
clause(1514, a(var('X'), n505), a(var('X'), n504)).
clause(1517, a(var('X'), n506), a(var('X'), n505)).
clause(1520, a(var('X'), n507), a(var('X'), n506)).
clause(1523, a(var('X'), n508), a(var('X'), n507)).
clause(1526, a(var('X'), n509), a(var('X'), n508)).
clause(1529, a(var('X'), n510), a(var('X'), n509)).
clause(1532, a(var('X'), n511), a(var('X'), n510)).
clause(1535, a(var('X'), n512), a(var('X'), n511)).
clause(1538, a(var('X'), n513), a(var('X'), n512)).
clause(1541, a(var('X'), n514), a(var('X'), n513)).
clause(1544, a(var('X'), n515), a(var('X'), n514)).
clause(1547, a(var('X'), n516), a(var('X'), n515)).
clause(1550, a(var('X'), n517), a(var('X'), n516)).
clause(1553, a(var('X'), n518), a(var('X'), n517)).
clause(1556, a(var('X'), n519), a(var('X'), n518)).
clause(1559, a(var('X'), n520), a(var('X'), n519)).
clause(1562, a(var('X'), n521), a(var('X'), n520)).
clause(1565, a(var('X'), n522), a(var('X'), n521)).
clause(1568, a(var('X'), n523), a(var('X'), n522)).
clause(1571, a(var('X'), n524), a(var('X'), n523)).
clause(1574, a(var('X'), n525), a(var('X'), n524)).
clause(1577, a(var('X'), n526), a(var('X'), n525)).
clause(1580, a(var('X'), n527), a(var('X'), n526)).
clause(1583, a(var('X'), n528), a(var('X'), n527)).
clause(1586, a(var('X'), n529), a(var('X'), n528)).
clause(1589, a(var('X'), n530), a(var('X'), n529)).
clause(1592, a(var('X'), n531), a(var('X'), n530)).
clause(1595, a(var('X'), n532), a(var('X'), n531)).
clause(1598, a(var('X'), n533), a(var('X'), n532)).
clause(1601, a(var('X'), n534), a(var('X'), n533)).
clause(1604, a(var('X'), n535), a(var('X'), n534)).
clause(1607, a(var('X'), n536), a(var('X'), n535)).
clause(1610, a(var('X'), n537), a(var('X'), n536)).
clause(1613, a(var('X'), n538), a(var('X'), n537)).
clause(1616, a(var('X'), n539), a(var('X'), n538)).
clause(1619, a(var('X'), n540), a(var('X'), n539)).
clause(1622, a(var('X'), n541), a(var('X'), n540)).
clause(1625, a(var('X'), n542), a(var('X'), n541)).
clause(1628, a(var('X'), n543), a(var('X'), n542)).
clause(1631, a(var('X'), n544), a(var('X'), n543)).
clause(1634, a(var('X'), n545), a(var('X'), n544)).
clause(1637, a(var('X'), n546), a(var('X'), n545)).
clause(1640, a(var('X'), n547), a(var('X'), n546)).
clause(1643, a(var('X'), n548), a(var('X'), n547)).
clause(1646, a(var('X'), n549), a(var('X'), n548)).
clause(1649, a(var('X'), n550), a(var('X'), n549)).
clause(1652, a(var('X'), n551), a(var('X'), n550)).
clause(1655, a(var('X'), n552), a(var('X'), n551)).
clause(1658, a(var('X'), n553), a(var('X'), n552)).
clause(1661, a(var('X'), n554), a(var('X'), n553)).
clause(1664, a(var('X'), n555), a(var('X'), n554)).
clause(1667, a(var('X'), n556), a(var('X'), n555)).
clause(1670, a(var('X'), n557), a(var('X'), n556)).
clause(1673, a(var('X'), n558), a(var('X'), n557)).
clause(1676, a(var('X'), n559), a(var('X'), n558)).
clause(1679, a(var('X'), n560), a(var('X'), n559)).
clause(1682, a(var('X'), n561), a(var('X'), n560)).
clause(1685, a(var('X'), n562), a(var('X'), n561)).
clause(1688, a(var('X'), n563), a(var('X'), n562)).
clause(1691, a(var('X'), n564), a(var('X'), n563)).
clause(1694, a(var('X'), n565), a(var('X'), n564)).
clause(1697, a(var('X'), n566), a(var('X'), n565)).
clause(1700, a(var('X'), n567), a(var('X'), n566)).
clause(1703, a(var('X'), n568), a(var('X'), n567)).
clause(1706, a(var('X'), n569), a(var('X'), n568)).
clause(1709, a(var('X'), n570), a(var('X'), n569)).
clause(1712, a(var('X'), n571), a(var('X'), n570)).
clause(1715, a(var('X'), n572), a(var('X'), n571)).
clause(1718, a(var('X'), n573), a(var('X'), n572)).
clause(1721, a(var('X'), n574), a(var('X'), n573)).
clause(1724, a(var('X'), n575), a(var('X'), n574)).
clause(1727, a(var('X'), n576), a(var('X'), n575)).
clause(1730, a(var('X'), n577), a(var('X'), n576)).
clause(1733, a(var('X'), n578), a(var('X'), n577)).
clause(1736, a(var('X'), n579), a(var('X'), n578)).
clause(1739, a(var('X'), n580), a(var('X'), n579)).
clause(1742, a(var('X'), n581), a(var('X'), n580)).
clause(1745, a(var('X'), n582), a(var('X'), n581)).
clause(1748, a(var('X'), n583), a(var('X'), n582)).
clause(1751, a(var('X'), n584), a(var('X'), n583)).
clause(1754, a(var('X'), n585), a(var('X'), n584)).
clause(1757, a(var('X'), n586), a(var('X'), n585)).
clause(1760, a(var('X'), n587), a(var('X'), n586)).
clause(1763, a(var('X'), n588), a(var('X'), n587)).
clause(1766, a(var('X'), n589), a(var('X'), n588)).
clause(1769, a(var('X'), n590), a(var('X'), n589)).
clause(1772, a(var('X'), n591), a(var('X'), n590)).
clause(1775, a(var('X'), n592), a(var('X'), n591)).
clause(1778, a(var('X'), n593), a(var('X'), n592)).
clause(1781, a(var('X'), n594), a(var('X'), n593)).
clause(1784, a(var('X'), n595), a(var('X'), n594)).
clause(1787, a(var('X'), n596), a(var('X'), n595)).
clause(1790, a(var('X'), n597), a(var('X'), n596)).
clause(1793, a(var('X'), n598), a(var('X'), n597)).
clause(1796, a(var('X'), n599), a(var('X'), n598)).
clause(1799, a(var('X'), n600), a(var('X'), n599)).
clause(1802, a(var('X'), n601), a(var('X'), n600)).
clause(1805, a(var('X'), n602), a(var('X'), n601)).
clause(1808, a(var('X'), n603), a(var('X'), n602)).
clause(1811, a(var('X'), n604), a(var('X'), n603)).
clause(1814, a(var('X'), n605), a(var('X'), n604)).
clause(1817, a(var('X'), n606), a(var('X'), n605)).
clause(1820, a(var('X'), n607), a(var('X'), n606)).
clause(1823, a(var('X'), n608), a(var('X'), n607)).
clause(1826, a(var('X'), n609), a(var('X'), n608)).
clause(1829, a(var('X'), n610), a(var('X'), n609)).
clause(1832, a(var('X'), n611), a(var('X'), n610)).
clause(1835, a(var('X'), n612), a(var('X'), n611)).
clause(1838, a(var('X'), n613), a(var('X'), n612)).
clause(1841, a(var('X'), n614), a(var('X'), n613)).
clause(1844, a(var('X'), n615), a(var('X'), n614)).
clause(1847, a(var('X'), n616), a(var('X'), n615)).
clause(1850, a(var('X'), n617), a(var('X'), n616)).
clause(1853, a(var('X'), n618), a(var('X'), n617)).
clause(1856, a(var('X'), n619), a(var('X'), n618)).
clause(1859, a(var('X'), n620), a(var('X'), n619)).
clause(1862, a(var('X'), n621), a(var('X'), n620)).
clause(1865, a(var('X'), n622), a(var('X'), n621)).
clause(1868, a(var('X'), n623), a(var('X'), n622)).
clause(1871, a(var('X'), n624), a(var('X'), n623)).
clause(1874, a(var('X'), n625), a(var('X'), n624)).
clause(1877, a(var('X'), n626), a(var('X'), n625)).
clause(1880, a(var('X'), n627), a(var('X'), n626)).
clause(1883, a(var('X'), n628), a(var('X'), n627)).
clause(1886, a(var('X'), n629), a(var('X'), n628)).
clause(1889, a(var('X'), n630), a(var('X'), n629)).
clause(1892, a(var('X'), n631), a(var('X'), n630)).
clause(1895, a(var('X'), n632), a(var('X'), n631)).
clause(1898, a(var('X'), n633), a(var('X'), n632)).
clause(1901, a(var('X'), n634), a(var('X'), n633)).
clause(1904, a(var('X'), n635), a(var('X'), n634)).
clause(1907, a(var('X'), n636), a(var('X'), n635)).
clause(1910, a(var('X'), n637), a(var('X'), n636)).
clause(1913, a(var('X'), n638), a(var('X'), n637)).
clause(1916, a(var('X'), n639), a(var('X'), n638)).
clause(1919, a(var('X'), n640), a(var('X'), n639)).
clause(1922, a(var('X'), n641), a(var('X'), n640)).
clause(1925, a(var('X'), n642), a(var('X'), n641)).
clause(1928, a(var('X'), n643), a(var('X'), n642)).
clause(1931, a(var('X'), n644), a(var('X'), n643)).
clause(1934, a(var('X'), n645), a(var('X'), n644)).
clause(1937, a(var('X'), n646), a(var('X'), n645)).
clause(1940, a(var('X'), n647), a(var('X'), n646)).
clause(1943, a(var('X'), n648), a(var('X'), n647)).
clause(1946, a(var('X'), n649), a(var('X'), n648)).
clause(1949, a(var('X'), n650), a(var('X'), n649)).
clause(1952, a(var('X'), n651), a(var('X'), n650)).
clause(1955, a(var('X'), n652), a(var('X'), n651)).
clause(1958, a(var('X'), n653), a(var('X'), n652)).
clause(1961, a(var('X'), n654), a(var('X'), n653)).
clause(1964, a(var('X'), n655), a(var('X'), n654)).
clause(1967, a(var('X'), n656), a(var('X'), n655)).
clause(1970, a(var('X'), n657), a(var('X'), n656)).
clause(1973, a(var('X'), n658), a(var('X'), n657)).
clause(1976, a(var('X'), n659), a(var('X'), n658)).
clause(1979, a(var('X'), n660), a(var('X'), n659)).
clause(1982, a(var('X'), n661), a(var('X'), n660)).
clause(1985, a(var('X'), n662), a(var('X'), n661)).
clause(1988, a(var('X'), n663), a(var('X'), n662)).
clause(1991, a(var('X'), n664), a(var('X'), n663)).
clause(1994, a(var('X'), n665), a(var('X'), n664)).
clause(1997, a(var('X'), n666), a(var('X'), n665)).
clause(2000, a(var('X'), n667), a(var('X'), n666)).
clause(2003, a(var('X'), n668), a(var('X'), n667)).
clause(2006, a(var('X'), n669), a(var('X'), n668)).
clause(2009, a(var('X'), n670), a(var('X'), n669)).
clause(2012, a(var('X'), n671), a(var('X'), n670)).
clause(2015, a(var('X'), n672), a(var('X'), n671)).
clause(2018, a(var('X'), n673), a(var('X'), n672)).
clause(2021, a(var('X'), n674), a(var('X'), n673)).
clause(2024, a(var('X'), n675), a(var('X'), n674)).
clause(2027, a(var('X'), n676), a(var('X'), n675)).
clause(2030, a(var('X'), n677), a(var('X'), n676)).
clause(2033, a(var('X'), n678), a(var('X'), n677)).
clause(2036, a(var('X'), n679), a(var('X'), n678)).
clause(2039, a(var('X'), n680), a(var('X'), n679)).
clause(2042, a(var('X'), n681), a(var('X'), n680)).
clause(2045, a(var('X'), n682), a(var('X'), n681)).
clause(2048, a(var('X'), n683), a(var('X'), n682)).
clause(2051, a(var('X'), n684), a(var('X'), n683)).
clause(2054, a(var('X'), n685), a(var('X'), n684)).
clause(2057, a(var('X'), n686), a(var('X'), n685)).
clause(2060, a(var('X'), n687), a(var('X'), n686)).
clause(2063, a(var('X'), n688), a(var('X'), n687)).
clause(2066, a(var('X'), n689), a(var('X'), n688)).
clause(2069, a(var('X'), n690), a(var('X'), n689)).
clause(2072, a(var('X'), n691), a(var('X'), n690)).
clause(2075, a(var('X'), n692), a(var('X'), n691)).
clause(2078, a(var('X'), n693), a(var('X'), n692)).
clause(2081, a(var('X'), n694), a(var('X'), n693)).
clause(2084, a(var('X'), n695), a(var('X'), n694)).
clause(2087, a(var('X'), n696), a(var('X'), n695)).
clause(2090, a(var('X'), n697), a(var('X'), n696)).
clause(2093, a(var('X'), n698), a(var('X'), n697)).
clause(2096, a(var('X'), n699), a(var('X'), n698)).
clause(2099, a(var('X'), n700), a(var('X'), n699)).
clause(2102, a(var('X'), n701), a(var('X'), n700)).
clause(2105, a(var('X'), n702), a(var('X'), n701)).
clause(2108, a(var('X'), n703), a(var('X'), n702)).
clause(2111, a(var('X'), n704), a(var('X'), n703)).
clause(2114, a(var('X'), n705), a(var('X'), n704)).
clause(2117, a(var('X'), n706), a(var('X'), n705)).
clause(2120, a(var('X'), n707), a(var('X'), n706)).
clause(2123, a(var('X'), n708), a(var('X'), n707)).
clause(2126, a(var('X'), n709), a(var('X'), n708)).
clause(2129, a(var('X'), n710), a(var('X'), n709)).
clause(2132, a(var('X'), n711), a(var('X'), n710)).
clause(2135, a(var('X'), n712), a(var('X'), n711)).
clause(2138, a(var('X'), n713), a(var('X'), n712)).
clause(2141, a(var('X'), n714), a(var('X'), n713)).
clause(2144, a(var('X'), n715), a(var('X'), n714)).
clause(2147, a(var('X'), n716), a(var('X'), n715)).
clause(2150, a(var('X'), n717), a(var('X'), n716)).
clause(2153, a(var('X'), n718), a(var('X'), n717)).
clause(2156, a(var('X'), n719), a(var('X'), n718)).
clause(2159, a(var('X'), n720), a(var('X'), n719)).
clause(2162, a(var('X'), n721), a(var('X'), n720)).
clause(2165, a(var('X'), n722), a(var('X'), n721)).
clause(2168, a(var('X'), n723), a(var('X'), n722)).
clause(2171, a(var('X'), n724), a(var('X'), n723)).
clause(2174, a(var('X'), n725), a(var('X'), n724)).
clause(2177, a(var('X'), n726), a(var('X'), n725)).
clause(2180, a(var('X'), n727), a(var('X'), n726)).
clause(2183, a(var('X'), n728), a(var('X'), n727)).
clause(2186, a(var('X'), n729), a(var('X'), n728)).
clause(2189, a(var('X'), n730), a(var('X'), n729)).
clause(2192, a(var('X'), n731), a(var('X'), n730)).
clause(2195, a(var('X'), n732), a(var('X'), n731)).
clause(2198, a(var('X'), n733), a(var('X'), n732)).
clause(2201, a(var('X'), n734), a(var('X'), n733)).
clause(2204, a(var('X'), n735), a(var('X'), n734)).
clause(2207, a(var('X'), n736), a(var('X'), n735)).
clause(2210, a(var('X'), n737), a(var('X'), n736)).
clause(2213, a(var('X'), n738), a(var('X'), n737)).
clause(2216, a(var('X'), n739), a(var('X'), n738)).
clause(2219, a(var('X'), n740), a(var('X'), n739)).
clause(2222, a(var('X'), n741), a(var('X'), n740)).
clause(2225, a(var('X'), n742), a(var('X'), n741)).
clause(2228, a(var('X'), n743), a(var('X'), n742)).
clause(2231, a(var('X'), n744), a(var('X'), n743)).
clause(2234, a(var('X'), n745), a(var('X'), n744)).
clause(2237, a(var('X'), n746), a(var('X'), n745)).
clause(2240, a(var('X'), n747), a(var('X'), n746)).
clause(2243, a(var('X'), n748), a(var('X'), n747)).
clause(2246, a(var('X'), n749), a(var('X'), n748)).
clause(2249, a(var('X'), n750), a(var('X'), n749)).
clause(2252, a(var('X'), n751), a(var('X'), n750)).
clause(2255, a(var('X'), n752), a(var('X'), n751)).
clause(2258, a(var('X'), n753), a(var('X'), n752)).
clause(2261, a(var('X'), n754), a(var('X'), n753)).
clause(2264, a(var('X'), n755), a(var('X'), n754)).
clause(2267, a(var('X'), n756), a(var('X'), n755)).
clause(2270, a(var('X'), n757), a(var('X'), n756)).
clause(2273, a(var('X'), n758), a(var('X'), n757)).
clause(2276, a(var('X'), n759), a(var('X'), n758)).
clause(2279, a(var('X'), n760), a(var('X'), n759)).
clause(2282, a(var('X'), n761), a(var('X'), n760)).
clause(2285, a(var('X'), n762), a(var('X'), n761)).
clause(2288, a(var('X'), n763), a(var('X'), n762)).
clause(2291, a(var('X'), n764), a(var('X'), n763)).
clause(2294, a(var('X'), n765), a(var('X'), n764)).
clause(2297, a(var('X'), n766), a(var('X'), n765)).
clause(2300, a(var('X'), n767), a(var('X'), n766)).
clause(2303, a(var('X'), n768), a(var('X'), n767)).
clause(2306, a(var('X'), n769), a(var('X'), n768)).
clause(2309, a(var('X'), n770), a(var('X'), n769)).
clause(2312, a(var('X'), n771), a(var('X'), n770)).
clause(2315, a(var('X'), n772), a(var('X'), n771)).
clause(2318, a(var('X'), n773), a(var('X'), n772)).
clause(2321, a(var('X'), n774), a(var('X'), n773)).
clause(2324, a(var('X'), n775), a(var('X'), n774)).
clause(2327, a(var('X'), n776), a(var('X'), n775)).
clause(2330, a(var('X'), n777), a(var('X'), n776)).
clause(2333, a(var('X'), n778), a(var('X'), n777)).
clause(2336, a(var('X'), n779), a(var('X'), n778)).
clause(2339, a(var('X'), n780), a(var('X'), n779)).
clause(2342, a(var('X'), n781), a(var('X'), n780)).
clause(2345, a(var('X'), n782), a(var('X'), n781)).
clause(2348, a(var('X'), n783), a(var('X'), n782)).
clause(2351, a(var('X'), n784), a(var('X'), n783)).
clause(2354, a(var('X'), n785), a(var('X'), n784)).
clause(2357, a(var('X'), n786), a(var('X'), n785)).
clause(2360, a(var('X'), n787), a(var('X'), n786)).
clause(2363, a(var('X'), n788), a(var('X'), n787)).
clause(2366, a(var('X'), n789), a(var('X'), n788)).
clause(2369, a(var('X'), n790), a(var('X'), n789)).
clause(2372, a(var('X'), n791), a(var('X'), n790)).
clause(2375, a(var('X'), n792), a(var('X'), n791)).
clause(2378, a(var('X'), n793), a(var('X'), n792)).
clause(2381, a(var('X'), n794), a(var('X'), n793)).
clause(2384, a(var('X'), n795), a(var('X'), n794)).
clause(2387, a(var('X'), n796), a(var('X'), n795)).
clause(2390, a(var('X'), n797), a(var('X'), n796)).
clause(2393, a(var('X'), n798), a(var('X'), n797)).
clause(2396, a(var('X'), n799), a(var('X'), n798)).
clause(2399, a(var('X'), n800), a(var('X'), n799)).
clause(2402, a(var('X'), n801), a(var('X'), n800)).
clause(2405, a(var('X'), n802), a(var('X'), n801)).
clause(2408, a(var('X'), n803), a(var('X'), n802)).
clause(2411, a(var('X'), n804), a(var('X'), n803)).
clause(2414, a(var('X'), n805), a(var('X'), n804)).
clause(2417, a(var('X'), n806), a(var('X'), n805)).
clause(2420, a(var('X'), n807), a(var('X'), n806)).
clause(2423, a(var('X'), n808), a(var('X'), n807)).
clause(2426, a(var('X'), n809), a(var('X'), n808)).
clause(2429, a(var('X'), n810), a(var('X'), n809)).
clause(2432, a(var('X'), n811), a(var('X'), n810)).
clause(2435, a(var('X'), n812), a(var('X'), n811)).
clause(2438, a(var('X'), n813), a(var('X'), n812)).
clause(2441, a(var('X'), n814), a(var('X'), n813)).
clause(2444, a(var('X'), n815), a(var('X'), n814)).
clause(2447, a(var('X'), n816), a(var('X'), n815)).
clause(2450, a(var('X'), n817), a(var('X'), n816)).
clause(2453, a(var('X'), n818), a(var('X'), n817)).
clause(2456, a(var('X'), n819), a(var('X'), n818)).
clause(2459, a(var('X'), n820), a(var('X'), n819)).
clause(2462, a(var('X'), n821), a(var('X'), n820)).
clause(2465, a(var('X'), n822), a(var('X'), n821)).
clause(2468, a(var('X'), n823), a(var('X'), n822)).
clause(2471, a(var('X'), n824), a(var('X'), n823)).
clause(2474, a(var('X'), n825), a(var('X'), n824)).
clause(2477, a(var('X'), n826), a(var('X'), n825)).
clause(2480, a(var('X'), n827), a(var('X'), n826)).
clause(2483, a(var('X'), n828), a(var('X'), n827)).
clause(2486, a(var('X'), n829), a(var('X'), n828)).
clause(2489, a(var('X'), n830), a(var('X'), n829)).
clause(2492, a(var('X'), n831), a(var('X'), n830)).
clause(2495, a(var('X'), n832), a(var('X'), n831)).
clause(2498, a(var('X'), n833), a(var('X'), n832)).
clause(2501, a(var('X'), n834), a(var('X'), n833)).
clause(2504, a(var('X'), n835), a(var('X'), n834)).
clause(2507, a(var('X'), n836), a(var('X'), n835)).
clause(2510, a(var('X'), n837), a(var('X'), n836)).
clause(2513, a(var('X'), n838), a(var('X'), n837)).
clause(2516, a(var('X'), n839), a(var('X'), n838)).
clause(2519, a(var('X'), n840), a(var('X'), n839)).
clause(2522, a(var('X'), n841), a(var('X'), n840)).
clause(2525, a(var('X'), n842), a(var('X'), n841)).
clause(2528, a(var('X'), n843), a(var('X'), n842)).
clause(2531, a(var('X'), n844), a(var('X'), n843)).
clause(2534, a(var('X'), n845), a(var('X'), n844)).
clause(2537, a(var('X'), n846), a(var('X'), n845)).
clause(2540, a(var('X'), n847), a(var('X'), n846)).
clause(2543, a(var('X'), n848), a(var('X'), n847)).
clause(2546, a(var('X'), n849), a(var('X'), n848)).
clause(2549, a(var('X'), n850), a(var('X'), n849)).
clause(2552, a(var('X'), n851), a(var('X'), n850)).
clause(2555, a(var('X'), n852), a(var('X'), n851)).
clause(2558, a(var('X'), n853), a(var('X'), n852)).
clause(2561, a(var('X'), n854), a(var('X'), n853)).
clause(2564, a(var('X'), n855), a(var('X'), n854)).
clause(2567, a(var('X'), n856), a(var('X'), n855)).
clause(2570, a(var('X'), n857), a(var('X'), n856)).
clause(2573, a(var('X'), n858), a(var('X'), n857)).
clause(2576, a(var('X'), n859), a(var('X'), n858)).
clause(2579, a(var('X'), n860), a(var('X'), n859)).
clause(2582, a(var('X'), n861), a(var('X'), n860)).
clause(2585, a(var('X'), n862), a(var('X'), n861)).
clause(2588, a(var('X'), n863), a(var('X'), n862)).
clause(2591, a(var('X'), n864), a(var('X'), n863)).
clause(2594, a(var('X'), n865), a(var('X'), n864)).
clause(2597, a(var('X'), n866), a(var('X'), n865)).
clause(2600, a(var('X'), n867), a(var('X'), n866)).
clause(2603, a(var('X'), n868), a(var('X'), n867)).
clause(2606, a(var('X'), n869), a(var('X'), n868)).
clause(2609, a(var('X'), n870), a(var('X'), n869)).
clause(2612, a(var('X'), n871), a(var('X'), n870)).
clause(2615, a(var('X'), n872), a(var('X'), n871)).
clause(2618, a(var('X'), n873), a(var('X'), n872)).
clause(2621, a(var('X'), n874), a(var('X'), n873)).
clause(2624, a(var('X'), n875), a(var('X'), n874)).
clause(2627, a(var('X'), n876), a(var('X'), n875)).
clause(2630, a(var('X'), n877), a(var('X'), n876)).
clause(2633, a(var('X'), n878), a(var('X'), n877)).
clause(2636, a(var('X'), n879), a(var('X'), n878)).
clause(2639, a(var('X'), n880), a(var('X'), n879)).
clause(2642, a(var('X'), n881), a(var('X'), n880)).
clause(2645, a(var('X'), n882), a(var('X'), n881)).
clause(2648, a(var('X'), n883), a(var('X'), n882)).
clause(2651, a(var('X'), n884), a(var('X'), n883)).
clause(2654, a(var('X'), n885), a(var('X'), n884)).
clause(2657, a(var('X'), n886), a(var('X'), n885)).
clause(2660, a(var('X'), n887), a(var('X'), n886)).
clause(2663, a(var('X'), n888), a(var('X'), n887)).
clause(2666, a(var('X'), n889), a(var('X'), n888)).
clause(2669, a(var('X'), n890), a(var('X'), n889)).
clause(2672, a(var('X'), n891), a(var('X'), n890)).
clause(2675, a(var('X'), n892), a(var('X'), n891)).
clause(2678, a(var('X'), n893), a(var('X'), n892)).
clause(2681, a(var('X'), n894), a(var('X'), n893)).
clause(2684, a(var('X'), n895), a(var('X'), n894)).
clause(2687, a(var('X'), n896), a(var('X'), n895)).
clause(2690, a(var('X'), n897), a(var('X'), n896)).
clause(2693, a(var('X'), n898), a(var('X'), n897)).
clause(2696, a(var('X'), n899), a(var('X'), n898)).
clause(2699, a(var('X'), n900), a(var('X'), n899)).
clause(2702, a(var('X'), n901), a(var('X'), n900)).
clause(2705, a(var('X'), n902), a(var('X'), n901)).
clause(2708, a(var('X'), n903), a(var('X'), n902)).
clause(2711, a(var('X'), n904), a(var('X'), n903)).
clause(2714, a(var('X'), n905), a(var('X'), n904)).
clause(2717, a(var('X'), n906), a(var('X'), n905)).
clause(2720, a(var('X'), n907), a(var('X'), n906)).
clause(2723, a(var('X'), n908), a(var('X'), n907)).
clause(2726, a(var('X'), n909), a(var('X'), n908)).
clause(2729, a(var('X'), n910), a(var('X'), n909)).
clause(2732, a(var('X'), n911), a(var('X'), n910)).
clause(2735, a(var('X'), n912), a(var('X'), n911)).
clause(2738, a(var('X'), n913), a(var('X'), n912)).
clause(2741, a(var('X'), n914), a(var('X'), n913)).
clause(2744, a(var('X'), n915), a(var('X'), n914)).
clause(2747, a(var('X'), n916), a(var('X'), n915)).
clause(2750, a(var('X'), n917), a(var('X'), n916)).
clause(2753, a(var('X'), n918), a(var('X'), n917)).
clause(2756, a(var('X'), n919), a(var('X'), n918)).
clause(2759, a(var('X'), n920), a(var('X'), n919)).
clause(2762, a(var('X'), n921), a(var('X'), n920)).
clause(2765, a(var('X'), n922), a(var('X'), n921)).
clause(2768, a(var('X'), n923), a(var('X'), n922)).
clause(2771, a(var('X'), n924), a(var('X'), n923)).
clause(2774, a(var('X'), n925), a(var('X'), n924)).
clause(2777, a(var('X'), n926), a(var('X'), n925)).
clause(2780, a(var('X'), n927), a(var('X'), n926)).
clause(2783, a(var('X'), n928), a(var('X'), n927)).
clause(2786, a(var('X'), n929), a(var('X'), n928)).
clause(2789, a(var('X'), n930), a(var('X'), n929)).
clause(2792, a(var('X'), n931), a(var('X'), n930)).
clause(2795, a(var('X'), n932), a(var('X'), n931)).
clause(2798, a(var('X'), n933), a(var('X'), n932)).
clause(2801, a(var('X'), n934), a(var('X'), n933)).
clause(2804, a(var('X'), n935), a(var('X'), n934)).
clause(2807, a(var('X'), n936), a(var('X'), n935)).
clause(2810, a(var('X'), n937), a(var('X'), n936)).
clause(2813, a(var('X'), n938), a(var('X'), n937)).
clause(2816, a(var('X'), n939), a(var('X'), n938)).
clause(2819, a(var('X'), n940), a(var('X'), n939)).
clause(2822, a(var('X'), n941), a(var('X'), n940)).
clause(2825, a(var('X'), n942), a(var('X'), n941)).
clause(2828, a(var('X'), n943), a(var('X'), n942)).
clause(2831, a(var('X'), n944), a(var('X'), n943)).
clause(2834, a(var('X'), n945), a(var('X'), n944)).
clause(2837, a(var('X'), n946), a(var('X'), n945)).
clause(2840, a(var('X'), n947), a(var('X'), n946)).
clause(2843, a(var('X'), n948), a(var('X'), n947)).
clause(2846, a(var('X'), n949), a(var('X'), n948)).
clause(2849, a(var('X'), n950), a(var('X'), n949)).
clause(2852, a(var('X'), n951), a(var('X'), n950)).
clause(2855, a(var('X'), n952), a(var('X'), n951)).
clause(2858, a(var('X'), n953), a(var('X'), n952)).
clause(2861, a(var('X'), n954), a(var('X'), n953)).
clause(2864, a(var('X'), n955), a(var('X'), n954)).
clause(2867, a(var('X'), n956), a(var('X'), n955)).
clause(2870, a(var('X'), n957), a(var('X'), n956)).
clause(2873, a(var('X'), n958), a(var('X'), n957)).
clause(2876, a(var('X'), n959), a(var('X'), n958)).
clause(2879, a(var('X'), n960), a(var('X'), n959)).
clause(2882, a(var('X'), n961), a(var('X'), n960)).
clause(2885, a(var('X'), n962), a(var('X'), n961)).
clause(2888, a(var('X'), n963), a(var('X'), n962)).
clause(2891, a(var('X'), n964), a(var('X'), n963)).
clause(2894, a(var('X'), n965), a(var('X'), n964)).
clause(2897, a(var('X'), n966), a(var('X'), n965)).
clause(2900, a(var('X'), n967), a(var('X'), n966)).
clause(2903, a(var('X'), n968), a(var('X'), n967)).
clause(2906, a(var('X'), n969), a(var('X'), n968)).
clause(2909, a(var('X'), n970), a(var('X'), n969)).
clause(2912, a(var('X'), n971), a(var('X'), n970)).
clause(2915, a(var('X'), n972), a(var('X'), n971)).
clause(2918, a(var('X'), n973), a(var('X'), n972)).
clause(2921, a(var('X'), n974), a(var('X'), n973)).
clause(2924, a(var('X'), n975), a(var('X'), n974)).
clause(2927, a(var('X'), n976), a(var('X'), n975)).
clause(2930, a(var('X'), n977), a(var('X'), n976)).
clause(2933, a(var('X'), n978), a(var('X'), n977)).
clause(2936, a(var('X'), n979), a(var('X'), n978)).
clause(2939, a(var('X'), n980), a(var('X'), n979)).
clause(2942, a(var('X'), n981), a(var('X'), n980)).
clause(2945, a(var('X'), n982), a(var('X'), n981)).
clause(2948, a(var('X'), n983), a(var('X'), n982)).
clause(2951, a(var('X'), n984), a(var('X'), n983)).
clause(2954, a(var('X'), n985), a(var('X'), n984)).
clause(2957, a(var('X'), n986), a(var('X'), n985)).
clause(2960, a(var('X'), n987), a(var('X'), n986)).
clause(2963, a(var('X'), n988), a(var('X'), n987)).
clause(2966, a(var('X'), n989), a(var('X'), n988)).
clause(2969, a(var('X'), n990), a(var('X'), n989)).
clause(2972, a(var('X'), n991), a(var('X'), n990)).
clause(2975, a(var('X'), n992), a(var('X'), n991)).
clause(2978, a(var('X'), n993), a(var('X'), n992)).
clause(2981, a(var('X'), n994), a(var('X'), n993)).
clause(2984, a(var('X'), n995), a(var('X'), n994)).
clause(2987, a(var('X'), n996), a(var('X'), n995)).
clause(2990, a(var('X'), n997), a(var('X'), n996)).
clause(2993, a(var('X'), n998), a(var('X'), n997)).
clause(2996, a(var('X'), n999), a(var('X'), n998)).
clause(2999, a(var('X'), n1000), a(var('X'), n999)).
clause(3002, a(var('X'), a2), a(var('X'), n1000)).
clause(3003, holds_result(test, true), a(ind, a2)).
clause(3004, arc(check1, "C1 OK - the starting classification n0 is present."), a(ind, n0)).
clause(3005, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."), (a(ind, n1), a(ind, i1), a(ind, j1))).
clause(3006, arc(check3, "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches."), (a(ind, n500), a(ind, i500), a(ind, j500))).
clause(3007, arc(check4, "C4 OK - the final taxonomy step from n999 to n1000 was completed."), (a(ind, n999), a(ind, n1000))).
clause(3008, arc(check5, "C5 OK - once n1000 is reached, the terminal class a2 is derived."), (a(ind, n1000), a(ind, a2))).
clause(3009, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."), (a(ind, a2), holds_result(test, true))).
substitution(1, []).
proof(1, a(ind, n0), rule(1), []).
substitution(2, ['X' = ind]).
proof(2, a(ind, n1), rule(2), [uses(1, a(ind, n0))]).
substitution(3, []).
proof(3, arc(check1, "C1 OK - the starting classification n0 is present."), rule(3004), [uses(1, a(ind, n0))]).
substitution(4, ['Check' = check1, 'Message' = "C1 OK - the starting classification n0 is present."]).
proof(4, solution([check1, "C1 OK - the starting classification n0 is present."]), query, [uses(3, arc(check1, "C1 OK - the starting classification n0 is present."))]).
substitution(5, ['X' = ind]).
proof(5, a(ind, i1), rule(3), [uses(1, a(ind, n0))]).
substitution(6, ['X' = ind]).
proof(6, a(ind, j1), rule(4), [uses(1, a(ind, n0))]).
substitution(7, []).
proof(7, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."), rule(3005), [uses(2, a(ind, n1)), uses(5, a(ind, i1)), uses(6, a(ind, j1))]).
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
proof(59, a(ind, n52), rule(155), [uses(58, a(ind, n51))]).
substitution(60, ['X' = ind]).
proof(60, a(ind, n53), rule(158), [uses(59, a(ind, n52))]).
substitution(61, ['X' = ind]).
proof(61, a(ind, n54), rule(161), [uses(60, a(ind, n53))]).
substitution(62, ['X' = ind]).
proof(62, a(ind, n55), rule(164), [uses(61, a(ind, n54))]).
substitution(63, ['X' = ind]).
proof(63, a(ind, n56), rule(167), [uses(62, a(ind, n55))]).
substitution(64, ['X' = ind]).
proof(64, a(ind, n57), rule(170), [uses(63, a(ind, n56))]).
substitution(65, ['X' = ind]).
proof(65, a(ind, n58), rule(173), [uses(64, a(ind, n57))]).
substitution(66, ['X' = ind]).
proof(66, a(ind, n59), rule(176), [uses(65, a(ind, n58))]).
substitution(67, ['X' = ind]).
proof(67, a(ind, n60), rule(179), [uses(66, a(ind, n59))]).
substitution(68, ['X' = ind]).
proof(68, a(ind, n61), rule(182), [uses(67, a(ind, n60))]).
substitution(69, ['X' = ind]).
proof(69, a(ind, n62), rule(185), [uses(68, a(ind, n61))]).
substitution(70, ['X' = ind]).
proof(70, a(ind, n63), rule(188), [uses(69, a(ind, n62))]).
substitution(71, ['X' = ind]).
proof(71, a(ind, n64), rule(191), [uses(70, a(ind, n63))]).
substitution(72, ['X' = ind]).
proof(72, a(ind, n65), rule(194), [uses(71, a(ind, n64))]).
substitution(73, ['X' = ind]).
proof(73, a(ind, n66), rule(197), [uses(72, a(ind, n65))]).
substitution(74, ['X' = ind]).
proof(74, a(ind, n67), rule(200), [uses(73, a(ind, n66))]).
substitution(75, ['X' = ind]).
proof(75, a(ind, n68), rule(203), [uses(74, a(ind, n67))]).
substitution(76, ['X' = ind]).
proof(76, a(ind, n69), rule(206), [uses(75, a(ind, n68))]).
substitution(77, ['X' = ind]).
proof(77, a(ind, n70), rule(209), [uses(76, a(ind, n69))]).
substitution(78, ['X' = ind]).
proof(78, a(ind, n71), rule(212), [uses(77, a(ind, n70))]).
substitution(79, ['X' = ind]).
proof(79, a(ind, n72), rule(215), [uses(78, a(ind, n71))]).
substitution(80, ['X' = ind]).
proof(80, a(ind, n73), rule(218), [uses(79, a(ind, n72))]).
substitution(81, ['X' = ind]).
proof(81, a(ind, n74), rule(221), [uses(80, a(ind, n73))]).
substitution(82, ['X' = ind]).
proof(82, a(ind, n75), rule(224), [uses(81, a(ind, n74))]).
substitution(83, ['X' = ind]).
proof(83, a(ind, n76), rule(227), [uses(82, a(ind, n75))]).
substitution(84, ['X' = ind]).
proof(84, a(ind, n77), rule(230), [uses(83, a(ind, n76))]).
substitution(85, ['X' = ind]).
proof(85, a(ind, n78), rule(233), [uses(84, a(ind, n77))]).
substitution(86, ['X' = ind]).
proof(86, a(ind, n79), rule(236), [uses(85, a(ind, n78))]).
substitution(87, ['X' = ind]).
proof(87, a(ind, n80), rule(239), [uses(86, a(ind, n79))]).
substitution(88, ['X' = ind]).
proof(88, a(ind, n81), rule(242), [uses(87, a(ind, n80))]).
substitution(89, ['X' = ind]).
proof(89, a(ind, n82), rule(245), [uses(88, a(ind, n81))]).
substitution(90, ['X' = ind]).
proof(90, a(ind, n83), rule(248), [uses(89, a(ind, n82))]).
substitution(91, ['X' = ind]).
proof(91, a(ind, n84), rule(251), [uses(90, a(ind, n83))]).
substitution(92, ['X' = ind]).
proof(92, a(ind, n85), rule(254), [uses(91, a(ind, n84))]).
substitution(93, ['X' = ind]).
proof(93, a(ind, n86), rule(257), [uses(92, a(ind, n85))]).
substitution(94, ['X' = ind]).
proof(94, a(ind, n87), rule(260), [uses(93, a(ind, n86))]).
substitution(95, ['X' = ind]).
proof(95, a(ind, n88), rule(263), [uses(94, a(ind, n87))]).
substitution(96, ['X' = ind]).
proof(96, a(ind, n89), rule(266), [uses(95, a(ind, n88))]).
substitution(97, ['X' = ind]).
proof(97, a(ind, n90), rule(269), [uses(96, a(ind, n89))]).
substitution(98, ['X' = ind]).
proof(98, a(ind, n91), rule(272), [uses(97, a(ind, n90))]).
substitution(99, ['X' = ind]).
proof(99, a(ind, n92), rule(275), [uses(98, a(ind, n91))]).
substitution(100, ['X' = ind]).
proof(100, a(ind, n93), rule(278), [uses(99, a(ind, n92))]).
substitution(101, ['X' = ind]).
proof(101, a(ind, n94), rule(281), [uses(100, a(ind, n93))]).
substitution(102, ['X' = ind]).
proof(102, a(ind, n95), rule(284), [uses(101, a(ind, n94))]).
substitution(103, ['X' = ind]).
proof(103, a(ind, n96), rule(287), [uses(102, a(ind, n95))]).
substitution(104, ['X' = ind]).
proof(104, a(ind, n97), rule(290), [uses(103, a(ind, n96))]).
substitution(105, ['X' = ind]).
proof(105, a(ind, n98), rule(293), [uses(104, a(ind, n97))]).
substitution(106, ['X' = ind]).
proof(106, a(ind, n99), rule(296), [uses(105, a(ind, n98))]).
substitution(107, ['X' = ind]).
proof(107, a(ind, n100), rule(299), [uses(106, a(ind, n99))]).
substitution(108, ['X' = ind]).
proof(108, a(ind, n101), rule(302), [uses(107, a(ind, n100))]).
substitution(109, ['X' = ind]).
proof(109, a(ind, n102), rule(305), [uses(108, a(ind, n101))]).
substitution(110, ['X' = ind]).
proof(110, a(ind, n103), rule(308), [uses(109, a(ind, n102))]).
substitution(111, ['X' = ind]).
proof(111, a(ind, n104), rule(311), [uses(110, a(ind, n103))]).
substitution(112, ['X' = ind]).
proof(112, a(ind, n105), rule(314), [uses(111, a(ind, n104))]).
substitution(113, ['X' = ind]).
proof(113, a(ind, n106), rule(317), [uses(112, a(ind, n105))]).
substitution(114, ['X' = ind]).
proof(114, a(ind, n107), rule(320), [uses(113, a(ind, n106))]).
substitution(115, ['X' = ind]).
proof(115, a(ind, n108), rule(323), [uses(114, a(ind, n107))]).
substitution(116, ['X' = ind]).
proof(116, a(ind, n109), rule(326), [uses(115, a(ind, n108))]).
substitution(117, ['X' = ind]).
proof(117, a(ind, n110), rule(329), [uses(116, a(ind, n109))]).
substitution(118, ['X' = ind]).
proof(118, a(ind, n111), rule(332), [uses(117, a(ind, n110))]).
substitution(119, ['X' = ind]).
proof(119, a(ind, n112), rule(335), [uses(118, a(ind, n111))]).
substitution(120, ['X' = ind]).
proof(120, a(ind, n113), rule(338), [uses(119, a(ind, n112))]).
substitution(121, ['X' = ind]).
proof(121, a(ind, n114), rule(341), [uses(120, a(ind, n113))]).
substitution(122, ['X' = ind]).
proof(122, a(ind, n115), rule(344), [uses(121, a(ind, n114))]).
substitution(123, ['X' = ind]).
proof(123, a(ind, n116), rule(347), [uses(122, a(ind, n115))]).
substitution(124, ['X' = ind]).
proof(124, a(ind, n117), rule(350), [uses(123, a(ind, n116))]).
substitution(125, ['X' = ind]).
proof(125, a(ind, n118), rule(353), [uses(124, a(ind, n117))]).
substitution(126, ['X' = ind]).
proof(126, a(ind, n119), rule(356), [uses(125, a(ind, n118))]).
substitution(127, ['X' = ind]).
proof(127, a(ind, n120), rule(359), [uses(126, a(ind, n119))]).
substitution(128, ['X' = ind]).
proof(128, a(ind, n121), rule(362), [uses(127, a(ind, n120))]).
substitution(129, ['X' = ind]).
proof(129, a(ind, n122), rule(365), [uses(128, a(ind, n121))]).
substitution(130, ['X' = ind]).
proof(130, a(ind, n123), rule(368), [uses(129, a(ind, n122))]).
substitution(131, ['X' = ind]).
proof(131, a(ind, n124), rule(371), [uses(130, a(ind, n123))]).
substitution(132, ['X' = ind]).
proof(132, a(ind, n125), rule(374), [uses(131, a(ind, n124))]).
substitution(133, ['X' = ind]).
proof(133, a(ind, n126), rule(377), [uses(132, a(ind, n125))]).
substitution(134, ['X' = ind]).
proof(134, a(ind, n127), rule(380), [uses(133, a(ind, n126))]).
substitution(135, ['X' = ind]).
proof(135, a(ind, n128), rule(383), [uses(134, a(ind, n127))]).
substitution(136, ['X' = ind]).
proof(136, a(ind, n129), rule(386), [uses(135, a(ind, n128))]).
substitution(137, ['X' = ind]).
proof(137, a(ind, n130), rule(389), [uses(136, a(ind, n129))]).
substitution(138, ['X' = ind]).
proof(138, a(ind, n131), rule(392), [uses(137, a(ind, n130))]).
substitution(139, ['X' = ind]).
proof(139, a(ind, n132), rule(395), [uses(138, a(ind, n131))]).
substitution(140, ['X' = ind]).
proof(140, a(ind, n133), rule(398), [uses(139, a(ind, n132))]).
substitution(141, ['X' = ind]).
proof(141, a(ind, n134), rule(401), [uses(140, a(ind, n133))]).
substitution(142, ['X' = ind]).
proof(142, a(ind, n135), rule(404), [uses(141, a(ind, n134))]).
substitution(143, ['X' = ind]).
proof(143, a(ind, n136), rule(407), [uses(142, a(ind, n135))]).
substitution(144, ['X' = ind]).
proof(144, a(ind, n137), rule(410), [uses(143, a(ind, n136))]).
substitution(145, ['X' = ind]).
proof(145, a(ind, n138), rule(413), [uses(144, a(ind, n137))]).
substitution(146, ['X' = ind]).
proof(146, a(ind, n139), rule(416), [uses(145, a(ind, n138))]).
substitution(147, ['X' = ind]).
proof(147, a(ind, n140), rule(419), [uses(146, a(ind, n139))]).
substitution(148, ['X' = ind]).
proof(148, a(ind, n141), rule(422), [uses(147, a(ind, n140))]).
substitution(149, ['X' = ind]).
proof(149, a(ind, n142), rule(425), [uses(148, a(ind, n141))]).
substitution(150, ['X' = ind]).
proof(150, a(ind, n143), rule(428), [uses(149, a(ind, n142))]).
substitution(151, ['X' = ind]).
proof(151, a(ind, n144), rule(431), [uses(150, a(ind, n143))]).
substitution(152, ['X' = ind]).
proof(152, a(ind, n145), rule(434), [uses(151, a(ind, n144))]).
substitution(153, ['X' = ind]).
proof(153, a(ind, n146), rule(437), [uses(152, a(ind, n145))]).
substitution(154, ['X' = ind]).
proof(154, a(ind, n147), rule(440), [uses(153, a(ind, n146))]).
substitution(155, ['X' = ind]).
proof(155, a(ind, n148), rule(443), [uses(154, a(ind, n147))]).
substitution(156, ['X' = ind]).
proof(156, a(ind, n149), rule(446), [uses(155, a(ind, n148))]).
substitution(157, ['X' = ind]).
proof(157, a(ind, n150), rule(449), [uses(156, a(ind, n149))]).
substitution(158, ['X' = ind]).
proof(158, a(ind, n151), rule(452), [uses(157, a(ind, n150))]).
substitution(159, ['X' = ind]).
proof(159, a(ind, n152), rule(455), [uses(158, a(ind, n151))]).
substitution(160, ['X' = ind]).
proof(160, a(ind, n153), rule(458), [uses(159, a(ind, n152))]).
substitution(161, ['X' = ind]).
proof(161, a(ind, n154), rule(461), [uses(160, a(ind, n153))]).
substitution(162, ['X' = ind]).
proof(162, a(ind, n155), rule(464), [uses(161, a(ind, n154))]).
substitution(163, ['X' = ind]).
proof(163, a(ind, n156), rule(467), [uses(162, a(ind, n155))]).
substitution(164, ['X' = ind]).
proof(164, a(ind, n157), rule(470), [uses(163, a(ind, n156))]).
substitution(165, ['X' = ind]).
proof(165, a(ind, n158), rule(473), [uses(164, a(ind, n157))]).
substitution(166, ['X' = ind]).
proof(166, a(ind, n159), rule(476), [uses(165, a(ind, n158))]).
substitution(167, ['X' = ind]).
proof(167, a(ind, n160), rule(479), [uses(166, a(ind, n159))]).
substitution(168, ['X' = ind]).
proof(168, a(ind, n161), rule(482), [uses(167, a(ind, n160))]).
substitution(169, ['X' = ind]).
proof(169, a(ind, n162), rule(485), [uses(168, a(ind, n161))]).
substitution(170, ['X' = ind]).
proof(170, a(ind, n163), rule(488), [uses(169, a(ind, n162))]).
substitution(171, ['X' = ind]).
proof(171, a(ind, n164), rule(491), [uses(170, a(ind, n163))]).
substitution(172, ['X' = ind]).
proof(172, a(ind, n165), rule(494), [uses(171, a(ind, n164))]).
substitution(173, ['X' = ind]).
proof(173, a(ind, n166), rule(497), [uses(172, a(ind, n165))]).
substitution(174, ['X' = ind]).
proof(174, a(ind, n167), rule(500), [uses(173, a(ind, n166))]).
substitution(175, ['X' = ind]).
proof(175, a(ind, n168), rule(503), [uses(174, a(ind, n167))]).
substitution(176, ['X' = ind]).
proof(176, a(ind, n169), rule(506), [uses(175, a(ind, n168))]).
substitution(177, ['X' = ind]).
proof(177, a(ind, n170), rule(509), [uses(176, a(ind, n169))]).
substitution(178, ['X' = ind]).
proof(178, a(ind, n171), rule(512), [uses(177, a(ind, n170))]).
substitution(179, ['X' = ind]).
proof(179, a(ind, n172), rule(515), [uses(178, a(ind, n171))]).
substitution(180, ['X' = ind]).
proof(180, a(ind, n173), rule(518), [uses(179, a(ind, n172))]).
substitution(181, ['X' = ind]).
proof(181, a(ind, n174), rule(521), [uses(180, a(ind, n173))]).
substitution(182, ['X' = ind]).
proof(182, a(ind, n175), rule(524), [uses(181, a(ind, n174))]).
substitution(183, ['X' = ind]).
proof(183, a(ind, n176), rule(527), [uses(182, a(ind, n175))]).
substitution(184, ['X' = ind]).
proof(184, a(ind, n177), rule(530), [uses(183, a(ind, n176))]).
substitution(185, ['X' = ind]).
proof(185, a(ind, n178), rule(533), [uses(184, a(ind, n177))]).
substitution(186, ['X' = ind]).
proof(186, a(ind, n179), rule(536), [uses(185, a(ind, n178))]).
substitution(187, ['X' = ind]).
proof(187, a(ind, n180), rule(539), [uses(186, a(ind, n179))]).
substitution(188, ['X' = ind]).
proof(188, a(ind, n181), rule(542), [uses(187, a(ind, n180))]).
substitution(189, ['X' = ind]).
proof(189, a(ind, n182), rule(545), [uses(188, a(ind, n181))]).
substitution(190, ['X' = ind]).
proof(190, a(ind, n183), rule(548), [uses(189, a(ind, n182))]).
substitution(191, ['X' = ind]).
proof(191, a(ind, n184), rule(551), [uses(190, a(ind, n183))]).
substitution(192, ['X' = ind]).
proof(192, a(ind, n185), rule(554), [uses(191, a(ind, n184))]).
substitution(193, ['X' = ind]).
proof(193, a(ind, n186), rule(557), [uses(192, a(ind, n185))]).
substitution(194, ['X' = ind]).
proof(194, a(ind, n187), rule(560), [uses(193, a(ind, n186))]).
substitution(195, ['X' = ind]).
proof(195, a(ind, n188), rule(563), [uses(194, a(ind, n187))]).
substitution(196, ['X' = ind]).
proof(196, a(ind, n189), rule(566), [uses(195, a(ind, n188))]).
substitution(197, ['X' = ind]).
proof(197, a(ind, n190), rule(569), [uses(196, a(ind, n189))]).
substitution(198, ['X' = ind]).
proof(198, a(ind, n191), rule(572), [uses(197, a(ind, n190))]).
substitution(199, ['X' = ind]).
proof(199, a(ind, n192), rule(575), [uses(198, a(ind, n191))]).
substitution(200, ['X' = ind]).
proof(200, a(ind, n193), rule(578), [uses(199, a(ind, n192))]).
substitution(201, ['X' = ind]).
proof(201, a(ind, n194), rule(581), [uses(200, a(ind, n193))]).
substitution(202, ['X' = ind]).
proof(202, a(ind, n195), rule(584), [uses(201, a(ind, n194))]).
substitution(203, ['X' = ind]).
proof(203, a(ind, n196), rule(587), [uses(202, a(ind, n195))]).
substitution(204, ['X' = ind]).
proof(204, a(ind, n197), rule(590), [uses(203, a(ind, n196))]).
substitution(205, ['X' = ind]).
proof(205, a(ind, n198), rule(593), [uses(204, a(ind, n197))]).
substitution(206, ['X' = ind]).
proof(206, a(ind, n199), rule(596), [uses(205, a(ind, n198))]).
substitution(207, ['X' = ind]).
proof(207, a(ind, n200), rule(599), [uses(206, a(ind, n199))]).
substitution(208, ['X' = ind]).
proof(208, a(ind, n201), rule(602), [uses(207, a(ind, n200))]).
substitution(209, ['X' = ind]).
proof(209, a(ind, n202), rule(605), [uses(208, a(ind, n201))]).
substitution(210, ['X' = ind]).
proof(210, a(ind, n203), rule(608), [uses(209, a(ind, n202))]).
substitution(211, ['X' = ind]).
proof(211, a(ind, n204), rule(611), [uses(210, a(ind, n203))]).
substitution(212, ['X' = ind]).
proof(212, a(ind, n205), rule(614), [uses(211, a(ind, n204))]).
substitution(213, ['X' = ind]).
proof(213, a(ind, n206), rule(617), [uses(212, a(ind, n205))]).
substitution(214, ['X' = ind]).
proof(214, a(ind, n207), rule(620), [uses(213, a(ind, n206))]).
substitution(215, ['X' = ind]).
proof(215, a(ind, n208), rule(623), [uses(214, a(ind, n207))]).
substitution(216, ['X' = ind]).
proof(216, a(ind, n209), rule(626), [uses(215, a(ind, n208))]).
substitution(217, ['X' = ind]).
proof(217, a(ind, n210), rule(629), [uses(216, a(ind, n209))]).
substitution(218, ['X' = ind]).
proof(218, a(ind, n211), rule(632), [uses(217, a(ind, n210))]).
substitution(219, ['X' = ind]).
proof(219, a(ind, n212), rule(635), [uses(218, a(ind, n211))]).
substitution(220, ['X' = ind]).
proof(220, a(ind, n213), rule(638), [uses(219, a(ind, n212))]).
substitution(221, ['X' = ind]).
proof(221, a(ind, n214), rule(641), [uses(220, a(ind, n213))]).
substitution(222, ['X' = ind]).
proof(222, a(ind, n215), rule(644), [uses(221, a(ind, n214))]).
substitution(223, ['X' = ind]).
proof(223, a(ind, n216), rule(647), [uses(222, a(ind, n215))]).
substitution(224, ['X' = ind]).
proof(224, a(ind, n217), rule(650), [uses(223, a(ind, n216))]).
substitution(225, ['X' = ind]).
proof(225, a(ind, n218), rule(653), [uses(224, a(ind, n217))]).
substitution(226, ['X' = ind]).
proof(226, a(ind, n219), rule(656), [uses(225, a(ind, n218))]).
substitution(227, ['X' = ind]).
proof(227, a(ind, n220), rule(659), [uses(226, a(ind, n219))]).
substitution(228, ['X' = ind]).
proof(228, a(ind, n221), rule(662), [uses(227, a(ind, n220))]).
substitution(229, ['X' = ind]).
proof(229, a(ind, n222), rule(665), [uses(228, a(ind, n221))]).
substitution(230, ['X' = ind]).
proof(230, a(ind, n223), rule(668), [uses(229, a(ind, n222))]).
substitution(231, ['X' = ind]).
proof(231, a(ind, n224), rule(671), [uses(230, a(ind, n223))]).
substitution(232, ['X' = ind]).
proof(232, a(ind, n225), rule(674), [uses(231, a(ind, n224))]).
substitution(233, ['X' = ind]).
proof(233, a(ind, n226), rule(677), [uses(232, a(ind, n225))]).
substitution(234, ['X' = ind]).
proof(234, a(ind, n227), rule(680), [uses(233, a(ind, n226))]).
substitution(235, ['X' = ind]).
proof(235, a(ind, n228), rule(683), [uses(234, a(ind, n227))]).
substitution(236, ['X' = ind]).
proof(236, a(ind, n229), rule(686), [uses(235, a(ind, n228))]).
substitution(237, ['X' = ind]).
proof(237, a(ind, n230), rule(689), [uses(236, a(ind, n229))]).
substitution(238, ['X' = ind]).
proof(238, a(ind, n231), rule(692), [uses(237, a(ind, n230))]).
substitution(239, ['X' = ind]).
proof(239, a(ind, n232), rule(695), [uses(238, a(ind, n231))]).
substitution(240, ['X' = ind]).
proof(240, a(ind, n233), rule(698), [uses(239, a(ind, n232))]).
substitution(241, ['X' = ind]).
proof(241, a(ind, n234), rule(701), [uses(240, a(ind, n233))]).
substitution(242, ['X' = ind]).
proof(242, a(ind, n235), rule(704), [uses(241, a(ind, n234))]).
substitution(243, ['X' = ind]).
proof(243, a(ind, n236), rule(707), [uses(242, a(ind, n235))]).
substitution(244, ['X' = ind]).
proof(244, a(ind, n237), rule(710), [uses(243, a(ind, n236))]).
substitution(245, ['X' = ind]).
proof(245, a(ind, n238), rule(713), [uses(244, a(ind, n237))]).
substitution(246, ['X' = ind]).
proof(246, a(ind, n239), rule(716), [uses(245, a(ind, n238))]).
substitution(247, ['X' = ind]).
proof(247, a(ind, n240), rule(719), [uses(246, a(ind, n239))]).
substitution(248, ['X' = ind]).
proof(248, a(ind, n241), rule(722), [uses(247, a(ind, n240))]).
substitution(249, ['X' = ind]).
proof(249, a(ind, n242), rule(725), [uses(248, a(ind, n241))]).
substitution(250, ['X' = ind]).
proof(250, a(ind, n243), rule(728), [uses(249, a(ind, n242))]).
substitution(251, ['X' = ind]).
proof(251, a(ind, n244), rule(731), [uses(250, a(ind, n243))]).
substitution(252, ['X' = ind]).
proof(252, a(ind, n245), rule(734), [uses(251, a(ind, n244))]).
substitution(253, ['X' = ind]).
proof(253, a(ind, n246), rule(737), [uses(252, a(ind, n245))]).
substitution(254, ['X' = ind]).
proof(254, a(ind, n247), rule(740), [uses(253, a(ind, n246))]).
substitution(255, ['X' = ind]).
proof(255, a(ind, n248), rule(743), [uses(254, a(ind, n247))]).
substitution(256, ['X' = ind]).
proof(256, a(ind, n249), rule(746), [uses(255, a(ind, n248))]).
substitution(257, ['X' = ind]).
proof(257, a(ind, n250), rule(749), [uses(256, a(ind, n249))]).
substitution(258, ['X' = ind]).
proof(258, a(ind, n251), rule(752), [uses(257, a(ind, n250))]).
substitution(259, ['X' = ind]).
proof(259, a(ind, n252), rule(755), [uses(258, a(ind, n251))]).
substitution(260, ['X' = ind]).
proof(260, a(ind, n253), rule(758), [uses(259, a(ind, n252))]).
substitution(261, ['X' = ind]).
proof(261, a(ind, n254), rule(761), [uses(260, a(ind, n253))]).
substitution(262, ['X' = ind]).
proof(262, a(ind, n255), rule(764), [uses(261, a(ind, n254))]).
substitution(263, ['X' = ind]).
proof(263, a(ind, n256), rule(767), [uses(262, a(ind, n255))]).
substitution(264, ['X' = ind]).
proof(264, a(ind, n257), rule(770), [uses(263, a(ind, n256))]).
substitution(265, ['X' = ind]).
proof(265, a(ind, n258), rule(773), [uses(264, a(ind, n257))]).
substitution(266, ['X' = ind]).
proof(266, a(ind, n259), rule(776), [uses(265, a(ind, n258))]).
substitution(267, ['X' = ind]).
proof(267, a(ind, n260), rule(779), [uses(266, a(ind, n259))]).
substitution(268, ['X' = ind]).
proof(268, a(ind, n261), rule(782), [uses(267, a(ind, n260))]).
substitution(269, ['X' = ind]).
proof(269, a(ind, n262), rule(785), [uses(268, a(ind, n261))]).
substitution(270, ['X' = ind]).
proof(270, a(ind, n263), rule(788), [uses(269, a(ind, n262))]).
substitution(271, ['X' = ind]).
proof(271, a(ind, n264), rule(791), [uses(270, a(ind, n263))]).
substitution(272, ['X' = ind]).
proof(272, a(ind, n265), rule(794), [uses(271, a(ind, n264))]).
substitution(273, ['X' = ind]).
proof(273, a(ind, n266), rule(797), [uses(272, a(ind, n265))]).
substitution(274, ['X' = ind]).
proof(274, a(ind, n267), rule(800), [uses(273, a(ind, n266))]).
substitution(275, ['X' = ind]).
proof(275, a(ind, n268), rule(803), [uses(274, a(ind, n267))]).
substitution(276, ['X' = ind]).
proof(276, a(ind, n269), rule(806), [uses(275, a(ind, n268))]).
substitution(277, ['X' = ind]).
proof(277, a(ind, n270), rule(809), [uses(276, a(ind, n269))]).
substitution(278, ['X' = ind]).
proof(278, a(ind, n271), rule(812), [uses(277, a(ind, n270))]).
substitution(279, ['X' = ind]).
proof(279, a(ind, n272), rule(815), [uses(278, a(ind, n271))]).
substitution(280, ['X' = ind]).
proof(280, a(ind, n273), rule(818), [uses(279, a(ind, n272))]).
substitution(281, ['X' = ind]).
proof(281, a(ind, n274), rule(821), [uses(280, a(ind, n273))]).
substitution(282, ['X' = ind]).
proof(282, a(ind, n275), rule(824), [uses(281, a(ind, n274))]).
substitution(283, ['X' = ind]).
proof(283, a(ind, n276), rule(827), [uses(282, a(ind, n275))]).
substitution(284, ['X' = ind]).
proof(284, a(ind, n277), rule(830), [uses(283, a(ind, n276))]).
substitution(285, ['X' = ind]).
proof(285, a(ind, n278), rule(833), [uses(284, a(ind, n277))]).
substitution(286, ['X' = ind]).
proof(286, a(ind, n279), rule(836), [uses(285, a(ind, n278))]).
substitution(287, ['X' = ind]).
proof(287, a(ind, n280), rule(839), [uses(286, a(ind, n279))]).
substitution(288, ['X' = ind]).
proof(288, a(ind, n281), rule(842), [uses(287, a(ind, n280))]).
substitution(289, ['X' = ind]).
proof(289, a(ind, n282), rule(845), [uses(288, a(ind, n281))]).
substitution(290, ['X' = ind]).
proof(290, a(ind, n283), rule(848), [uses(289, a(ind, n282))]).
substitution(291, ['X' = ind]).
proof(291, a(ind, n284), rule(851), [uses(290, a(ind, n283))]).
substitution(292, ['X' = ind]).
proof(292, a(ind, n285), rule(854), [uses(291, a(ind, n284))]).
substitution(293, ['X' = ind]).
proof(293, a(ind, n286), rule(857), [uses(292, a(ind, n285))]).
substitution(294, ['X' = ind]).
proof(294, a(ind, n287), rule(860), [uses(293, a(ind, n286))]).
substitution(295, ['X' = ind]).
proof(295, a(ind, n288), rule(863), [uses(294, a(ind, n287))]).
substitution(296, ['X' = ind]).
proof(296, a(ind, n289), rule(866), [uses(295, a(ind, n288))]).
substitution(297, ['X' = ind]).
proof(297, a(ind, n290), rule(869), [uses(296, a(ind, n289))]).
substitution(298, ['X' = ind]).
proof(298, a(ind, n291), rule(872), [uses(297, a(ind, n290))]).
substitution(299, ['X' = ind]).
proof(299, a(ind, n292), rule(875), [uses(298, a(ind, n291))]).
substitution(300, ['X' = ind]).
proof(300, a(ind, n293), rule(878), [uses(299, a(ind, n292))]).
substitution(301, ['X' = ind]).
proof(301, a(ind, n294), rule(881), [uses(300, a(ind, n293))]).
substitution(302, ['X' = ind]).
proof(302, a(ind, n295), rule(884), [uses(301, a(ind, n294))]).
substitution(303, ['X' = ind]).
proof(303, a(ind, n296), rule(887), [uses(302, a(ind, n295))]).
substitution(304, ['X' = ind]).
proof(304, a(ind, n297), rule(890), [uses(303, a(ind, n296))]).
substitution(305, ['X' = ind]).
proof(305, a(ind, n298), rule(893), [uses(304, a(ind, n297))]).
substitution(306, ['X' = ind]).
proof(306, a(ind, n299), rule(896), [uses(305, a(ind, n298))]).
substitution(307, ['X' = ind]).
proof(307, a(ind, n300), rule(899), [uses(306, a(ind, n299))]).
substitution(308, ['X' = ind]).
proof(308, a(ind, n301), rule(902), [uses(307, a(ind, n300))]).
substitution(309, ['X' = ind]).
proof(309, a(ind, n302), rule(905), [uses(308, a(ind, n301))]).
substitution(310, ['X' = ind]).
proof(310, a(ind, n303), rule(908), [uses(309, a(ind, n302))]).
substitution(311, ['X' = ind]).
proof(311, a(ind, n304), rule(911), [uses(310, a(ind, n303))]).
substitution(312, ['X' = ind]).
proof(312, a(ind, n305), rule(914), [uses(311, a(ind, n304))]).
substitution(313, ['X' = ind]).
proof(313, a(ind, n306), rule(917), [uses(312, a(ind, n305))]).
substitution(314, ['X' = ind]).
proof(314, a(ind, n307), rule(920), [uses(313, a(ind, n306))]).
substitution(315, ['X' = ind]).
proof(315, a(ind, n308), rule(923), [uses(314, a(ind, n307))]).
substitution(316, ['X' = ind]).
proof(316, a(ind, n309), rule(926), [uses(315, a(ind, n308))]).
substitution(317, ['X' = ind]).
proof(317, a(ind, n310), rule(929), [uses(316, a(ind, n309))]).
substitution(318, ['X' = ind]).
proof(318, a(ind, n311), rule(932), [uses(317, a(ind, n310))]).
substitution(319, ['X' = ind]).
proof(319, a(ind, n312), rule(935), [uses(318, a(ind, n311))]).
substitution(320, ['X' = ind]).
proof(320, a(ind, n313), rule(938), [uses(319, a(ind, n312))]).
substitution(321, ['X' = ind]).
proof(321, a(ind, n314), rule(941), [uses(320, a(ind, n313))]).
substitution(322, ['X' = ind]).
proof(322, a(ind, n315), rule(944), [uses(321, a(ind, n314))]).
substitution(323, ['X' = ind]).
proof(323, a(ind, n316), rule(947), [uses(322, a(ind, n315))]).
substitution(324, ['X' = ind]).
proof(324, a(ind, n317), rule(950), [uses(323, a(ind, n316))]).
substitution(325, ['X' = ind]).
proof(325, a(ind, n318), rule(953), [uses(324, a(ind, n317))]).
substitution(326, ['X' = ind]).
proof(326, a(ind, n319), rule(956), [uses(325, a(ind, n318))]).
substitution(327, ['X' = ind]).
proof(327, a(ind, n320), rule(959), [uses(326, a(ind, n319))]).
substitution(328, ['X' = ind]).
proof(328, a(ind, n321), rule(962), [uses(327, a(ind, n320))]).
substitution(329, ['X' = ind]).
proof(329, a(ind, n322), rule(965), [uses(328, a(ind, n321))]).
substitution(330, ['X' = ind]).
proof(330, a(ind, n323), rule(968), [uses(329, a(ind, n322))]).
substitution(331, ['X' = ind]).
proof(331, a(ind, n324), rule(971), [uses(330, a(ind, n323))]).
substitution(332, ['X' = ind]).
proof(332, a(ind, n325), rule(974), [uses(331, a(ind, n324))]).
substitution(333, ['X' = ind]).
proof(333, a(ind, n326), rule(977), [uses(332, a(ind, n325))]).
substitution(334, ['X' = ind]).
proof(334, a(ind, n327), rule(980), [uses(333, a(ind, n326))]).
substitution(335, ['X' = ind]).
proof(335, a(ind, n328), rule(983), [uses(334, a(ind, n327))]).
substitution(336, ['X' = ind]).
proof(336, a(ind, n329), rule(986), [uses(335, a(ind, n328))]).
substitution(337, ['X' = ind]).
proof(337, a(ind, n330), rule(989), [uses(336, a(ind, n329))]).
substitution(338, ['X' = ind]).
proof(338, a(ind, n331), rule(992), [uses(337, a(ind, n330))]).
substitution(339, ['X' = ind]).
proof(339, a(ind, n332), rule(995), [uses(338, a(ind, n331))]).
substitution(340, ['X' = ind]).
proof(340, a(ind, n333), rule(998), [uses(339, a(ind, n332))]).
substitution(341, ['X' = ind]).
proof(341, a(ind, n334), rule(1001), [uses(340, a(ind, n333))]).
substitution(342, ['X' = ind]).
proof(342, a(ind, n335), rule(1004), [uses(341, a(ind, n334))]).
substitution(343, ['X' = ind]).
proof(343, a(ind, n336), rule(1007), [uses(342, a(ind, n335))]).
substitution(344, ['X' = ind]).
proof(344, a(ind, n337), rule(1010), [uses(343, a(ind, n336))]).
substitution(345, ['X' = ind]).
proof(345, a(ind, n338), rule(1013), [uses(344, a(ind, n337))]).
substitution(346, ['X' = ind]).
proof(346, a(ind, n339), rule(1016), [uses(345, a(ind, n338))]).
substitution(347, ['X' = ind]).
proof(347, a(ind, n340), rule(1019), [uses(346, a(ind, n339))]).
substitution(348, ['X' = ind]).
proof(348, a(ind, n341), rule(1022), [uses(347, a(ind, n340))]).
substitution(349, ['X' = ind]).
proof(349, a(ind, n342), rule(1025), [uses(348, a(ind, n341))]).
substitution(350, ['X' = ind]).
proof(350, a(ind, n343), rule(1028), [uses(349, a(ind, n342))]).
substitution(351, ['X' = ind]).
proof(351, a(ind, n344), rule(1031), [uses(350, a(ind, n343))]).
substitution(352, ['X' = ind]).
proof(352, a(ind, n345), rule(1034), [uses(351, a(ind, n344))]).
substitution(353, ['X' = ind]).
proof(353, a(ind, n346), rule(1037), [uses(352, a(ind, n345))]).
substitution(354, ['X' = ind]).
proof(354, a(ind, n347), rule(1040), [uses(353, a(ind, n346))]).
substitution(355, ['X' = ind]).
proof(355, a(ind, n348), rule(1043), [uses(354, a(ind, n347))]).
substitution(356, ['X' = ind]).
proof(356, a(ind, n349), rule(1046), [uses(355, a(ind, n348))]).
substitution(357, ['X' = ind]).
proof(357, a(ind, n350), rule(1049), [uses(356, a(ind, n349))]).
substitution(358, ['X' = ind]).
proof(358, a(ind, n351), rule(1052), [uses(357, a(ind, n350))]).
substitution(359, ['X' = ind]).
proof(359, a(ind, n352), rule(1055), [uses(358, a(ind, n351))]).
substitution(360, ['X' = ind]).
proof(360, a(ind, n353), rule(1058), [uses(359, a(ind, n352))]).
substitution(361, ['X' = ind]).
proof(361, a(ind, n354), rule(1061), [uses(360, a(ind, n353))]).
substitution(362, ['X' = ind]).
proof(362, a(ind, n355), rule(1064), [uses(361, a(ind, n354))]).
substitution(363, ['X' = ind]).
proof(363, a(ind, n356), rule(1067), [uses(362, a(ind, n355))]).
substitution(364, ['X' = ind]).
proof(364, a(ind, n357), rule(1070), [uses(363, a(ind, n356))]).
substitution(365, ['X' = ind]).
proof(365, a(ind, n358), rule(1073), [uses(364, a(ind, n357))]).
substitution(366, ['X' = ind]).
proof(366, a(ind, n359), rule(1076), [uses(365, a(ind, n358))]).
substitution(367, ['X' = ind]).
proof(367, a(ind, n360), rule(1079), [uses(366, a(ind, n359))]).
substitution(368, ['X' = ind]).
proof(368, a(ind, n361), rule(1082), [uses(367, a(ind, n360))]).
substitution(369, ['X' = ind]).
proof(369, a(ind, n362), rule(1085), [uses(368, a(ind, n361))]).
substitution(370, ['X' = ind]).
proof(370, a(ind, n363), rule(1088), [uses(369, a(ind, n362))]).
substitution(371, ['X' = ind]).
proof(371, a(ind, n364), rule(1091), [uses(370, a(ind, n363))]).
substitution(372, ['X' = ind]).
proof(372, a(ind, n365), rule(1094), [uses(371, a(ind, n364))]).
substitution(373, ['X' = ind]).
proof(373, a(ind, n366), rule(1097), [uses(372, a(ind, n365))]).
substitution(374, ['X' = ind]).
proof(374, a(ind, n367), rule(1100), [uses(373, a(ind, n366))]).
substitution(375, ['X' = ind]).
proof(375, a(ind, n368), rule(1103), [uses(374, a(ind, n367))]).
substitution(376, ['X' = ind]).
proof(376, a(ind, n369), rule(1106), [uses(375, a(ind, n368))]).
substitution(377, ['X' = ind]).
proof(377, a(ind, n370), rule(1109), [uses(376, a(ind, n369))]).
substitution(378, ['X' = ind]).
proof(378, a(ind, n371), rule(1112), [uses(377, a(ind, n370))]).
substitution(379, ['X' = ind]).
proof(379, a(ind, n372), rule(1115), [uses(378, a(ind, n371))]).
substitution(380, ['X' = ind]).
proof(380, a(ind, n373), rule(1118), [uses(379, a(ind, n372))]).
substitution(381, ['X' = ind]).
proof(381, a(ind, n374), rule(1121), [uses(380, a(ind, n373))]).
substitution(382, ['X' = ind]).
proof(382, a(ind, n375), rule(1124), [uses(381, a(ind, n374))]).
substitution(383, ['X' = ind]).
proof(383, a(ind, n376), rule(1127), [uses(382, a(ind, n375))]).
substitution(384, ['X' = ind]).
proof(384, a(ind, n377), rule(1130), [uses(383, a(ind, n376))]).
substitution(385, ['X' = ind]).
proof(385, a(ind, n378), rule(1133), [uses(384, a(ind, n377))]).
substitution(386, ['X' = ind]).
proof(386, a(ind, n379), rule(1136), [uses(385, a(ind, n378))]).
substitution(387, ['X' = ind]).
proof(387, a(ind, n380), rule(1139), [uses(386, a(ind, n379))]).
substitution(388, ['X' = ind]).
proof(388, a(ind, n381), rule(1142), [uses(387, a(ind, n380))]).
substitution(389, ['X' = ind]).
proof(389, a(ind, n382), rule(1145), [uses(388, a(ind, n381))]).
substitution(390, ['X' = ind]).
proof(390, a(ind, n383), rule(1148), [uses(389, a(ind, n382))]).
substitution(391, ['X' = ind]).
proof(391, a(ind, n384), rule(1151), [uses(390, a(ind, n383))]).
substitution(392, ['X' = ind]).
proof(392, a(ind, n385), rule(1154), [uses(391, a(ind, n384))]).
substitution(393, ['X' = ind]).
proof(393, a(ind, n386), rule(1157), [uses(392, a(ind, n385))]).
substitution(394, ['X' = ind]).
proof(394, a(ind, n387), rule(1160), [uses(393, a(ind, n386))]).
substitution(395, ['X' = ind]).
proof(395, a(ind, n388), rule(1163), [uses(394, a(ind, n387))]).
substitution(396, ['X' = ind]).
proof(396, a(ind, n389), rule(1166), [uses(395, a(ind, n388))]).
substitution(397, ['X' = ind]).
proof(397, a(ind, n390), rule(1169), [uses(396, a(ind, n389))]).
substitution(398, ['X' = ind]).
proof(398, a(ind, n391), rule(1172), [uses(397, a(ind, n390))]).
substitution(399, ['X' = ind]).
proof(399, a(ind, n392), rule(1175), [uses(398, a(ind, n391))]).
substitution(400, ['X' = ind]).
proof(400, a(ind, n393), rule(1178), [uses(399, a(ind, n392))]).
substitution(401, ['X' = ind]).
proof(401, a(ind, n394), rule(1181), [uses(400, a(ind, n393))]).
substitution(402, ['X' = ind]).
proof(402, a(ind, n395), rule(1184), [uses(401, a(ind, n394))]).
substitution(403, ['X' = ind]).
proof(403, a(ind, n396), rule(1187), [uses(402, a(ind, n395))]).
substitution(404, ['X' = ind]).
proof(404, a(ind, n397), rule(1190), [uses(403, a(ind, n396))]).
substitution(405, ['X' = ind]).
proof(405, a(ind, n398), rule(1193), [uses(404, a(ind, n397))]).
substitution(406, ['X' = ind]).
proof(406, a(ind, n399), rule(1196), [uses(405, a(ind, n398))]).
substitution(407, ['X' = ind]).
proof(407, a(ind, n400), rule(1199), [uses(406, a(ind, n399))]).
substitution(408, ['X' = ind]).
proof(408, a(ind, n401), rule(1202), [uses(407, a(ind, n400))]).
substitution(409, ['X' = ind]).
proof(409, a(ind, n402), rule(1205), [uses(408, a(ind, n401))]).
substitution(410, ['X' = ind]).
proof(410, a(ind, n403), rule(1208), [uses(409, a(ind, n402))]).
substitution(411, ['X' = ind]).
proof(411, a(ind, n404), rule(1211), [uses(410, a(ind, n403))]).
substitution(412, ['X' = ind]).
proof(412, a(ind, n405), rule(1214), [uses(411, a(ind, n404))]).
substitution(413, ['X' = ind]).
proof(413, a(ind, n406), rule(1217), [uses(412, a(ind, n405))]).
substitution(414, ['X' = ind]).
proof(414, a(ind, n407), rule(1220), [uses(413, a(ind, n406))]).
substitution(415, ['X' = ind]).
proof(415, a(ind, n408), rule(1223), [uses(414, a(ind, n407))]).
substitution(416, ['X' = ind]).
proof(416, a(ind, n409), rule(1226), [uses(415, a(ind, n408))]).
substitution(417, ['X' = ind]).
proof(417, a(ind, n410), rule(1229), [uses(416, a(ind, n409))]).
substitution(418, ['X' = ind]).
proof(418, a(ind, n411), rule(1232), [uses(417, a(ind, n410))]).
substitution(419, ['X' = ind]).
proof(419, a(ind, n412), rule(1235), [uses(418, a(ind, n411))]).
substitution(420, ['X' = ind]).
proof(420, a(ind, n413), rule(1238), [uses(419, a(ind, n412))]).
substitution(421, ['X' = ind]).
proof(421, a(ind, n414), rule(1241), [uses(420, a(ind, n413))]).
substitution(422, ['X' = ind]).
proof(422, a(ind, n415), rule(1244), [uses(421, a(ind, n414))]).
substitution(423, ['X' = ind]).
proof(423, a(ind, n416), rule(1247), [uses(422, a(ind, n415))]).
substitution(424, ['X' = ind]).
proof(424, a(ind, n417), rule(1250), [uses(423, a(ind, n416))]).
substitution(425, ['X' = ind]).
proof(425, a(ind, n418), rule(1253), [uses(424, a(ind, n417))]).
substitution(426, ['X' = ind]).
proof(426, a(ind, n419), rule(1256), [uses(425, a(ind, n418))]).
substitution(427, ['X' = ind]).
proof(427, a(ind, n420), rule(1259), [uses(426, a(ind, n419))]).
substitution(428, ['X' = ind]).
proof(428, a(ind, n421), rule(1262), [uses(427, a(ind, n420))]).
substitution(429, ['X' = ind]).
proof(429, a(ind, n422), rule(1265), [uses(428, a(ind, n421))]).
substitution(430, ['X' = ind]).
proof(430, a(ind, n423), rule(1268), [uses(429, a(ind, n422))]).
substitution(431, ['X' = ind]).
proof(431, a(ind, n424), rule(1271), [uses(430, a(ind, n423))]).
substitution(432, ['X' = ind]).
proof(432, a(ind, n425), rule(1274), [uses(431, a(ind, n424))]).
substitution(433, ['X' = ind]).
proof(433, a(ind, n426), rule(1277), [uses(432, a(ind, n425))]).
substitution(434, ['X' = ind]).
proof(434, a(ind, n427), rule(1280), [uses(433, a(ind, n426))]).
substitution(435, ['X' = ind]).
proof(435, a(ind, n428), rule(1283), [uses(434, a(ind, n427))]).
substitution(436, ['X' = ind]).
proof(436, a(ind, n429), rule(1286), [uses(435, a(ind, n428))]).
substitution(437, ['X' = ind]).
proof(437, a(ind, n430), rule(1289), [uses(436, a(ind, n429))]).
substitution(438, ['X' = ind]).
proof(438, a(ind, n431), rule(1292), [uses(437, a(ind, n430))]).
substitution(439, ['X' = ind]).
proof(439, a(ind, n432), rule(1295), [uses(438, a(ind, n431))]).
substitution(440, ['X' = ind]).
proof(440, a(ind, n433), rule(1298), [uses(439, a(ind, n432))]).
substitution(441, ['X' = ind]).
proof(441, a(ind, n434), rule(1301), [uses(440, a(ind, n433))]).
substitution(442, ['X' = ind]).
proof(442, a(ind, n435), rule(1304), [uses(441, a(ind, n434))]).
substitution(443, ['X' = ind]).
proof(443, a(ind, n436), rule(1307), [uses(442, a(ind, n435))]).
substitution(444, ['X' = ind]).
proof(444, a(ind, n437), rule(1310), [uses(443, a(ind, n436))]).
substitution(445, ['X' = ind]).
proof(445, a(ind, n438), rule(1313), [uses(444, a(ind, n437))]).
substitution(446, ['X' = ind]).
proof(446, a(ind, n439), rule(1316), [uses(445, a(ind, n438))]).
substitution(447, ['X' = ind]).
proof(447, a(ind, n440), rule(1319), [uses(446, a(ind, n439))]).
substitution(448, ['X' = ind]).
proof(448, a(ind, n441), rule(1322), [uses(447, a(ind, n440))]).
substitution(449, ['X' = ind]).
proof(449, a(ind, n442), rule(1325), [uses(448, a(ind, n441))]).
substitution(450, ['X' = ind]).
proof(450, a(ind, n443), rule(1328), [uses(449, a(ind, n442))]).
substitution(451, ['X' = ind]).
proof(451, a(ind, n444), rule(1331), [uses(450, a(ind, n443))]).
substitution(452, ['X' = ind]).
proof(452, a(ind, n445), rule(1334), [uses(451, a(ind, n444))]).
substitution(453, ['X' = ind]).
proof(453, a(ind, n446), rule(1337), [uses(452, a(ind, n445))]).
substitution(454, ['X' = ind]).
proof(454, a(ind, n447), rule(1340), [uses(453, a(ind, n446))]).
substitution(455, ['X' = ind]).
proof(455, a(ind, n448), rule(1343), [uses(454, a(ind, n447))]).
substitution(456, ['X' = ind]).
proof(456, a(ind, n449), rule(1346), [uses(455, a(ind, n448))]).
substitution(457, ['X' = ind]).
proof(457, a(ind, n450), rule(1349), [uses(456, a(ind, n449))]).
substitution(458, ['X' = ind]).
proof(458, a(ind, n451), rule(1352), [uses(457, a(ind, n450))]).
substitution(459, ['X' = ind]).
proof(459, a(ind, n452), rule(1355), [uses(458, a(ind, n451))]).
substitution(460, ['X' = ind]).
proof(460, a(ind, n453), rule(1358), [uses(459, a(ind, n452))]).
substitution(461, ['X' = ind]).
proof(461, a(ind, n454), rule(1361), [uses(460, a(ind, n453))]).
substitution(462, ['X' = ind]).
proof(462, a(ind, n455), rule(1364), [uses(461, a(ind, n454))]).
substitution(463, ['X' = ind]).
proof(463, a(ind, n456), rule(1367), [uses(462, a(ind, n455))]).
substitution(464, ['X' = ind]).
proof(464, a(ind, n457), rule(1370), [uses(463, a(ind, n456))]).
substitution(465, ['X' = ind]).
proof(465, a(ind, n458), rule(1373), [uses(464, a(ind, n457))]).
substitution(466, ['X' = ind]).
proof(466, a(ind, n459), rule(1376), [uses(465, a(ind, n458))]).
substitution(467, ['X' = ind]).
proof(467, a(ind, n460), rule(1379), [uses(466, a(ind, n459))]).
substitution(468, ['X' = ind]).
proof(468, a(ind, n461), rule(1382), [uses(467, a(ind, n460))]).
substitution(469, ['X' = ind]).
proof(469, a(ind, n462), rule(1385), [uses(468, a(ind, n461))]).
substitution(470, ['X' = ind]).
proof(470, a(ind, n463), rule(1388), [uses(469, a(ind, n462))]).
substitution(471, ['X' = ind]).
proof(471, a(ind, n464), rule(1391), [uses(470, a(ind, n463))]).
substitution(472, ['X' = ind]).
proof(472, a(ind, n465), rule(1394), [uses(471, a(ind, n464))]).
substitution(473, ['X' = ind]).
proof(473, a(ind, n466), rule(1397), [uses(472, a(ind, n465))]).
substitution(474, ['X' = ind]).
proof(474, a(ind, n467), rule(1400), [uses(473, a(ind, n466))]).
substitution(475, ['X' = ind]).
proof(475, a(ind, n468), rule(1403), [uses(474, a(ind, n467))]).
substitution(476, ['X' = ind]).
proof(476, a(ind, n469), rule(1406), [uses(475, a(ind, n468))]).
substitution(477, ['X' = ind]).
proof(477, a(ind, n470), rule(1409), [uses(476, a(ind, n469))]).
substitution(478, ['X' = ind]).
proof(478, a(ind, n471), rule(1412), [uses(477, a(ind, n470))]).
substitution(479, ['X' = ind]).
proof(479, a(ind, n472), rule(1415), [uses(478, a(ind, n471))]).
substitution(480, ['X' = ind]).
proof(480, a(ind, n473), rule(1418), [uses(479, a(ind, n472))]).
substitution(481, ['X' = ind]).
proof(481, a(ind, n474), rule(1421), [uses(480, a(ind, n473))]).
substitution(482, ['X' = ind]).
proof(482, a(ind, n475), rule(1424), [uses(481, a(ind, n474))]).
substitution(483, ['X' = ind]).
proof(483, a(ind, n476), rule(1427), [uses(482, a(ind, n475))]).
substitution(484, ['X' = ind]).
proof(484, a(ind, n477), rule(1430), [uses(483, a(ind, n476))]).
substitution(485, ['X' = ind]).
proof(485, a(ind, n478), rule(1433), [uses(484, a(ind, n477))]).
substitution(486, ['X' = ind]).
proof(486, a(ind, n479), rule(1436), [uses(485, a(ind, n478))]).
substitution(487, ['X' = ind]).
proof(487, a(ind, n480), rule(1439), [uses(486, a(ind, n479))]).
substitution(488, ['X' = ind]).
proof(488, a(ind, n481), rule(1442), [uses(487, a(ind, n480))]).
substitution(489, ['X' = ind]).
proof(489, a(ind, n482), rule(1445), [uses(488, a(ind, n481))]).
substitution(490, ['X' = ind]).
proof(490, a(ind, n483), rule(1448), [uses(489, a(ind, n482))]).
substitution(491, ['X' = ind]).
proof(491, a(ind, n484), rule(1451), [uses(490, a(ind, n483))]).
substitution(492, ['X' = ind]).
proof(492, a(ind, n485), rule(1454), [uses(491, a(ind, n484))]).
substitution(493, ['X' = ind]).
proof(493, a(ind, n486), rule(1457), [uses(492, a(ind, n485))]).
substitution(494, ['X' = ind]).
proof(494, a(ind, n487), rule(1460), [uses(493, a(ind, n486))]).
substitution(495, ['X' = ind]).
proof(495, a(ind, n488), rule(1463), [uses(494, a(ind, n487))]).
substitution(496, ['X' = ind]).
proof(496, a(ind, n489), rule(1466), [uses(495, a(ind, n488))]).
substitution(497, ['X' = ind]).
proof(497, a(ind, n490), rule(1469), [uses(496, a(ind, n489))]).
substitution(498, ['X' = ind]).
proof(498, a(ind, n491), rule(1472), [uses(497, a(ind, n490))]).
substitution(499, ['X' = ind]).
proof(499, a(ind, n492), rule(1475), [uses(498, a(ind, n491))]).
substitution(500, ['X' = ind]).
proof(500, a(ind, n493), rule(1478), [uses(499, a(ind, n492))]).
substitution(501, ['X' = ind]).
proof(501, a(ind, n494), rule(1481), [uses(500, a(ind, n493))]).
substitution(502, ['X' = ind]).
proof(502, a(ind, n495), rule(1484), [uses(501, a(ind, n494))]).
substitution(503, ['X' = ind]).
proof(503, a(ind, n496), rule(1487), [uses(502, a(ind, n495))]).
substitution(504, ['X' = ind]).
proof(504, a(ind, n497), rule(1490), [uses(503, a(ind, n496))]).
substitution(505, ['X' = ind]).
proof(505, a(ind, n498), rule(1493), [uses(504, a(ind, n497))]).
substitution(506, ['X' = ind]).
proof(506, a(ind, n499), rule(1496), [uses(505, a(ind, n498))]).
substitution(507, ['X' = ind]).
proof(507, a(ind, n500), rule(1499), [uses(506, a(ind, n499))]).
substitution(508, ['X' = ind]).
proof(508, a(ind, n501), rule(1502), [uses(507, a(ind, n500))]).
substitution(509, ['X' = ind]).
proof(509, a(ind, i500), rule(1500), [uses(506, a(ind, n499))]).
substitution(510, ['X' = ind]).
proof(510, a(ind, n502), rule(1505), [uses(508, a(ind, n501))]).
substitution(511, ['X' = ind]).
proof(511, a(ind, n503), rule(1508), [uses(510, a(ind, n502))]).
substitution(512, ['X' = ind]).
proof(512, a(ind, j500), rule(1501), [uses(506, a(ind, n499))]).
substitution(513, ['X' = ind]).
proof(513, a(ind, n504), rule(1511), [uses(511, a(ind, n503))]).
substitution(514, []).
proof(514, arc(check3, "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches."), rule(3006), [uses(507, a(ind, n500)), uses(509, a(ind, i500)), uses(512, a(ind, j500))]).
substitution(515, ['X' = ind]).
proof(515, a(ind, n505), rule(1514), [uses(513, a(ind, n504))]).
substitution(516, ['Check' = check3, 'Message' = "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches."]).
proof(516, solution([check3, "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches."]), query, [uses(514, arc(check3, "C3 OK - the chain reaches the midpoint n500 and still carries both side-label branches."))]).
substitution(517, ['X' = ind]).
proof(517, a(ind, n506), rule(1517), [uses(515, a(ind, n505))]).
substitution(518, ['X' = ind]).
proof(518, a(ind, n507), rule(1520), [uses(517, a(ind, n506))]).
substitution(519, ['X' = ind]).
proof(519, a(ind, n508), rule(1523), [uses(518, a(ind, n507))]).
substitution(520, ['X' = ind]).
proof(520, a(ind, n509), rule(1526), [uses(519, a(ind, n508))]).
substitution(521, ['X' = ind]).
proof(521, a(ind, n510), rule(1529), [uses(520, a(ind, n509))]).
substitution(522, ['X' = ind]).
proof(522, a(ind, n511), rule(1532), [uses(521, a(ind, n510))]).
substitution(523, ['X' = ind]).
proof(523, a(ind, n512), rule(1535), [uses(522, a(ind, n511))]).
substitution(524, ['X' = ind]).
proof(524, a(ind, n513), rule(1538), [uses(523, a(ind, n512))]).
substitution(525, ['X' = ind]).
proof(525, a(ind, n514), rule(1541), [uses(524, a(ind, n513))]).
substitution(526, ['X' = ind]).
proof(526, a(ind, n515), rule(1544), [uses(525, a(ind, n514))]).
substitution(527, ['X' = ind]).
proof(527, a(ind, n516), rule(1547), [uses(526, a(ind, n515))]).
substitution(528, ['X' = ind]).
proof(528, a(ind, n517), rule(1550), [uses(527, a(ind, n516))]).
substitution(529, ['X' = ind]).
proof(529, a(ind, n518), rule(1553), [uses(528, a(ind, n517))]).
substitution(530, ['X' = ind]).
proof(530, a(ind, n519), rule(1556), [uses(529, a(ind, n518))]).
substitution(531, ['X' = ind]).
proof(531, a(ind, n520), rule(1559), [uses(530, a(ind, n519))]).
substitution(532, ['X' = ind]).
proof(532, a(ind, n521), rule(1562), [uses(531, a(ind, n520))]).
substitution(533, ['X' = ind]).
proof(533, a(ind, n522), rule(1565), [uses(532, a(ind, n521))]).
substitution(534, ['X' = ind]).
proof(534, a(ind, n523), rule(1568), [uses(533, a(ind, n522))]).
substitution(535, ['X' = ind]).
proof(535, a(ind, n524), rule(1571), [uses(534, a(ind, n523))]).
substitution(536, ['X' = ind]).
proof(536, a(ind, n525), rule(1574), [uses(535, a(ind, n524))]).
substitution(537, ['X' = ind]).
proof(537, a(ind, n526), rule(1577), [uses(536, a(ind, n525))]).
substitution(538, ['X' = ind]).
proof(538, a(ind, n527), rule(1580), [uses(537, a(ind, n526))]).
substitution(539, ['X' = ind]).
proof(539, a(ind, n528), rule(1583), [uses(538, a(ind, n527))]).
substitution(540, ['X' = ind]).
proof(540, a(ind, n529), rule(1586), [uses(539, a(ind, n528))]).
substitution(541, ['X' = ind]).
proof(541, a(ind, n530), rule(1589), [uses(540, a(ind, n529))]).
substitution(542, ['X' = ind]).
proof(542, a(ind, n531), rule(1592), [uses(541, a(ind, n530))]).
substitution(543, ['X' = ind]).
proof(543, a(ind, n532), rule(1595), [uses(542, a(ind, n531))]).
substitution(544, ['X' = ind]).
proof(544, a(ind, n533), rule(1598), [uses(543, a(ind, n532))]).
substitution(545, ['X' = ind]).
proof(545, a(ind, n534), rule(1601), [uses(544, a(ind, n533))]).
substitution(546, ['X' = ind]).
proof(546, a(ind, n535), rule(1604), [uses(545, a(ind, n534))]).
substitution(547, ['X' = ind]).
proof(547, a(ind, n536), rule(1607), [uses(546, a(ind, n535))]).
substitution(548, ['X' = ind]).
proof(548, a(ind, n537), rule(1610), [uses(547, a(ind, n536))]).
substitution(549, ['X' = ind]).
proof(549, a(ind, n538), rule(1613), [uses(548, a(ind, n537))]).
substitution(550, ['X' = ind]).
proof(550, a(ind, n539), rule(1616), [uses(549, a(ind, n538))]).
substitution(551, ['X' = ind]).
proof(551, a(ind, n540), rule(1619), [uses(550, a(ind, n539))]).
substitution(552, ['X' = ind]).
proof(552, a(ind, n541), rule(1622), [uses(551, a(ind, n540))]).
substitution(553, ['X' = ind]).
proof(553, a(ind, n542), rule(1625), [uses(552, a(ind, n541))]).
substitution(554, ['X' = ind]).
proof(554, a(ind, n543), rule(1628), [uses(553, a(ind, n542))]).
substitution(555, ['X' = ind]).
proof(555, a(ind, n544), rule(1631), [uses(554, a(ind, n543))]).
substitution(556, ['X' = ind]).
proof(556, a(ind, n545), rule(1634), [uses(555, a(ind, n544))]).
substitution(557, ['X' = ind]).
proof(557, a(ind, n546), rule(1637), [uses(556, a(ind, n545))]).
substitution(558, ['X' = ind]).
proof(558, a(ind, n547), rule(1640), [uses(557, a(ind, n546))]).
substitution(559, ['X' = ind]).
proof(559, a(ind, n548), rule(1643), [uses(558, a(ind, n547))]).
substitution(560, ['X' = ind]).
proof(560, a(ind, n549), rule(1646), [uses(559, a(ind, n548))]).
substitution(561, ['X' = ind]).
proof(561, a(ind, n550), rule(1649), [uses(560, a(ind, n549))]).
substitution(562, ['X' = ind]).
proof(562, a(ind, n551), rule(1652), [uses(561, a(ind, n550))]).
substitution(563, ['X' = ind]).
proof(563, a(ind, n552), rule(1655), [uses(562, a(ind, n551))]).
substitution(564, ['X' = ind]).
proof(564, a(ind, n553), rule(1658), [uses(563, a(ind, n552))]).
substitution(565, ['X' = ind]).
proof(565, a(ind, n554), rule(1661), [uses(564, a(ind, n553))]).
substitution(566, ['X' = ind]).
proof(566, a(ind, n555), rule(1664), [uses(565, a(ind, n554))]).
substitution(567, ['X' = ind]).
proof(567, a(ind, n556), rule(1667), [uses(566, a(ind, n555))]).
substitution(568, ['X' = ind]).
proof(568, a(ind, n557), rule(1670), [uses(567, a(ind, n556))]).
substitution(569, ['X' = ind]).
proof(569, a(ind, n558), rule(1673), [uses(568, a(ind, n557))]).
substitution(570, ['X' = ind]).
proof(570, a(ind, n559), rule(1676), [uses(569, a(ind, n558))]).
substitution(571, ['X' = ind]).
proof(571, a(ind, n560), rule(1679), [uses(570, a(ind, n559))]).
substitution(572, ['X' = ind]).
proof(572, a(ind, n561), rule(1682), [uses(571, a(ind, n560))]).
substitution(573, ['X' = ind]).
proof(573, a(ind, n562), rule(1685), [uses(572, a(ind, n561))]).
substitution(574, ['X' = ind]).
proof(574, a(ind, n563), rule(1688), [uses(573, a(ind, n562))]).
substitution(575, ['X' = ind]).
proof(575, a(ind, n564), rule(1691), [uses(574, a(ind, n563))]).
substitution(576, ['X' = ind]).
proof(576, a(ind, n565), rule(1694), [uses(575, a(ind, n564))]).
substitution(577, ['X' = ind]).
proof(577, a(ind, n566), rule(1697), [uses(576, a(ind, n565))]).
substitution(578, ['X' = ind]).
proof(578, a(ind, n567), rule(1700), [uses(577, a(ind, n566))]).
substitution(579, ['X' = ind]).
proof(579, a(ind, n568), rule(1703), [uses(578, a(ind, n567))]).
substitution(580, ['X' = ind]).
proof(580, a(ind, n569), rule(1706), [uses(579, a(ind, n568))]).
substitution(581, ['X' = ind]).
proof(581, a(ind, n570), rule(1709), [uses(580, a(ind, n569))]).
substitution(582, ['X' = ind]).
proof(582, a(ind, n571), rule(1712), [uses(581, a(ind, n570))]).
substitution(583, ['X' = ind]).
proof(583, a(ind, n572), rule(1715), [uses(582, a(ind, n571))]).
substitution(584, ['X' = ind]).
proof(584, a(ind, n573), rule(1718), [uses(583, a(ind, n572))]).
substitution(585, ['X' = ind]).
proof(585, a(ind, n574), rule(1721), [uses(584, a(ind, n573))]).
substitution(586, ['X' = ind]).
proof(586, a(ind, n575), rule(1724), [uses(585, a(ind, n574))]).
substitution(587, ['X' = ind]).
proof(587, a(ind, n576), rule(1727), [uses(586, a(ind, n575))]).
substitution(588, ['X' = ind]).
proof(588, a(ind, n577), rule(1730), [uses(587, a(ind, n576))]).
substitution(589, ['X' = ind]).
proof(589, a(ind, n578), rule(1733), [uses(588, a(ind, n577))]).
substitution(590, ['X' = ind]).
proof(590, a(ind, n579), rule(1736), [uses(589, a(ind, n578))]).
substitution(591, ['X' = ind]).
proof(591, a(ind, n580), rule(1739), [uses(590, a(ind, n579))]).
substitution(592, ['X' = ind]).
proof(592, a(ind, n581), rule(1742), [uses(591, a(ind, n580))]).
substitution(593, ['X' = ind]).
proof(593, a(ind, n582), rule(1745), [uses(592, a(ind, n581))]).
substitution(594, ['X' = ind]).
proof(594, a(ind, n583), rule(1748), [uses(593, a(ind, n582))]).
substitution(595, ['X' = ind]).
proof(595, a(ind, n584), rule(1751), [uses(594, a(ind, n583))]).
substitution(596, ['X' = ind]).
proof(596, a(ind, n585), rule(1754), [uses(595, a(ind, n584))]).
substitution(597, ['X' = ind]).
proof(597, a(ind, n586), rule(1757), [uses(596, a(ind, n585))]).
substitution(598, ['X' = ind]).
proof(598, a(ind, n587), rule(1760), [uses(597, a(ind, n586))]).
substitution(599, ['X' = ind]).
proof(599, a(ind, n588), rule(1763), [uses(598, a(ind, n587))]).
substitution(600, ['X' = ind]).
proof(600, a(ind, n589), rule(1766), [uses(599, a(ind, n588))]).
substitution(601, ['X' = ind]).
proof(601, a(ind, n590), rule(1769), [uses(600, a(ind, n589))]).
substitution(602, ['X' = ind]).
proof(602, a(ind, n591), rule(1772), [uses(601, a(ind, n590))]).
substitution(603, ['X' = ind]).
proof(603, a(ind, n592), rule(1775), [uses(602, a(ind, n591))]).
substitution(604, ['X' = ind]).
proof(604, a(ind, n593), rule(1778), [uses(603, a(ind, n592))]).
substitution(605, ['X' = ind]).
proof(605, a(ind, n594), rule(1781), [uses(604, a(ind, n593))]).
substitution(606, ['X' = ind]).
proof(606, a(ind, n595), rule(1784), [uses(605, a(ind, n594))]).
substitution(607, ['X' = ind]).
proof(607, a(ind, n596), rule(1787), [uses(606, a(ind, n595))]).
substitution(608, ['X' = ind]).
proof(608, a(ind, n597), rule(1790), [uses(607, a(ind, n596))]).
substitution(609, ['X' = ind]).
proof(609, a(ind, n598), rule(1793), [uses(608, a(ind, n597))]).
substitution(610, ['X' = ind]).
proof(610, a(ind, n599), rule(1796), [uses(609, a(ind, n598))]).
substitution(611, ['X' = ind]).
proof(611, a(ind, n600), rule(1799), [uses(610, a(ind, n599))]).
substitution(612, ['X' = ind]).
proof(612, a(ind, n601), rule(1802), [uses(611, a(ind, n600))]).
substitution(613, ['X' = ind]).
proof(613, a(ind, n602), rule(1805), [uses(612, a(ind, n601))]).
substitution(614, ['X' = ind]).
proof(614, a(ind, n603), rule(1808), [uses(613, a(ind, n602))]).
substitution(615, ['X' = ind]).
proof(615, a(ind, n604), rule(1811), [uses(614, a(ind, n603))]).
substitution(616, ['X' = ind]).
proof(616, a(ind, n605), rule(1814), [uses(615, a(ind, n604))]).
substitution(617, ['X' = ind]).
proof(617, a(ind, n606), rule(1817), [uses(616, a(ind, n605))]).
substitution(618, ['X' = ind]).
proof(618, a(ind, n607), rule(1820), [uses(617, a(ind, n606))]).
substitution(619, ['X' = ind]).
proof(619, a(ind, n608), rule(1823), [uses(618, a(ind, n607))]).
substitution(620, ['X' = ind]).
proof(620, a(ind, n609), rule(1826), [uses(619, a(ind, n608))]).
substitution(621, ['X' = ind]).
proof(621, a(ind, n610), rule(1829), [uses(620, a(ind, n609))]).
substitution(622, ['X' = ind]).
proof(622, a(ind, n611), rule(1832), [uses(621, a(ind, n610))]).
substitution(623, ['X' = ind]).
proof(623, a(ind, n612), rule(1835), [uses(622, a(ind, n611))]).
substitution(624, ['X' = ind]).
proof(624, a(ind, n613), rule(1838), [uses(623, a(ind, n612))]).
substitution(625, ['X' = ind]).
proof(625, a(ind, n614), rule(1841), [uses(624, a(ind, n613))]).
substitution(626, ['X' = ind]).
proof(626, a(ind, n615), rule(1844), [uses(625, a(ind, n614))]).
substitution(627, ['X' = ind]).
proof(627, a(ind, n616), rule(1847), [uses(626, a(ind, n615))]).
substitution(628, ['X' = ind]).
proof(628, a(ind, n617), rule(1850), [uses(627, a(ind, n616))]).
substitution(629, ['X' = ind]).
proof(629, a(ind, n618), rule(1853), [uses(628, a(ind, n617))]).
substitution(630, ['X' = ind]).
proof(630, a(ind, n619), rule(1856), [uses(629, a(ind, n618))]).
substitution(631, ['X' = ind]).
proof(631, a(ind, n620), rule(1859), [uses(630, a(ind, n619))]).
substitution(632, ['X' = ind]).
proof(632, a(ind, n621), rule(1862), [uses(631, a(ind, n620))]).
substitution(633, ['X' = ind]).
proof(633, a(ind, n622), rule(1865), [uses(632, a(ind, n621))]).
substitution(634, ['X' = ind]).
proof(634, a(ind, n623), rule(1868), [uses(633, a(ind, n622))]).
substitution(635, ['X' = ind]).
proof(635, a(ind, n624), rule(1871), [uses(634, a(ind, n623))]).
substitution(636, ['X' = ind]).
proof(636, a(ind, n625), rule(1874), [uses(635, a(ind, n624))]).
substitution(637, ['X' = ind]).
proof(637, a(ind, n626), rule(1877), [uses(636, a(ind, n625))]).
substitution(638, ['X' = ind]).
proof(638, a(ind, n627), rule(1880), [uses(637, a(ind, n626))]).
substitution(639, ['X' = ind]).
proof(639, a(ind, n628), rule(1883), [uses(638, a(ind, n627))]).
substitution(640, ['X' = ind]).
proof(640, a(ind, n629), rule(1886), [uses(639, a(ind, n628))]).
substitution(641, ['X' = ind]).
proof(641, a(ind, n630), rule(1889), [uses(640, a(ind, n629))]).
substitution(642, ['X' = ind]).
proof(642, a(ind, n631), rule(1892), [uses(641, a(ind, n630))]).
substitution(643, ['X' = ind]).
proof(643, a(ind, n632), rule(1895), [uses(642, a(ind, n631))]).
substitution(644, ['X' = ind]).
proof(644, a(ind, n633), rule(1898), [uses(643, a(ind, n632))]).
substitution(645, ['X' = ind]).
proof(645, a(ind, n634), rule(1901), [uses(644, a(ind, n633))]).
substitution(646, ['X' = ind]).
proof(646, a(ind, n635), rule(1904), [uses(645, a(ind, n634))]).
substitution(647, ['X' = ind]).
proof(647, a(ind, n636), rule(1907), [uses(646, a(ind, n635))]).
substitution(648, ['X' = ind]).
proof(648, a(ind, n637), rule(1910), [uses(647, a(ind, n636))]).
substitution(649, ['X' = ind]).
proof(649, a(ind, n638), rule(1913), [uses(648, a(ind, n637))]).
substitution(650, ['X' = ind]).
proof(650, a(ind, n639), rule(1916), [uses(649, a(ind, n638))]).
substitution(651, ['X' = ind]).
proof(651, a(ind, n640), rule(1919), [uses(650, a(ind, n639))]).
substitution(652, ['X' = ind]).
proof(652, a(ind, n641), rule(1922), [uses(651, a(ind, n640))]).
substitution(653, ['X' = ind]).
proof(653, a(ind, n642), rule(1925), [uses(652, a(ind, n641))]).
substitution(654, ['X' = ind]).
proof(654, a(ind, n643), rule(1928), [uses(653, a(ind, n642))]).
substitution(655, ['X' = ind]).
proof(655, a(ind, n644), rule(1931), [uses(654, a(ind, n643))]).
substitution(656, ['X' = ind]).
proof(656, a(ind, n645), rule(1934), [uses(655, a(ind, n644))]).
substitution(657, ['X' = ind]).
proof(657, a(ind, n646), rule(1937), [uses(656, a(ind, n645))]).
substitution(658, ['X' = ind]).
proof(658, a(ind, n647), rule(1940), [uses(657, a(ind, n646))]).
substitution(659, ['X' = ind]).
proof(659, a(ind, n648), rule(1943), [uses(658, a(ind, n647))]).
substitution(660, ['X' = ind]).
proof(660, a(ind, n649), rule(1946), [uses(659, a(ind, n648))]).
substitution(661, ['X' = ind]).
proof(661, a(ind, n650), rule(1949), [uses(660, a(ind, n649))]).
substitution(662, ['X' = ind]).
proof(662, a(ind, n651), rule(1952), [uses(661, a(ind, n650))]).
substitution(663, ['X' = ind]).
proof(663, a(ind, n652), rule(1955), [uses(662, a(ind, n651))]).
substitution(664, ['X' = ind]).
proof(664, a(ind, n653), rule(1958), [uses(663, a(ind, n652))]).
substitution(665, ['X' = ind]).
proof(665, a(ind, n654), rule(1961), [uses(664, a(ind, n653))]).
substitution(666, ['X' = ind]).
proof(666, a(ind, n655), rule(1964), [uses(665, a(ind, n654))]).
substitution(667, ['X' = ind]).
proof(667, a(ind, n656), rule(1967), [uses(666, a(ind, n655))]).
substitution(668, ['X' = ind]).
proof(668, a(ind, n657), rule(1970), [uses(667, a(ind, n656))]).
substitution(669, ['X' = ind]).
proof(669, a(ind, n658), rule(1973), [uses(668, a(ind, n657))]).
substitution(670, ['X' = ind]).
proof(670, a(ind, n659), rule(1976), [uses(669, a(ind, n658))]).
substitution(671, ['X' = ind]).
proof(671, a(ind, n660), rule(1979), [uses(670, a(ind, n659))]).
substitution(672, ['X' = ind]).
proof(672, a(ind, n661), rule(1982), [uses(671, a(ind, n660))]).
substitution(673, ['X' = ind]).
proof(673, a(ind, n662), rule(1985), [uses(672, a(ind, n661))]).
substitution(674, ['X' = ind]).
proof(674, a(ind, n663), rule(1988), [uses(673, a(ind, n662))]).
substitution(675, ['X' = ind]).
proof(675, a(ind, n664), rule(1991), [uses(674, a(ind, n663))]).
substitution(676, ['X' = ind]).
proof(676, a(ind, n665), rule(1994), [uses(675, a(ind, n664))]).
substitution(677, ['X' = ind]).
proof(677, a(ind, n666), rule(1997), [uses(676, a(ind, n665))]).
substitution(678, ['X' = ind]).
proof(678, a(ind, n667), rule(2000), [uses(677, a(ind, n666))]).
substitution(679, ['X' = ind]).
proof(679, a(ind, n668), rule(2003), [uses(678, a(ind, n667))]).
substitution(680, ['X' = ind]).
proof(680, a(ind, n669), rule(2006), [uses(679, a(ind, n668))]).
substitution(681, ['X' = ind]).
proof(681, a(ind, n670), rule(2009), [uses(680, a(ind, n669))]).
substitution(682, ['X' = ind]).
proof(682, a(ind, n671), rule(2012), [uses(681, a(ind, n670))]).
substitution(683, ['X' = ind]).
proof(683, a(ind, n672), rule(2015), [uses(682, a(ind, n671))]).
substitution(684, ['X' = ind]).
proof(684, a(ind, n673), rule(2018), [uses(683, a(ind, n672))]).
substitution(685, ['X' = ind]).
proof(685, a(ind, n674), rule(2021), [uses(684, a(ind, n673))]).
substitution(686, ['X' = ind]).
proof(686, a(ind, n675), rule(2024), [uses(685, a(ind, n674))]).
substitution(687, ['X' = ind]).
proof(687, a(ind, n676), rule(2027), [uses(686, a(ind, n675))]).
substitution(688, ['X' = ind]).
proof(688, a(ind, n677), rule(2030), [uses(687, a(ind, n676))]).
substitution(689, ['X' = ind]).
proof(689, a(ind, n678), rule(2033), [uses(688, a(ind, n677))]).
substitution(690, ['X' = ind]).
proof(690, a(ind, n679), rule(2036), [uses(689, a(ind, n678))]).
substitution(691, ['X' = ind]).
proof(691, a(ind, n680), rule(2039), [uses(690, a(ind, n679))]).
substitution(692, ['X' = ind]).
proof(692, a(ind, n681), rule(2042), [uses(691, a(ind, n680))]).
substitution(693, ['X' = ind]).
proof(693, a(ind, n682), rule(2045), [uses(692, a(ind, n681))]).
substitution(694, ['X' = ind]).
proof(694, a(ind, n683), rule(2048), [uses(693, a(ind, n682))]).
substitution(695, ['X' = ind]).
proof(695, a(ind, n684), rule(2051), [uses(694, a(ind, n683))]).
substitution(696, ['X' = ind]).
proof(696, a(ind, n685), rule(2054), [uses(695, a(ind, n684))]).
substitution(697, ['X' = ind]).
proof(697, a(ind, n686), rule(2057), [uses(696, a(ind, n685))]).
substitution(698, ['X' = ind]).
proof(698, a(ind, n687), rule(2060), [uses(697, a(ind, n686))]).
substitution(699, ['X' = ind]).
proof(699, a(ind, n688), rule(2063), [uses(698, a(ind, n687))]).
substitution(700, ['X' = ind]).
proof(700, a(ind, n689), rule(2066), [uses(699, a(ind, n688))]).
substitution(701, ['X' = ind]).
proof(701, a(ind, n690), rule(2069), [uses(700, a(ind, n689))]).
substitution(702, ['X' = ind]).
proof(702, a(ind, n691), rule(2072), [uses(701, a(ind, n690))]).
substitution(703, ['X' = ind]).
proof(703, a(ind, n692), rule(2075), [uses(702, a(ind, n691))]).
substitution(704, ['X' = ind]).
proof(704, a(ind, n693), rule(2078), [uses(703, a(ind, n692))]).
substitution(705, ['X' = ind]).
proof(705, a(ind, n694), rule(2081), [uses(704, a(ind, n693))]).
substitution(706, ['X' = ind]).
proof(706, a(ind, n695), rule(2084), [uses(705, a(ind, n694))]).
substitution(707, ['X' = ind]).
proof(707, a(ind, n696), rule(2087), [uses(706, a(ind, n695))]).
substitution(708, ['X' = ind]).
proof(708, a(ind, n697), rule(2090), [uses(707, a(ind, n696))]).
substitution(709, ['X' = ind]).
proof(709, a(ind, n698), rule(2093), [uses(708, a(ind, n697))]).
substitution(710, ['X' = ind]).
proof(710, a(ind, n699), rule(2096), [uses(709, a(ind, n698))]).
substitution(711, ['X' = ind]).
proof(711, a(ind, n700), rule(2099), [uses(710, a(ind, n699))]).
substitution(712, ['X' = ind]).
proof(712, a(ind, n701), rule(2102), [uses(711, a(ind, n700))]).
substitution(713, ['X' = ind]).
proof(713, a(ind, n702), rule(2105), [uses(712, a(ind, n701))]).
substitution(714, ['X' = ind]).
proof(714, a(ind, n703), rule(2108), [uses(713, a(ind, n702))]).
substitution(715, ['X' = ind]).
proof(715, a(ind, n704), rule(2111), [uses(714, a(ind, n703))]).
substitution(716, ['X' = ind]).
proof(716, a(ind, n705), rule(2114), [uses(715, a(ind, n704))]).
substitution(717, ['X' = ind]).
proof(717, a(ind, n706), rule(2117), [uses(716, a(ind, n705))]).
substitution(718, ['X' = ind]).
proof(718, a(ind, n707), rule(2120), [uses(717, a(ind, n706))]).
substitution(719, ['X' = ind]).
proof(719, a(ind, n708), rule(2123), [uses(718, a(ind, n707))]).
substitution(720, ['X' = ind]).
proof(720, a(ind, n709), rule(2126), [uses(719, a(ind, n708))]).
substitution(721, ['X' = ind]).
proof(721, a(ind, n710), rule(2129), [uses(720, a(ind, n709))]).
substitution(722, ['X' = ind]).
proof(722, a(ind, n711), rule(2132), [uses(721, a(ind, n710))]).
substitution(723, ['X' = ind]).
proof(723, a(ind, n712), rule(2135), [uses(722, a(ind, n711))]).
substitution(724, ['X' = ind]).
proof(724, a(ind, n713), rule(2138), [uses(723, a(ind, n712))]).
substitution(725, ['X' = ind]).
proof(725, a(ind, n714), rule(2141), [uses(724, a(ind, n713))]).
substitution(726, ['X' = ind]).
proof(726, a(ind, n715), rule(2144), [uses(725, a(ind, n714))]).
substitution(727, ['X' = ind]).
proof(727, a(ind, n716), rule(2147), [uses(726, a(ind, n715))]).
substitution(728, ['X' = ind]).
proof(728, a(ind, n717), rule(2150), [uses(727, a(ind, n716))]).
substitution(729, ['X' = ind]).
proof(729, a(ind, n718), rule(2153), [uses(728, a(ind, n717))]).
substitution(730, ['X' = ind]).
proof(730, a(ind, n719), rule(2156), [uses(729, a(ind, n718))]).
substitution(731, ['X' = ind]).
proof(731, a(ind, n720), rule(2159), [uses(730, a(ind, n719))]).
substitution(732, ['X' = ind]).
proof(732, a(ind, n721), rule(2162), [uses(731, a(ind, n720))]).
substitution(733, ['X' = ind]).
proof(733, a(ind, n722), rule(2165), [uses(732, a(ind, n721))]).
substitution(734, ['X' = ind]).
proof(734, a(ind, n723), rule(2168), [uses(733, a(ind, n722))]).
substitution(735, ['X' = ind]).
proof(735, a(ind, n724), rule(2171), [uses(734, a(ind, n723))]).
substitution(736, ['X' = ind]).
proof(736, a(ind, n725), rule(2174), [uses(735, a(ind, n724))]).
substitution(737, ['X' = ind]).
proof(737, a(ind, n726), rule(2177), [uses(736, a(ind, n725))]).
substitution(738, ['X' = ind]).
proof(738, a(ind, n727), rule(2180), [uses(737, a(ind, n726))]).
substitution(739, ['X' = ind]).
proof(739, a(ind, n728), rule(2183), [uses(738, a(ind, n727))]).
substitution(740, ['X' = ind]).
proof(740, a(ind, n729), rule(2186), [uses(739, a(ind, n728))]).
substitution(741, ['X' = ind]).
proof(741, a(ind, n730), rule(2189), [uses(740, a(ind, n729))]).
substitution(742, ['X' = ind]).
proof(742, a(ind, n731), rule(2192), [uses(741, a(ind, n730))]).
substitution(743, ['X' = ind]).
proof(743, a(ind, n732), rule(2195), [uses(742, a(ind, n731))]).
substitution(744, ['X' = ind]).
proof(744, a(ind, n733), rule(2198), [uses(743, a(ind, n732))]).
substitution(745, ['X' = ind]).
proof(745, a(ind, n734), rule(2201), [uses(744, a(ind, n733))]).
substitution(746, ['X' = ind]).
proof(746, a(ind, n735), rule(2204), [uses(745, a(ind, n734))]).
substitution(747, ['X' = ind]).
proof(747, a(ind, n736), rule(2207), [uses(746, a(ind, n735))]).
substitution(748, ['X' = ind]).
proof(748, a(ind, n737), rule(2210), [uses(747, a(ind, n736))]).
substitution(749, ['X' = ind]).
proof(749, a(ind, n738), rule(2213), [uses(748, a(ind, n737))]).
substitution(750, ['X' = ind]).
proof(750, a(ind, n739), rule(2216), [uses(749, a(ind, n738))]).
substitution(751, ['X' = ind]).
proof(751, a(ind, n740), rule(2219), [uses(750, a(ind, n739))]).
substitution(752, ['X' = ind]).
proof(752, a(ind, n741), rule(2222), [uses(751, a(ind, n740))]).
substitution(753, ['X' = ind]).
proof(753, a(ind, n742), rule(2225), [uses(752, a(ind, n741))]).
substitution(754, ['X' = ind]).
proof(754, a(ind, n743), rule(2228), [uses(753, a(ind, n742))]).
substitution(755, ['X' = ind]).
proof(755, a(ind, n744), rule(2231), [uses(754, a(ind, n743))]).
substitution(756, ['X' = ind]).
proof(756, a(ind, n745), rule(2234), [uses(755, a(ind, n744))]).
substitution(757, ['X' = ind]).
proof(757, a(ind, n746), rule(2237), [uses(756, a(ind, n745))]).
substitution(758, ['X' = ind]).
proof(758, a(ind, n747), rule(2240), [uses(757, a(ind, n746))]).
substitution(759, ['X' = ind]).
proof(759, a(ind, n748), rule(2243), [uses(758, a(ind, n747))]).
substitution(760, ['X' = ind]).
proof(760, a(ind, n749), rule(2246), [uses(759, a(ind, n748))]).
substitution(761, ['X' = ind]).
proof(761, a(ind, n750), rule(2249), [uses(760, a(ind, n749))]).
substitution(762, ['X' = ind]).
proof(762, a(ind, n751), rule(2252), [uses(761, a(ind, n750))]).
substitution(763, ['X' = ind]).
proof(763, a(ind, n752), rule(2255), [uses(762, a(ind, n751))]).
substitution(764, ['X' = ind]).
proof(764, a(ind, n753), rule(2258), [uses(763, a(ind, n752))]).
substitution(765, ['X' = ind]).
proof(765, a(ind, n754), rule(2261), [uses(764, a(ind, n753))]).
substitution(766, ['X' = ind]).
proof(766, a(ind, n755), rule(2264), [uses(765, a(ind, n754))]).
substitution(767, ['X' = ind]).
proof(767, a(ind, n756), rule(2267), [uses(766, a(ind, n755))]).
substitution(768, ['X' = ind]).
proof(768, a(ind, n757), rule(2270), [uses(767, a(ind, n756))]).
substitution(769, ['X' = ind]).
proof(769, a(ind, n758), rule(2273), [uses(768, a(ind, n757))]).
substitution(770, ['X' = ind]).
proof(770, a(ind, n759), rule(2276), [uses(769, a(ind, n758))]).
substitution(771, ['X' = ind]).
proof(771, a(ind, n760), rule(2279), [uses(770, a(ind, n759))]).
substitution(772, ['X' = ind]).
proof(772, a(ind, n761), rule(2282), [uses(771, a(ind, n760))]).
substitution(773, ['X' = ind]).
proof(773, a(ind, n762), rule(2285), [uses(772, a(ind, n761))]).
substitution(774, ['X' = ind]).
proof(774, a(ind, n763), rule(2288), [uses(773, a(ind, n762))]).
substitution(775, ['X' = ind]).
proof(775, a(ind, n764), rule(2291), [uses(774, a(ind, n763))]).
substitution(776, ['X' = ind]).
proof(776, a(ind, n765), rule(2294), [uses(775, a(ind, n764))]).
substitution(777, ['X' = ind]).
proof(777, a(ind, n766), rule(2297), [uses(776, a(ind, n765))]).
substitution(778, ['X' = ind]).
proof(778, a(ind, n767), rule(2300), [uses(777, a(ind, n766))]).
substitution(779, ['X' = ind]).
proof(779, a(ind, n768), rule(2303), [uses(778, a(ind, n767))]).
substitution(780, ['X' = ind]).
proof(780, a(ind, n769), rule(2306), [uses(779, a(ind, n768))]).
substitution(781, ['X' = ind]).
proof(781, a(ind, n770), rule(2309), [uses(780, a(ind, n769))]).
substitution(782, ['X' = ind]).
proof(782, a(ind, n771), rule(2312), [uses(781, a(ind, n770))]).
substitution(783, ['X' = ind]).
proof(783, a(ind, n772), rule(2315), [uses(782, a(ind, n771))]).
substitution(784, ['X' = ind]).
proof(784, a(ind, n773), rule(2318), [uses(783, a(ind, n772))]).
substitution(785, ['X' = ind]).
proof(785, a(ind, n774), rule(2321), [uses(784, a(ind, n773))]).
substitution(786, ['X' = ind]).
proof(786, a(ind, n775), rule(2324), [uses(785, a(ind, n774))]).
substitution(787, ['X' = ind]).
proof(787, a(ind, n776), rule(2327), [uses(786, a(ind, n775))]).
substitution(788, ['X' = ind]).
proof(788, a(ind, n777), rule(2330), [uses(787, a(ind, n776))]).
substitution(789, ['X' = ind]).
proof(789, a(ind, n778), rule(2333), [uses(788, a(ind, n777))]).
substitution(790, ['X' = ind]).
proof(790, a(ind, n779), rule(2336), [uses(789, a(ind, n778))]).
substitution(791, ['X' = ind]).
proof(791, a(ind, n780), rule(2339), [uses(790, a(ind, n779))]).
substitution(792, ['X' = ind]).
proof(792, a(ind, n781), rule(2342), [uses(791, a(ind, n780))]).
substitution(793, ['X' = ind]).
proof(793, a(ind, n782), rule(2345), [uses(792, a(ind, n781))]).
substitution(794, ['X' = ind]).
proof(794, a(ind, n783), rule(2348), [uses(793, a(ind, n782))]).
substitution(795, ['X' = ind]).
proof(795, a(ind, n784), rule(2351), [uses(794, a(ind, n783))]).
substitution(796, ['X' = ind]).
proof(796, a(ind, n785), rule(2354), [uses(795, a(ind, n784))]).
substitution(797, ['X' = ind]).
proof(797, a(ind, n786), rule(2357), [uses(796, a(ind, n785))]).
substitution(798, ['X' = ind]).
proof(798, a(ind, n787), rule(2360), [uses(797, a(ind, n786))]).
substitution(799, ['X' = ind]).
proof(799, a(ind, n788), rule(2363), [uses(798, a(ind, n787))]).
substitution(800, ['X' = ind]).
proof(800, a(ind, n789), rule(2366), [uses(799, a(ind, n788))]).
substitution(801, ['X' = ind]).
proof(801, a(ind, n790), rule(2369), [uses(800, a(ind, n789))]).
substitution(802, ['X' = ind]).
proof(802, a(ind, n791), rule(2372), [uses(801, a(ind, n790))]).
substitution(803, ['X' = ind]).
proof(803, a(ind, n792), rule(2375), [uses(802, a(ind, n791))]).
substitution(804, ['X' = ind]).
proof(804, a(ind, n793), rule(2378), [uses(803, a(ind, n792))]).
substitution(805, ['X' = ind]).
proof(805, a(ind, n794), rule(2381), [uses(804, a(ind, n793))]).
substitution(806, ['X' = ind]).
proof(806, a(ind, n795), rule(2384), [uses(805, a(ind, n794))]).
substitution(807, ['X' = ind]).
proof(807, a(ind, n796), rule(2387), [uses(806, a(ind, n795))]).
substitution(808, ['X' = ind]).
proof(808, a(ind, n797), rule(2390), [uses(807, a(ind, n796))]).
substitution(809, ['X' = ind]).
proof(809, a(ind, n798), rule(2393), [uses(808, a(ind, n797))]).
substitution(810, ['X' = ind]).
proof(810, a(ind, n799), rule(2396), [uses(809, a(ind, n798))]).
substitution(811, ['X' = ind]).
proof(811, a(ind, n800), rule(2399), [uses(810, a(ind, n799))]).
substitution(812, ['X' = ind]).
proof(812, a(ind, n801), rule(2402), [uses(811, a(ind, n800))]).
substitution(813, ['X' = ind]).
proof(813, a(ind, n802), rule(2405), [uses(812, a(ind, n801))]).
substitution(814, ['X' = ind]).
proof(814, a(ind, n803), rule(2408), [uses(813, a(ind, n802))]).
substitution(815, ['X' = ind]).
proof(815, a(ind, n804), rule(2411), [uses(814, a(ind, n803))]).
substitution(816, ['X' = ind]).
proof(816, a(ind, n805), rule(2414), [uses(815, a(ind, n804))]).
substitution(817, ['X' = ind]).
proof(817, a(ind, n806), rule(2417), [uses(816, a(ind, n805))]).
substitution(818, ['X' = ind]).
proof(818, a(ind, n807), rule(2420), [uses(817, a(ind, n806))]).
substitution(819, ['X' = ind]).
proof(819, a(ind, n808), rule(2423), [uses(818, a(ind, n807))]).
substitution(820, ['X' = ind]).
proof(820, a(ind, n809), rule(2426), [uses(819, a(ind, n808))]).
substitution(821, ['X' = ind]).
proof(821, a(ind, n810), rule(2429), [uses(820, a(ind, n809))]).
substitution(822, ['X' = ind]).
proof(822, a(ind, n811), rule(2432), [uses(821, a(ind, n810))]).
substitution(823, ['X' = ind]).
proof(823, a(ind, n812), rule(2435), [uses(822, a(ind, n811))]).
substitution(824, ['X' = ind]).
proof(824, a(ind, n813), rule(2438), [uses(823, a(ind, n812))]).
substitution(825, ['X' = ind]).
proof(825, a(ind, n814), rule(2441), [uses(824, a(ind, n813))]).
substitution(826, ['X' = ind]).
proof(826, a(ind, n815), rule(2444), [uses(825, a(ind, n814))]).
substitution(827, ['X' = ind]).
proof(827, a(ind, n816), rule(2447), [uses(826, a(ind, n815))]).
substitution(828, ['X' = ind]).
proof(828, a(ind, n817), rule(2450), [uses(827, a(ind, n816))]).
substitution(829, ['X' = ind]).
proof(829, a(ind, n818), rule(2453), [uses(828, a(ind, n817))]).
substitution(830, ['X' = ind]).
proof(830, a(ind, n819), rule(2456), [uses(829, a(ind, n818))]).
substitution(831, ['X' = ind]).
proof(831, a(ind, n820), rule(2459), [uses(830, a(ind, n819))]).
substitution(832, ['X' = ind]).
proof(832, a(ind, n821), rule(2462), [uses(831, a(ind, n820))]).
substitution(833, ['X' = ind]).
proof(833, a(ind, n822), rule(2465), [uses(832, a(ind, n821))]).
substitution(834, ['X' = ind]).
proof(834, a(ind, n823), rule(2468), [uses(833, a(ind, n822))]).
substitution(835, ['X' = ind]).
proof(835, a(ind, n824), rule(2471), [uses(834, a(ind, n823))]).
substitution(836, ['X' = ind]).
proof(836, a(ind, n825), rule(2474), [uses(835, a(ind, n824))]).
substitution(837, ['X' = ind]).
proof(837, a(ind, n826), rule(2477), [uses(836, a(ind, n825))]).
substitution(838, ['X' = ind]).
proof(838, a(ind, n827), rule(2480), [uses(837, a(ind, n826))]).
substitution(839, ['X' = ind]).
proof(839, a(ind, n828), rule(2483), [uses(838, a(ind, n827))]).
substitution(840, ['X' = ind]).
proof(840, a(ind, n829), rule(2486), [uses(839, a(ind, n828))]).
substitution(841, ['X' = ind]).
proof(841, a(ind, n830), rule(2489), [uses(840, a(ind, n829))]).
substitution(842, ['X' = ind]).
proof(842, a(ind, n831), rule(2492), [uses(841, a(ind, n830))]).
substitution(843, ['X' = ind]).
proof(843, a(ind, n832), rule(2495), [uses(842, a(ind, n831))]).
substitution(844, ['X' = ind]).
proof(844, a(ind, n833), rule(2498), [uses(843, a(ind, n832))]).
substitution(845, ['X' = ind]).
proof(845, a(ind, n834), rule(2501), [uses(844, a(ind, n833))]).
substitution(846, ['X' = ind]).
proof(846, a(ind, n835), rule(2504), [uses(845, a(ind, n834))]).
substitution(847, ['X' = ind]).
proof(847, a(ind, n836), rule(2507), [uses(846, a(ind, n835))]).
substitution(848, ['X' = ind]).
proof(848, a(ind, n837), rule(2510), [uses(847, a(ind, n836))]).
substitution(849, ['X' = ind]).
proof(849, a(ind, n838), rule(2513), [uses(848, a(ind, n837))]).
substitution(850, ['X' = ind]).
proof(850, a(ind, n839), rule(2516), [uses(849, a(ind, n838))]).
substitution(851, ['X' = ind]).
proof(851, a(ind, n840), rule(2519), [uses(850, a(ind, n839))]).
substitution(852, ['X' = ind]).
proof(852, a(ind, n841), rule(2522), [uses(851, a(ind, n840))]).
substitution(853, ['X' = ind]).
proof(853, a(ind, n842), rule(2525), [uses(852, a(ind, n841))]).
substitution(854, ['X' = ind]).
proof(854, a(ind, n843), rule(2528), [uses(853, a(ind, n842))]).
substitution(855, ['X' = ind]).
proof(855, a(ind, n844), rule(2531), [uses(854, a(ind, n843))]).
substitution(856, ['X' = ind]).
proof(856, a(ind, n845), rule(2534), [uses(855, a(ind, n844))]).
substitution(857, ['X' = ind]).
proof(857, a(ind, n846), rule(2537), [uses(856, a(ind, n845))]).
substitution(858, ['X' = ind]).
proof(858, a(ind, n847), rule(2540), [uses(857, a(ind, n846))]).
substitution(859, ['X' = ind]).
proof(859, a(ind, n848), rule(2543), [uses(858, a(ind, n847))]).
substitution(860, ['X' = ind]).
proof(860, a(ind, n849), rule(2546), [uses(859, a(ind, n848))]).
substitution(861, ['X' = ind]).
proof(861, a(ind, n850), rule(2549), [uses(860, a(ind, n849))]).
substitution(862, ['X' = ind]).
proof(862, a(ind, n851), rule(2552), [uses(861, a(ind, n850))]).
substitution(863, ['X' = ind]).
proof(863, a(ind, n852), rule(2555), [uses(862, a(ind, n851))]).
substitution(864, ['X' = ind]).
proof(864, a(ind, n853), rule(2558), [uses(863, a(ind, n852))]).
substitution(865, ['X' = ind]).
proof(865, a(ind, n854), rule(2561), [uses(864, a(ind, n853))]).
substitution(866, ['X' = ind]).
proof(866, a(ind, n855), rule(2564), [uses(865, a(ind, n854))]).
substitution(867, ['X' = ind]).
proof(867, a(ind, n856), rule(2567), [uses(866, a(ind, n855))]).
substitution(868, ['X' = ind]).
proof(868, a(ind, n857), rule(2570), [uses(867, a(ind, n856))]).
substitution(869, ['X' = ind]).
proof(869, a(ind, n858), rule(2573), [uses(868, a(ind, n857))]).
substitution(870, ['X' = ind]).
proof(870, a(ind, n859), rule(2576), [uses(869, a(ind, n858))]).
substitution(871, ['X' = ind]).
proof(871, a(ind, n860), rule(2579), [uses(870, a(ind, n859))]).
substitution(872, ['X' = ind]).
proof(872, a(ind, n861), rule(2582), [uses(871, a(ind, n860))]).
substitution(873, ['X' = ind]).
proof(873, a(ind, n862), rule(2585), [uses(872, a(ind, n861))]).
substitution(874, ['X' = ind]).
proof(874, a(ind, n863), rule(2588), [uses(873, a(ind, n862))]).
substitution(875, ['X' = ind]).
proof(875, a(ind, n864), rule(2591), [uses(874, a(ind, n863))]).
substitution(876, ['X' = ind]).
proof(876, a(ind, n865), rule(2594), [uses(875, a(ind, n864))]).
substitution(877, ['X' = ind]).
proof(877, a(ind, n866), rule(2597), [uses(876, a(ind, n865))]).
substitution(878, ['X' = ind]).
proof(878, a(ind, n867), rule(2600), [uses(877, a(ind, n866))]).
substitution(879, ['X' = ind]).
proof(879, a(ind, n868), rule(2603), [uses(878, a(ind, n867))]).
substitution(880, ['X' = ind]).
proof(880, a(ind, n869), rule(2606), [uses(879, a(ind, n868))]).
substitution(881, ['X' = ind]).
proof(881, a(ind, n870), rule(2609), [uses(880, a(ind, n869))]).
substitution(882, ['X' = ind]).
proof(882, a(ind, n871), rule(2612), [uses(881, a(ind, n870))]).
substitution(883, ['X' = ind]).
proof(883, a(ind, n872), rule(2615), [uses(882, a(ind, n871))]).
substitution(884, ['X' = ind]).
proof(884, a(ind, n873), rule(2618), [uses(883, a(ind, n872))]).
substitution(885, ['X' = ind]).
proof(885, a(ind, n874), rule(2621), [uses(884, a(ind, n873))]).
substitution(886, ['X' = ind]).
proof(886, a(ind, n875), rule(2624), [uses(885, a(ind, n874))]).
substitution(887, ['X' = ind]).
proof(887, a(ind, n876), rule(2627), [uses(886, a(ind, n875))]).
substitution(888, ['X' = ind]).
proof(888, a(ind, n877), rule(2630), [uses(887, a(ind, n876))]).
substitution(889, ['X' = ind]).
proof(889, a(ind, n878), rule(2633), [uses(888, a(ind, n877))]).
substitution(890, ['X' = ind]).
proof(890, a(ind, n879), rule(2636), [uses(889, a(ind, n878))]).
substitution(891, ['X' = ind]).
proof(891, a(ind, n880), rule(2639), [uses(890, a(ind, n879))]).
substitution(892, ['X' = ind]).
proof(892, a(ind, n881), rule(2642), [uses(891, a(ind, n880))]).
substitution(893, ['X' = ind]).
proof(893, a(ind, n882), rule(2645), [uses(892, a(ind, n881))]).
substitution(894, ['X' = ind]).
proof(894, a(ind, n883), rule(2648), [uses(893, a(ind, n882))]).
substitution(895, ['X' = ind]).
proof(895, a(ind, n884), rule(2651), [uses(894, a(ind, n883))]).
substitution(896, ['X' = ind]).
proof(896, a(ind, n885), rule(2654), [uses(895, a(ind, n884))]).
substitution(897, ['X' = ind]).
proof(897, a(ind, n886), rule(2657), [uses(896, a(ind, n885))]).
substitution(898, ['X' = ind]).
proof(898, a(ind, n887), rule(2660), [uses(897, a(ind, n886))]).
substitution(899, ['X' = ind]).
proof(899, a(ind, n888), rule(2663), [uses(898, a(ind, n887))]).
substitution(900, ['X' = ind]).
proof(900, a(ind, n889), rule(2666), [uses(899, a(ind, n888))]).
substitution(901, ['X' = ind]).
proof(901, a(ind, n890), rule(2669), [uses(900, a(ind, n889))]).
substitution(902, ['X' = ind]).
proof(902, a(ind, n891), rule(2672), [uses(901, a(ind, n890))]).
substitution(903, ['X' = ind]).
proof(903, a(ind, n892), rule(2675), [uses(902, a(ind, n891))]).
substitution(904, ['X' = ind]).
proof(904, a(ind, n893), rule(2678), [uses(903, a(ind, n892))]).
substitution(905, ['X' = ind]).
proof(905, a(ind, n894), rule(2681), [uses(904, a(ind, n893))]).
substitution(906, ['X' = ind]).
proof(906, a(ind, n895), rule(2684), [uses(905, a(ind, n894))]).
substitution(907, ['X' = ind]).
proof(907, a(ind, n896), rule(2687), [uses(906, a(ind, n895))]).
substitution(908, ['X' = ind]).
proof(908, a(ind, n897), rule(2690), [uses(907, a(ind, n896))]).
substitution(909, ['X' = ind]).
proof(909, a(ind, n898), rule(2693), [uses(908, a(ind, n897))]).
substitution(910, ['X' = ind]).
proof(910, a(ind, n899), rule(2696), [uses(909, a(ind, n898))]).
substitution(911, ['X' = ind]).
proof(911, a(ind, n900), rule(2699), [uses(910, a(ind, n899))]).
substitution(912, ['X' = ind]).
proof(912, a(ind, n901), rule(2702), [uses(911, a(ind, n900))]).
substitution(913, ['X' = ind]).
proof(913, a(ind, n902), rule(2705), [uses(912, a(ind, n901))]).
substitution(914, ['X' = ind]).
proof(914, a(ind, n903), rule(2708), [uses(913, a(ind, n902))]).
substitution(915, ['X' = ind]).
proof(915, a(ind, n904), rule(2711), [uses(914, a(ind, n903))]).
substitution(916, ['X' = ind]).
proof(916, a(ind, n905), rule(2714), [uses(915, a(ind, n904))]).
substitution(917, ['X' = ind]).
proof(917, a(ind, n906), rule(2717), [uses(916, a(ind, n905))]).
substitution(918, ['X' = ind]).
proof(918, a(ind, n907), rule(2720), [uses(917, a(ind, n906))]).
substitution(919, ['X' = ind]).
proof(919, a(ind, n908), rule(2723), [uses(918, a(ind, n907))]).
substitution(920, ['X' = ind]).
proof(920, a(ind, n909), rule(2726), [uses(919, a(ind, n908))]).
substitution(921, ['X' = ind]).
proof(921, a(ind, n910), rule(2729), [uses(920, a(ind, n909))]).
substitution(922, ['X' = ind]).
proof(922, a(ind, n911), rule(2732), [uses(921, a(ind, n910))]).
substitution(923, ['X' = ind]).
proof(923, a(ind, n912), rule(2735), [uses(922, a(ind, n911))]).
substitution(924, ['X' = ind]).
proof(924, a(ind, n913), rule(2738), [uses(923, a(ind, n912))]).
substitution(925, ['X' = ind]).
proof(925, a(ind, n914), rule(2741), [uses(924, a(ind, n913))]).
substitution(926, ['X' = ind]).
proof(926, a(ind, n915), rule(2744), [uses(925, a(ind, n914))]).
substitution(927, ['X' = ind]).
proof(927, a(ind, n916), rule(2747), [uses(926, a(ind, n915))]).
substitution(928, ['X' = ind]).
proof(928, a(ind, n917), rule(2750), [uses(927, a(ind, n916))]).
substitution(929, ['X' = ind]).
proof(929, a(ind, n918), rule(2753), [uses(928, a(ind, n917))]).
substitution(930, ['X' = ind]).
proof(930, a(ind, n919), rule(2756), [uses(929, a(ind, n918))]).
substitution(931, ['X' = ind]).
proof(931, a(ind, n920), rule(2759), [uses(930, a(ind, n919))]).
substitution(932, ['X' = ind]).
proof(932, a(ind, n921), rule(2762), [uses(931, a(ind, n920))]).
substitution(933, ['X' = ind]).
proof(933, a(ind, n922), rule(2765), [uses(932, a(ind, n921))]).
substitution(934, ['X' = ind]).
proof(934, a(ind, n923), rule(2768), [uses(933, a(ind, n922))]).
substitution(935, ['X' = ind]).
proof(935, a(ind, n924), rule(2771), [uses(934, a(ind, n923))]).
substitution(936, ['X' = ind]).
proof(936, a(ind, n925), rule(2774), [uses(935, a(ind, n924))]).
substitution(937, ['X' = ind]).
proof(937, a(ind, n926), rule(2777), [uses(936, a(ind, n925))]).
substitution(938, ['X' = ind]).
proof(938, a(ind, n927), rule(2780), [uses(937, a(ind, n926))]).
substitution(939, ['X' = ind]).
proof(939, a(ind, n928), rule(2783), [uses(938, a(ind, n927))]).
substitution(940, ['X' = ind]).
proof(940, a(ind, n929), rule(2786), [uses(939, a(ind, n928))]).
substitution(941, ['X' = ind]).
proof(941, a(ind, n930), rule(2789), [uses(940, a(ind, n929))]).
substitution(942, ['X' = ind]).
proof(942, a(ind, n931), rule(2792), [uses(941, a(ind, n930))]).
substitution(943, ['X' = ind]).
proof(943, a(ind, n932), rule(2795), [uses(942, a(ind, n931))]).
substitution(944, ['X' = ind]).
proof(944, a(ind, n933), rule(2798), [uses(943, a(ind, n932))]).
substitution(945, ['X' = ind]).
proof(945, a(ind, n934), rule(2801), [uses(944, a(ind, n933))]).
substitution(946, ['X' = ind]).
proof(946, a(ind, n935), rule(2804), [uses(945, a(ind, n934))]).
substitution(947, ['X' = ind]).
proof(947, a(ind, n936), rule(2807), [uses(946, a(ind, n935))]).
substitution(948, ['X' = ind]).
proof(948, a(ind, n937), rule(2810), [uses(947, a(ind, n936))]).
substitution(949, ['X' = ind]).
proof(949, a(ind, n938), rule(2813), [uses(948, a(ind, n937))]).
substitution(950, ['X' = ind]).
proof(950, a(ind, n939), rule(2816), [uses(949, a(ind, n938))]).
substitution(951, ['X' = ind]).
proof(951, a(ind, n940), rule(2819), [uses(950, a(ind, n939))]).
substitution(952, ['X' = ind]).
proof(952, a(ind, n941), rule(2822), [uses(951, a(ind, n940))]).
substitution(953, ['X' = ind]).
proof(953, a(ind, n942), rule(2825), [uses(952, a(ind, n941))]).
substitution(954, ['X' = ind]).
proof(954, a(ind, n943), rule(2828), [uses(953, a(ind, n942))]).
substitution(955, ['X' = ind]).
proof(955, a(ind, n944), rule(2831), [uses(954, a(ind, n943))]).
substitution(956, ['X' = ind]).
proof(956, a(ind, n945), rule(2834), [uses(955, a(ind, n944))]).
substitution(957, ['X' = ind]).
proof(957, a(ind, n946), rule(2837), [uses(956, a(ind, n945))]).
substitution(958, ['X' = ind]).
proof(958, a(ind, n947), rule(2840), [uses(957, a(ind, n946))]).
substitution(959, ['X' = ind]).
proof(959, a(ind, n948), rule(2843), [uses(958, a(ind, n947))]).
substitution(960, ['X' = ind]).
proof(960, a(ind, n949), rule(2846), [uses(959, a(ind, n948))]).
substitution(961, ['X' = ind]).
proof(961, a(ind, n950), rule(2849), [uses(960, a(ind, n949))]).
substitution(962, ['X' = ind]).
proof(962, a(ind, n951), rule(2852), [uses(961, a(ind, n950))]).
substitution(963, ['X' = ind]).
proof(963, a(ind, n952), rule(2855), [uses(962, a(ind, n951))]).
substitution(964, ['X' = ind]).
proof(964, a(ind, n953), rule(2858), [uses(963, a(ind, n952))]).
substitution(965, ['X' = ind]).
proof(965, a(ind, n954), rule(2861), [uses(964, a(ind, n953))]).
substitution(966, ['X' = ind]).
proof(966, a(ind, n955), rule(2864), [uses(965, a(ind, n954))]).
substitution(967, ['X' = ind]).
proof(967, a(ind, n956), rule(2867), [uses(966, a(ind, n955))]).
substitution(968, ['X' = ind]).
proof(968, a(ind, n957), rule(2870), [uses(967, a(ind, n956))]).
substitution(969, ['X' = ind]).
proof(969, a(ind, n958), rule(2873), [uses(968, a(ind, n957))]).
substitution(970, ['X' = ind]).
proof(970, a(ind, n959), rule(2876), [uses(969, a(ind, n958))]).
substitution(971, ['X' = ind]).
proof(971, a(ind, n960), rule(2879), [uses(970, a(ind, n959))]).
substitution(972, ['X' = ind]).
proof(972, a(ind, n961), rule(2882), [uses(971, a(ind, n960))]).
substitution(973, ['X' = ind]).
proof(973, a(ind, n962), rule(2885), [uses(972, a(ind, n961))]).
substitution(974, ['X' = ind]).
proof(974, a(ind, n963), rule(2888), [uses(973, a(ind, n962))]).
substitution(975, ['X' = ind]).
proof(975, a(ind, n964), rule(2891), [uses(974, a(ind, n963))]).
substitution(976, ['X' = ind]).
proof(976, a(ind, n965), rule(2894), [uses(975, a(ind, n964))]).
substitution(977, ['X' = ind]).
proof(977, a(ind, n966), rule(2897), [uses(976, a(ind, n965))]).
substitution(978, ['X' = ind]).
proof(978, a(ind, n967), rule(2900), [uses(977, a(ind, n966))]).
substitution(979, ['X' = ind]).
proof(979, a(ind, n968), rule(2903), [uses(978, a(ind, n967))]).
substitution(980, ['X' = ind]).
proof(980, a(ind, n969), rule(2906), [uses(979, a(ind, n968))]).
substitution(981, ['X' = ind]).
proof(981, a(ind, n970), rule(2909), [uses(980, a(ind, n969))]).
substitution(982, ['X' = ind]).
proof(982, a(ind, n971), rule(2912), [uses(981, a(ind, n970))]).
substitution(983, ['X' = ind]).
proof(983, a(ind, n972), rule(2915), [uses(982, a(ind, n971))]).
substitution(984, ['X' = ind]).
proof(984, a(ind, n973), rule(2918), [uses(983, a(ind, n972))]).
substitution(985, ['X' = ind]).
proof(985, a(ind, n974), rule(2921), [uses(984, a(ind, n973))]).
substitution(986, ['X' = ind]).
proof(986, a(ind, n975), rule(2924), [uses(985, a(ind, n974))]).
substitution(987, ['X' = ind]).
proof(987, a(ind, n976), rule(2927), [uses(986, a(ind, n975))]).
substitution(988, ['X' = ind]).
proof(988, a(ind, n977), rule(2930), [uses(987, a(ind, n976))]).
substitution(989, ['X' = ind]).
proof(989, a(ind, n978), rule(2933), [uses(988, a(ind, n977))]).
substitution(990, ['X' = ind]).
proof(990, a(ind, n979), rule(2936), [uses(989, a(ind, n978))]).
substitution(991, ['X' = ind]).
proof(991, a(ind, n980), rule(2939), [uses(990, a(ind, n979))]).
substitution(992, ['X' = ind]).
proof(992, a(ind, n981), rule(2942), [uses(991, a(ind, n980))]).
substitution(993, ['X' = ind]).
proof(993, a(ind, n982), rule(2945), [uses(992, a(ind, n981))]).
substitution(994, ['X' = ind]).
proof(994, a(ind, n983), rule(2948), [uses(993, a(ind, n982))]).
substitution(995, ['X' = ind]).
proof(995, a(ind, n984), rule(2951), [uses(994, a(ind, n983))]).
substitution(996, ['X' = ind]).
proof(996, a(ind, n985), rule(2954), [uses(995, a(ind, n984))]).
substitution(997, ['X' = ind]).
proof(997, a(ind, n986), rule(2957), [uses(996, a(ind, n985))]).
substitution(998, ['X' = ind]).
proof(998, a(ind, n987), rule(2960), [uses(997, a(ind, n986))]).
substitution(999, ['X' = ind]).
proof(999, a(ind, n988), rule(2963), [uses(998, a(ind, n987))]).
substitution(1000, ['X' = ind]).
proof(1000, a(ind, n989), rule(2966), [uses(999, a(ind, n988))]).
substitution(1001, ['X' = ind]).
proof(1001, a(ind, n990), rule(2969), [uses(1000, a(ind, n989))]).
substitution(1002, ['X' = ind]).
proof(1002, a(ind, n991), rule(2972), [uses(1001, a(ind, n990))]).
substitution(1003, ['X' = ind]).
proof(1003, a(ind, n992), rule(2975), [uses(1002, a(ind, n991))]).
substitution(1004, ['X' = ind]).
proof(1004, a(ind, n993), rule(2978), [uses(1003, a(ind, n992))]).
substitution(1005, ['X' = ind]).
proof(1005, a(ind, n994), rule(2981), [uses(1004, a(ind, n993))]).
substitution(1006, ['X' = ind]).
proof(1006, a(ind, n995), rule(2984), [uses(1005, a(ind, n994))]).
substitution(1007, ['X' = ind]).
proof(1007, a(ind, n996), rule(2987), [uses(1006, a(ind, n995))]).
substitution(1008, ['X' = ind]).
proof(1008, a(ind, n997), rule(2990), [uses(1007, a(ind, n996))]).
substitution(1009, ['X' = ind]).
proof(1009, a(ind, n998), rule(2993), [uses(1008, a(ind, n997))]).
substitution(1010, ['X' = ind]).
proof(1010, a(ind, n999), rule(2996), [uses(1009, a(ind, n998))]).
substitution(1011, ['X' = ind]).
proof(1011, a(ind, n1000), rule(2999), [uses(1010, a(ind, n999))]).
substitution(1012, []).
proof(1012, arc(check4, "C4 OK - the final taxonomy step from n999 to n1000 was completed."), rule(3007), [uses(1010, a(ind, n999)), uses(1011, a(ind, n1000))]).
substitution(1013, ['X' = ind]).
proof(1013, a(ind, a2), rule(3002), [uses(1011, a(ind, n1000))]).
substitution(1014, ['Check' = check4, 'Message' = "C4 OK - the final taxonomy step from n999 to n1000 was completed."]).
proof(1014, solution([check4, "C4 OK - the final taxonomy step from n999 to n1000 was completed."]), query, [uses(1012, arc(check4, "C4 OK - the final taxonomy step from n999 to n1000 was completed."))]).
substitution(1015, []).
proof(1015, arc(check5, "C5 OK - once n1000 is reached, the terminal class a2 is derived."), rule(3008), [uses(1011, a(ind, n1000)), uses(1013, a(ind, a2))]).
substitution(1016, ['Check' = check5, 'Message' = "C5 OK - once n1000 is reached, the terminal class a2 is derived."]).
proof(1016, solution([check5, "C5 OK - once n1000 is reached, the terminal class a2 is derived."]), query, [uses(1015, arc(check5, "C5 OK - once n1000 is reached, the terminal class a2 is derived."))]).
substitution(1017, []).
proof(1017, holds_result(test, true), rule(3003), [uses(1013, a(ind, a2))]).
substitution(1018, []).
proof(1018, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."), rule(3009), [uses(1013, a(ind, a2)), uses(1017, holds_result(test, true))]).
substitution(1019, ['Check' = check6, 'Message' = "C6 OK - the success flag is raised only after the terminal class a2 is present."]).
proof(1019, solution([check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."]), query, [uses(1018, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."))]).
substitution(1020, []).
proof(1020, a(ind, n0), rule(1), []).
substitution(1021, ['X' = ind]).
proof(1021, a(ind, n1), rule(2), [uses(1020, a(ind, n0))]).
substitution(1022, ['X' = ind]).
proof(1022, a(ind, n2), rule(5), [uses(1021, a(ind, n1))]).
substitution(1023, ['X' = ind]).
proof(1023, a(ind, n3), rule(8), [uses(1022, a(ind, n2))]).
substitution(1024, ['X' = ind]).
proof(1024, a(ind, n4), rule(11), [uses(1023, a(ind, n3))]).
substitution(1025, ['X' = ind]).
proof(1025, a(ind, n5), rule(14), [uses(1024, a(ind, n4))]).
substitution(1026, ['X' = ind]).
proof(1026, a(ind, n6), rule(17), [uses(1025, a(ind, n5))]).
substitution(1027, ['X' = ind]).
proof(1027, a(ind, n7), rule(20), [uses(1026, a(ind, n6))]).
substitution(1028, ['X' = ind]).
proof(1028, a(ind, n8), rule(23), [uses(1027, a(ind, n7))]).
substitution(1029, ['X' = ind]).
proof(1029, a(ind, n9), rule(26), [uses(1028, a(ind, n8))]).
substitution(1030, ['X' = ind]).
proof(1030, a(ind, n10), rule(29), [uses(1029, a(ind, n9))]).
substitution(1031, ['X' = ind]).
proof(1031, a(ind, n11), rule(32), [uses(1030, a(ind, n10))]).
substitution(1032, ['X' = ind]).
proof(1032, a(ind, n12), rule(35), [uses(1031, a(ind, n11))]).
substitution(1033, ['X' = ind]).
proof(1033, a(ind, n13), rule(38), [uses(1032, a(ind, n12))]).
substitution(1034, ['X' = ind]).
proof(1034, a(ind, n14), rule(41), [uses(1033, a(ind, n13))]).
substitution(1035, ['X' = ind]).
proof(1035, a(ind, n15), rule(44), [uses(1034, a(ind, n14))]).
substitution(1036, ['X' = ind]).
proof(1036, a(ind, n16), rule(47), [uses(1035, a(ind, n15))]).
substitution(1037, ['X' = ind]).
proof(1037, a(ind, n17), rule(50), [uses(1036, a(ind, n16))]).
substitution(1038, ['X' = ind]).
proof(1038, a(ind, n18), rule(53), [uses(1037, a(ind, n17))]).
substitution(1039, ['X' = ind]).
proof(1039, a(ind, n19), rule(56), [uses(1038, a(ind, n18))]).
substitution(1040, ['X' = ind]).
proof(1040, a(ind, n20), rule(59), [uses(1039, a(ind, n19))]).
substitution(1041, ['X' = ind]).
proof(1041, a(ind, n21), rule(62), [uses(1040, a(ind, n20))]).
substitution(1042, ['X' = ind]).
proof(1042, a(ind, n22), rule(65), [uses(1041, a(ind, n21))]).
substitution(1043, ['X' = ind]).
proof(1043, a(ind, n23), rule(68), [uses(1042, a(ind, n22))]).
substitution(1044, ['X' = ind]).
proof(1044, a(ind, n24), rule(71), [uses(1043, a(ind, n23))]).
substitution(1045, ['X' = ind]).
proof(1045, a(ind, n25), rule(74), [uses(1044, a(ind, n24))]).
substitution(1046, ['X' = ind]).
proof(1046, a(ind, n26), rule(77), [uses(1045, a(ind, n25))]).
substitution(1047, ['X' = ind]).
proof(1047, a(ind, n27), rule(80), [uses(1046, a(ind, n26))]).
substitution(1048, ['X' = ind]).
proof(1048, a(ind, n28), rule(83), [uses(1047, a(ind, n27))]).
substitution(1049, ['X' = ind]).
proof(1049, a(ind, n29), rule(86), [uses(1048, a(ind, n28))]).
substitution(1050, ['X' = ind]).
proof(1050, a(ind, n30), rule(89), [uses(1049, a(ind, n29))]).
substitution(1051, ['X' = ind]).
proof(1051, a(ind, n31), rule(92), [uses(1050, a(ind, n30))]).
substitution(1052, ['X' = ind]).
proof(1052, a(ind, n32), rule(95), [uses(1051, a(ind, n31))]).
substitution(1053, ['X' = ind]).
proof(1053, a(ind, n33), rule(98), [uses(1052, a(ind, n32))]).
substitution(1054, ['X' = ind]).
proof(1054, a(ind, n34), rule(101), [uses(1053, a(ind, n33))]).
substitution(1055, ['X' = ind]).
proof(1055, a(ind, n35), rule(104), [uses(1054, a(ind, n34))]).
substitution(1056, ['X' = ind]).
proof(1056, a(ind, n36), rule(107), [uses(1055, a(ind, n35))]).
substitution(1057, ['X' = ind]).
proof(1057, a(ind, n37), rule(110), [uses(1056, a(ind, n36))]).
substitution(1058, ['X' = ind]).
proof(1058, a(ind, n38), rule(113), [uses(1057, a(ind, n37))]).
substitution(1059, ['X' = ind]).
proof(1059, a(ind, n39), rule(116), [uses(1058, a(ind, n38))]).
substitution(1060, ['X' = ind]).
proof(1060, a(ind, n40), rule(119), [uses(1059, a(ind, n39))]).
substitution(1061, ['X' = ind]).
proof(1061, a(ind, n41), rule(122), [uses(1060, a(ind, n40))]).
substitution(1062, ['X' = ind]).
proof(1062, a(ind, n42), rule(125), [uses(1061, a(ind, n41))]).
substitution(1063, ['X' = ind]).
proof(1063, a(ind, n43), rule(128), [uses(1062, a(ind, n42))]).
substitution(1064, ['X' = ind]).
proof(1064, a(ind, n44), rule(131), [uses(1063, a(ind, n43))]).
substitution(1065, ['X' = ind]).
proof(1065, a(ind, n45), rule(134), [uses(1064, a(ind, n44))]).
substitution(1066, ['X' = ind]).
proof(1066, a(ind, n46), rule(137), [uses(1065, a(ind, n45))]).
substitution(1067, ['X' = ind]).
proof(1067, a(ind, n47), rule(140), [uses(1066, a(ind, n46))]).
substitution(1068, ['X' = ind]).
proof(1068, a(ind, n48), rule(143), [uses(1067, a(ind, n47))]).
substitution(1069, ['X' = ind]).
proof(1069, a(ind, n49), rule(146), [uses(1068, a(ind, n48))]).
substitution(1070, ['X' = ind]).
proof(1070, a(ind, n50), rule(149), [uses(1069, a(ind, n49))]).
substitution(1071, ['X' = ind]).
proof(1071, a(ind, n51), rule(152), [uses(1070, a(ind, n50))]).
substitution(1072, ['X' = ind]).
proof(1072, a(ind, n52), rule(155), [uses(1071, a(ind, n51))]).
substitution(1073, ['X' = ind]).
proof(1073, a(ind, n53), rule(158), [uses(1072, a(ind, n52))]).
substitution(1074, ['X' = ind]).
proof(1074, a(ind, n54), rule(161), [uses(1073, a(ind, n53))]).
substitution(1075, ['X' = ind]).
proof(1075, a(ind, n55), rule(164), [uses(1074, a(ind, n54))]).
substitution(1076, ['X' = ind]).
proof(1076, a(ind, n56), rule(167), [uses(1075, a(ind, n55))]).
substitution(1077, ['X' = ind]).
proof(1077, a(ind, n57), rule(170), [uses(1076, a(ind, n56))]).
substitution(1078, ['X' = ind]).
proof(1078, a(ind, n58), rule(173), [uses(1077, a(ind, n57))]).
substitution(1079, ['X' = ind]).
proof(1079, a(ind, n59), rule(176), [uses(1078, a(ind, n58))]).
substitution(1080, ['X' = ind]).
proof(1080, a(ind, n60), rule(179), [uses(1079, a(ind, n59))]).
substitution(1081, ['X' = ind]).
proof(1081, a(ind, n61), rule(182), [uses(1080, a(ind, n60))]).
substitution(1082, ['X' = ind]).
proof(1082, a(ind, n62), rule(185), [uses(1081, a(ind, n61))]).
substitution(1083, ['X' = ind]).
proof(1083, a(ind, n63), rule(188), [uses(1082, a(ind, n62))]).
substitution(1084, ['X' = ind]).
proof(1084, a(ind, n64), rule(191), [uses(1083, a(ind, n63))]).
substitution(1085, ['X' = ind]).
proof(1085, a(ind, n65), rule(194), [uses(1084, a(ind, n64))]).
substitution(1086, ['X' = ind]).
proof(1086, a(ind, n66), rule(197), [uses(1085, a(ind, n65))]).
substitution(1087, ['X' = ind]).
proof(1087, a(ind, n67), rule(200), [uses(1086, a(ind, n66))]).
substitution(1088, ['X' = ind]).
proof(1088, a(ind, n68), rule(203), [uses(1087, a(ind, n67))]).
substitution(1089, ['X' = ind]).
proof(1089, a(ind, n69), rule(206), [uses(1088, a(ind, n68))]).
substitution(1090, ['X' = ind]).
proof(1090, a(ind, n70), rule(209), [uses(1089, a(ind, n69))]).
substitution(1091, ['X' = ind]).
proof(1091, a(ind, n71), rule(212), [uses(1090, a(ind, n70))]).
substitution(1092, ['X' = ind]).
proof(1092, a(ind, n72), rule(215), [uses(1091, a(ind, n71))]).
substitution(1093, ['X' = ind]).
proof(1093, a(ind, n73), rule(218), [uses(1092, a(ind, n72))]).
substitution(1094, ['X' = ind]).
proof(1094, a(ind, n74), rule(221), [uses(1093, a(ind, n73))]).
substitution(1095, ['X' = ind]).
proof(1095, a(ind, n75), rule(224), [uses(1094, a(ind, n74))]).
substitution(1096, ['X' = ind]).
proof(1096, a(ind, n76), rule(227), [uses(1095, a(ind, n75))]).
substitution(1097, ['X' = ind]).
proof(1097, a(ind, n77), rule(230), [uses(1096, a(ind, n76))]).
substitution(1098, ['X' = ind]).
proof(1098, a(ind, n78), rule(233), [uses(1097, a(ind, n77))]).
substitution(1099, ['X' = ind]).
proof(1099, a(ind, n79), rule(236), [uses(1098, a(ind, n78))]).
substitution(1100, ['X' = ind]).
proof(1100, a(ind, n80), rule(239), [uses(1099, a(ind, n79))]).
substitution(1101, ['X' = ind]).
proof(1101, a(ind, n81), rule(242), [uses(1100, a(ind, n80))]).
substitution(1102, ['X' = ind]).
proof(1102, a(ind, n82), rule(245), [uses(1101, a(ind, n81))]).
substitution(1103, ['X' = ind]).
proof(1103, a(ind, n83), rule(248), [uses(1102, a(ind, n82))]).
substitution(1104, ['X' = ind]).
proof(1104, a(ind, n84), rule(251), [uses(1103, a(ind, n83))]).
substitution(1105, ['X' = ind]).
proof(1105, a(ind, n85), rule(254), [uses(1104, a(ind, n84))]).
substitution(1106, ['X' = ind]).
proof(1106, a(ind, n86), rule(257), [uses(1105, a(ind, n85))]).
substitution(1107, ['X' = ind]).
proof(1107, a(ind, n87), rule(260), [uses(1106, a(ind, n86))]).
substitution(1108, ['X' = ind]).
proof(1108, a(ind, n88), rule(263), [uses(1107, a(ind, n87))]).
substitution(1109, ['X' = ind]).
proof(1109, a(ind, n89), rule(266), [uses(1108, a(ind, n88))]).
substitution(1110, ['X' = ind]).
proof(1110, a(ind, n90), rule(269), [uses(1109, a(ind, n89))]).
substitution(1111, ['X' = ind]).
proof(1111, a(ind, n91), rule(272), [uses(1110, a(ind, n90))]).
substitution(1112, ['X' = ind]).
proof(1112, a(ind, n92), rule(275), [uses(1111, a(ind, n91))]).
substitution(1113, ['X' = ind]).
proof(1113, a(ind, n93), rule(278), [uses(1112, a(ind, n92))]).
substitution(1114, ['X' = ind]).
proof(1114, a(ind, n94), rule(281), [uses(1113, a(ind, n93))]).
substitution(1115, ['X' = ind]).
proof(1115, a(ind, n95), rule(284), [uses(1114, a(ind, n94))]).
substitution(1116, ['X' = ind]).
proof(1116, a(ind, n96), rule(287), [uses(1115, a(ind, n95))]).
substitution(1117, ['X' = ind]).
proof(1117, a(ind, n97), rule(290), [uses(1116, a(ind, n96))]).
substitution(1118, ['X' = ind]).
proof(1118, a(ind, n98), rule(293), [uses(1117, a(ind, n97))]).
substitution(1119, ['X' = ind]).
proof(1119, a(ind, n99), rule(296), [uses(1118, a(ind, n98))]).
substitution(1120, ['X' = ind]).
proof(1120, a(ind, n100), rule(299), [uses(1119, a(ind, n99))]).
substitution(1121, ['X' = ind]).
proof(1121, a(ind, n101), rule(302), [uses(1120, a(ind, n100))]).
substitution(1122, ['X' = ind]).
proof(1122, a(ind, n102), rule(305), [uses(1121, a(ind, n101))]).
substitution(1123, ['X' = ind]).
proof(1123, a(ind, n103), rule(308), [uses(1122, a(ind, n102))]).
substitution(1124, ['X' = ind]).
proof(1124, a(ind, n104), rule(311), [uses(1123, a(ind, n103))]).
substitution(1125, ['X' = ind]).
proof(1125, a(ind, n105), rule(314), [uses(1124, a(ind, n104))]).
substitution(1126, ['X' = ind]).
proof(1126, a(ind, n106), rule(317), [uses(1125, a(ind, n105))]).
substitution(1127, ['X' = ind]).
proof(1127, a(ind, n107), rule(320), [uses(1126, a(ind, n106))]).
substitution(1128, ['X' = ind]).
proof(1128, a(ind, n108), rule(323), [uses(1127, a(ind, n107))]).
substitution(1129, ['X' = ind]).
proof(1129, a(ind, n109), rule(326), [uses(1128, a(ind, n108))]).
substitution(1130, ['X' = ind]).
proof(1130, a(ind, n110), rule(329), [uses(1129, a(ind, n109))]).
substitution(1131, ['X' = ind]).
proof(1131, a(ind, n111), rule(332), [uses(1130, a(ind, n110))]).
substitution(1132, ['X' = ind]).
proof(1132, a(ind, n112), rule(335), [uses(1131, a(ind, n111))]).
substitution(1133, ['X' = ind]).
proof(1133, a(ind, n113), rule(338), [uses(1132, a(ind, n112))]).
substitution(1134, ['X' = ind]).
proof(1134, a(ind, n114), rule(341), [uses(1133, a(ind, n113))]).
substitution(1135, ['X' = ind]).
proof(1135, a(ind, n115), rule(344), [uses(1134, a(ind, n114))]).
substitution(1136, ['X' = ind]).
proof(1136, a(ind, n116), rule(347), [uses(1135, a(ind, n115))]).
substitution(1137, ['X' = ind]).
proof(1137, a(ind, n117), rule(350), [uses(1136, a(ind, n116))]).
substitution(1138, ['X' = ind]).
proof(1138, a(ind, n118), rule(353), [uses(1137, a(ind, n117))]).
substitution(1139, ['X' = ind]).
proof(1139, a(ind, n119), rule(356), [uses(1138, a(ind, n118))]).
substitution(1140, ['X' = ind]).
proof(1140, a(ind, n120), rule(359), [uses(1139, a(ind, n119))]).
substitution(1141, ['X' = ind]).
proof(1141, a(ind, n121), rule(362), [uses(1140, a(ind, n120))]).
substitution(1142, ['X' = ind]).
proof(1142, a(ind, n122), rule(365), [uses(1141, a(ind, n121))]).
substitution(1143, ['X' = ind]).
proof(1143, a(ind, n123), rule(368), [uses(1142, a(ind, n122))]).
substitution(1144, ['X' = ind]).
proof(1144, a(ind, n124), rule(371), [uses(1143, a(ind, n123))]).
substitution(1145, ['X' = ind]).
proof(1145, a(ind, n125), rule(374), [uses(1144, a(ind, n124))]).
substitution(1146, ['X' = ind]).
proof(1146, a(ind, n126), rule(377), [uses(1145, a(ind, n125))]).
substitution(1147, ['X' = ind]).
proof(1147, a(ind, n127), rule(380), [uses(1146, a(ind, n126))]).
substitution(1148, ['X' = ind]).
proof(1148, a(ind, n128), rule(383), [uses(1147, a(ind, n127))]).
substitution(1149, ['X' = ind]).
proof(1149, a(ind, n129), rule(386), [uses(1148, a(ind, n128))]).
substitution(1150, ['X' = ind]).
proof(1150, a(ind, n130), rule(389), [uses(1149, a(ind, n129))]).
substitution(1151, ['X' = ind]).
proof(1151, a(ind, n131), rule(392), [uses(1150, a(ind, n130))]).
substitution(1152, ['X' = ind]).
proof(1152, a(ind, n132), rule(395), [uses(1151, a(ind, n131))]).
substitution(1153, ['X' = ind]).
proof(1153, a(ind, n133), rule(398), [uses(1152, a(ind, n132))]).
substitution(1154, ['X' = ind]).
proof(1154, a(ind, n134), rule(401), [uses(1153, a(ind, n133))]).
substitution(1155, ['X' = ind]).
proof(1155, a(ind, n135), rule(404), [uses(1154, a(ind, n134))]).
substitution(1156, ['X' = ind]).
proof(1156, a(ind, n136), rule(407), [uses(1155, a(ind, n135))]).
substitution(1157, ['X' = ind]).
proof(1157, a(ind, n137), rule(410), [uses(1156, a(ind, n136))]).
substitution(1158, ['X' = ind]).
proof(1158, a(ind, n138), rule(413), [uses(1157, a(ind, n137))]).
substitution(1159, ['X' = ind]).
proof(1159, a(ind, n139), rule(416), [uses(1158, a(ind, n138))]).
substitution(1160, ['X' = ind]).
proof(1160, a(ind, n140), rule(419), [uses(1159, a(ind, n139))]).
substitution(1161, ['X' = ind]).
proof(1161, a(ind, n141), rule(422), [uses(1160, a(ind, n140))]).
substitution(1162, ['X' = ind]).
proof(1162, a(ind, n142), rule(425), [uses(1161, a(ind, n141))]).
substitution(1163, ['X' = ind]).
proof(1163, a(ind, n143), rule(428), [uses(1162, a(ind, n142))]).
substitution(1164, ['X' = ind]).
proof(1164, a(ind, n144), rule(431), [uses(1163, a(ind, n143))]).
substitution(1165, ['X' = ind]).
proof(1165, a(ind, n145), rule(434), [uses(1164, a(ind, n144))]).
substitution(1166, ['X' = ind]).
proof(1166, a(ind, n146), rule(437), [uses(1165, a(ind, n145))]).
substitution(1167, ['X' = ind]).
proof(1167, a(ind, n147), rule(440), [uses(1166, a(ind, n146))]).
substitution(1168, ['X' = ind]).
proof(1168, a(ind, n148), rule(443), [uses(1167, a(ind, n147))]).
substitution(1169, ['X' = ind]).
proof(1169, a(ind, n149), rule(446), [uses(1168, a(ind, n148))]).
substitution(1170, ['X' = ind]).
proof(1170, a(ind, n150), rule(449), [uses(1169, a(ind, n149))]).
substitution(1171, ['X' = ind]).
proof(1171, a(ind, n151), rule(452), [uses(1170, a(ind, n150))]).
substitution(1172, ['X' = ind]).
proof(1172, a(ind, n152), rule(455), [uses(1171, a(ind, n151))]).
substitution(1173, ['X' = ind]).
proof(1173, a(ind, n153), rule(458), [uses(1172, a(ind, n152))]).
substitution(1174, ['X' = ind]).
proof(1174, a(ind, n154), rule(461), [uses(1173, a(ind, n153))]).
substitution(1175, ['X' = ind]).
proof(1175, a(ind, n155), rule(464), [uses(1174, a(ind, n154))]).
substitution(1176, ['X' = ind]).
proof(1176, a(ind, n156), rule(467), [uses(1175, a(ind, n155))]).
substitution(1177, ['X' = ind]).
proof(1177, a(ind, n157), rule(470), [uses(1176, a(ind, n156))]).
substitution(1178, ['X' = ind]).
proof(1178, a(ind, n158), rule(473), [uses(1177, a(ind, n157))]).
substitution(1179, ['X' = ind]).
proof(1179, a(ind, n159), rule(476), [uses(1178, a(ind, n158))]).
substitution(1180, ['X' = ind]).
proof(1180, a(ind, n160), rule(479), [uses(1179, a(ind, n159))]).
substitution(1181, ['X' = ind]).
proof(1181, a(ind, n161), rule(482), [uses(1180, a(ind, n160))]).
substitution(1182, ['X' = ind]).
proof(1182, a(ind, n162), rule(485), [uses(1181, a(ind, n161))]).
substitution(1183, ['X' = ind]).
proof(1183, a(ind, n163), rule(488), [uses(1182, a(ind, n162))]).
substitution(1184, ['X' = ind]).
proof(1184, a(ind, n164), rule(491), [uses(1183, a(ind, n163))]).
substitution(1185, ['X' = ind]).
proof(1185, a(ind, n165), rule(494), [uses(1184, a(ind, n164))]).
substitution(1186, ['X' = ind]).
proof(1186, a(ind, n166), rule(497), [uses(1185, a(ind, n165))]).
substitution(1187, ['X' = ind]).
proof(1187, a(ind, n167), rule(500), [uses(1186, a(ind, n166))]).
substitution(1188, ['X' = ind]).
proof(1188, a(ind, n168), rule(503), [uses(1187, a(ind, n167))]).
substitution(1189, ['X' = ind]).
proof(1189, a(ind, n169), rule(506), [uses(1188, a(ind, n168))]).
substitution(1190, ['X' = ind]).
proof(1190, a(ind, n170), rule(509), [uses(1189, a(ind, n169))]).
substitution(1191, ['X' = ind]).
proof(1191, a(ind, n171), rule(512), [uses(1190, a(ind, n170))]).
substitution(1192, ['X' = ind]).
proof(1192, a(ind, n172), rule(515), [uses(1191, a(ind, n171))]).
substitution(1193, ['X' = ind]).
proof(1193, a(ind, n173), rule(518), [uses(1192, a(ind, n172))]).
substitution(1194, ['X' = ind]).
proof(1194, a(ind, n174), rule(521), [uses(1193, a(ind, n173))]).
substitution(1195, ['X' = ind]).
proof(1195, a(ind, n175), rule(524), [uses(1194, a(ind, n174))]).
substitution(1196, ['X' = ind]).
proof(1196, a(ind, n176), rule(527), [uses(1195, a(ind, n175))]).
substitution(1197, ['X' = ind]).
proof(1197, a(ind, n177), rule(530), [uses(1196, a(ind, n176))]).
substitution(1198, ['X' = ind]).
proof(1198, a(ind, n178), rule(533), [uses(1197, a(ind, n177))]).
substitution(1199, ['X' = ind]).
proof(1199, a(ind, n179), rule(536), [uses(1198, a(ind, n178))]).
substitution(1200, ['X' = ind]).
proof(1200, a(ind, n180), rule(539), [uses(1199, a(ind, n179))]).
substitution(1201, ['X' = ind]).
proof(1201, a(ind, n181), rule(542), [uses(1200, a(ind, n180))]).
substitution(1202, ['X' = ind]).
proof(1202, a(ind, n182), rule(545), [uses(1201, a(ind, n181))]).
substitution(1203, ['X' = ind]).
proof(1203, a(ind, n183), rule(548), [uses(1202, a(ind, n182))]).
substitution(1204, ['X' = ind]).
proof(1204, a(ind, n184), rule(551), [uses(1203, a(ind, n183))]).
substitution(1205, ['X' = ind]).
proof(1205, a(ind, n185), rule(554), [uses(1204, a(ind, n184))]).
substitution(1206, ['X' = ind]).
proof(1206, a(ind, n186), rule(557), [uses(1205, a(ind, n185))]).
substitution(1207, ['X' = ind]).
proof(1207, a(ind, n187), rule(560), [uses(1206, a(ind, n186))]).
substitution(1208, ['X' = ind]).
proof(1208, a(ind, n188), rule(563), [uses(1207, a(ind, n187))]).
substitution(1209, ['X' = ind]).
proof(1209, a(ind, n189), rule(566), [uses(1208, a(ind, n188))]).
substitution(1210, ['X' = ind]).
proof(1210, a(ind, n190), rule(569), [uses(1209, a(ind, n189))]).
substitution(1211, ['X' = ind]).
proof(1211, a(ind, n191), rule(572), [uses(1210, a(ind, n190))]).
substitution(1212, ['X' = ind]).
proof(1212, a(ind, n192), rule(575), [uses(1211, a(ind, n191))]).
substitution(1213, ['X' = ind]).
proof(1213, a(ind, n193), rule(578), [uses(1212, a(ind, n192))]).
substitution(1214, ['X' = ind]).
proof(1214, a(ind, n194), rule(581), [uses(1213, a(ind, n193))]).
substitution(1215, ['X' = ind]).
proof(1215, a(ind, n195), rule(584), [uses(1214, a(ind, n194))]).
substitution(1216, ['X' = ind]).
proof(1216, a(ind, n196), rule(587), [uses(1215, a(ind, n195))]).
substitution(1217, ['X' = ind]).
proof(1217, a(ind, n197), rule(590), [uses(1216, a(ind, n196))]).
substitution(1218, ['X' = ind]).
proof(1218, a(ind, n198), rule(593), [uses(1217, a(ind, n197))]).
substitution(1219, ['X' = ind]).
proof(1219, a(ind, n199), rule(596), [uses(1218, a(ind, n198))]).
substitution(1220, ['X' = ind]).
proof(1220, a(ind, n200), rule(599), [uses(1219, a(ind, n199))]).
substitution(1221, ['X' = ind]).
proof(1221, a(ind, n201), rule(602), [uses(1220, a(ind, n200))]).
substitution(1222, ['X' = ind]).
proof(1222, a(ind, n202), rule(605), [uses(1221, a(ind, n201))]).
substitution(1223, ['X' = ind]).
proof(1223, a(ind, n203), rule(608), [uses(1222, a(ind, n202))]).
substitution(1224, ['X' = ind]).
proof(1224, a(ind, n204), rule(611), [uses(1223, a(ind, n203))]).
substitution(1225, ['X' = ind]).
proof(1225, a(ind, n205), rule(614), [uses(1224, a(ind, n204))]).
substitution(1226, ['X' = ind]).
proof(1226, a(ind, n206), rule(617), [uses(1225, a(ind, n205))]).
substitution(1227, ['X' = ind]).
proof(1227, a(ind, n207), rule(620), [uses(1226, a(ind, n206))]).
substitution(1228, ['X' = ind]).
proof(1228, a(ind, n208), rule(623), [uses(1227, a(ind, n207))]).
substitution(1229, ['X' = ind]).
proof(1229, a(ind, n209), rule(626), [uses(1228, a(ind, n208))]).
substitution(1230, ['X' = ind]).
proof(1230, a(ind, n210), rule(629), [uses(1229, a(ind, n209))]).
substitution(1231, ['X' = ind]).
proof(1231, a(ind, n211), rule(632), [uses(1230, a(ind, n210))]).
substitution(1232, ['X' = ind]).
proof(1232, a(ind, n212), rule(635), [uses(1231, a(ind, n211))]).
substitution(1233, ['X' = ind]).
proof(1233, a(ind, n213), rule(638), [uses(1232, a(ind, n212))]).
substitution(1234, ['X' = ind]).
proof(1234, a(ind, n214), rule(641), [uses(1233, a(ind, n213))]).
substitution(1235, ['X' = ind]).
proof(1235, a(ind, n215), rule(644), [uses(1234, a(ind, n214))]).
substitution(1236, ['X' = ind]).
proof(1236, a(ind, n216), rule(647), [uses(1235, a(ind, n215))]).
substitution(1237, ['X' = ind]).
proof(1237, a(ind, n217), rule(650), [uses(1236, a(ind, n216))]).
substitution(1238, ['X' = ind]).
proof(1238, a(ind, n218), rule(653), [uses(1237, a(ind, n217))]).
substitution(1239, ['X' = ind]).
proof(1239, a(ind, n219), rule(656), [uses(1238, a(ind, n218))]).
substitution(1240, ['X' = ind]).
proof(1240, a(ind, n220), rule(659), [uses(1239, a(ind, n219))]).
substitution(1241, ['X' = ind]).
proof(1241, a(ind, n221), rule(662), [uses(1240, a(ind, n220))]).
substitution(1242, ['X' = ind]).
proof(1242, a(ind, n222), rule(665), [uses(1241, a(ind, n221))]).
substitution(1243, ['X' = ind]).
proof(1243, a(ind, n223), rule(668), [uses(1242, a(ind, n222))]).
substitution(1244, ['X' = ind]).
proof(1244, a(ind, n224), rule(671), [uses(1243, a(ind, n223))]).
substitution(1245, ['X' = ind]).
proof(1245, a(ind, n225), rule(674), [uses(1244, a(ind, n224))]).
substitution(1246, ['X' = ind]).
proof(1246, a(ind, n226), rule(677), [uses(1245, a(ind, n225))]).
substitution(1247, ['X' = ind]).
proof(1247, a(ind, n227), rule(680), [uses(1246, a(ind, n226))]).
substitution(1248, ['X' = ind]).
proof(1248, a(ind, n228), rule(683), [uses(1247, a(ind, n227))]).
substitution(1249, ['X' = ind]).
proof(1249, a(ind, n229), rule(686), [uses(1248, a(ind, n228))]).
substitution(1250, ['X' = ind]).
proof(1250, a(ind, n230), rule(689), [uses(1249, a(ind, n229))]).
substitution(1251, ['X' = ind]).
proof(1251, a(ind, n231), rule(692), [uses(1250, a(ind, n230))]).
substitution(1252, ['X' = ind]).
proof(1252, a(ind, n232), rule(695), [uses(1251, a(ind, n231))]).
substitution(1253, ['X' = ind]).
proof(1253, a(ind, n233), rule(698), [uses(1252, a(ind, n232))]).
substitution(1254, ['X' = ind]).
proof(1254, a(ind, n234), rule(701), [uses(1253, a(ind, n233))]).
substitution(1255, ['X' = ind]).
proof(1255, a(ind, n235), rule(704), [uses(1254, a(ind, n234))]).
substitution(1256, ['X' = ind]).
proof(1256, a(ind, n236), rule(707), [uses(1255, a(ind, n235))]).
substitution(1257, ['X' = ind]).
proof(1257, a(ind, n237), rule(710), [uses(1256, a(ind, n236))]).
substitution(1258, ['X' = ind]).
proof(1258, a(ind, n238), rule(713), [uses(1257, a(ind, n237))]).
substitution(1259, ['X' = ind]).
proof(1259, a(ind, n239), rule(716), [uses(1258, a(ind, n238))]).
substitution(1260, ['X' = ind]).
proof(1260, a(ind, n240), rule(719), [uses(1259, a(ind, n239))]).
substitution(1261, ['X' = ind]).
proof(1261, a(ind, n241), rule(722), [uses(1260, a(ind, n240))]).
substitution(1262, ['X' = ind]).
proof(1262, a(ind, n242), rule(725), [uses(1261, a(ind, n241))]).
substitution(1263, ['X' = ind]).
proof(1263, a(ind, n243), rule(728), [uses(1262, a(ind, n242))]).
substitution(1264, ['X' = ind]).
proof(1264, a(ind, n244), rule(731), [uses(1263, a(ind, n243))]).
substitution(1265, ['X' = ind]).
proof(1265, a(ind, n245), rule(734), [uses(1264, a(ind, n244))]).
substitution(1266, ['X' = ind]).
proof(1266, a(ind, n246), rule(737), [uses(1265, a(ind, n245))]).
substitution(1267, ['X' = ind]).
proof(1267, a(ind, n247), rule(740), [uses(1266, a(ind, n246))]).
substitution(1268, ['X' = ind]).
proof(1268, a(ind, n248), rule(743), [uses(1267, a(ind, n247))]).
substitution(1269, ['X' = ind]).
proof(1269, a(ind, n249), rule(746), [uses(1268, a(ind, n248))]).
substitution(1270, ['X' = ind]).
proof(1270, a(ind, n250), rule(749), [uses(1269, a(ind, n249))]).
substitution(1271, ['X' = ind]).
proof(1271, a(ind, n251), rule(752), [uses(1270, a(ind, n250))]).
substitution(1272, ['X' = ind]).
proof(1272, a(ind, n252), rule(755), [uses(1271, a(ind, n251))]).
substitution(1273, ['X' = ind]).
proof(1273, a(ind, n253), rule(758), [uses(1272, a(ind, n252))]).
substitution(1274, ['X' = ind]).
proof(1274, a(ind, n254), rule(761), [uses(1273, a(ind, n253))]).
substitution(1275, ['X' = ind]).
proof(1275, a(ind, n255), rule(764), [uses(1274, a(ind, n254))]).
substitution(1276, ['X' = ind]).
proof(1276, a(ind, n256), rule(767), [uses(1275, a(ind, n255))]).
substitution(1277, ['X' = ind]).
proof(1277, a(ind, n257), rule(770), [uses(1276, a(ind, n256))]).
substitution(1278, ['X' = ind]).
proof(1278, a(ind, n258), rule(773), [uses(1277, a(ind, n257))]).
substitution(1279, ['X' = ind]).
proof(1279, a(ind, n259), rule(776), [uses(1278, a(ind, n258))]).
substitution(1280, ['X' = ind]).
proof(1280, a(ind, n260), rule(779), [uses(1279, a(ind, n259))]).
substitution(1281, ['X' = ind]).
proof(1281, a(ind, n261), rule(782), [uses(1280, a(ind, n260))]).
substitution(1282, ['X' = ind]).
proof(1282, a(ind, n262), rule(785), [uses(1281, a(ind, n261))]).
substitution(1283, ['X' = ind]).
proof(1283, a(ind, n263), rule(788), [uses(1282, a(ind, n262))]).
substitution(1284, ['X' = ind]).
proof(1284, a(ind, n264), rule(791), [uses(1283, a(ind, n263))]).
substitution(1285, ['X' = ind]).
proof(1285, a(ind, n265), rule(794), [uses(1284, a(ind, n264))]).
substitution(1286, ['X' = ind]).
proof(1286, a(ind, n266), rule(797), [uses(1285, a(ind, n265))]).
substitution(1287, ['X' = ind]).
proof(1287, a(ind, n267), rule(800), [uses(1286, a(ind, n266))]).
substitution(1288, ['X' = ind]).
proof(1288, a(ind, n268), rule(803), [uses(1287, a(ind, n267))]).
substitution(1289, ['X' = ind]).
proof(1289, a(ind, n269), rule(806), [uses(1288, a(ind, n268))]).
substitution(1290, ['X' = ind]).
proof(1290, a(ind, n270), rule(809), [uses(1289, a(ind, n269))]).
substitution(1291, ['X' = ind]).
proof(1291, a(ind, n271), rule(812), [uses(1290, a(ind, n270))]).
substitution(1292, ['X' = ind]).
proof(1292, a(ind, n272), rule(815), [uses(1291, a(ind, n271))]).
substitution(1293, ['X' = ind]).
proof(1293, a(ind, n273), rule(818), [uses(1292, a(ind, n272))]).
substitution(1294, ['X' = ind]).
proof(1294, a(ind, n274), rule(821), [uses(1293, a(ind, n273))]).
substitution(1295, ['X' = ind]).
proof(1295, a(ind, n275), rule(824), [uses(1294, a(ind, n274))]).
substitution(1296, ['X' = ind]).
proof(1296, a(ind, n276), rule(827), [uses(1295, a(ind, n275))]).
substitution(1297, ['X' = ind]).
proof(1297, a(ind, n277), rule(830), [uses(1296, a(ind, n276))]).
substitution(1298, ['X' = ind]).
proof(1298, a(ind, n278), rule(833), [uses(1297, a(ind, n277))]).
substitution(1299, ['X' = ind]).
proof(1299, a(ind, n279), rule(836), [uses(1298, a(ind, n278))]).
substitution(1300, ['X' = ind]).
proof(1300, a(ind, n280), rule(839), [uses(1299, a(ind, n279))]).
substitution(1301, ['X' = ind]).
proof(1301, a(ind, n281), rule(842), [uses(1300, a(ind, n280))]).
substitution(1302, ['X' = ind]).
proof(1302, a(ind, n282), rule(845), [uses(1301, a(ind, n281))]).
substitution(1303, ['X' = ind]).
proof(1303, a(ind, n283), rule(848), [uses(1302, a(ind, n282))]).
substitution(1304, ['X' = ind]).
proof(1304, a(ind, n284), rule(851), [uses(1303, a(ind, n283))]).
substitution(1305, ['X' = ind]).
proof(1305, a(ind, n285), rule(854), [uses(1304, a(ind, n284))]).
substitution(1306, ['X' = ind]).
proof(1306, a(ind, n286), rule(857), [uses(1305, a(ind, n285))]).
substitution(1307, ['X' = ind]).
proof(1307, a(ind, n287), rule(860), [uses(1306, a(ind, n286))]).
substitution(1308, ['X' = ind]).
proof(1308, a(ind, n288), rule(863), [uses(1307, a(ind, n287))]).
substitution(1309, ['X' = ind]).
proof(1309, a(ind, n289), rule(866), [uses(1308, a(ind, n288))]).
substitution(1310, ['X' = ind]).
proof(1310, a(ind, n290), rule(869), [uses(1309, a(ind, n289))]).
substitution(1311, ['X' = ind]).
proof(1311, a(ind, n291), rule(872), [uses(1310, a(ind, n290))]).
substitution(1312, ['X' = ind]).
proof(1312, a(ind, n292), rule(875), [uses(1311, a(ind, n291))]).
substitution(1313, ['X' = ind]).
proof(1313, a(ind, n293), rule(878), [uses(1312, a(ind, n292))]).
substitution(1314, ['X' = ind]).
proof(1314, a(ind, n294), rule(881), [uses(1313, a(ind, n293))]).
substitution(1315, ['X' = ind]).
proof(1315, a(ind, n295), rule(884), [uses(1314, a(ind, n294))]).
substitution(1316, ['X' = ind]).
proof(1316, a(ind, n296), rule(887), [uses(1315, a(ind, n295))]).
substitution(1317, ['X' = ind]).
proof(1317, a(ind, n297), rule(890), [uses(1316, a(ind, n296))]).
substitution(1318, ['X' = ind]).
proof(1318, a(ind, n298), rule(893), [uses(1317, a(ind, n297))]).
substitution(1319, ['X' = ind]).
proof(1319, a(ind, n299), rule(896), [uses(1318, a(ind, n298))]).
substitution(1320, ['X' = ind]).
proof(1320, a(ind, n300), rule(899), [uses(1319, a(ind, n299))]).
substitution(1321, ['X' = ind]).
proof(1321, a(ind, n301), rule(902), [uses(1320, a(ind, n300))]).
substitution(1322, ['X' = ind]).
proof(1322, a(ind, n302), rule(905), [uses(1321, a(ind, n301))]).
substitution(1323, ['X' = ind]).
proof(1323, a(ind, n303), rule(908), [uses(1322, a(ind, n302))]).
substitution(1324, ['X' = ind]).
proof(1324, a(ind, n304), rule(911), [uses(1323, a(ind, n303))]).
substitution(1325, ['X' = ind]).
proof(1325, a(ind, n305), rule(914), [uses(1324, a(ind, n304))]).
substitution(1326, ['X' = ind]).
proof(1326, a(ind, n306), rule(917), [uses(1325, a(ind, n305))]).
substitution(1327, ['X' = ind]).
proof(1327, a(ind, n307), rule(920), [uses(1326, a(ind, n306))]).
substitution(1328, ['X' = ind]).
proof(1328, a(ind, n308), rule(923), [uses(1327, a(ind, n307))]).
substitution(1329, ['X' = ind]).
proof(1329, a(ind, n309), rule(926), [uses(1328, a(ind, n308))]).
substitution(1330, ['X' = ind]).
proof(1330, a(ind, n310), rule(929), [uses(1329, a(ind, n309))]).
substitution(1331, ['X' = ind]).
proof(1331, a(ind, n311), rule(932), [uses(1330, a(ind, n310))]).
substitution(1332, ['X' = ind]).
proof(1332, a(ind, n312), rule(935), [uses(1331, a(ind, n311))]).
substitution(1333, ['X' = ind]).
proof(1333, a(ind, n313), rule(938), [uses(1332, a(ind, n312))]).
substitution(1334, ['X' = ind]).
proof(1334, a(ind, n314), rule(941), [uses(1333, a(ind, n313))]).
substitution(1335, ['X' = ind]).
proof(1335, a(ind, n315), rule(944), [uses(1334, a(ind, n314))]).
substitution(1336, ['X' = ind]).
proof(1336, a(ind, n316), rule(947), [uses(1335, a(ind, n315))]).
substitution(1337, ['X' = ind]).
proof(1337, a(ind, n317), rule(950), [uses(1336, a(ind, n316))]).
substitution(1338, ['X' = ind]).
proof(1338, a(ind, n318), rule(953), [uses(1337, a(ind, n317))]).
substitution(1339, ['X' = ind]).
proof(1339, a(ind, n319), rule(956), [uses(1338, a(ind, n318))]).
substitution(1340, ['X' = ind]).
proof(1340, a(ind, n320), rule(959), [uses(1339, a(ind, n319))]).
substitution(1341, ['X' = ind]).
proof(1341, a(ind, n321), rule(962), [uses(1340, a(ind, n320))]).
substitution(1342, ['X' = ind]).
proof(1342, a(ind, n322), rule(965), [uses(1341, a(ind, n321))]).
substitution(1343, ['X' = ind]).
proof(1343, a(ind, n323), rule(968), [uses(1342, a(ind, n322))]).
substitution(1344, ['X' = ind]).
proof(1344, a(ind, n324), rule(971), [uses(1343, a(ind, n323))]).
substitution(1345, ['X' = ind]).
proof(1345, a(ind, n325), rule(974), [uses(1344, a(ind, n324))]).
substitution(1346, ['X' = ind]).
proof(1346, a(ind, n326), rule(977), [uses(1345, a(ind, n325))]).
substitution(1347, ['X' = ind]).
proof(1347, a(ind, n327), rule(980), [uses(1346, a(ind, n326))]).
substitution(1348, ['X' = ind]).
proof(1348, a(ind, n328), rule(983), [uses(1347, a(ind, n327))]).
substitution(1349, ['X' = ind]).
proof(1349, a(ind, n329), rule(986), [uses(1348, a(ind, n328))]).
substitution(1350, ['X' = ind]).
proof(1350, a(ind, n330), rule(989), [uses(1349, a(ind, n329))]).
substitution(1351, ['X' = ind]).
proof(1351, a(ind, n331), rule(992), [uses(1350, a(ind, n330))]).
substitution(1352, ['X' = ind]).
proof(1352, a(ind, n332), rule(995), [uses(1351, a(ind, n331))]).
substitution(1353, ['X' = ind]).
proof(1353, a(ind, n333), rule(998), [uses(1352, a(ind, n332))]).
substitution(1354, ['X' = ind]).
proof(1354, a(ind, n334), rule(1001), [uses(1353, a(ind, n333))]).
substitution(1355, ['X' = ind]).
proof(1355, a(ind, n335), rule(1004), [uses(1354, a(ind, n334))]).
substitution(1356, ['X' = ind]).
proof(1356, a(ind, n336), rule(1007), [uses(1355, a(ind, n335))]).
substitution(1357, ['X' = ind]).
proof(1357, a(ind, n337), rule(1010), [uses(1356, a(ind, n336))]).
substitution(1358, ['X' = ind]).
proof(1358, a(ind, n338), rule(1013), [uses(1357, a(ind, n337))]).
substitution(1359, ['X' = ind]).
proof(1359, a(ind, n339), rule(1016), [uses(1358, a(ind, n338))]).
substitution(1360, ['X' = ind]).
proof(1360, a(ind, n340), rule(1019), [uses(1359, a(ind, n339))]).
substitution(1361, ['X' = ind]).
proof(1361, a(ind, n341), rule(1022), [uses(1360, a(ind, n340))]).
substitution(1362, ['X' = ind]).
proof(1362, a(ind, n342), rule(1025), [uses(1361, a(ind, n341))]).
substitution(1363, ['X' = ind]).
proof(1363, a(ind, n343), rule(1028), [uses(1362, a(ind, n342))]).
substitution(1364, ['X' = ind]).
proof(1364, a(ind, n344), rule(1031), [uses(1363, a(ind, n343))]).
substitution(1365, ['X' = ind]).
proof(1365, a(ind, n345), rule(1034), [uses(1364, a(ind, n344))]).
substitution(1366, ['X' = ind]).
proof(1366, a(ind, n346), rule(1037), [uses(1365, a(ind, n345))]).
substitution(1367, ['X' = ind]).
proof(1367, a(ind, n347), rule(1040), [uses(1366, a(ind, n346))]).
substitution(1368, ['X' = ind]).
proof(1368, a(ind, n348), rule(1043), [uses(1367, a(ind, n347))]).
substitution(1369, ['X' = ind]).
proof(1369, a(ind, n349), rule(1046), [uses(1368, a(ind, n348))]).
substitution(1370, ['X' = ind]).
proof(1370, a(ind, n350), rule(1049), [uses(1369, a(ind, n349))]).
substitution(1371, ['X' = ind]).
proof(1371, a(ind, n351), rule(1052), [uses(1370, a(ind, n350))]).
substitution(1372, ['X' = ind]).
proof(1372, a(ind, n352), rule(1055), [uses(1371, a(ind, n351))]).
substitution(1373, ['X' = ind]).
proof(1373, a(ind, n353), rule(1058), [uses(1372, a(ind, n352))]).
substitution(1374, ['X' = ind]).
proof(1374, a(ind, n354), rule(1061), [uses(1373, a(ind, n353))]).
substitution(1375, ['X' = ind]).
proof(1375, a(ind, n355), rule(1064), [uses(1374, a(ind, n354))]).
substitution(1376, ['X' = ind]).
proof(1376, a(ind, n356), rule(1067), [uses(1375, a(ind, n355))]).
substitution(1377, ['X' = ind]).
proof(1377, a(ind, n357), rule(1070), [uses(1376, a(ind, n356))]).
substitution(1378, ['X' = ind]).
proof(1378, a(ind, n358), rule(1073), [uses(1377, a(ind, n357))]).
substitution(1379, ['X' = ind]).
proof(1379, a(ind, n359), rule(1076), [uses(1378, a(ind, n358))]).
substitution(1380, ['X' = ind]).
proof(1380, a(ind, n360), rule(1079), [uses(1379, a(ind, n359))]).
substitution(1381, ['X' = ind]).
proof(1381, a(ind, n361), rule(1082), [uses(1380, a(ind, n360))]).
substitution(1382, ['X' = ind]).
proof(1382, a(ind, n362), rule(1085), [uses(1381, a(ind, n361))]).
substitution(1383, ['X' = ind]).
proof(1383, a(ind, n363), rule(1088), [uses(1382, a(ind, n362))]).
substitution(1384, ['X' = ind]).
proof(1384, a(ind, n364), rule(1091), [uses(1383, a(ind, n363))]).
substitution(1385, ['X' = ind]).
proof(1385, a(ind, n365), rule(1094), [uses(1384, a(ind, n364))]).
substitution(1386, ['X' = ind]).
proof(1386, a(ind, n366), rule(1097), [uses(1385, a(ind, n365))]).
substitution(1387, ['X' = ind]).
proof(1387, a(ind, n367), rule(1100), [uses(1386, a(ind, n366))]).
substitution(1388, ['X' = ind]).
proof(1388, a(ind, n368), rule(1103), [uses(1387, a(ind, n367))]).
substitution(1389, ['X' = ind]).
proof(1389, a(ind, n369), rule(1106), [uses(1388, a(ind, n368))]).
substitution(1390, ['X' = ind]).
proof(1390, a(ind, n370), rule(1109), [uses(1389, a(ind, n369))]).
substitution(1391, ['X' = ind]).
proof(1391, a(ind, n371), rule(1112), [uses(1390, a(ind, n370))]).
substitution(1392, ['X' = ind]).
proof(1392, a(ind, n372), rule(1115), [uses(1391, a(ind, n371))]).
substitution(1393, ['X' = ind]).
proof(1393, a(ind, n373), rule(1118), [uses(1392, a(ind, n372))]).
substitution(1394, ['X' = ind]).
proof(1394, a(ind, n374), rule(1121), [uses(1393, a(ind, n373))]).
substitution(1395, ['X' = ind]).
proof(1395, a(ind, n375), rule(1124), [uses(1394, a(ind, n374))]).
substitution(1396, ['X' = ind]).
proof(1396, a(ind, n376), rule(1127), [uses(1395, a(ind, n375))]).
substitution(1397, ['X' = ind]).
proof(1397, a(ind, n377), rule(1130), [uses(1396, a(ind, n376))]).
substitution(1398, ['X' = ind]).
proof(1398, a(ind, n378), rule(1133), [uses(1397, a(ind, n377))]).
substitution(1399, ['X' = ind]).
proof(1399, a(ind, n379), rule(1136), [uses(1398, a(ind, n378))]).
substitution(1400, ['X' = ind]).
proof(1400, a(ind, n380), rule(1139), [uses(1399, a(ind, n379))]).
substitution(1401, ['X' = ind]).
proof(1401, a(ind, n381), rule(1142), [uses(1400, a(ind, n380))]).
substitution(1402, ['X' = ind]).
proof(1402, a(ind, n382), rule(1145), [uses(1401, a(ind, n381))]).
substitution(1403, ['X' = ind]).
proof(1403, a(ind, n383), rule(1148), [uses(1402, a(ind, n382))]).
substitution(1404, ['X' = ind]).
proof(1404, a(ind, n384), rule(1151), [uses(1403, a(ind, n383))]).
substitution(1405, ['X' = ind]).
proof(1405, a(ind, n385), rule(1154), [uses(1404, a(ind, n384))]).
substitution(1406, ['X' = ind]).
proof(1406, a(ind, n386), rule(1157), [uses(1405, a(ind, n385))]).
substitution(1407, ['X' = ind]).
proof(1407, a(ind, n387), rule(1160), [uses(1406, a(ind, n386))]).
substitution(1408, ['X' = ind]).
proof(1408, a(ind, n388), rule(1163), [uses(1407, a(ind, n387))]).
substitution(1409, ['X' = ind]).
proof(1409, a(ind, n389), rule(1166), [uses(1408, a(ind, n388))]).
substitution(1410, ['X' = ind]).
proof(1410, a(ind, n390), rule(1169), [uses(1409, a(ind, n389))]).
substitution(1411, ['X' = ind]).
proof(1411, a(ind, n391), rule(1172), [uses(1410, a(ind, n390))]).
substitution(1412, ['X' = ind]).
proof(1412, a(ind, n392), rule(1175), [uses(1411, a(ind, n391))]).
substitution(1413, ['X' = ind]).
proof(1413, a(ind, n393), rule(1178), [uses(1412, a(ind, n392))]).
substitution(1414, ['X' = ind]).
proof(1414, a(ind, n394), rule(1181), [uses(1413, a(ind, n393))]).
substitution(1415, ['X' = ind]).
proof(1415, a(ind, n395), rule(1184), [uses(1414, a(ind, n394))]).
substitution(1416, ['X' = ind]).
proof(1416, a(ind, n396), rule(1187), [uses(1415, a(ind, n395))]).
substitution(1417, ['X' = ind]).
proof(1417, a(ind, n397), rule(1190), [uses(1416, a(ind, n396))]).
substitution(1418, ['X' = ind]).
proof(1418, a(ind, n398), rule(1193), [uses(1417, a(ind, n397))]).
substitution(1419, ['X' = ind]).
proof(1419, a(ind, n399), rule(1196), [uses(1418, a(ind, n398))]).
substitution(1420, ['X' = ind]).
proof(1420, a(ind, n400), rule(1199), [uses(1419, a(ind, n399))]).
substitution(1421, ['X' = ind]).
proof(1421, a(ind, n401), rule(1202), [uses(1420, a(ind, n400))]).
substitution(1422, ['X' = ind]).
proof(1422, a(ind, n402), rule(1205), [uses(1421, a(ind, n401))]).
substitution(1423, ['X' = ind]).
proof(1423, a(ind, n403), rule(1208), [uses(1422, a(ind, n402))]).
substitution(1424, ['X' = ind]).
proof(1424, a(ind, n404), rule(1211), [uses(1423, a(ind, n403))]).
substitution(1425, ['X' = ind]).
proof(1425, a(ind, n405), rule(1214), [uses(1424, a(ind, n404))]).
substitution(1426, ['X' = ind]).
proof(1426, a(ind, n406), rule(1217), [uses(1425, a(ind, n405))]).
substitution(1427, ['X' = ind]).
proof(1427, a(ind, n407), rule(1220), [uses(1426, a(ind, n406))]).
substitution(1428, ['X' = ind]).
proof(1428, a(ind, n408), rule(1223), [uses(1427, a(ind, n407))]).
substitution(1429, ['X' = ind]).
proof(1429, a(ind, n409), rule(1226), [uses(1428, a(ind, n408))]).
substitution(1430, ['X' = ind]).
proof(1430, a(ind, n410), rule(1229), [uses(1429, a(ind, n409))]).
substitution(1431, ['X' = ind]).
proof(1431, a(ind, n411), rule(1232), [uses(1430, a(ind, n410))]).
substitution(1432, ['X' = ind]).
proof(1432, a(ind, n412), rule(1235), [uses(1431, a(ind, n411))]).
substitution(1433, ['X' = ind]).
proof(1433, a(ind, n413), rule(1238), [uses(1432, a(ind, n412))]).
substitution(1434, ['X' = ind]).
proof(1434, a(ind, n414), rule(1241), [uses(1433, a(ind, n413))]).
substitution(1435, ['X' = ind]).
proof(1435, a(ind, n415), rule(1244), [uses(1434, a(ind, n414))]).
substitution(1436, ['X' = ind]).
proof(1436, a(ind, n416), rule(1247), [uses(1435, a(ind, n415))]).
substitution(1437, ['X' = ind]).
proof(1437, a(ind, n417), rule(1250), [uses(1436, a(ind, n416))]).
substitution(1438, ['X' = ind]).
proof(1438, a(ind, n418), rule(1253), [uses(1437, a(ind, n417))]).
substitution(1439, ['X' = ind]).
proof(1439, a(ind, n419), rule(1256), [uses(1438, a(ind, n418))]).
substitution(1440, ['X' = ind]).
proof(1440, a(ind, n420), rule(1259), [uses(1439, a(ind, n419))]).
substitution(1441, ['X' = ind]).
proof(1441, a(ind, n421), rule(1262), [uses(1440, a(ind, n420))]).
substitution(1442, ['X' = ind]).
proof(1442, a(ind, n422), rule(1265), [uses(1441, a(ind, n421))]).
substitution(1443, ['X' = ind]).
proof(1443, a(ind, n423), rule(1268), [uses(1442, a(ind, n422))]).
substitution(1444, ['X' = ind]).
proof(1444, a(ind, n424), rule(1271), [uses(1443, a(ind, n423))]).
substitution(1445, ['X' = ind]).
proof(1445, a(ind, n425), rule(1274), [uses(1444, a(ind, n424))]).
substitution(1446, ['X' = ind]).
proof(1446, a(ind, n426), rule(1277), [uses(1445, a(ind, n425))]).
substitution(1447, ['X' = ind]).
proof(1447, a(ind, n427), rule(1280), [uses(1446, a(ind, n426))]).
substitution(1448, ['X' = ind]).
proof(1448, a(ind, n428), rule(1283), [uses(1447, a(ind, n427))]).
substitution(1449, ['X' = ind]).
proof(1449, a(ind, n429), rule(1286), [uses(1448, a(ind, n428))]).
substitution(1450, ['X' = ind]).
proof(1450, a(ind, n430), rule(1289), [uses(1449, a(ind, n429))]).
substitution(1451, ['X' = ind]).
proof(1451, a(ind, n431), rule(1292), [uses(1450, a(ind, n430))]).
substitution(1452, ['X' = ind]).
proof(1452, a(ind, n432), rule(1295), [uses(1451, a(ind, n431))]).
substitution(1453, ['X' = ind]).
proof(1453, a(ind, n433), rule(1298), [uses(1452, a(ind, n432))]).
substitution(1454, ['X' = ind]).
proof(1454, a(ind, n434), rule(1301), [uses(1453, a(ind, n433))]).
substitution(1455, ['X' = ind]).
proof(1455, a(ind, n435), rule(1304), [uses(1454, a(ind, n434))]).
substitution(1456, ['X' = ind]).
proof(1456, a(ind, n436), rule(1307), [uses(1455, a(ind, n435))]).
substitution(1457, ['X' = ind]).
proof(1457, a(ind, n437), rule(1310), [uses(1456, a(ind, n436))]).
substitution(1458, ['X' = ind]).
proof(1458, a(ind, n438), rule(1313), [uses(1457, a(ind, n437))]).
substitution(1459, ['X' = ind]).
proof(1459, a(ind, n439), rule(1316), [uses(1458, a(ind, n438))]).
substitution(1460, ['X' = ind]).
proof(1460, a(ind, n440), rule(1319), [uses(1459, a(ind, n439))]).
substitution(1461, ['X' = ind]).
proof(1461, a(ind, n441), rule(1322), [uses(1460, a(ind, n440))]).
substitution(1462, ['X' = ind]).
proof(1462, a(ind, n442), rule(1325), [uses(1461, a(ind, n441))]).
substitution(1463, ['X' = ind]).
proof(1463, a(ind, n443), rule(1328), [uses(1462, a(ind, n442))]).
substitution(1464, ['X' = ind]).
proof(1464, a(ind, n444), rule(1331), [uses(1463, a(ind, n443))]).
substitution(1465, ['X' = ind]).
proof(1465, a(ind, n445), rule(1334), [uses(1464, a(ind, n444))]).
substitution(1466, ['X' = ind]).
proof(1466, a(ind, n446), rule(1337), [uses(1465, a(ind, n445))]).
substitution(1467, ['X' = ind]).
proof(1467, a(ind, n447), rule(1340), [uses(1466, a(ind, n446))]).
substitution(1468, ['X' = ind]).
proof(1468, a(ind, n448), rule(1343), [uses(1467, a(ind, n447))]).
substitution(1469, ['X' = ind]).
proof(1469, a(ind, n449), rule(1346), [uses(1468, a(ind, n448))]).
substitution(1470, ['X' = ind]).
proof(1470, a(ind, n450), rule(1349), [uses(1469, a(ind, n449))]).
substitution(1471, ['X' = ind]).
proof(1471, a(ind, n451), rule(1352), [uses(1470, a(ind, n450))]).
substitution(1472, ['X' = ind]).
proof(1472, a(ind, n452), rule(1355), [uses(1471, a(ind, n451))]).
substitution(1473, ['X' = ind]).
proof(1473, a(ind, n453), rule(1358), [uses(1472, a(ind, n452))]).
substitution(1474, ['X' = ind]).
proof(1474, a(ind, n454), rule(1361), [uses(1473, a(ind, n453))]).
substitution(1475, ['X' = ind]).
proof(1475, a(ind, n455), rule(1364), [uses(1474, a(ind, n454))]).
substitution(1476, ['X' = ind]).
proof(1476, a(ind, n456), rule(1367), [uses(1475, a(ind, n455))]).
substitution(1477, ['X' = ind]).
proof(1477, a(ind, n457), rule(1370), [uses(1476, a(ind, n456))]).
substitution(1478, ['X' = ind]).
proof(1478, a(ind, n458), rule(1373), [uses(1477, a(ind, n457))]).
substitution(1479, ['X' = ind]).
proof(1479, a(ind, n459), rule(1376), [uses(1478, a(ind, n458))]).
substitution(1480, ['X' = ind]).
proof(1480, a(ind, n460), rule(1379), [uses(1479, a(ind, n459))]).
substitution(1481, ['X' = ind]).
proof(1481, a(ind, n461), rule(1382), [uses(1480, a(ind, n460))]).
substitution(1482, ['X' = ind]).
proof(1482, a(ind, n462), rule(1385), [uses(1481, a(ind, n461))]).
substitution(1483, ['X' = ind]).
proof(1483, a(ind, n463), rule(1388), [uses(1482, a(ind, n462))]).
substitution(1484, ['X' = ind]).
proof(1484, a(ind, n464), rule(1391), [uses(1483, a(ind, n463))]).
substitution(1485, ['X' = ind]).
proof(1485, a(ind, n465), rule(1394), [uses(1484, a(ind, n464))]).
substitution(1486, ['X' = ind]).
proof(1486, a(ind, n466), rule(1397), [uses(1485, a(ind, n465))]).
substitution(1487, ['X' = ind]).
proof(1487, a(ind, n467), rule(1400), [uses(1486, a(ind, n466))]).
substitution(1488, ['X' = ind]).
proof(1488, a(ind, n468), rule(1403), [uses(1487, a(ind, n467))]).
substitution(1489, ['X' = ind]).
proof(1489, a(ind, n469), rule(1406), [uses(1488, a(ind, n468))]).
substitution(1490, ['X' = ind]).
proof(1490, a(ind, n470), rule(1409), [uses(1489, a(ind, n469))]).
substitution(1491, ['X' = ind]).
proof(1491, a(ind, n471), rule(1412), [uses(1490, a(ind, n470))]).
substitution(1492, ['X' = ind]).
proof(1492, a(ind, n472), rule(1415), [uses(1491, a(ind, n471))]).
substitution(1493, ['X' = ind]).
proof(1493, a(ind, n473), rule(1418), [uses(1492, a(ind, n472))]).
substitution(1494, ['X' = ind]).
proof(1494, a(ind, n474), rule(1421), [uses(1493, a(ind, n473))]).
substitution(1495, ['X' = ind]).
proof(1495, a(ind, n475), rule(1424), [uses(1494, a(ind, n474))]).
substitution(1496, ['X' = ind]).
proof(1496, a(ind, n476), rule(1427), [uses(1495, a(ind, n475))]).
substitution(1497, ['X' = ind]).
proof(1497, a(ind, n477), rule(1430), [uses(1496, a(ind, n476))]).
substitution(1498, ['X' = ind]).
proof(1498, a(ind, n478), rule(1433), [uses(1497, a(ind, n477))]).
substitution(1499, ['X' = ind]).
proof(1499, a(ind, n479), rule(1436), [uses(1498, a(ind, n478))]).
substitution(1500, ['X' = ind]).
proof(1500, a(ind, n480), rule(1439), [uses(1499, a(ind, n479))]).
substitution(1501, ['X' = ind]).
proof(1501, a(ind, n481), rule(1442), [uses(1500, a(ind, n480))]).
substitution(1502, ['X' = ind]).
proof(1502, a(ind, n482), rule(1445), [uses(1501, a(ind, n481))]).
substitution(1503, ['X' = ind]).
proof(1503, a(ind, n483), rule(1448), [uses(1502, a(ind, n482))]).
substitution(1504, ['X' = ind]).
proof(1504, a(ind, n484), rule(1451), [uses(1503, a(ind, n483))]).
substitution(1505, ['X' = ind]).
proof(1505, a(ind, n485), rule(1454), [uses(1504, a(ind, n484))]).
substitution(1506, ['X' = ind]).
proof(1506, a(ind, n486), rule(1457), [uses(1505, a(ind, n485))]).
substitution(1507, ['X' = ind]).
proof(1507, a(ind, n487), rule(1460), [uses(1506, a(ind, n486))]).
substitution(1508, ['X' = ind]).
proof(1508, a(ind, n488), rule(1463), [uses(1507, a(ind, n487))]).
substitution(1509, ['X' = ind]).
proof(1509, a(ind, n489), rule(1466), [uses(1508, a(ind, n488))]).
substitution(1510, ['X' = ind]).
proof(1510, a(ind, n490), rule(1469), [uses(1509, a(ind, n489))]).
substitution(1511, ['X' = ind]).
proof(1511, a(ind, n491), rule(1472), [uses(1510, a(ind, n490))]).
substitution(1512, ['X' = ind]).
proof(1512, a(ind, n492), rule(1475), [uses(1511, a(ind, n491))]).
substitution(1513, ['X' = ind]).
proof(1513, a(ind, n493), rule(1478), [uses(1512, a(ind, n492))]).
substitution(1514, ['X' = ind]).
proof(1514, a(ind, n494), rule(1481), [uses(1513, a(ind, n493))]).
substitution(1515, ['X' = ind]).
proof(1515, a(ind, n495), rule(1484), [uses(1514, a(ind, n494))]).
substitution(1516, ['X' = ind]).
proof(1516, a(ind, n496), rule(1487), [uses(1515, a(ind, n495))]).
substitution(1517, ['X' = ind]).
proof(1517, a(ind, n497), rule(1490), [uses(1516, a(ind, n496))]).
substitution(1518, ['X' = ind]).
proof(1518, a(ind, n498), rule(1493), [uses(1517, a(ind, n497))]).
substitution(1519, ['X' = ind]).
proof(1519, a(ind, n499), rule(1496), [uses(1518, a(ind, n498))]).
substitution(1520, ['X' = ind]).
proof(1520, a(ind, n500), rule(1499), [uses(1519, a(ind, n499))]).
substitution(1521, ['X' = ind]).
proof(1521, a(ind, n501), rule(1502), [uses(1520, a(ind, n500))]).
substitution(1522, ['X' = ind]).
proof(1522, a(ind, n502), rule(1505), [uses(1521, a(ind, n501))]).
substitution(1523, ['X' = ind]).
proof(1523, a(ind, n503), rule(1508), [uses(1522, a(ind, n502))]).
substitution(1524, ['X' = ind]).
proof(1524, a(ind, n504), rule(1511), [uses(1523, a(ind, n503))]).
substitution(1525, ['X' = ind]).
proof(1525, a(ind, n505), rule(1514), [uses(1524, a(ind, n504))]).
substitution(1526, ['X' = ind]).
proof(1526, a(ind, n506), rule(1517), [uses(1525, a(ind, n505))]).
substitution(1527, ['X' = ind]).
proof(1527, a(ind, n507), rule(1520), [uses(1526, a(ind, n506))]).
substitution(1528, ['X' = ind]).
proof(1528, a(ind, n508), rule(1523), [uses(1527, a(ind, n507))]).
substitution(1529, ['X' = ind]).
proof(1529, a(ind, n509), rule(1526), [uses(1528, a(ind, n508))]).
substitution(1530, ['X' = ind]).
proof(1530, a(ind, n510), rule(1529), [uses(1529, a(ind, n509))]).
substitution(1531, ['X' = ind]).
proof(1531, a(ind, n511), rule(1532), [uses(1530, a(ind, n510))]).
substitution(1532, ['X' = ind]).
proof(1532, a(ind, n512), rule(1535), [uses(1531, a(ind, n511))]).
substitution(1533, ['X' = ind]).
proof(1533, a(ind, n513), rule(1538), [uses(1532, a(ind, n512))]).
substitution(1534, ['X' = ind]).
proof(1534, a(ind, n514), rule(1541), [uses(1533, a(ind, n513))]).
substitution(1535, ['X' = ind]).
proof(1535, a(ind, n515), rule(1544), [uses(1534, a(ind, n514))]).
substitution(1536, ['X' = ind]).
proof(1536, a(ind, n516), rule(1547), [uses(1535, a(ind, n515))]).
substitution(1537, ['X' = ind]).
proof(1537, a(ind, n517), rule(1550), [uses(1536, a(ind, n516))]).
substitution(1538, ['X' = ind]).
proof(1538, a(ind, n518), rule(1553), [uses(1537, a(ind, n517))]).
substitution(1539, ['X' = ind]).
proof(1539, a(ind, n519), rule(1556), [uses(1538, a(ind, n518))]).
substitution(1540, ['X' = ind]).
proof(1540, a(ind, n520), rule(1559), [uses(1539, a(ind, n519))]).
substitution(1541, ['X' = ind]).
proof(1541, a(ind, n521), rule(1562), [uses(1540, a(ind, n520))]).
substitution(1542, ['X' = ind]).
proof(1542, a(ind, n522), rule(1565), [uses(1541, a(ind, n521))]).
substitution(1543, ['X' = ind]).
proof(1543, a(ind, n523), rule(1568), [uses(1542, a(ind, n522))]).
substitution(1544, ['X' = ind]).
proof(1544, a(ind, n524), rule(1571), [uses(1543, a(ind, n523))]).
substitution(1545, ['X' = ind]).
proof(1545, a(ind, n525), rule(1574), [uses(1544, a(ind, n524))]).
substitution(1546, ['X' = ind]).
proof(1546, a(ind, n526), rule(1577), [uses(1545, a(ind, n525))]).
substitution(1547, ['X' = ind]).
proof(1547, a(ind, n527), rule(1580), [uses(1546, a(ind, n526))]).
substitution(1548, ['X' = ind]).
proof(1548, a(ind, n528), rule(1583), [uses(1547, a(ind, n527))]).
substitution(1549, ['X' = ind]).
proof(1549, a(ind, n529), rule(1586), [uses(1548, a(ind, n528))]).
substitution(1550, ['X' = ind]).
proof(1550, a(ind, n530), rule(1589), [uses(1549, a(ind, n529))]).
substitution(1551, ['X' = ind]).
proof(1551, a(ind, n531), rule(1592), [uses(1550, a(ind, n530))]).
substitution(1552, ['X' = ind]).
proof(1552, a(ind, n532), rule(1595), [uses(1551, a(ind, n531))]).
substitution(1553, ['X' = ind]).
proof(1553, a(ind, n533), rule(1598), [uses(1552, a(ind, n532))]).
substitution(1554, ['X' = ind]).
proof(1554, a(ind, n534), rule(1601), [uses(1553, a(ind, n533))]).
substitution(1555, ['X' = ind]).
proof(1555, a(ind, n535), rule(1604), [uses(1554, a(ind, n534))]).
substitution(1556, ['X' = ind]).
proof(1556, a(ind, n536), rule(1607), [uses(1555, a(ind, n535))]).
substitution(1557, ['X' = ind]).
proof(1557, a(ind, n537), rule(1610), [uses(1556, a(ind, n536))]).
substitution(1558, ['X' = ind]).
proof(1558, a(ind, n538), rule(1613), [uses(1557, a(ind, n537))]).
substitution(1559, ['X' = ind]).
proof(1559, a(ind, n539), rule(1616), [uses(1558, a(ind, n538))]).
substitution(1560, ['X' = ind]).
proof(1560, a(ind, n540), rule(1619), [uses(1559, a(ind, n539))]).
substitution(1561, ['X' = ind]).
proof(1561, a(ind, n541), rule(1622), [uses(1560, a(ind, n540))]).
substitution(1562, ['X' = ind]).
proof(1562, a(ind, n542), rule(1625), [uses(1561, a(ind, n541))]).
substitution(1563, ['X' = ind]).
proof(1563, a(ind, n543), rule(1628), [uses(1562, a(ind, n542))]).
substitution(1564, ['X' = ind]).
proof(1564, a(ind, n544), rule(1631), [uses(1563, a(ind, n543))]).
substitution(1565, ['X' = ind]).
proof(1565, a(ind, n545), rule(1634), [uses(1564, a(ind, n544))]).
substitution(1566, ['X' = ind]).
proof(1566, a(ind, n546), rule(1637), [uses(1565, a(ind, n545))]).
substitution(1567, ['X' = ind]).
proof(1567, a(ind, n547), rule(1640), [uses(1566, a(ind, n546))]).
substitution(1568, ['X' = ind]).
proof(1568, a(ind, n548), rule(1643), [uses(1567, a(ind, n547))]).
substitution(1569, ['X' = ind]).
proof(1569, a(ind, n549), rule(1646), [uses(1568, a(ind, n548))]).
substitution(1570, ['X' = ind]).
proof(1570, a(ind, n550), rule(1649), [uses(1569, a(ind, n549))]).
substitution(1571, ['X' = ind]).
proof(1571, a(ind, n551), rule(1652), [uses(1570, a(ind, n550))]).
substitution(1572, ['X' = ind]).
proof(1572, a(ind, n552), rule(1655), [uses(1571, a(ind, n551))]).
substitution(1573, ['X' = ind]).
proof(1573, a(ind, n553), rule(1658), [uses(1572, a(ind, n552))]).
substitution(1574, ['X' = ind]).
proof(1574, a(ind, n554), rule(1661), [uses(1573, a(ind, n553))]).
substitution(1575, ['X' = ind]).
proof(1575, a(ind, n555), rule(1664), [uses(1574, a(ind, n554))]).
substitution(1576, ['X' = ind]).
proof(1576, a(ind, n556), rule(1667), [uses(1575, a(ind, n555))]).
substitution(1577, ['X' = ind]).
proof(1577, a(ind, n557), rule(1670), [uses(1576, a(ind, n556))]).
substitution(1578, ['X' = ind]).
proof(1578, a(ind, n558), rule(1673), [uses(1577, a(ind, n557))]).
substitution(1579, ['X' = ind]).
proof(1579, a(ind, n559), rule(1676), [uses(1578, a(ind, n558))]).
substitution(1580, ['X' = ind]).
proof(1580, a(ind, n560), rule(1679), [uses(1579, a(ind, n559))]).
substitution(1581, ['X' = ind]).
proof(1581, a(ind, n561), rule(1682), [uses(1580, a(ind, n560))]).
substitution(1582, ['X' = ind]).
proof(1582, a(ind, n562), rule(1685), [uses(1581, a(ind, n561))]).
substitution(1583, ['X' = ind]).
proof(1583, a(ind, n563), rule(1688), [uses(1582, a(ind, n562))]).
substitution(1584, ['X' = ind]).
proof(1584, a(ind, n564), rule(1691), [uses(1583, a(ind, n563))]).
substitution(1585, ['X' = ind]).
proof(1585, a(ind, n565), rule(1694), [uses(1584, a(ind, n564))]).
substitution(1586, ['X' = ind]).
proof(1586, a(ind, n566), rule(1697), [uses(1585, a(ind, n565))]).
substitution(1587, ['X' = ind]).
proof(1587, a(ind, n567), rule(1700), [uses(1586, a(ind, n566))]).
substitution(1588, ['X' = ind]).
proof(1588, a(ind, n568), rule(1703), [uses(1587, a(ind, n567))]).
substitution(1589, ['X' = ind]).
proof(1589, a(ind, n569), rule(1706), [uses(1588, a(ind, n568))]).
substitution(1590, ['X' = ind]).
proof(1590, a(ind, n570), rule(1709), [uses(1589, a(ind, n569))]).
substitution(1591, ['X' = ind]).
proof(1591, a(ind, n571), rule(1712), [uses(1590, a(ind, n570))]).
substitution(1592, ['X' = ind]).
proof(1592, a(ind, n572), rule(1715), [uses(1591, a(ind, n571))]).
substitution(1593, ['X' = ind]).
proof(1593, a(ind, n573), rule(1718), [uses(1592, a(ind, n572))]).
substitution(1594, ['X' = ind]).
proof(1594, a(ind, n574), rule(1721), [uses(1593, a(ind, n573))]).
substitution(1595, ['X' = ind]).
proof(1595, a(ind, n575), rule(1724), [uses(1594, a(ind, n574))]).
substitution(1596, ['X' = ind]).
proof(1596, a(ind, n576), rule(1727), [uses(1595, a(ind, n575))]).
substitution(1597, ['X' = ind]).
proof(1597, a(ind, n577), rule(1730), [uses(1596, a(ind, n576))]).
substitution(1598, ['X' = ind]).
proof(1598, a(ind, n578), rule(1733), [uses(1597, a(ind, n577))]).
substitution(1599, ['X' = ind]).
proof(1599, a(ind, n579), rule(1736), [uses(1598, a(ind, n578))]).
substitution(1600, ['X' = ind]).
proof(1600, a(ind, n580), rule(1739), [uses(1599, a(ind, n579))]).
substitution(1601, ['X' = ind]).
proof(1601, a(ind, n581), rule(1742), [uses(1600, a(ind, n580))]).
substitution(1602, ['X' = ind]).
proof(1602, a(ind, n582), rule(1745), [uses(1601, a(ind, n581))]).
substitution(1603, ['X' = ind]).
proof(1603, a(ind, n583), rule(1748), [uses(1602, a(ind, n582))]).
substitution(1604, ['X' = ind]).
proof(1604, a(ind, n584), rule(1751), [uses(1603, a(ind, n583))]).
substitution(1605, ['X' = ind]).
proof(1605, a(ind, n585), rule(1754), [uses(1604, a(ind, n584))]).
substitution(1606, ['X' = ind]).
proof(1606, a(ind, n586), rule(1757), [uses(1605, a(ind, n585))]).
substitution(1607, ['X' = ind]).
proof(1607, a(ind, n587), rule(1760), [uses(1606, a(ind, n586))]).
substitution(1608, ['X' = ind]).
proof(1608, a(ind, n588), rule(1763), [uses(1607, a(ind, n587))]).
substitution(1609, ['X' = ind]).
proof(1609, a(ind, n589), rule(1766), [uses(1608, a(ind, n588))]).
substitution(1610, ['X' = ind]).
proof(1610, a(ind, n590), rule(1769), [uses(1609, a(ind, n589))]).
substitution(1611, ['X' = ind]).
proof(1611, a(ind, n591), rule(1772), [uses(1610, a(ind, n590))]).
substitution(1612, ['X' = ind]).
proof(1612, a(ind, n592), rule(1775), [uses(1611, a(ind, n591))]).
substitution(1613, ['X' = ind]).
proof(1613, a(ind, n593), rule(1778), [uses(1612, a(ind, n592))]).
substitution(1614, ['X' = ind]).
proof(1614, a(ind, n594), rule(1781), [uses(1613, a(ind, n593))]).
substitution(1615, ['X' = ind]).
proof(1615, a(ind, n595), rule(1784), [uses(1614, a(ind, n594))]).
substitution(1616, ['X' = ind]).
proof(1616, a(ind, n596), rule(1787), [uses(1615, a(ind, n595))]).
substitution(1617, ['X' = ind]).
proof(1617, a(ind, n597), rule(1790), [uses(1616, a(ind, n596))]).
substitution(1618, ['X' = ind]).
proof(1618, a(ind, n598), rule(1793), [uses(1617, a(ind, n597))]).
substitution(1619, ['X' = ind]).
proof(1619, a(ind, n599), rule(1796), [uses(1618, a(ind, n598))]).
substitution(1620, ['X' = ind]).
proof(1620, a(ind, n600), rule(1799), [uses(1619, a(ind, n599))]).
substitution(1621, ['X' = ind]).
proof(1621, a(ind, n601), rule(1802), [uses(1620, a(ind, n600))]).
substitution(1622, ['X' = ind]).
proof(1622, a(ind, n602), rule(1805), [uses(1621, a(ind, n601))]).
substitution(1623, ['X' = ind]).
proof(1623, a(ind, n603), rule(1808), [uses(1622, a(ind, n602))]).
substitution(1624, ['X' = ind]).
proof(1624, a(ind, n604), rule(1811), [uses(1623, a(ind, n603))]).
substitution(1625, ['X' = ind]).
proof(1625, a(ind, n605), rule(1814), [uses(1624, a(ind, n604))]).
substitution(1626, ['X' = ind]).
proof(1626, a(ind, n606), rule(1817), [uses(1625, a(ind, n605))]).
substitution(1627, ['X' = ind]).
proof(1627, a(ind, n607), rule(1820), [uses(1626, a(ind, n606))]).
substitution(1628, ['X' = ind]).
proof(1628, a(ind, n608), rule(1823), [uses(1627, a(ind, n607))]).
substitution(1629, ['X' = ind]).
proof(1629, a(ind, n609), rule(1826), [uses(1628, a(ind, n608))]).
substitution(1630, ['X' = ind]).
proof(1630, a(ind, n610), rule(1829), [uses(1629, a(ind, n609))]).
substitution(1631, ['X' = ind]).
proof(1631, a(ind, n611), rule(1832), [uses(1630, a(ind, n610))]).
substitution(1632, ['X' = ind]).
proof(1632, a(ind, n612), rule(1835), [uses(1631, a(ind, n611))]).
substitution(1633, ['X' = ind]).
proof(1633, a(ind, n613), rule(1838), [uses(1632, a(ind, n612))]).
substitution(1634, ['X' = ind]).
proof(1634, a(ind, n614), rule(1841), [uses(1633, a(ind, n613))]).
substitution(1635, ['X' = ind]).
proof(1635, a(ind, n615), rule(1844), [uses(1634, a(ind, n614))]).
substitution(1636, ['X' = ind]).
proof(1636, a(ind, n616), rule(1847), [uses(1635, a(ind, n615))]).
substitution(1637, ['X' = ind]).
proof(1637, a(ind, n617), rule(1850), [uses(1636, a(ind, n616))]).
substitution(1638, ['X' = ind]).
proof(1638, a(ind, n618), rule(1853), [uses(1637, a(ind, n617))]).
substitution(1639, ['X' = ind]).
proof(1639, a(ind, n619), rule(1856), [uses(1638, a(ind, n618))]).
substitution(1640, ['X' = ind]).
proof(1640, a(ind, n620), rule(1859), [uses(1639, a(ind, n619))]).
substitution(1641, ['X' = ind]).
proof(1641, a(ind, n621), rule(1862), [uses(1640, a(ind, n620))]).
substitution(1642, ['X' = ind]).
proof(1642, a(ind, n622), rule(1865), [uses(1641, a(ind, n621))]).
substitution(1643, ['X' = ind]).
proof(1643, a(ind, n623), rule(1868), [uses(1642, a(ind, n622))]).
substitution(1644, ['X' = ind]).
proof(1644, a(ind, n624), rule(1871), [uses(1643, a(ind, n623))]).
substitution(1645, ['X' = ind]).
proof(1645, a(ind, n625), rule(1874), [uses(1644, a(ind, n624))]).
substitution(1646, ['X' = ind]).
proof(1646, a(ind, n626), rule(1877), [uses(1645, a(ind, n625))]).
substitution(1647, ['X' = ind]).
proof(1647, a(ind, n627), rule(1880), [uses(1646, a(ind, n626))]).
substitution(1648, ['X' = ind]).
proof(1648, a(ind, n628), rule(1883), [uses(1647, a(ind, n627))]).
substitution(1649, ['X' = ind]).
proof(1649, a(ind, n629), rule(1886), [uses(1648, a(ind, n628))]).
substitution(1650, ['X' = ind]).
proof(1650, a(ind, n630), rule(1889), [uses(1649, a(ind, n629))]).
substitution(1651, ['X' = ind]).
proof(1651, a(ind, n631), rule(1892), [uses(1650, a(ind, n630))]).
substitution(1652, ['X' = ind]).
proof(1652, a(ind, n632), rule(1895), [uses(1651, a(ind, n631))]).
substitution(1653, ['X' = ind]).
proof(1653, a(ind, n633), rule(1898), [uses(1652, a(ind, n632))]).
substitution(1654, ['X' = ind]).
proof(1654, a(ind, n634), rule(1901), [uses(1653, a(ind, n633))]).
substitution(1655, ['X' = ind]).
proof(1655, a(ind, n635), rule(1904), [uses(1654, a(ind, n634))]).
substitution(1656, ['X' = ind]).
proof(1656, a(ind, n636), rule(1907), [uses(1655, a(ind, n635))]).
substitution(1657, ['X' = ind]).
proof(1657, a(ind, n637), rule(1910), [uses(1656, a(ind, n636))]).
substitution(1658, ['X' = ind]).
proof(1658, a(ind, n638), rule(1913), [uses(1657, a(ind, n637))]).
substitution(1659, ['X' = ind]).
proof(1659, a(ind, n639), rule(1916), [uses(1658, a(ind, n638))]).
substitution(1660, ['X' = ind]).
proof(1660, a(ind, n640), rule(1919), [uses(1659, a(ind, n639))]).
substitution(1661, ['X' = ind]).
proof(1661, a(ind, n641), rule(1922), [uses(1660, a(ind, n640))]).
substitution(1662, ['X' = ind]).
proof(1662, a(ind, n642), rule(1925), [uses(1661, a(ind, n641))]).
substitution(1663, ['X' = ind]).
proof(1663, a(ind, n643), rule(1928), [uses(1662, a(ind, n642))]).
substitution(1664, ['X' = ind]).
proof(1664, a(ind, n644), rule(1931), [uses(1663, a(ind, n643))]).
substitution(1665, ['X' = ind]).
proof(1665, a(ind, n645), rule(1934), [uses(1664, a(ind, n644))]).
substitution(1666, ['X' = ind]).
proof(1666, a(ind, n646), rule(1937), [uses(1665, a(ind, n645))]).
substitution(1667, ['X' = ind]).
proof(1667, a(ind, n647), rule(1940), [uses(1666, a(ind, n646))]).
substitution(1668, ['X' = ind]).
proof(1668, a(ind, n648), rule(1943), [uses(1667, a(ind, n647))]).
substitution(1669, ['X' = ind]).
proof(1669, a(ind, n649), rule(1946), [uses(1668, a(ind, n648))]).
substitution(1670, ['X' = ind]).
proof(1670, a(ind, n650), rule(1949), [uses(1669, a(ind, n649))]).
substitution(1671, ['X' = ind]).
proof(1671, a(ind, n651), rule(1952), [uses(1670, a(ind, n650))]).
substitution(1672, ['X' = ind]).
proof(1672, a(ind, n652), rule(1955), [uses(1671, a(ind, n651))]).
substitution(1673, ['X' = ind]).
proof(1673, a(ind, n653), rule(1958), [uses(1672, a(ind, n652))]).
substitution(1674, ['X' = ind]).
proof(1674, a(ind, n654), rule(1961), [uses(1673, a(ind, n653))]).
substitution(1675, ['X' = ind]).
proof(1675, a(ind, n655), rule(1964), [uses(1674, a(ind, n654))]).
substitution(1676, ['X' = ind]).
proof(1676, a(ind, n656), rule(1967), [uses(1675, a(ind, n655))]).
substitution(1677, ['X' = ind]).
proof(1677, a(ind, n657), rule(1970), [uses(1676, a(ind, n656))]).
substitution(1678, ['X' = ind]).
proof(1678, a(ind, n658), rule(1973), [uses(1677, a(ind, n657))]).
substitution(1679, ['X' = ind]).
proof(1679, a(ind, n659), rule(1976), [uses(1678, a(ind, n658))]).
substitution(1680, ['X' = ind]).
proof(1680, a(ind, n660), rule(1979), [uses(1679, a(ind, n659))]).
substitution(1681, ['X' = ind]).
proof(1681, a(ind, n661), rule(1982), [uses(1680, a(ind, n660))]).
substitution(1682, ['X' = ind]).
proof(1682, a(ind, n662), rule(1985), [uses(1681, a(ind, n661))]).
substitution(1683, ['X' = ind]).
proof(1683, a(ind, n663), rule(1988), [uses(1682, a(ind, n662))]).
substitution(1684, ['X' = ind]).
proof(1684, a(ind, n664), rule(1991), [uses(1683, a(ind, n663))]).
substitution(1685, ['X' = ind]).
proof(1685, a(ind, n665), rule(1994), [uses(1684, a(ind, n664))]).
substitution(1686, ['X' = ind]).
proof(1686, a(ind, n666), rule(1997), [uses(1685, a(ind, n665))]).
substitution(1687, ['X' = ind]).
proof(1687, a(ind, n667), rule(2000), [uses(1686, a(ind, n666))]).
substitution(1688, ['X' = ind]).
proof(1688, a(ind, n668), rule(2003), [uses(1687, a(ind, n667))]).
substitution(1689, ['X' = ind]).
proof(1689, a(ind, n669), rule(2006), [uses(1688, a(ind, n668))]).
substitution(1690, ['X' = ind]).
proof(1690, a(ind, n670), rule(2009), [uses(1689, a(ind, n669))]).
substitution(1691, ['X' = ind]).
proof(1691, a(ind, n671), rule(2012), [uses(1690, a(ind, n670))]).
substitution(1692, ['X' = ind]).
proof(1692, a(ind, n672), rule(2015), [uses(1691, a(ind, n671))]).
substitution(1693, ['X' = ind]).
proof(1693, a(ind, n673), rule(2018), [uses(1692, a(ind, n672))]).
substitution(1694, ['X' = ind]).
proof(1694, a(ind, n674), rule(2021), [uses(1693, a(ind, n673))]).
substitution(1695, ['X' = ind]).
proof(1695, a(ind, n675), rule(2024), [uses(1694, a(ind, n674))]).
substitution(1696, ['X' = ind]).
proof(1696, a(ind, n676), rule(2027), [uses(1695, a(ind, n675))]).
substitution(1697, ['X' = ind]).
proof(1697, a(ind, n677), rule(2030), [uses(1696, a(ind, n676))]).
substitution(1698, ['X' = ind]).
proof(1698, a(ind, n678), rule(2033), [uses(1697, a(ind, n677))]).
substitution(1699, ['X' = ind]).
proof(1699, a(ind, n679), rule(2036), [uses(1698, a(ind, n678))]).
substitution(1700, ['X' = ind]).
proof(1700, a(ind, n680), rule(2039), [uses(1699, a(ind, n679))]).
substitution(1701, ['X' = ind]).
proof(1701, a(ind, n681), rule(2042), [uses(1700, a(ind, n680))]).
substitution(1702, ['X' = ind]).
proof(1702, a(ind, n682), rule(2045), [uses(1701, a(ind, n681))]).
substitution(1703, ['X' = ind]).
proof(1703, a(ind, n683), rule(2048), [uses(1702, a(ind, n682))]).
substitution(1704, ['X' = ind]).
proof(1704, a(ind, n684), rule(2051), [uses(1703, a(ind, n683))]).
substitution(1705, ['X' = ind]).
proof(1705, a(ind, n685), rule(2054), [uses(1704, a(ind, n684))]).
substitution(1706, ['X' = ind]).
proof(1706, a(ind, n686), rule(2057), [uses(1705, a(ind, n685))]).
substitution(1707, ['X' = ind]).
proof(1707, a(ind, n687), rule(2060), [uses(1706, a(ind, n686))]).
substitution(1708, ['X' = ind]).
proof(1708, a(ind, n688), rule(2063), [uses(1707, a(ind, n687))]).
substitution(1709, ['X' = ind]).
proof(1709, a(ind, n689), rule(2066), [uses(1708, a(ind, n688))]).
substitution(1710, ['X' = ind]).
proof(1710, a(ind, n690), rule(2069), [uses(1709, a(ind, n689))]).
substitution(1711, ['X' = ind]).
proof(1711, a(ind, n691), rule(2072), [uses(1710, a(ind, n690))]).
substitution(1712, ['X' = ind]).
proof(1712, a(ind, n692), rule(2075), [uses(1711, a(ind, n691))]).
substitution(1713, ['X' = ind]).
proof(1713, a(ind, n693), rule(2078), [uses(1712, a(ind, n692))]).
substitution(1714, ['X' = ind]).
proof(1714, a(ind, n694), rule(2081), [uses(1713, a(ind, n693))]).
substitution(1715, ['X' = ind]).
proof(1715, a(ind, n695), rule(2084), [uses(1714, a(ind, n694))]).
substitution(1716, ['X' = ind]).
proof(1716, a(ind, n696), rule(2087), [uses(1715, a(ind, n695))]).
substitution(1717, ['X' = ind]).
proof(1717, a(ind, n697), rule(2090), [uses(1716, a(ind, n696))]).
substitution(1718, ['X' = ind]).
proof(1718, a(ind, n698), rule(2093), [uses(1717, a(ind, n697))]).
substitution(1719, ['X' = ind]).
proof(1719, a(ind, n699), rule(2096), [uses(1718, a(ind, n698))]).
substitution(1720, ['X' = ind]).
proof(1720, a(ind, n700), rule(2099), [uses(1719, a(ind, n699))]).
substitution(1721, ['X' = ind]).
proof(1721, a(ind, n701), rule(2102), [uses(1720, a(ind, n700))]).
substitution(1722, ['X' = ind]).
proof(1722, a(ind, n702), rule(2105), [uses(1721, a(ind, n701))]).
substitution(1723, ['X' = ind]).
proof(1723, a(ind, n703), rule(2108), [uses(1722, a(ind, n702))]).
substitution(1724, ['X' = ind]).
proof(1724, a(ind, n704), rule(2111), [uses(1723, a(ind, n703))]).
substitution(1725, ['X' = ind]).
proof(1725, a(ind, n705), rule(2114), [uses(1724, a(ind, n704))]).
substitution(1726, ['X' = ind]).
proof(1726, a(ind, n706), rule(2117), [uses(1725, a(ind, n705))]).
substitution(1727, ['X' = ind]).
proof(1727, a(ind, n707), rule(2120), [uses(1726, a(ind, n706))]).
substitution(1728, ['X' = ind]).
proof(1728, a(ind, n708), rule(2123), [uses(1727, a(ind, n707))]).
substitution(1729, ['X' = ind]).
proof(1729, a(ind, n709), rule(2126), [uses(1728, a(ind, n708))]).
substitution(1730, ['X' = ind]).
proof(1730, a(ind, n710), rule(2129), [uses(1729, a(ind, n709))]).
substitution(1731, ['X' = ind]).
proof(1731, a(ind, n711), rule(2132), [uses(1730, a(ind, n710))]).
substitution(1732, ['X' = ind]).
proof(1732, a(ind, n712), rule(2135), [uses(1731, a(ind, n711))]).
substitution(1733, ['X' = ind]).
proof(1733, a(ind, n713), rule(2138), [uses(1732, a(ind, n712))]).
substitution(1734, ['X' = ind]).
proof(1734, a(ind, n714), rule(2141), [uses(1733, a(ind, n713))]).
substitution(1735, ['X' = ind]).
proof(1735, a(ind, n715), rule(2144), [uses(1734, a(ind, n714))]).
substitution(1736, ['X' = ind]).
proof(1736, a(ind, n716), rule(2147), [uses(1735, a(ind, n715))]).
substitution(1737, ['X' = ind]).
proof(1737, a(ind, n717), rule(2150), [uses(1736, a(ind, n716))]).
substitution(1738, ['X' = ind]).
proof(1738, a(ind, n718), rule(2153), [uses(1737, a(ind, n717))]).
substitution(1739, ['X' = ind]).
proof(1739, a(ind, n719), rule(2156), [uses(1738, a(ind, n718))]).
substitution(1740, ['X' = ind]).
proof(1740, a(ind, n720), rule(2159), [uses(1739, a(ind, n719))]).
substitution(1741, ['X' = ind]).
proof(1741, a(ind, n721), rule(2162), [uses(1740, a(ind, n720))]).
substitution(1742, ['X' = ind]).
proof(1742, a(ind, n722), rule(2165), [uses(1741, a(ind, n721))]).
substitution(1743, ['X' = ind]).
proof(1743, a(ind, n723), rule(2168), [uses(1742, a(ind, n722))]).
substitution(1744, ['X' = ind]).
proof(1744, a(ind, n724), rule(2171), [uses(1743, a(ind, n723))]).
substitution(1745, ['X' = ind]).
proof(1745, a(ind, n725), rule(2174), [uses(1744, a(ind, n724))]).
substitution(1746, ['X' = ind]).
proof(1746, a(ind, n726), rule(2177), [uses(1745, a(ind, n725))]).
substitution(1747, ['X' = ind]).
proof(1747, a(ind, n727), rule(2180), [uses(1746, a(ind, n726))]).
substitution(1748, ['X' = ind]).
proof(1748, a(ind, n728), rule(2183), [uses(1747, a(ind, n727))]).
substitution(1749, ['X' = ind]).
proof(1749, a(ind, n729), rule(2186), [uses(1748, a(ind, n728))]).
substitution(1750, ['X' = ind]).
proof(1750, a(ind, n730), rule(2189), [uses(1749, a(ind, n729))]).
substitution(1751, ['X' = ind]).
proof(1751, a(ind, n731), rule(2192), [uses(1750, a(ind, n730))]).
substitution(1752, ['X' = ind]).
proof(1752, a(ind, n732), rule(2195), [uses(1751, a(ind, n731))]).
substitution(1753, ['X' = ind]).
proof(1753, a(ind, n733), rule(2198), [uses(1752, a(ind, n732))]).
substitution(1754, ['X' = ind]).
proof(1754, a(ind, n734), rule(2201), [uses(1753, a(ind, n733))]).
substitution(1755, ['X' = ind]).
proof(1755, a(ind, n735), rule(2204), [uses(1754, a(ind, n734))]).
substitution(1756, ['X' = ind]).
proof(1756, a(ind, n736), rule(2207), [uses(1755, a(ind, n735))]).
substitution(1757, ['X' = ind]).
proof(1757, a(ind, n737), rule(2210), [uses(1756, a(ind, n736))]).
substitution(1758, ['X' = ind]).
proof(1758, a(ind, n738), rule(2213), [uses(1757, a(ind, n737))]).
substitution(1759, ['X' = ind]).
proof(1759, a(ind, n739), rule(2216), [uses(1758, a(ind, n738))]).
substitution(1760, ['X' = ind]).
proof(1760, a(ind, n740), rule(2219), [uses(1759, a(ind, n739))]).
substitution(1761, ['X' = ind]).
proof(1761, a(ind, n741), rule(2222), [uses(1760, a(ind, n740))]).
substitution(1762, ['X' = ind]).
proof(1762, a(ind, n742), rule(2225), [uses(1761, a(ind, n741))]).
substitution(1763, ['X' = ind]).
proof(1763, a(ind, n743), rule(2228), [uses(1762, a(ind, n742))]).
substitution(1764, ['X' = ind]).
proof(1764, a(ind, n744), rule(2231), [uses(1763, a(ind, n743))]).
substitution(1765, ['X' = ind]).
proof(1765, a(ind, n745), rule(2234), [uses(1764, a(ind, n744))]).
substitution(1766, ['X' = ind]).
proof(1766, a(ind, n746), rule(2237), [uses(1765, a(ind, n745))]).
substitution(1767, ['X' = ind]).
proof(1767, a(ind, n747), rule(2240), [uses(1766, a(ind, n746))]).
substitution(1768, ['X' = ind]).
proof(1768, a(ind, n748), rule(2243), [uses(1767, a(ind, n747))]).
substitution(1769, ['X' = ind]).
proof(1769, a(ind, n749), rule(2246), [uses(1768, a(ind, n748))]).
substitution(1770, ['X' = ind]).
proof(1770, a(ind, n750), rule(2249), [uses(1769, a(ind, n749))]).
substitution(1771, ['X' = ind]).
proof(1771, a(ind, n751), rule(2252), [uses(1770, a(ind, n750))]).
substitution(1772, ['X' = ind]).
proof(1772, a(ind, n752), rule(2255), [uses(1771, a(ind, n751))]).
substitution(1773, ['X' = ind]).
proof(1773, a(ind, n753), rule(2258), [uses(1772, a(ind, n752))]).
substitution(1774, ['X' = ind]).
proof(1774, a(ind, n754), rule(2261), [uses(1773, a(ind, n753))]).
substitution(1775, ['X' = ind]).
proof(1775, a(ind, n755), rule(2264), [uses(1774, a(ind, n754))]).
substitution(1776, ['X' = ind]).
proof(1776, a(ind, n756), rule(2267), [uses(1775, a(ind, n755))]).
substitution(1777, ['X' = ind]).
proof(1777, a(ind, n757), rule(2270), [uses(1776, a(ind, n756))]).
substitution(1778, ['X' = ind]).
proof(1778, a(ind, n758), rule(2273), [uses(1777, a(ind, n757))]).
substitution(1779, ['X' = ind]).
proof(1779, a(ind, n759), rule(2276), [uses(1778, a(ind, n758))]).
substitution(1780, ['X' = ind]).
proof(1780, a(ind, n760), rule(2279), [uses(1779, a(ind, n759))]).
substitution(1781, ['X' = ind]).
proof(1781, a(ind, n761), rule(2282), [uses(1780, a(ind, n760))]).
substitution(1782, ['X' = ind]).
proof(1782, a(ind, n762), rule(2285), [uses(1781, a(ind, n761))]).
substitution(1783, ['X' = ind]).
proof(1783, a(ind, n763), rule(2288), [uses(1782, a(ind, n762))]).
substitution(1784, ['X' = ind]).
proof(1784, a(ind, n764), rule(2291), [uses(1783, a(ind, n763))]).
substitution(1785, ['X' = ind]).
proof(1785, a(ind, n765), rule(2294), [uses(1784, a(ind, n764))]).
substitution(1786, ['X' = ind]).
proof(1786, a(ind, n766), rule(2297), [uses(1785, a(ind, n765))]).
substitution(1787, ['X' = ind]).
proof(1787, a(ind, n767), rule(2300), [uses(1786, a(ind, n766))]).
substitution(1788, ['X' = ind]).
proof(1788, a(ind, n768), rule(2303), [uses(1787, a(ind, n767))]).
substitution(1789, ['X' = ind]).
proof(1789, a(ind, n769), rule(2306), [uses(1788, a(ind, n768))]).
substitution(1790, ['X' = ind]).
proof(1790, a(ind, n770), rule(2309), [uses(1789, a(ind, n769))]).
substitution(1791, ['X' = ind]).
proof(1791, a(ind, n771), rule(2312), [uses(1790, a(ind, n770))]).
substitution(1792, ['X' = ind]).
proof(1792, a(ind, n772), rule(2315), [uses(1791, a(ind, n771))]).
substitution(1793, ['X' = ind]).
proof(1793, a(ind, n773), rule(2318), [uses(1792, a(ind, n772))]).
substitution(1794, ['X' = ind]).
proof(1794, a(ind, n774), rule(2321), [uses(1793, a(ind, n773))]).
substitution(1795, ['X' = ind]).
proof(1795, a(ind, n775), rule(2324), [uses(1794, a(ind, n774))]).
substitution(1796, ['X' = ind]).
proof(1796, a(ind, n776), rule(2327), [uses(1795, a(ind, n775))]).
substitution(1797, ['X' = ind]).
proof(1797, a(ind, n777), rule(2330), [uses(1796, a(ind, n776))]).
substitution(1798, ['X' = ind]).
proof(1798, a(ind, n778), rule(2333), [uses(1797, a(ind, n777))]).
substitution(1799, ['X' = ind]).
proof(1799, a(ind, n779), rule(2336), [uses(1798, a(ind, n778))]).
substitution(1800, ['X' = ind]).
proof(1800, a(ind, n780), rule(2339), [uses(1799, a(ind, n779))]).
substitution(1801, ['X' = ind]).
proof(1801, a(ind, n781), rule(2342), [uses(1800, a(ind, n780))]).
substitution(1802, ['X' = ind]).
proof(1802, a(ind, n782), rule(2345), [uses(1801, a(ind, n781))]).
substitution(1803, ['X' = ind]).
proof(1803, a(ind, n783), rule(2348), [uses(1802, a(ind, n782))]).
substitution(1804, ['X' = ind]).
proof(1804, a(ind, n784), rule(2351), [uses(1803, a(ind, n783))]).
substitution(1805, ['X' = ind]).
proof(1805, a(ind, n785), rule(2354), [uses(1804, a(ind, n784))]).
substitution(1806, ['X' = ind]).
proof(1806, a(ind, n786), rule(2357), [uses(1805, a(ind, n785))]).
substitution(1807, ['X' = ind]).
proof(1807, a(ind, n787), rule(2360), [uses(1806, a(ind, n786))]).
substitution(1808, ['X' = ind]).
proof(1808, a(ind, n788), rule(2363), [uses(1807, a(ind, n787))]).
substitution(1809, ['X' = ind]).
proof(1809, a(ind, n789), rule(2366), [uses(1808, a(ind, n788))]).
substitution(1810, ['X' = ind]).
proof(1810, a(ind, n790), rule(2369), [uses(1809, a(ind, n789))]).
substitution(1811, ['X' = ind]).
proof(1811, a(ind, n791), rule(2372), [uses(1810, a(ind, n790))]).
substitution(1812, ['X' = ind]).
proof(1812, a(ind, n792), rule(2375), [uses(1811, a(ind, n791))]).
substitution(1813, ['X' = ind]).
proof(1813, a(ind, n793), rule(2378), [uses(1812, a(ind, n792))]).
substitution(1814, ['X' = ind]).
proof(1814, a(ind, n794), rule(2381), [uses(1813, a(ind, n793))]).
substitution(1815, ['X' = ind]).
proof(1815, a(ind, n795), rule(2384), [uses(1814, a(ind, n794))]).
substitution(1816, ['X' = ind]).
proof(1816, a(ind, n796), rule(2387), [uses(1815, a(ind, n795))]).
substitution(1817, ['X' = ind]).
proof(1817, a(ind, n797), rule(2390), [uses(1816, a(ind, n796))]).
substitution(1818, ['X' = ind]).
proof(1818, a(ind, n798), rule(2393), [uses(1817, a(ind, n797))]).
substitution(1819, ['X' = ind]).
proof(1819, a(ind, n799), rule(2396), [uses(1818, a(ind, n798))]).
substitution(1820, ['X' = ind]).
proof(1820, a(ind, n800), rule(2399), [uses(1819, a(ind, n799))]).
substitution(1821, ['X' = ind]).
proof(1821, a(ind, n801), rule(2402), [uses(1820, a(ind, n800))]).
substitution(1822, ['X' = ind]).
proof(1822, a(ind, n802), rule(2405), [uses(1821, a(ind, n801))]).
substitution(1823, ['X' = ind]).
proof(1823, a(ind, n803), rule(2408), [uses(1822, a(ind, n802))]).
substitution(1824, ['X' = ind]).
proof(1824, a(ind, n804), rule(2411), [uses(1823, a(ind, n803))]).
substitution(1825, ['X' = ind]).
proof(1825, a(ind, n805), rule(2414), [uses(1824, a(ind, n804))]).
substitution(1826, ['X' = ind]).
proof(1826, a(ind, n806), rule(2417), [uses(1825, a(ind, n805))]).
substitution(1827, ['X' = ind]).
proof(1827, a(ind, n807), rule(2420), [uses(1826, a(ind, n806))]).
substitution(1828, ['X' = ind]).
proof(1828, a(ind, n808), rule(2423), [uses(1827, a(ind, n807))]).
substitution(1829, ['X' = ind]).
proof(1829, a(ind, n809), rule(2426), [uses(1828, a(ind, n808))]).
substitution(1830, ['X' = ind]).
proof(1830, a(ind, n810), rule(2429), [uses(1829, a(ind, n809))]).
substitution(1831, ['X' = ind]).
proof(1831, a(ind, n811), rule(2432), [uses(1830, a(ind, n810))]).
substitution(1832, ['X' = ind]).
proof(1832, a(ind, n812), rule(2435), [uses(1831, a(ind, n811))]).
substitution(1833, ['X' = ind]).
proof(1833, a(ind, n813), rule(2438), [uses(1832, a(ind, n812))]).
substitution(1834, ['X' = ind]).
proof(1834, a(ind, n814), rule(2441), [uses(1833, a(ind, n813))]).
substitution(1835, ['X' = ind]).
proof(1835, a(ind, n815), rule(2444), [uses(1834, a(ind, n814))]).
substitution(1836, ['X' = ind]).
proof(1836, a(ind, n816), rule(2447), [uses(1835, a(ind, n815))]).
substitution(1837, ['X' = ind]).
proof(1837, a(ind, n817), rule(2450), [uses(1836, a(ind, n816))]).
substitution(1838, ['X' = ind]).
proof(1838, a(ind, n818), rule(2453), [uses(1837, a(ind, n817))]).
substitution(1839, ['X' = ind]).
proof(1839, a(ind, n819), rule(2456), [uses(1838, a(ind, n818))]).
substitution(1840, ['X' = ind]).
proof(1840, a(ind, n820), rule(2459), [uses(1839, a(ind, n819))]).
substitution(1841, ['X' = ind]).
proof(1841, a(ind, n821), rule(2462), [uses(1840, a(ind, n820))]).
substitution(1842, ['X' = ind]).
proof(1842, a(ind, n822), rule(2465), [uses(1841, a(ind, n821))]).
substitution(1843, ['X' = ind]).
proof(1843, a(ind, n823), rule(2468), [uses(1842, a(ind, n822))]).
substitution(1844, ['X' = ind]).
proof(1844, a(ind, n824), rule(2471), [uses(1843, a(ind, n823))]).
substitution(1845, ['X' = ind]).
proof(1845, a(ind, n825), rule(2474), [uses(1844, a(ind, n824))]).
substitution(1846, ['X' = ind]).
proof(1846, a(ind, n826), rule(2477), [uses(1845, a(ind, n825))]).
substitution(1847, ['X' = ind]).
proof(1847, a(ind, n827), rule(2480), [uses(1846, a(ind, n826))]).
substitution(1848, ['X' = ind]).
proof(1848, a(ind, n828), rule(2483), [uses(1847, a(ind, n827))]).
substitution(1849, ['X' = ind]).
proof(1849, a(ind, n829), rule(2486), [uses(1848, a(ind, n828))]).
substitution(1850, ['X' = ind]).
proof(1850, a(ind, n830), rule(2489), [uses(1849, a(ind, n829))]).
substitution(1851, ['X' = ind]).
proof(1851, a(ind, n831), rule(2492), [uses(1850, a(ind, n830))]).
substitution(1852, ['X' = ind]).
proof(1852, a(ind, n832), rule(2495), [uses(1851, a(ind, n831))]).
substitution(1853, ['X' = ind]).
proof(1853, a(ind, n833), rule(2498), [uses(1852, a(ind, n832))]).
substitution(1854, ['X' = ind]).
proof(1854, a(ind, n834), rule(2501), [uses(1853, a(ind, n833))]).
substitution(1855, ['X' = ind]).
proof(1855, a(ind, n835), rule(2504), [uses(1854, a(ind, n834))]).
substitution(1856, ['X' = ind]).
proof(1856, a(ind, n836), rule(2507), [uses(1855, a(ind, n835))]).
substitution(1857, ['X' = ind]).
proof(1857, a(ind, n837), rule(2510), [uses(1856, a(ind, n836))]).
substitution(1858, ['X' = ind]).
proof(1858, a(ind, n838), rule(2513), [uses(1857, a(ind, n837))]).
substitution(1859, ['X' = ind]).
proof(1859, a(ind, n839), rule(2516), [uses(1858, a(ind, n838))]).
substitution(1860, ['X' = ind]).
proof(1860, a(ind, n840), rule(2519), [uses(1859, a(ind, n839))]).
substitution(1861, ['X' = ind]).
proof(1861, a(ind, n841), rule(2522), [uses(1860, a(ind, n840))]).
substitution(1862, ['X' = ind]).
proof(1862, a(ind, n842), rule(2525), [uses(1861, a(ind, n841))]).
substitution(1863, ['X' = ind]).
proof(1863, a(ind, n843), rule(2528), [uses(1862, a(ind, n842))]).
substitution(1864, ['X' = ind]).
proof(1864, a(ind, n844), rule(2531), [uses(1863, a(ind, n843))]).
substitution(1865, ['X' = ind]).
proof(1865, a(ind, n845), rule(2534), [uses(1864, a(ind, n844))]).
substitution(1866, ['X' = ind]).
proof(1866, a(ind, n846), rule(2537), [uses(1865, a(ind, n845))]).
substitution(1867, ['X' = ind]).
proof(1867, a(ind, n847), rule(2540), [uses(1866, a(ind, n846))]).
substitution(1868, ['X' = ind]).
proof(1868, a(ind, n848), rule(2543), [uses(1867, a(ind, n847))]).
substitution(1869, ['X' = ind]).
proof(1869, a(ind, n849), rule(2546), [uses(1868, a(ind, n848))]).
substitution(1870, ['X' = ind]).
proof(1870, a(ind, n850), rule(2549), [uses(1869, a(ind, n849))]).
substitution(1871, ['X' = ind]).
proof(1871, a(ind, n851), rule(2552), [uses(1870, a(ind, n850))]).
substitution(1872, ['X' = ind]).
proof(1872, a(ind, n852), rule(2555), [uses(1871, a(ind, n851))]).
substitution(1873, ['X' = ind]).
proof(1873, a(ind, n853), rule(2558), [uses(1872, a(ind, n852))]).
substitution(1874, ['X' = ind]).
proof(1874, a(ind, n854), rule(2561), [uses(1873, a(ind, n853))]).
substitution(1875, ['X' = ind]).
proof(1875, a(ind, n855), rule(2564), [uses(1874, a(ind, n854))]).
substitution(1876, ['X' = ind]).
proof(1876, a(ind, n856), rule(2567), [uses(1875, a(ind, n855))]).
substitution(1877, ['X' = ind]).
proof(1877, a(ind, n857), rule(2570), [uses(1876, a(ind, n856))]).
substitution(1878, ['X' = ind]).
proof(1878, a(ind, n858), rule(2573), [uses(1877, a(ind, n857))]).
substitution(1879, ['X' = ind]).
proof(1879, a(ind, n859), rule(2576), [uses(1878, a(ind, n858))]).
substitution(1880, ['X' = ind]).
proof(1880, a(ind, n860), rule(2579), [uses(1879, a(ind, n859))]).
substitution(1881, ['X' = ind]).
proof(1881, a(ind, n861), rule(2582), [uses(1880, a(ind, n860))]).
substitution(1882, ['X' = ind]).
proof(1882, a(ind, n862), rule(2585), [uses(1881, a(ind, n861))]).
substitution(1883, ['X' = ind]).
proof(1883, a(ind, n863), rule(2588), [uses(1882, a(ind, n862))]).
substitution(1884, ['X' = ind]).
proof(1884, a(ind, n864), rule(2591), [uses(1883, a(ind, n863))]).
substitution(1885, ['X' = ind]).
proof(1885, a(ind, n865), rule(2594), [uses(1884, a(ind, n864))]).
substitution(1886, ['X' = ind]).
proof(1886, a(ind, n866), rule(2597), [uses(1885, a(ind, n865))]).
substitution(1887, ['X' = ind]).
proof(1887, a(ind, n867), rule(2600), [uses(1886, a(ind, n866))]).
substitution(1888, ['X' = ind]).
proof(1888, a(ind, n868), rule(2603), [uses(1887, a(ind, n867))]).
substitution(1889, ['X' = ind]).
proof(1889, a(ind, n869), rule(2606), [uses(1888, a(ind, n868))]).
substitution(1890, ['X' = ind]).
proof(1890, a(ind, n870), rule(2609), [uses(1889, a(ind, n869))]).
substitution(1891, ['X' = ind]).
proof(1891, a(ind, n871), rule(2612), [uses(1890, a(ind, n870))]).
substitution(1892, ['X' = ind]).
proof(1892, a(ind, n872), rule(2615), [uses(1891, a(ind, n871))]).
substitution(1893, ['X' = ind]).
proof(1893, a(ind, n873), rule(2618), [uses(1892, a(ind, n872))]).
substitution(1894, ['X' = ind]).
proof(1894, a(ind, n874), rule(2621), [uses(1893, a(ind, n873))]).
substitution(1895, ['X' = ind]).
proof(1895, a(ind, n875), rule(2624), [uses(1894, a(ind, n874))]).
substitution(1896, ['X' = ind]).
proof(1896, a(ind, n876), rule(2627), [uses(1895, a(ind, n875))]).
substitution(1897, ['X' = ind]).
proof(1897, a(ind, n877), rule(2630), [uses(1896, a(ind, n876))]).
substitution(1898, ['X' = ind]).
proof(1898, a(ind, n878), rule(2633), [uses(1897, a(ind, n877))]).
substitution(1899, ['X' = ind]).
proof(1899, a(ind, n879), rule(2636), [uses(1898, a(ind, n878))]).
substitution(1900, ['X' = ind]).
proof(1900, a(ind, n880), rule(2639), [uses(1899, a(ind, n879))]).
substitution(1901, ['X' = ind]).
proof(1901, a(ind, n881), rule(2642), [uses(1900, a(ind, n880))]).
substitution(1902, ['X' = ind]).
proof(1902, a(ind, n882), rule(2645), [uses(1901, a(ind, n881))]).
substitution(1903, ['X' = ind]).
proof(1903, a(ind, n883), rule(2648), [uses(1902, a(ind, n882))]).
substitution(1904, ['X' = ind]).
proof(1904, a(ind, n884), rule(2651), [uses(1903, a(ind, n883))]).
substitution(1905, ['X' = ind]).
proof(1905, a(ind, n885), rule(2654), [uses(1904, a(ind, n884))]).
substitution(1906, ['X' = ind]).
proof(1906, a(ind, n886), rule(2657), [uses(1905, a(ind, n885))]).
substitution(1907, ['X' = ind]).
proof(1907, a(ind, n887), rule(2660), [uses(1906, a(ind, n886))]).
substitution(1908, ['X' = ind]).
proof(1908, a(ind, n888), rule(2663), [uses(1907, a(ind, n887))]).
substitution(1909, ['X' = ind]).
proof(1909, a(ind, n889), rule(2666), [uses(1908, a(ind, n888))]).
substitution(1910, ['X' = ind]).
proof(1910, a(ind, n890), rule(2669), [uses(1909, a(ind, n889))]).
substitution(1911, ['X' = ind]).
proof(1911, a(ind, n891), rule(2672), [uses(1910, a(ind, n890))]).
substitution(1912, ['X' = ind]).
proof(1912, a(ind, n892), rule(2675), [uses(1911, a(ind, n891))]).
substitution(1913, ['X' = ind]).
proof(1913, a(ind, n893), rule(2678), [uses(1912, a(ind, n892))]).
substitution(1914, ['X' = ind]).
proof(1914, a(ind, n894), rule(2681), [uses(1913, a(ind, n893))]).
substitution(1915, ['X' = ind]).
proof(1915, a(ind, n895), rule(2684), [uses(1914, a(ind, n894))]).
substitution(1916, ['X' = ind]).
proof(1916, a(ind, n896), rule(2687), [uses(1915, a(ind, n895))]).
substitution(1917, ['X' = ind]).
proof(1917, a(ind, n897), rule(2690), [uses(1916, a(ind, n896))]).
substitution(1918, ['X' = ind]).
proof(1918, a(ind, n898), rule(2693), [uses(1917, a(ind, n897))]).
substitution(1919, ['X' = ind]).
proof(1919, a(ind, n899), rule(2696), [uses(1918, a(ind, n898))]).
substitution(1920, ['X' = ind]).
proof(1920, a(ind, n900), rule(2699), [uses(1919, a(ind, n899))]).
substitution(1921, ['X' = ind]).
proof(1921, a(ind, n901), rule(2702), [uses(1920, a(ind, n900))]).
substitution(1922, ['X' = ind]).
proof(1922, a(ind, n902), rule(2705), [uses(1921, a(ind, n901))]).
substitution(1923, ['X' = ind]).
proof(1923, a(ind, n903), rule(2708), [uses(1922, a(ind, n902))]).
substitution(1924, ['X' = ind]).
proof(1924, a(ind, n904), rule(2711), [uses(1923, a(ind, n903))]).
substitution(1925, ['X' = ind]).
proof(1925, a(ind, n905), rule(2714), [uses(1924, a(ind, n904))]).
substitution(1926, ['X' = ind]).
proof(1926, a(ind, n906), rule(2717), [uses(1925, a(ind, n905))]).
substitution(1927, ['X' = ind]).
proof(1927, a(ind, n907), rule(2720), [uses(1926, a(ind, n906))]).
substitution(1928, ['X' = ind]).
proof(1928, a(ind, n908), rule(2723), [uses(1927, a(ind, n907))]).
substitution(1929, ['X' = ind]).
proof(1929, a(ind, n909), rule(2726), [uses(1928, a(ind, n908))]).
substitution(1930, ['X' = ind]).
proof(1930, a(ind, n910), rule(2729), [uses(1929, a(ind, n909))]).
substitution(1931, ['X' = ind]).
proof(1931, a(ind, n911), rule(2732), [uses(1930, a(ind, n910))]).
substitution(1932, ['X' = ind]).
proof(1932, a(ind, n912), rule(2735), [uses(1931, a(ind, n911))]).
substitution(1933, ['X' = ind]).
proof(1933, a(ind, n913), rule(2738), [uses(1932, a(ind, n912))]).
substitution(1934, ['X' = ind]).
proof(1934, a(ind, n914), rule(2741), [uses(1933, a(ind, n913))]).
substitution(1935, ['X' = ind]).
proof(1935, a(ind, n915), rule(2744), [uses(1934, a(ind, n914))]).
substitution(1936, ['X' = ind]).
proof(1936, a(ind, n916), rule(2747), [uses(1935, a(ind, n915))]).
substitution(1937, ['X' = ind]).
proof(1937, a(ind, n917), rule(2750), [uses(1936, a(ind, n916))]).
substitution(1938, ['X' = ind]).
proof(1938, a(ind, n918), rule(2753), [uses(1937, a(ind, n917))]).
substitution(1939, ['X' = ind]).
proof(1939, a(ind, n919), rule(2756), [uses(1938, a(ind, n918))]).
substitution(1940, ['X' = ind]).
proof(1940, a(ind, n920), rule(2759), [uses(1939, a(ind, n919))]).
substitution(1941, ['X' = ind]).
proof(1941, a(ind, n921), rule(2762), [uses(1940, a(ind, n920))]).
substitution(1942, ['X' = ind]).
proof(1942, a(ind, n922), rule(2765), [uses(1941, a(ind, n921))]).
substitution(1943, ['X' = ind]).
proof(1943, a(ind, n923), rule(2768), [uses(1942, a(ind, n922))]).
substitution(1944, ['X' = ind]).
proof(1944, a(ind, n924), rule(2771), [uses(1943, a(ind, n923))]).
substitution(1945, ['X' = ind]).
proof(1945, a(ind, n925), rule(2774), [uses(1944, a(ind, n924))]).
substitution(1946, ['X' = ind]).
proof(1946, a(ind, n926), rule(2777), [uses(1945, a(ind, n925))]).
substitution(1947, ['X' = ind]).
proof(1947, a(ind, n927), rule(2780), [uses(1946, a(ind, n926))]).
substitution(1948, ['X' = ind]).
proof(1948, a(ind, n928), rule(2783), [uses(1947, a(ind, n927))]).
substitution(1949, ['X' = ind]).
proof(1949, a(ind, n929), rule(2786), [uses(1948, a(ind, n928))]).
substitution(1950, ['X' = ind]).
proof(1950, a(ind, n930), rule(2789), [uses(1949, a(ind, n929))]).
substitution(1951, ['X' = ind]).
proof(1951, a(ind, n931), rule(2792), [uses(1950, a(ind, n930))]).
substitution(1952, ['X' = ind]).
proof(1952, a(ind, n932), rule(2795), [uses(1951, a(ind, n931))]).
substitution(1953, ['X' = ind]).
proof(1953, a(ind, n933), rule(2798), [uses(1952, a(ind, n932))]).
substitution(1954, ['X' = ind]).
proof(1954, a(ind, n934), rule(2801), [uses(1953, a(ind, n933))]).
substitution(1955, ['X' = ind]).
proof(1955, a(ind, n935), rule(2804), [uses(1954, a(ind, n934))]).
substitution(1956, ['X' = ind]).
proof(1956, a(ind, n936), rule(2807), [uses(1955, a(ind, n935))]).
substitution(1957, ['X' = ind]).
proof(1957, a(ind, n937), rule(2810), [uses(1956, a(ind, n936))]).
substitution(1958, ['X' = ind]).
proof(1958, a(ind, n938), rule(2813), [uses(1957, a(ind, n937))]).
substitution(1959, ['X' = ind]).
proof(1959, a(ind, n939), rule(2816), [uses(1958, a(ind, n938))]).
substitution(1960, ['X' = ind]).
proof(1960, a(ind, n940), rule(2819), [uses(1959, a(ind, n939))]).
substitution(1961, ['X' = ind]).
proof(1961, a(ind, n941), rule(2822), [uses(1960, a(ind, n940))]).
substitution(1962, ['X' = ind]).
proof(1962, a(ind, n942), rule(2825), [uses(1961, a(ind, n941))]).
substitution(1963, ['X' = ind]).
proof(1963, a(ind, n943), rule(2828), [uses(1962, a(ind, n942))]).
substitution(1964, ['X' = ind]).
proof(1964, a(ind, n944), rule(2831), [uses(1963, a(ind, n943))]).
substitution(1965, ['X' = ind]).
proof(1965, a(ind, n945), rule(2834), [uses(1964, a(ind, n944))]).
substitution(1966, ['X' = ind]).
proof(1966, a(ind, n946), rule(2837), [uses(1965, a(ind, n945))]).
substitution(1967, ['X' = ind]).
proof(1967, a(ind, n947), rule(2840), [uses(1966, a(ind, n946))]).
substitution(1968, ['X' = ind]).
proof(1968, a(ind, n948), rule(2843), [uses(1967, a(ind, n947))]).
substitution(1969, ['X' = ind]).
proof(1969, a(ind, n949), rule(2846), [uses(1968, a(ind, n948))]).
substitution(1970, ['X' = ind]).
proof(1970, a(ind, n950), rule(2849), [uses(1969, a(ind, n949))]).
substitution(1971, ['X' = ind]).
proof(1971, a(ind, n951), rule(2852), [uses(1970, a(ind, n950))]).
substitution(1972, ['X' = ind]).
proof(1972, a(ind, n952), rule(2855), [uses(1971, a(ind, n951))]).
substitution(1973, ['X' = ind]).
proof(1973, a(ind, n953), rule(2858), [uses(1972, a(ind, n952))]).
substitution(1974, ['X' = ind]).
proof(1974, a(ind, n954), rule(2861), [uses(1973, a(ind, n953))]).
substitution(1975, ['X' = ind]).
proof(1975, a(ind, n955), rule(2864), [uses(1974, a(ind, n954))]).
substitution(1976, ['X' = ind]).
proof(1976, a(ind, n956), rule(2867), [uses(1975, a(ind, n955))]).
substitution(1977, ['X' = ind]).
proof(1977, a(ind, n957), rule(2870), [uses(1976, a(ind, n956))]).
substitution(1978, ['X' = ind]).
proof(1978, a(ind, n958), rule(2873), [uses(1977, a(ind, n957))]).
substitution(1979, ['X' = ind]).
proof(1979, a(ind, n959), rule(2876), [uses(1978, a(ind, n958))]).
substitution(1980, ['X' = ind]).
proof(1980, a(ind, n960), rule(2879), [uses(1979, a(ind, n959))]).
substitution(1981, ['X' = ind]).
proof(1981, a(ind, n961), rule(2882), [uses(1980, a(ind, n960))]).
substitution(1982, ['X' = ind]).
proof(1982, a(ind, n962), rule(2885), [uses(1981, a(ind, n961))]).
substitution(1983, ['X' = ind]).
proof(1983, a(ind, n963), rule(2888), [uses(1982, a(ind, n962))]).
substitution(1984, ['X' = ind]).
proof(1984, a(ind, n964), rule(2891), [uses(1983, a(ind, n963))]).
substitution(1985, ['X' = ind]).
proof(1985, a(ind, n965), rule(2894), [uses(1984, a(ind, n964))]).
substitution(1986, ['X' = ind]).
proof(1986, a(ind, n966), rule(2897), [uses(1985, a(ind, n965))]).
substitution(1987, ['X' = ind]).
proof(1987, a(ind, n967), rule(2900), [uses(1986, a(ind, n966))]).
substitution(1988, ['X' = ind]).
proof(1988, a(ind, n968), rule(2903), [uses(1987, a(ind, n967))]).
substitution(1989, ['X' = ind]).
proof(1989, a(ind, n969), rule(2906), [uses(1988, a(ind, n968))]).
substitution(1990, ['X' = ind]).
proof(1990, a(ind, n970), rule(2909), [uses(1989, a(ind, n969))]).
substitution(1991, ['X' = ind]).
proof(1991, a(ind, n971), rule(2912), [uses(1990, a(ind, n970))]).
substitution(1992, ['X' = ind]).
proof(1992, a(ind, n972), rule(2915), [uses(1991, a(ind, n971))]).
substitution(1993, ['X' = ind]).
proof(1993, a(ind, n973), rule(2918), [uses(1992, a(ind, n972))]).
substitution(1994, ['X' = ind]).
proof(1994, a(ind, n974), rule(2921), [uses(1993, a(ind, n973))]).
substitution(1995, ['X' = ind]).
proof(1995, a(ind, n975), rule(2924), [uses(1994, a(ind, n974))]).
substitution(1996, ['X' = ind]).
proof(1996, a(ind, n976), rule(2927), [uses(1995, a(ind, n975))]).
substitution(1997, ['X' = ind]).
proof(1997, a(ind, n977), rule(2930), [uses(1996, a(ind, n976))]).
substitution(1998, ['X' = ind]).
proof(1998, a(ind, n978), rule(2933), [uses(1997, a(ind, n977))]).
substitution(1999, ['X' = ind]).
proof(1999, a(ind, n979), rule(2936), [uses(1998, a(ind, n978))]).
substitution(2000, ['X' = ind]).
proof(2000, a(ind, n980), rule(2939), [uses(1999, a(ind, n979))]).
substitution(2001, ['X' = ind]).
proof(2001, a(ind, n981), rule(2942), [uses(2000, a(ind, n980))]).
substitution(2002, ['X' = ind]).
proof(2002, a(ind, n982), rule(2945), [uses(2001, a(ind, n981))]).
substitution(2003, ['X' = ind]).
proof(2003, a(ind, n983), rule(2948), [uses(2002, a(ind, n982))]).
substitution(2004, ['X' = ind]).
proof(2004, a(ind, n984), rule(2951), [uses(2003, a(ind, n983))]).
substitution(2005, ['X' = ind]).
proof(2005, a(ind, n985), rule(2954), [uses(2004, a(ind, n984))]).
substitution(2006, ['X' = ind]).
proof(2006, a(ind, n986), rule(2957), [uses(2005, a(ind, n985))]).
substitution(2007, ['X' = ind]).
proof(2007, a(ind, n987), rule(2960), [uses(2006, a(ind, n986))]).
substitution(2008, ['X' = ind]).
proof(2008, a(ind, n988), rule(2963), [uses(2007, a(ind, n987))]).
substitution(2009, ['X' = ind]).
proof(2009, a(ind, n989), rule(2966), [uses(2008, a(ind, n988))]).
substitution(2010, ['X' = ind]).
proof(2010, a(ind, n990), rule(2969), [uses(2009, a(ind, n989))]).
substitution(2011, ['X' = ind]).
proof(2011, a(ind, n991), rule(2972), [uses(2010, a(ind, n990))]).
substitution(2012, ['X' = ind]).
proof(2012, a(ind, n992), rule(2975), [uses(2011, a(ind, n991))]).
substitution(2013, ['X' = ind]).
proof(2013, a(ind, n993), rule(2978), [uses(2012, a(ind, n992))]).
substitution(2014, ['X' = ind]).
proof(2014, a(ind, n994), rule(2981), [uses(2013, a(ind, n993))]).
substitution(2015, ['X' = ind]).
proof(2015, a(ind, n995), rule(2984), [uses(2014, a(ind, n994))]).
substitution(2016, ['X' = ind]).
proof(2016, a(ind, n996), rule(2987), [uses(2015, a(ind, n995))]).
substitution(2017, ['X' = ind]).
proof(2017, a(ind, n997), rule(2990), [uses(2016, a(ind, n996))]).
substitution(2018, ['X' = ind]).
proof(2018, a(ind, n998), rule(2993), [uses(2017, a(ind, n997))]).
substitution(2019, ['X' = ind]).
proof(2019, a(ind, n999), rule(2996), [uses(2018, a(ind, n998))]).
substitution(2020, ['X' = ind]).
proof(2020, a(ind, n1000), rule(2999), [uses(2019, a(ind, n999))]).
substitution(2021, ['X' = ind]).
proof(2021, a(ind, a2), rule(3002), [uses(2020, a(ind, n1000))]).
substitution(2022, []).
proof(2022, holds_result(test, true), rule(3003), [uses(2021, a(ind, a2))]).
substitution(2023, []).
proof(2023, solution([]), query, [uses(2022, holds_result(test, true))]).
