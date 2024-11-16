:- include('KB.pl').


contains(Bottle, Color, Layer, s0) :-
    bottle_fact(Bottle, Bottom, Top),
    (
        (Layer = 1, Color = Bottom);
        (Layer = 2, Color = Top)
    ).


contains(Bottle, Color, Layer, result(Action, S)) :-
    Action = pour(Source, Dest),
    (
        % Pour into destination bottle
        Dest = Bottle,
        next_empty_layer(Dest, Layer, S),
        top_layer(Source, Color, S)
    );
    (
        % Bottle unaffected by the pour action
        Bottle \= Source,
        Bottle \= Dest,
        contains(Bottle, Color, Layer, S)
    );
    (
        % Source bottle with updated state
        Source = Bottle,
        Layer = 2, % Assuming we only pour from the top layer
        Color = e,
        contains(Bottle, _, 2, S) % Ensures we track that top layer is now empty
    ).


pour(Source, Dest) :-
    Source \= Dest.


top_layer(Bottle, Color, S) :-
    contains(Bottle, Color, 2, S),
    Color \= e.

next_empty_layer(Bottle, Layer, S) :-
    contains(Bottle, e, Layer, S).

% Helper to map bottle facts to the initial state
bottle_fact(1, T, B) :- bottle1(T, B).
bottle_fact(2, T, B) :- bottle2(T, B).
bottle_fact(3, T, B) :- bottle3(T, B).

% Goal predicate to check if all bottles are uniformly filled
goal(S) :-
    all_bottles_filled_uniformly(S).

all_bottles_filled_uniformly(S) :-
    bottle_filled_uniformly(1, S),
    bottle_filled_uniformly(2, S),
    bottle_filled_uniformly(3, S).


bottle_filled_uniformly(Bottle, S) :-
    contains(Bottle, Color, 1, S),
    contains(Bottle, Color, 2, S).
