% bottle1(e,r).
% bottle2(b,r). 
% bottle3(b,b). 

% bottle1(r,r).
% bottle2(b,r). 
% bottle3(b,b). 

% bottle1(r,r). 
% bottle2(r,r).
% bottle3(b,b).

% bottle1(e,r). 
% bottle2(b,r). 
% bottle3(e,r).

% bottle1(e,r). 
% bottle2(b,r).
% bottle3(e,e).

%% One Color
% bottle1(e,e). 
% bottle2(e,g).
% bottle3(e,e).

%% Two Colors (Same)
% bottle1(e,g). 
% bottle2(e,g).
% bottle3(e,e).

%% Two Colors (Different)
% bottle1(e,y). 
% bottle2(e,g).
% bottle3(e,e).

%% Three Colors (All infinite loops)
% bottle1(e,y). 
% bottle2(e,y).
% bottle3(e,y).

%% Four Colors (2 Same only should work)
% bottle1(e,g). 
% bottle2(r,g).
% bottle3(e,r).

%% Five Colors (No Solution ever)
% bottle1(r,y). 
% bottle2(y,r).
% bottle3(e,y).

%% Sixth Colors (Only if it came solved)
bottle1(g,g). 
bottle2(r,g).
bottle3(r,r).