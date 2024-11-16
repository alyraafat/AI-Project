:- include('KB.pl').

% Fluents: top(BottleNum, Color, S), bottom(BottleNum, Color, S)

% Initial state for s0
top(1, T1, s0) :- bottle1(T1, _).
bottom(1, B1, s0) :- bottle1(_, B1).
top(2, T2, s0) :- bottle2(T2, _).
bottom(2, B2, s0) :- bottle2(_, B2).
top(3, T3, s0) :- bottle3(T3, _).
bottom(3, B3, s0) :- bottle3(_, B3).

% Empty and full predicates
empty(BottleNum, S) :-
    top(BottleNum, e, S),
    bottom(BottleNum, e, S).

full(BottleNum, S) :-
    top(BottleNum, C1, S),
    bottom(BottleNum, C2, S),
    C1 \= e,
    C2 \= e.

% Action preconditions
poss(pour(I, J), S) :-
    I \= J,
    top(I, ColorI, S),
    ColorI \= e,
    top(J, e, S),
    (
        bottom(J, e, S)
    ;
        bottom(J, ColorI, S)
    ).

% Successor state axiom for top
top(BottleNum, NewColor, result(Action, S)) :-
    Action = pour(I, J),
    poss(Action, S),
    (
        BottleNum = I ->
            bottom(BottleNum, BottomColor, S),
            (BottomColor \= e -> NewColor = BottomColor; NewColor = e)
    ;
        BottleNum = J ->
            top(I, ColorI, S),
            NewColor = ColorI
    ;
        top(BottleNum, NewColor, S)
    ).

% Successor state axiom for bottom
bottom(BottleNum, NewColor, result(Action, S)) :-
    Action = pour(I, J),
    poss(Action, S),
    (
        BottleNum = J,
        bottom(BottleNum, e, S) ->
            top(I, ColorI, S),
            NewColor = ColorI
    ;
        bottom(BottleNum, NewColor, S)
    ).

% Goal condition
goal(S) :-
    top(1, C1, S), bottom(1, C1, S), C1 \= e,
    top(2, C2, S), bottom(2, C2, S), C2 \= e,
    top(3, C3, S), bottom(3, C3, S), C3 \= e.

% Iterative deepening search
ids(Solution) :-
    between(0, infinite, Depth),
    call_with_depth_limit(solve(Solution), Depth, Result),
    (
        Result \= depth_limit_exceeded
    ->  !
    ;   fail
    ).

solve(S) :-
    plan(S, s0),
    goal(S).

plan(S, S).
plan(S2, S0) :-
    plan(S1, S0),
    poss(Action, S1),
    S2 = result(Action, S1).
