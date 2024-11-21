:- include("Our_KB.pl").

% Fluent 1: top_layer - Shows if a color is in the top layer of a bottle

%% Check for possible pouring in the bottle 
possibleTopPourIfTarget(Action, C, S) :-
    Action = pour(Source, Target),
    (
        top_layer(Source, C, S);
        (
            bottom_layer(Source, C, S),
            top_layer(Source, e, S)
        )
    ),
    C \= e,
    top_layer(Target, e, S),
    bottom_layer(Target, C, S), % to force the color to be on top as it is an effect axiom
    Source \= Target.

possibleTopPourIfSource(Action, S) :-
    Action = pour(Source, Target),
    % (
    %     top_layer(Source, C, S);
    %     (
    %         bottom_layer(Source, C, S),
    %         top_layer(Source, e, S)
    %     )
    % ),
    top_layer(Source, C, S),
    top_layer(Target, e, S),
    (
        bottom_layer(Target, C, S);
        bottom_layer(Target, e, S)
    ),
    C \= e,
    Source \= Target.

is_invalid_pour(Action, S):-
    Action = pour(Source, Target),
    (
        ( % not empty target
            Source \= Target,
            top_layer(Target, Color1, S),
            bottom_layer(Target, Color2, S),
            Color1 \= e,
            Color2 \= e
        );
        ( % pouring a color on a different color
            Source \= Target,
            top_layer(Target, e, S),
            bottom_layer(Target, Color1, S),
            Color1 \= e, 
            (
                top_layer(Source, Color2, S);
                (
                    bottom_layer(Source, Color2, S),
                    top_layer(Source, e, S)
                )
            ),
            Color2 \= e,
            Color2 \= Color1
        );
        ( 
            Source \= Target,
            top_layer(Source, e, S),
            bottom_layer(Source, e, S)
        );
        (
            Source = Target
        )
    ).

%% Initial States bottles 
top_layer(1, T, s0) :- bottle1(T, _).
top_layer(2, T, s0) :- bottle2(T, _).
top_layer(3, T, s0) :- bottle3(T, _).

%% Effect axiom
top_layer(Target, NewColor, S2) :- % I currently have no top, and I will have the top when I pour from the source
    % writeln('Testing 1st Top layer'),
    S2 = result(Action, S),
    Action = pour(_, Target),
    possibleTopPourIfTarget(Action, C, S), % Check if possible to pour
    C = NewColor, !.

top_layer(Source, e, S2) :- % I am the source, So I will pour on another bottle, this is an effect axiom to the empty top.
    % writeln('Testing 2nd Top layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    possibleTopPourIfSource(Action, S), !.

%% Frame Axiom: 
top_layer(Bottle, Color, S2) :- % test when we pour 2 different bottels
    % writeln('Testing 3rd Top layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    Bottle \= Source, Bottle \= Target, Source \= Target,
    top_layer(Bottle, Color, S), !.

top_layer(Source, e, S2) :- % when we pour from the source and our top is empty, so the empty will remain as is
    % writeln('Testing 4th top layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    top_layer(Source, e, S),
    bottom_layer(Source, C, S),
    C\=e,
    top_layer(Target, e, S),
    (
        bottom_layer(Target, C, S);
        bottom_layer(Target, e, S)
    ),
    Source \= Target, !.

top_layer(Target, e, S2) :- % I am the target and I am empty and the source bottle pours into me so my top remains empty still
    % writeln('Testing 5th Top layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    top_layer(Target, e, S),
    bottom_layer(Target, e, S),
    (
        top_layer(Source, C, S);
        (
            bottom_layer(Source, C, S),
            top_layer(Source, e, S)
        )
    ),
    C\=e,
    Source\=Target, !.



%% unsuccessful/invalid pours
top_layer(Target, Color, S2):-
    % writeln('Testing 6th Top Layer')
    S2 = result(Action, S),
    Action = pour(Source, Target),
    is_invalid_pour(Action, S),
    top_layer(Target, Color, S), !.

top_layer(Source, Color, S2):-
    % writeln('Testing 7th Top Layer')
    S2 = result(Action, S),
    Action = pour(Source, Target),
    is_invalid_pour(Action, S),
    top_layer(Source, Color, S), !.

top_layer(Bottle, Color, S2) :- % test when we pour same bottle to itself
    % writeln('Testing 8th Top layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    Bottle \= Source, Bottle \= Target, Source = Target,
    top_layer(Bottle, Color, S), !.
    

%------------------------------------------------------------------------------------------------


possibleBottomPourIfTarget(Action, C, S):-
    Action = pour(Source, Target),
    top_layer(Target, e, S),
    bottom_layer(Target, e, S),
    (
        top_layer(Source, C, S);
        (
            top_layer(Source, e, S),
            bottom_layer(Source, C, S)
        )
    ),
    C \= e,
    Source \= Target.

possibleBottomPourIfSource(Action, S):-
    Action = pour(Source, Target),
    top_layer(Source, e, S),
    bottom_layer(Source, C, S),
    C \= e,
    top_layer(Target, e, S),
    (
        bottom_layer(Target, e, S);
        bottom_layer(Target, C, S)
    ),
    Source \= Target.

%% Initial State bottom 
bottom_layer(1, B, s0) :- bottle1(_, B).
bottom_layer(2, B, s0) :- bottle2(_, B).
bottom_layer(3, B, s0) :- bottle3(_, B).

% effect
bottom_layer(Target, NewColor, S2) :- % If I am empty and another bottle poured on me, I should have the color of the poured layer 
%    writeln('Testing 1st Bottom layer'),
   S2 = result(Action, S),    
   Action = pour(_, Target),
   possibleBottomPourIfTarget(Action, C, S),
   C = NewColor, !.

bottom_layer(Source, e, S2) :- % If I am the source, this will make me turn empty if I pour the last layer
    % writeln('Testing 2nd bottom layer'),
    S2 = result(Action, S),    
    Action = pour(Source, Target),
    possibleBottomPourIfSource(Action, S), !.
    
% frame
bottom_layer(Bottle, NewColor, S2) :- % 2 different bottles so I will remain as is
    % writeln('Testing 3rd bottom layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    Bottle \= Source, Bottle \= Target, Source\=Target,
    bottom_layer(Bottle, NewColor, S), !.

bottom_layer(Source, NewColor, S2):- % I am the source and I have a top layer which I will pour to another empty bottle or a another bottle which has an empty top
    % writeln('Testing 4th bottom layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    top_layer(Source, C, S),
    C \= e,
    top_layer(Target, e, S),
    (
        bottom_layer(Target, e, S);
        bottom_layer(Target, C, S)
    ),
    Source \= Target,
    bottom_layer(Source, NewColor, S), !.

    
bottom_layer(Target, NewColor, S2):- % I am the target and i have a bottom but my top is empty and needs to be filled with another non empty bottle having same Color at top or bottom if top is empty
    % writeln('Testing 5th bottom layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    (
        top_layer(Source, NewColor, S);
        (
            top_layer(Source, e, S),
            bottom_layer(Source, NewColor, S)
        )
    ),
    NewColor \= e,
    top_layer(Target, e, S),
    bottom_layer(Target, NewColor, S),
    Source \= Target,!.

%% the unsuccessful/invalid pours
bottom_layer(Source, Color, S2):-
    S2 = result(Action, S),
    Action = pour(Source, Target),
    is_invalid_pour(Action, S),
    bottom_layer(Source, Color, S), !.

bottom_layer(Target, Color, S2):-
    S2 = result(Action, S),
    Action = pour(Source, Target),
    is_invalid_pour(Action, S),
    bottom_layer(Target, Color, S), !.

bottom_layer(Bottle, Color, S2) :- % 2 same bottles so remain as is
    % writeln('Testing 8th bottom layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    Bottle \= Source, Bottle \= Target, Source=Target,
    bottom_layer(Bottle, Color, S), !.

createNewSituations([], []).
createNewSituations([S|T1], NewSituationsAll):-
    Situation1 = result(pour(1,2), S),
    Situation2 = result(pour(2,1), S),
    Situation3 = result(pour(1,3), S),
    Situation4 = result(pour(3,1), S),
    Situation5 = result(pour(2,3), S),
    Situation6 = result(pour(3,2), S),
    Situation7 = result(pour(1,1), S),
    Situation8 = result(pour(2,2), S),
    Situation9 = result(pour(3,3), S),
    NewSituations = [Situation1, Situation2, Situation3, Situation4, Situation5, Situation6, Situation7, Situation8, Situation9],
    createNewSituations(T1, NewSituationsRest),
    append(NewSituationsRest, NewSituations, NewSituationsAll).

verifyAllSituations([], _) :- fail.


verifyAllSituations([S|_], S1):-
    %%writeln(['S',S]),
    verifySituation(S),
    S1 = S.

verifyAllSituations([_|T], S1):-
    %%writeln(['S1', S1]),
    verifyAllSituations(T, S1).


generateSituation(S, S1):-
    verifyAllSituations(S, S1).

generateSituation(S, S1):-
    createNewSituations(S, NewSituations),
    generateSituation(NewSituations, S1).

verifySituation(S):-
    top_layer(1, C1, S), bottom_layer(1, C1, S),
    top_layer(2, C2, S), bottom_layer(2, C2, S),
    top_layer(3, C3, S), bottom_layer(3, C3, S).
    %%writeln([C1,C2,C3]).

goalHelper(S) :-
    (   var(S)
    ->  generateSituation([s0], S)
    ;   verifySituation(S)
    ).


ids(S,L):-
    (call_with_depth_limit(goalHelper(S),L,R), number(R));
    (call_with_depth_limit(goalHelper(S),L,R), R=depth_limit_exceeded, L1 is L+1, ids(S,L1)).



goal(S):-
    ids(S, 300000).
