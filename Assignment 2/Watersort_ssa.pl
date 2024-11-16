:- include("KB.pl").
% :- include("KB2.pl").

empty(BottleNum, S) :-
    top(BottleNum, e, S),
    bottom(BottleNum, e, S).

full(BottleNum, S) :-
    top(BottleNum, C1, S),
    bottom(BottleNum, C2, S),
    C1 \= e,
    C2 \= e.


poss(pour(I, J), S) :-
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
    ),
    I \= J.

possibleForTop(pour(I, J), S):-
    (
        top(I, ColorI, S);
        (
            top(I, e, S),
            bottom(I, ColorI, S)
        )
    ),
    ColorI \= e,
    top(J, e, S),
    bottom(J, ColorI, S),
    I \= J. 

% Successor state axiom for top
% Initial state for s0
top(1, T1, s0) :- bottle1(T1, _).
top(2, T2, s0) :- bottle2(T2, _).
top(3, T3, s0) :- bottle3(T3, _).

% situation(S):- S=s0.
% situation(result(_, S)):- situation(S).

top(BottleNum, NewColor, result(Action, S)):-
    (
        \+ top(BottleNum, NewColor, S),
        Action = pour(_, BottleNum),
        possibleForTop(Action, S)
    );
    (
        top(BottleNum, NewColor, S),
        (
            (
                Action = pour(I1, J1),
                poss(Action, S),
                I1\=BottleNum,
                J1\=BottleNum
            )
            % ;
            % (
            %     Action = pour(I2, J2),
            %     I2=BottleNum,
            %     J2\=BottleNum,
            %     (
            %         full(J2, S);
            %         (
            %             top(J2, e, S),
            %             bottom(J2, OtherColor, S),
            %             OtherColor \= NewColor
            %         )
            %     )
            % );
            % (
            %     Action = pour(I3, J3),
            %     I3\=BottleNum,
            %     J3=BottleNum,
            %     (
            %         full(BottleNum, S);
            %         empty(I3, S)
            %     )
            % )
        )
    ).


% Successor state axiom for bottom
possibleForBottom(pour(I, J), S):-
    (
        top(I, ColorI, S);
        (
            top(I, e, S),
            bottom(I, ColorI, S)
        )
    ),
    ColorI \= e,
    top(J, e, S),
    bottom(J, e, S),
    I \= J. 

bottom(1, B1, s0) :- bottle1(_, B1).
bottom(2, B2, s0) :- bottle2(_, B2).
bottom(3, B3, s0) :- bottle3(_, B3).

bottom(BottleNum, NewColor, result(Action, S)):-
    % writeln(S),
    (
        \+ bottom(BottleNum, NewColor, S),
        Action=pour(_ ,BottleNum),
        possibleForBottom(Action, S)

    );
    (
        bottom(BottleNum, NewColor, S),
        (
            (
                Action=pour(I1,J1),
                poss(Action, S),
                I1\=BottleNum,
                J1\=BottleNum
            );
            (
                Action=pour(I2,J2),
                (
                    % successful
                    (
                        top(BottleNum, SomeColor, S),
                        SomeColor\=e,
                        (
                            empty(J2, e, S);
                            (
                                top(J2, e, S),
                                bottom(J2, SomeColor, S)
                            )
                        )
                    )
                    % ;
                    % (
                    %     full(J2, S)
                    % );
                    % (
                    %     top(J2, e, S),
                    %     bottom(J2, OtherColor, S),
                    %     OtherColor\=NewColor
                    % )
                ),
                I2=BottleNum,
                J2\=BottleNum
            );
            (
                Action=pour(I3,J3),
                (
                    \+ possibleForBottom(Action, S);
                    top(BottleNum, e, S)
                ),
                I3\=BottleNum,
                J3=BottleNum
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
    ids(S, 1000).


    
