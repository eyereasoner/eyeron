# Eyelang result format 2
query(1, [call(meal(?v0, ?v1, ?v2, ?v3, ?v4, ?v5))], [binding("m", ?v0), binding("p", ?v1), binding("n", ?v2), binding("s", ?v3), binding("lf", ?v4), binding("rf", ?v5)]).
result(1, complete, 15).
answer(1, [binding("m", mp1_1), binding("p", p1), binding("n", 1), binding("s", s1), binding("lf", f51), binding("rf", f12)]).
answer(1, [binding("m", mp3_1), binding("p", p3), binding("n", 1), binding("s", s1), binding("lf", f23), binding("rf", f34)]).
answer(1, [binding("m", mp4_1), binding("p", p4), binding("n", 1), binding("s", s2), binding("lf", f34), binding("rf", f45)]).
answer(1, [binding("m", mp2_1), binding("p", p2), binding("n", 1), binding("s", s2), binding("lf", f12), binding("rf", f23)]).
answer(1, [binding("m", mp5_1), binding("p", p5), binding("n", 1), binding("s", s3), binding("lf", f45), binding("rf", f51)]).
answer(1, [binding("m", mp1_2), binding("p", p1), binding("n", 2), binding("s", s4), binding("lf", f51), binding("rf", f12)]).
answer(1, [binding("m", mp3_2), binding("p", p3), binding("n", 2), binding("s", s4), binding("lf", f23), binding("rf", f34)]).
answer(1, [binding("m", mp2_2), binding("p", p2), binding("n", 2), binding("s", s5), binding("lf", f12), binding("rf", f23)]).
answer(1, [binding("m", mp4_2), binding("p", p4), binding("n", 2), binding("s", s5), binding("lf", f34), binding("rf", f45)]).
answer(1, [binding("m", mp5_2), binding("p", p5), binding("n", 2), binding("s", s6), binding("lf", f45), binding("rf", f51)]).
answer(1, [binding("m", mp3_3), binding("p", p3), binding("n", 3), binding("s", s7), binding("lf", f23), binding("rf", f34)]).
answer(1, [binding("m", mp1_3), binding("p", p1), binding("n", 3), binding("s", s7), binding("lf", f51), binding("rf", f12)]).
answer(1, [binding("m", mp4_3), binding("p", p4), binding("n", 3), binding("s", s8), binding("lf", f34), binding("rf", f45)]).
answer(1, [binding("m", mp2_3), binding("p", p2), binding("n", 3), binding("s", s8), binding("lf", f12), binding("rf", f23)]).
answer(1, [binding("m", mp5_3), binding("p", p5), binding("n", 3), binding("s", s9), binding("lf", f45), binding("rf", f51)]).
query(2, [call(send_fork(?v0, ?v1, ?v2, ?v3))], [binding("c", ?v0), binding("from", ?v1), binding("to", ?v2), binding("f", ?v3)]).
result(2, complete, 26).
answer(2, [binding("c", c0), binding("from", p2), binding("to", p3), binding("f", f23)]).
answer(2, [binding("c", c2), binding("from", p1), binding("to", p2), binding("f", f12)]).
answer(2, [binding("c", c2), binding("from", p3), binding("to", p4), binding("f", f34)]).
answer(2, [binding("c", c4), binding("from", p4), binding("to", p5), binding("f", f45)]).
answer(2, [binding("c", c4), binding("from", p1), binding("to", p5), binding("f", f51)]).
answer(2, [binding("c", c2), binding("from", p3), binding("to", p2), binding("f", f23)]).
answer(2, [binding("c", c6), binding("from", p4), binding("to", p3), binding("f", f34)]).
answer(2, [binding("c", c6), binding("from", p2), binding("to", p1), binding("f", f12)]).
answer(2, [binding("c", c6), binding("from", p5), binding("to", p1), binding("f", f51)]).
answer(2, [binding("c", c8), binding("from", p5), binding("to", p4), binding("f", f45)]).
answer(2, [binding("c", c6), binding("from", p2), binding("to", p3), binding("f", f23)]).
answer(2, [binding("c", c8), binding("from", p3), binding("to", p4), binding("f", f34)]).
answer(2, [binding("c", c8), binding("from", p1), binding("to", p2), binding("f", f12)]).
answer(2, [binding("c", c8), binding("from", p3), binding("to", p2), binding("f", f23)]).
answer(2, [binding("c", c10), binding("from", p4), binding("to", p5), binding("f", f45)]).
answer(2, [binding("c", c10), binding("from", p1), binding("to", p5), binding("f", f51)]).
answer(2, [binding("c", c12), binding("from", p4), binding("to", p3), binding("f", f34)]).
answer(2, [binding("c", c12), binding("from", p2), binding("to", p1), binding("f", f12)]).
answer(2, [binding("c", c12), binding("from", p2), binding("to", p3), binding("f", f23)]).
answer(2, [binding("c", c12), binding("from", p5), binding("to", p1), binding("f", f51)]).
answer(2, [binding("c", c14), binding("from", p5), binding("to", p4), binding("f", f45)]).
answer(2, [binding("c", c14), binding("from", p3), binding("to", p4), binding("f", f34)]).
answer(2, [binding("c", c14), binding("from", p1), binding("to", p2), binding("f", f12)]).
answer(2, [binding("c", c14), binding("from", p3), binding("to", p2), binding("f", f23)]).
answer(2, [binding("c", c16), binding("from", p4), binding("to", p5), binding("f", f45)]).
answer(2, [binding("c", c16), binding("from", p1), binding("to", p5), binding("f", f51)]).
query(3, [call(everyone_ate_times_3(?v0))], [binding("result", ?v0)]).
result(3, complete, 1).
answer(3, [binding("result", true)]).
