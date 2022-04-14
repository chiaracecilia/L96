% this function given a point on the chaotic trajectory considers all the UPOs and finds the
% shadowing UPO using a reduced version of the algorithm. 

% INPUT
% punto: point on the UPO that I am shadowing
% trajectories_UPOs: trajectories of the UPOs
% indice_shad_UPO_previous_step: vector containing for each UPO the index
% that realises the minimum 
% tau: radius of the neighboorhood where I will calculate the distances
% N: number of UPOs that shadows the traj at each timestep

% OUTPUT
% shadowing_UPO(N,1): index that identifies the UPO that shadows the point
% dist_shadowing_UPO(N,1): distance of the shadowing UPO
% coordinate_shadowing(N,3): coordinate of the shadowing UPO
% indice_shad(N,1):index that realises the minimum along the shadowing UPO
% indice_shad_UPO(number_UPOs, 1): for each UPO, index that realises the minimum with punto


function [shadowing_UPO, dist_shadowing_UPO, coordinate_shadowing, indice_shad_UPO, indice_shad] = shadowing_UPO_reduced(punto, trajectories_UPOs, indice_shad_UPO_previous_step, tau, number_points_trajectories,N, M)

number_UPOs = length(trajectories_UPOs(1,1,:));
indice_shad_UPO = zeros(number_UPOs, 1);
dist = zeros(number_UPOs, 1);
coord = zeros(number_UPOs, M);

% for each UPO j , calculates the distances only in the window centered in
% indice_shad_UPO_previous_step with radius tau.


for j=1:number_UPOs
    UPO_traj = traj_single_UPO(trajectories_UPOs, number_points_trajectories(j),j);
    [coord(j,:), dist(j), indice_shad_UPO(j)] = point_that_realises_the_minimum_reduced(punto, UPO_traj, indice_shad_UPO_previous_step(j), tau);
end

% sort the vector of the distances in ascending order
[dist_sorted, idx] = sort(dist);
% consider only the first N shadowing UPOs
dist_shadowing_UPO = dist_sorted(1:N);
shadowing_UPO  = idx(1:N);
coordinate_shadowing = coord(shadowing_UPO,:)';
indice_shad = indice_shad_UPO(shadowing_UPO);
end
