% Prolog result format 4
query(1,
      meal(_0, _1, _2, _3, _4, _5),
      ['M' = _0, 'P' = _1, 'N' = _2, 'S' = _3, 'Lf' = _4, 'Rf' = _5]).
result(1, complete, 15).
answer(1, ['M' = mp1_1, 'P' = p1, 'N' = 1, 'S' = s1, 'Lf' = f51, 'Rf' = f12]).
answer(1, ['M' = mp3_1, 'P' = p3, 'N' = 1, 'S' = s1, 'Lf' = f23, 'Rf' = f34]).
answer(1, ['M' = mp4_1, 'P' = p4, 'N' = 1, 'S' = s2, 'Lf' = f34, 'Rf' = f45]).
answer(1, ['M' = mp2_1, 'P' = p2, 'N' = 1, 'S' = s2, 'Lf' = f12, 'Rf' = f23]).
answer(1, ['M' = mp5_1, 'P' = p5, 'N' = 1, 'S' = s3, 'Lf' = f45, 'Rf' = f51]).
answer(1, ['M' = mp1_2, 'P' = p1, 'N' = 2, 'S' = s4, 'Lf' = f51, 'Rf' = f12]).
answer(1, ['M' = mp3_2, 'P' = p3, 'N' = 2, 'S' = s4, 'Lf' = f23, 'Rf' = f34]).
answer(1, ['M' = mp2_2, 'P' = p2, 'N' = 2, 'S' = s5, 'Lf' = f12, 'Rf' = f23]).
answer(1, ['M' = mp4_2, 'P' = p4, 'N' = 2, 'S' = s5, 'Lf' = f34, 'Rf' = f45]).
answer(1, ['M' = mp5_2, 'P' = p5, 'N' = 2, 'S' = s6, 'Lf' = f45, 'Rf' = f51]).
answer(1, ['M' = mp3_3, 'P' = p3, 'N' = 3, 'S' = s7, 'Lf' = f23, 'Rf' = f34]).
answer(1, ['M' = mp1_3, 'P' = p1, 'N' = 3, 'S' = s7, 'Lf' = f51, 'Rf' = f12]).
answer(1, ['M' = mp4_3, 'P' = p4, 'N' = 3, 'S' = s8, 'Lf' = f34, 'Rf' = f45]).
answer(1, ['M' = mp2_3, 'P' = p2, 'N' = 3, 'S' = s8, 'Lf' = f12, 'Rf' = f23]).
answer(1, ['M' = mp5_3, 'P' = p5, 'N' = 3, 'S' = s9, 'Lf' = f45, 'Rf' = f51]).
query(2, send_fork(_0, _1, _2, _3), ['C' = _0, 'From' = _1, 'To' = _2, 'F' = _3]).
result(2, complete, 26).
answer(2, ['C' = c0, 'From' = p2, 'To' = p3, 'F' = f23]).
answer(2, ['C' = c2, 'From' = p1, 'To' = p2, 'F' = f12]).
answer(2, ['C' = c2, 'From' = p3, 'To' = p4, 'F' = f34]).
answer(2, ['C' = c4, 'From' = p4, 'To' = p5, 'F' = f45]).
answer(2, ['C' = c4, 'From' = p1, 'To' = p5, 'F' = f51]).
answer(2, ['C' = c2, 'From' = p3, 'To' = p2, 'F' = f23]).
answer(2, ['C' = c6, 'From' = p4, 'To' = p3, 'F' = f34]).
answer(2, ['C' = c6, 'From' = p2, 'To' = p1, 'F' = f12]).
answer(2, ['C' = c6, 'From' = p5, 'To' = p1, 'F' = f51]).
answer(2, ['C' = c8, 'From' = p5, 'To' = p4, 'F' = f45]).
answer(2, ['C' = c6, 'From' = p2, 'To' = p3, 'F' = f23]).
answer(2, ['C' = c8, 'From' = p3, 'To' = p4, 'F' = f34]).
answer(2, ['C' = c8, 'From' = p1, 'To' = p2, 'F' = f12]).
answer(2, ['C' = c8, 'From' = p3, 'To' = p2, 'F' = f23]).
answer(2, ['C' = c10, 'From' = p4, 'To' = p5, 'F' = f45]).
answer(2, ['C' = c10, 'From' = p1, 'To' = p5, 'F' = f51]).
answer(2, ['C' = c12, 'From' = p4, 'To' = p3, 'F' = f34]).
answer(2, ['C' = c12, 'From' = p2, 'To' = p1, 'F' = f12]).
answer(2, ['C' = c12, 'From' = p2, 'To' = p3, 'F' = f23]).
answer(2, ['C' = c12, 'From' = p5, 'To' = p1, 'F' = f51]).
answer(2, ['C' = c14, 'From' = p5, 'To' = p4, 'F' = f45]).
answer(2, ['C' = c14, 'From' = p3, 'To' = p4, 'F' = f34]).
answer(2, ['C' = c14, 'From' = p1, 'To' = p2, 'F' = f12]).
answer(2, ['C' = c14, 'From' = p3, 'To' = p2, 'F' = f23]).
answer(2, ['C' = c16, 'From' = p4, 'To' = p5, 'F' = f45]).
answer(2, ['C' = c16, 'From' = p1, 'To' = p5, 'F' = f51]).
query(3, everyone_ate_times_3(_0), ['Result' = _0]).
result(3, complete, 1).
answer(3, ['Result' = true]).
