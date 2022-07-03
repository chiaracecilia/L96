% this script calculates the transition matrix given data from the
% shadowing of a chaotic orbit


% load data from shadowing
load('shadowing_UPO.mat')
load('upo_data.mat')
%%
[TRANSITION] = matrix(shadowing_UPO(:,1), T);

