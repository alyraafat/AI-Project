:- include("KB.pl").

% Fluent 1: top_layer - Shows if a color is in the top layer of a bottle

%% Check for possible pouring in the bottle 
possibleTopPourIfTarget(Action, S) :-
    Action = pour(Source, Target),
    (
        top_layer(Source, C, S);
        (
            bottom_layer(Source, C, S),
            top_layer(Source, e, S)
        )
    ),
    C\=e,
    top_layer(Target, e, S),
    bottom_layer(Target, C, S),
    Source \= Target.

possibleTopPourIfSource(Action, S) :-
    Action = pour(Source, Target),
    (
        top_layer(Source, C, S);
        (
            bottom_layer(Source, C, S),
            top_layer(Source, e, S)
        )
    ),
    top_layer(Target, e, S),
    Source \= Target.

%% Initial States bottles 
top_layer(1, T, s0) :- bottle1(T, _).
top_layer(2, T, s0) :- bottle2(T, _).
top_layer(3, T, s0) :- bottle3(T, _).

%% Effect axiom
top_layer(Target, NewColor, S2) :-
    writeln('Testing 1st Top layer'),
    S2 = result(Action, S),
    % \+ top_layer(Target, NewColor, S),
    % writeln('Here2'),
    Action = pour(Source, Target),
    possibleTopPourIfTarget(Action, S). % Check if possible to pour
    % top_layer(Source, NewColor, S).

top_layer(Source, NewColor, S2) :-
    writeln('Testing 2nd Top layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    possibleTopPourIfSource(Action, S).
%   bottom_layer(Source, NewColor, S).

%% Frame Axiom: 
top_layer(Bottle, Color, S2) :-
    writeln('Testing 3rd Top layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    Bottle \= Source, Bottle \= Target,
    top_layer(Bottle, Color, S).

top_layer(Target, e, S2) :-
    writeln('Testing 5th Top layer'),
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
    Source\=Target.


% Fluent 2: bottom_layer, Shows if a color is in the bottom layer of a bottle 

possibleBottomPourIfTarget(Action, S):-
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
bottom_layer(Target, NewColor, S2) :-
    writeln('Testing 1st Bottom layer'),
    S2 = result(Action, S),    
    Action = pour(Source, Target),
    possibleBottomPourIfTarget(Action, S).

bottom_layer(Source, NewColor, S2) :-
    writeln('Testing 2nd bottom layer'),
    S2 = result(Action, S),    
    Action = pour(Source, Target),
    possibleBottomPourIfSource(Action, S).
    
% frame

bottom_layer(Bottle, NewColor, S2) :- % 2 different bottles so I will remain as is
    writeln('Testing 3rd bottom layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    Bottle \= Source, Bottle \= Target,
    bottom_layer(Bottle, NewColor, S).

bottom_layer(Source, NewColor, S2):- % 
    writeln('Testing 4th bottom layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    top_layer(Source, C, S),
    C \= e,
    top_layer(Target, e, S),
    (
        bottom_layer(Source, e, S);
        bottom_layer(Target, C, S)
    ),
    Source \= Target.

bottom_layer(Target, NewColor, S2):-
    writeln('Testing 5th bottom layer'),
    S2 = result(Action, S),
    Action = pour(Source, Target),
    (
        top_layer(Source, C, S);
        (
            top_layer(Source, e, S);
            bottom_layer(Source, C, S)
        )
    ),
    C \= e,
    top_layer(Target, e, S),
    Source \= Target.


goalHelper(S) :-
    top_layer(1, C1, S), bottom_layer(1, C1, S),
    top_layer(2, C2, S), bottom_layer(2, C2, S),
    top_layer(3, C3, S), bottom_layer(3, C3, S).


ids(S,L):-
   (call_with_depth_limit(goalHelper(S),L,R), number(R));
   (call_with_depth_limit(goalHelper(S),L,R), R=depth_limit_exceeded, L1 is L+1, ids(S,L1)).


goal(S):-
    ids(S, 1000).
