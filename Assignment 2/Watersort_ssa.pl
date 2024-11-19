:- include("KB.pl").
% :- include("KB2.pl").

empty( BottleNum, S) :-
    top( BottleNum, e, S),
    bottom( BottleNum, e, S).

full(BottleNum, S) :-
    top(BottleNum, C1, S),
    bottom(BottleNum, C2, S),
    C1 \= e,
    C2 \= e.


poss(pour(I, J), ColorI, S) :-
    (
        top(I, ColorI, S);
        (
            top(I, e, S),
            bottom(I, ColorI, S)
        )
    ),
    top(J, e, S),
    (
        bottom(J, e, S);
        bottom(J, ColorI, S)
    ),
    ColorI \= e,
    I \= J.

possibleForTop(pour(I, J), ColorI, S):-
    writeln(['Color possible for top', ColorI]),
    (
        top(I, ColorI, S);
        (
            top(I, e, S),
            bottom(I, ColorI, S)
        )
    ),
    top(J, e, S),
    bottom(J, ColorI, S),
    ColorI \= e,
    I \= J,
    writeln(['Color possible for top', ColorI]).


situation(S):- S=s0.
situation(result(_, S)):- situation(S).

% Successor state axiom for top
% Initial state for s0
top(1, T1, s0) :- bottle1(T1, _).
top(2, T2, s0) :- bottle2(T2, _).
top(3, T3, s0) :- bottle3(T3, _).

% effect axiom
top(BottleNum, NewColor, result(Action, S)):-
    % writeln(['The value of S in top is: ~w~n', S, NewColor]),
    \+ top(BottleNum, NewColor, S),
    writeln(['The value of S in top is: ~w~n', S, NewColor]),
    Action = pour(_, BottleNum),
    possibleForTop(Action, NewColor, S).

% frame axiom
% top( BottleNum, NewColor, result(_, S)):-  
%     top( BottleNum, NewColor, S).
    % writeln(['The value of S in top is: ~w~n', S, NewColor]).
    % (
        % (
        %     Action = pour(I1, J1),
        %     poss(Action, S),
        %     I1\=BottleNum,
        %     J1\=BottleNum
        % )
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
    % ).
    


% Successor state axiom for bottom
% this predicate checks whether if it is possible to add a certain color to the bottom of a bottle
% the bottle we pour from (I) should contains at least 1 color and the bottle we pour to (J) should be empty
possibleForBottom(pour(I, J), ColorI, S):-
    (
        top(I, ColorI, S);
        (
            top(I, e, S),
            bottom(I, ColorI, S)
        )
    ),
    empty(J, S),
    ColorI \= e,
    I \= J. 

% base cases
bottom(1, B1, s0) :- bottle1(_, B1).
bottom(2, B2, s0) :- bottle2(_, B2).
bottom(3, B3, s0) :- bottle3(_, B3).

% effect axiom
bottom( BottleNum, NewColor, result(Action, S)):-
    \+ bottom( BottleNum, NewColor, S),
    writeln(['The value of S in bottom is: ~w~n', S, NewColor]),
    Action=pour(_ ,BottleNum),
    possibleForBottom(Action, NewColor,S).

% frame axiom
bottom(BottleNum, NewColor, result(Action, S)):-
    bottom(BottleNum, NewColor, S),
    writeln(['The value of S in bottom is: ~w~n', S, NewColor]),
    (
        % pour between 2 bottles other than BottleNum
        % (
        %     Action=pour(I1,J1),
        %     poss(Action, S),
        %     I1\=BottleNum,
        %     J1\=BottleNum
        % );
        % pour from current BottleNum to another bottle in which BottleNum has somecolor at the top and not empty to maintain the bottom color
        % and the bottle we pour to is either empty or has the same color at the top as BottleNum
        (
            Action=pour(I2,J2),
            (
                % successful
                (
                    top(BottleNum, SomeColor, S),
                    SomeColor\=e,
                    (
                        empty(J2, S);
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
        % pour tp BottleNum when BottleNum has empty top only and other bottle has either empty top and NewColor at bottom or
        % NewColor at top and SomeColor at bottom
        (
            Action=pour(I3,J3),
            (
                % \+ possibleForBottom(Action, S);
                (
                    top(BottleNum, e, S),
                    (
                        (
                            top(J3, NewColor, S),
                            bottom(J3, SomeColor, S),
                            SomeColor\=e
                        );
                        (
                            top(J3, e , S),
                            bottom(J3, NewColor, S)
                        )
                    )
                )

            ),
            I3\=BottleNum,
            J3=BottleNum
        )
    ).

% Goal condition
goalHelper(S) :-
    % situation(S),
    top(1, C1, S), bottom(1, C1, S),
    top(2, C2, S), bottom(2, C2, S),
    top(3, C3, S), bottom(3, C3, S).


ids(S,L):-
   (call_with_depth_limit(goalHelper(S),L,R), number(R));
   (call_with_depth_limit(goalHelper(S),L,R), R=depth_limit_exceeded, L1 is L+1, ids(S,L1)).


goal(S):-
    ids(S, 1000).


    
