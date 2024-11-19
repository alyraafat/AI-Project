% Watersort.pl

% Include the knowledge base KB.pl
:- include('KB.pl').

% Define the bottles
bottle(bottle1).
bottle(bottle2).
bottle(bottle3).

% Initial state fluents based on KB.pl
top(bottle1, C1, s0) :- bottle1(C1, _).
bottom(bottle1, C2, s0) :- bottle1(_, C2).

top(bottle2, C1, s0) :- bottle2(C1, _).
bottom(bottle2, C2, s0) :- bottle2(_, C2).

top(bottle3, C1, s0) :- bottle3(C1, _).
bottom(bottle3, C2, s0) :- bottle3(_, C2).

% Define when a bottle is full
full(Bottle, S) :-
    top(Bottle, TopColor, S), TopColor \= e,
    bottom(Bottle, BottomColor, S), BottomColor \= e.

% Define when a bottle is empty
empty(Bottle, S) :-
    top(Bottle, e, S),
    bottom(Bottle, e, S).

% Action preconditions
poss(pour(I, J), S) :-
    bottle(I), bottle(J), I \= J,
    top(I, ColorI, S), ColorI \= e, % Source bottle has something to pour
    \+ full(J, S), % Target bottle is not full
    top(J, TopColorJ, S),
    (TopColorJ = e ; ColorI = TopColorJ). % Target bottle's top is empty or same color

% Successor-state axiom for 'top' fluent
top(Bottle, Color, result(A, S)) :-
    A = pour(I, J),
    (
        Bottle = I ->
        (
            bottom(I, BottomColorI, S),
            (BottomColorI = e ->
                Color = e % Source bottle top becomes empty
            ;
                Color = BottomColorI % Source bottle top becomes its bottom
            )
        )
    ;
        Bottle = J ->
        (
            top(J, TopColorJ, S),
            top(I, ColorI, S),
            (TopColorJ = e ->
                Color = ColorI % Target bottle top becomes source top color
            ;
                Color = TopColorJ % Target bottle top remains the same
            )
        )
    ;
        top(Bottle, Color, S) % Other bottles remain unchanged
    ).

% Successor-state axiom for 'bottom' fluent
bottom(Bottle, Color, result(A, S)) :-
    A = pour(I, J),
    (
        Bottle = I ->
        (
            bottom(I, BottomColorI, S),
            Color = e % Source bottle bottom becomes empty after pouring
        )
    ;
        Bottle = J ->
        (
            bottom(J, BottomColorJ, S),
            top(J, TopColorJ, S),
            top(I, ColorI, S),
            (TopColorJ \= e, BottomColorJ = e ->
                Color = ColorI % Target bottle bottom filled with source top color
            ;
                Color = BottomColorJ % Target bottle bottom remains unchanged
            )
        )
    ;
        bottom(Bottle, Color, S) % Other bottles remain unchanged
    ).

% Goal condition: each bottle filled with one color
goal_helper(S) :-
    bottle(B1), bottle(B2), bottle(B3),
    top(B1, C1, S), bottom(B1, C1, S), C1 \= e,
    top(B2, C2, S), bottom(B2, C2, S), C2 \= e,
    top(B3, C3, S), bottom(B3, C3, S), C3 \= e.

% IDS implementation using call_with_depth_limit/3
solve(S) :-
    ids(S, 0).

ids(S, Limit) :-
    call_with_depth_limit(search(s0, S, Limit), Limit, R),
    (number(R) -> true;
     R = depth_limit_exceeded,
     Limit1 is Limit + 1,
     ids(S, Limit1)
    ).

% Search predicate with depth limit
search(S, S, _) :-
    goal_helper(S).

search(S1, S, N) :-
    N > 0,
    poss(A, S1),
    S2 = result(A, S1),
    N1 is N - 1,
    search(S2, S, N1).

goal(S):-
    solve(S).


