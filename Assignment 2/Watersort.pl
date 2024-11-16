:- include("KB.pl").


sameColor(bottle(T,B)) :- T = B.

isEmpty(bottle(T, B)) :-  T = e, B = e.

pour(I, J, I2, J2) :-
    \+ isEmpty(I),
    I = bottle(T1, B1), 
    J = bottle(T2, B2),
    T2 = e,
    (
        (
            T1 \= e, 
            (
                (T1 = B2, J2 = bottle(T1, B2));
                (B2 = e, J2 = bottle(e, T1))
            ),
            I2 = bottle(e, B1)
        );
        (
            T1 = e, 
            (
                (B1 = B2, J2 = bottle(B1, B2));
                (B2 = e, J2 = bottle(e, B1))
            ),
            I2 = bottle(e, e)
        )
    ).


goal(S) :- 
    bottle1(T1,B1), bottle2(T2,B2), bottle3(T3,B3),
    B = [bottle(T1, B1), bottle(T2, B2), bottle(T3, B3)],
    goalHelper(B, s0, S).

goalHelper([H1,H2,H3], S, S):- 
    sameColor(H1),
    sameColor(H2),
    sameColor(H3),
    writeln([H1, H2, H3]).
    % writeln(S).

goalHelper([H1, H2, H3], S, SFinal) :-
    % writeln([H1, H2, H3]),
    % writeln(same_color(H1)),
    (\+ sameColor(H1); \+ sameColor(H2); \+ sameColor(H3)),
    (
        (pour(H1, H2, I2, J2), goalHelper([I2, J2, H3], result(pour(1, 2), S), SFinal));
        (pour(H2, H1, I2, J2), goalHelper([I2, J2, H3], result(pour(2, 1), S), SFinal));
        (pour(H1, H3, I2, J2), goalHelper([I2, H2, J2], result(pour(1, 3), S), SFinal));
        (pour(H3, H1, I2, J2), goalHelper([I2, H2, J2], result(pour(3, 1), S), SFinal));
        (pour(H2, H3, I2, J2), goalHelper([H1, I2, J2], result(pour(2, 3), S), SFinal));
        (pour(H3, H2, I2, J2), goalHelper([H1, I2, J2], result(pour(3, 2), S), SFinal))
    ).

ids(S,L):-
   (call_with_depth_limit(goal(S),L,R), number(R));
   (call_with_depth_limit(goal(S),L,R), R=depth_limit_exceeded, L1 is L+1, ids(S,L1)).