% this function interpolates a trajectory with a shift of dt/2

% trajectory UPO: trajectory of the orbit
% T(1,1): period of the orbit
% dt: time step
% M number of variables


function [o,tnew, number_points] = shifted_upo(trajectories_UPOs, T, dt, M, tau)

% initialise variables
told = 0:tau:T; % this is the old
tnew = dt/2:dt:T;
tnew = [0, tnew, T];
N = length(tnew);
o = zeros(N,M);
number_points = N;
for i = 1:M
    % interpolate the ith componnent
    o(:,i) = interp1(told, trajectories_UPOs(:,i), tnew, 'linear');
end