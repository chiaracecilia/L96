%% this algorithm calculates the FTLE of the chaotic trajectory at the given time-steps.

% INPUT 
% x_ch(N, length(x_chaotic)) chaotic trajectory
% dt(1,1): time step

% OUTPUT
% FTLE_directions(N,length(x_ch)) these are the directions of the FTLE

M=20;
F=5;
dt = 0.01;

x_ch = midpoint(@lorenz96,0,dt, 10^3, rand(1,M),M, F);
FTLE_directions = zeros(1, length(x_ch));

