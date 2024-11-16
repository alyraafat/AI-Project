:- include("KB.pl").
% :- include("KB2.pl").

% contains(bottle(T,B), color, bottleNum, s0):-
%     % writeln(bottleNum),
%     (bottleNum=1, bottle1(T1,B1), T=T1, B=B1); 
%     (bottleNum=2, bottle2(T2,B2), T=T2, B=B2); 
%     (bottleNum=3, bottle3(T3,B3), T=T3, B=B3).

% contains(bottle(T,B), color, bottleNum, result(a, S)):-
%     writeln(bottleNum),
%     (
%         \+ contains(bottle(T,B), color, bottleNum, S),
%         T=e,
%         (
%             B=e;
%             B=color
%         )
%     );
%     (
%         contains(bottle(T,B), color, bottleNum, S),
%         (
%             a = pour(I,J),
%             I\=bottleNum,
%             J\=bottleNum   
%         )
%     ).




% goalHelper(S):-
%     writeln(S),
%     contains(bottle(C1,C1), color, 1, S),
%     writeln(S),
%     contains(bottle(C2,C2), color, 2, S),
%     % writeln(S),
%     contains(bottle(C3,C3), color, 3, S).

% empty(bottle(T,B), bottleNum, s):-
%     top(bottle(T,B), bottleNum, e, s),
%     bottom(bottle(T,B), bottleNum, e, s).

% full(bottle(T,B), bottleNum, s):-
%     top(bottle(T,B), bottleNum, c1, s),
%     bottom(bottle(T,B), bottleNum, c2, s),
%     c1\=e,
%     c2\=e.
 
% bottom(bottle(_,c), bottleNum, c, s0):-
%     (bottleNum=1, bottle1(_,c));
%     (bottleNum=2, bottle2(_,c));
%     (bottleNum=3, bottle3(_,c)).

% bottom(bottle(T,B), bottleNum, c, result(a,s)):-
%     (
%         \+ bottom(bottle(T,B), bottleNum, c, s),
%         empty(bottle(T,B), bottleNum, s),
%         a=pour(I,J),
%         I\=bottleNum,
%         J=bottleNum,
%         b2 = bottle(_,_),
%         (
%             top(b2, I, c, s);
%             (
%                 bottom(b2,I,c,s),
%                 top(b2,I,e,s)
%             )
%         )
%     );
%     (
%         bottom(bottle(T,B), bottleNum, c, s),
%         % pour between 2 other bottles
%         (
%             a=pour(I,J),
%             I\=bottleNum,
%             J\=bottleNum,
%             I\=J
%         );
%         % pour from curr bottle to another bottle (successfully)
%         % or the other bottle is full or (top is empty and bottom is any other color than c) (unsuccessful)
%         (
%             a=pour(I,J),
%             I\=J,
%             I=bottleNum,
%             b2 = bottle(_,_),
%             (
%                 top(bottle(T,B), I, c2, s),
%                 c2\=e,
%                 top(b2, J, e, s),
%                 bottom(b2, J, c2, s)
%             );
%             \+ (
%                 full(b2, J, s)
%             );
%             \+ (
%                 top(b2, J, e, s),
%                 bottom(b2, J, c2, s),
%                 c2\=c 
%             )
%         );
%         % pour from another bottle to curr bottle (successfully)
%         % or the curr bottle is full or other bottle is empty or other botle has another color than c in top or in bottom if top is empty (unsuccessful)
%         (
%             a=pour(I,J),
%             I\=J,
%             J=bottleNum,
%             b2 = bottle(_,_),
%             (
%                 top(bottle(T,B), J, e, s),
%                 % bottom(bottle(T,B), J, c, s), mentioned above
%                 (
%                     (
%                         top(b2, I, e, s),
%                         bottom(b2, I, c, s)
%                     );
%                     top(b2, I, c, s)
%                 )
%             );
%             (
%                 (
%                     full(bottle(T,B), J, s)
%                 );
%                 (
%                     empty(b2, I, s)
%                 );
%                 (
%                     top(bottle(T,B), J, e, s),
%                     % bottom(bottle(T,B), J, c, s), mentioned above
%                     (
%                         (
%                             top(b2, I, e, s),
%                             bottom(b2, I, c2, s)
%                         );
%                         top(b2, I, c2, s)
%                     ),
%                     c2\=c
%                 )
%             )
            
%         )
%     ).

% top(bottle(c, _), bottleNum, c, s0):-
%     writeln(c),
%     (bottleNum=1, bottle1(c, _));
%     (bottleNum=2, bottle2(c, _));
%     (bottleNum=3, bottle3(c, _)).

% top(bottle(T,B), bottleNum, c, result(a,s)):-
%     (
%         \+ top(bottle(T,B), bottleNum, c, s),
%         a=pour(I,J),
%         I\=J,
%         J=bottleNum,
%         b2 = bottle(_,_),
%         top(bottle(T,B), J, e, s),
%         bottom(bottle(T,B), J, c, s),
%         (
%             (
%                 top(b2, I, e, s),
%                 bottom(b2, I, c, s)
%             );
%             top(b2, I, c, s)
%         )
%     );
%     (
%         top(bottle(T,B), bottleNum, c, s),
%         % pour between 2 other bottles
%         (
%             a=pour(I,J),
%             I\=J,
%             I\=bottleNum,
%             J\=bottleNum
%         );
%         % pour from curr bottle to other bottle unsuccessfully
%         (
%             a=pour(I,J),
%             I\=J,
%             I=bottleNum,
%             b2 = bottle(_,_),
%             (
%                 full(b2, J, s)
%             );
%             (
%                 top(b2, J, e, s),
%                 bottom(b2, J, c2, s),
%                 c2\=c
%             )
%         );
%         % pour from other bottle to this bottle unsuccessfully
%         (
%             a=pour(I,J),
%             I\=J,
%             J=bottleNum,
%             b2 = bottle(_,_),
%             (
%                 full(bottle(T,B), J, s)
%             );
%             (
%                 empty(b2, I, s)
%             )
%         )
%     ).

% goalHelper(S):-
%     writeln(S),
%     (
%         b1 = bottle(A1,A1),
%         top(b1, 1, c1, S), 
%         bottom(b1, 1, c1, S)
%     ),
%     (
%         b2 = bottle(A2,A2),
%         top(b2, 2, c2, S), 
%         bottom(b2, 2, c2, S)
%     ),
%     (
%         b3 = bottle(A3,A3),
%         top(b3, 3, c3, S), 
%         bottom(b3, 3, c3, S)
%     ).
%------------------------------------------------------------------
% Fluents: top(BottleNum, Color, S), bottom(BottleNum, Color, S)



empty(BottleNum, S) :-
    top(BottleNum, e, S),
    bottom(BottleNum, e, S).

full(BottleNum, S) :-
    top(BottleNum, C1, S),
    bottom(BottleNum, C2, S),
    C1 \= e,
    C2 \= e.


poss(pour(I, J), S) :-
    I \= J,
    (
        top(I, ColorI, S);
        (
            top(I, e, S),
            bottom(I, ColorI, S)
        )
    ),
    ColorI \= e,
    top(J, e, S),
    (
        bottom(J, e, S);
        bottom(J, ColorI, S)
    ).

% Successor state axiom for top
% Initial state for s0
top(1, T1, s0) :- bottle1(T1, _).
top(2, T2, s0) :- bottle2(T2, _).
top(3, T3, s0) :- bottle3(T3, _).

% situation(S):- S=s0.
% situation(result(Action, S)):- situation(S).

top(BottleNum, NewColor, result(Action, S)):-
    % writeln(S),
    (
        \+ top(BottleNum, NewColor, S),
        Action = pour(_, BottleNum),
        poss(Action, S)
    );
    (
        top(BottleNum, NewColor, S),
        (
            (
                Action = pour(I1, J1),
                I1\=BottleNum,
                J1\=BottleNum,
                poss(Action, S)
            );
            (
                Action = pour(I2, J2),
                I2=BottleNum,
                J2\=BottleNum,
                \+ poss(Action, S)
            );
            (
                Action = pour(I3, J3),
                I3\=BottleNum,
                J3=BottleNum,
                \+ poss(Action, S)
            )
        )
        
    ).


% Successor state axiom for bottom

bottom(1, B1, s0) :- bottle1(_, B1).
bottom(2, B2, s0) :- bottle2(_, B2).
bottom(3, B3, s0) :- bottle3(_, B3).

bottom(BottleNum, NewColor, result(Action, S)):-
    % writeln(S),
    (
        \+ bottom(BottleNum, NewColor, S),
        % Action=pour(I,J),
        poss(Action, S)
    );
    (
        bottom(BottleNum, NewColor, S),
        (
            (
                Action=pour(I1,J1),
                I1\=BottleNum,
                J1\=BottleNum,
                poss(Action, S)
            );
            (
                Action=pour(I2,J2),
                I2=BottleNum,
                J2\=BottleNum,
                (
                    \+ poss(Action, S);
                    (
                        top(BottleNum, SomeColor, S),
                        SomeColor\=e,
                        poss(Action, S)
                    )
                )
            );
            (
                Action=pour(I3,J3),
                I3\=BottleNum,
                J3=BottleNum,
                (
                    \+ poss(Action, S);
                    (
                        top(BottleNum, e, S),
                        poss(Action, S)
                    )
                )
            )
        )
        
    ).

% Goal condition
goalHelper(S) :-
    top(1, C1, S), bottom(1, C1, S),
    top(2, C2, S), bottom(2, C2, S),
    top(3, C3, S), bottom(3, C3, S).


ids(S,L):-
   (call_with_depth_limit(goalHelper(S),L,R), number(R));
   (call_with_depth_limit(goalHelper(S),L,R), R=depth_limit_exceeded, L1 is L+1, ids(S,L1)).


goal(S):-
    ids(S, 0).


    
