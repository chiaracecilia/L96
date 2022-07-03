% this function find the shadowing UPO for each point of the chaotic
% trajectory

% INPUT 
% x_chaotic: chaotic trajectory
% trajectories_UPOs: traj of the UPOs
% tau: radius of the interval where I do the controls
% number_points_trajectories: length of each UPO traj
% K: implement the full algorithm every K time-steps of the chaotic orbit. 
% N: I consider the first N UPOs for the shadowing 

% OUTPUT
% shadowing_UPO (length(x_chaotic),N): index that identifies the shadowing UPO
% dist_shadowing_UPO (length(x_chaotic),N): distance of the shadowing UPO with the chaotic trajectory
% coordinate_shadowing (length(x_chaotic),3, N) : coordinate of the shadowing UPO
% indice_shad_UPO (length(x_chaotic),N): along the UPO that shadows the traj, index that realises
% the minimum. save it for each time step, for each UPO

function [shadowing_UPO,dist_shadowing_UPO,coordinate_shadowing, indice_shad] = shadowing_UPOs_every_K_steps(x_chaotic, trajectories_UPOs, number_points_trajectories, tau, K, N,M)

% initialise the variables
shadowing_UPO = zeros(length(x_chaotic),N);
dist_shadowing_UPO = zeros(length(x_chaotic),N);
coordinate_shadowing = zeros(length(x_chaotic),M, N);
indice_shad = zeros(length(x_chaotic),N);
% for the first point on the chaotic orbit, calculate all the distances
% with all the points of all the UPOs and find the minimum 

[shadowing_UPO(1, :), dist_shadowing_UPO(1,:), coordinate_shadowing(1,:,:),indice_shad_UPO, indice_shad(1,:)] = shad_UPO_full(x_chaotic(1,:), trajectories_UPOs, number_points_trajectories,N,M);

% now check all the other points j of the chaotic orbit. For this one
% implement a reduced version of the algorithm 
k=0;

for j = 2:length(x_chaotic(:,1))
    % for each UPO consider the index that realises the minimum in the
    % previous step of the chaotic trajectory. 
    if (k==K)
        [shadowing_UPO(j,:), dist_shadowing_UPO(j,:), coordinate_shadowing(j,:,:), indice_shad_UPO, indice_shad(j,:)] = shad_UPO_full(x_chaotic(j,:), trajectories_UPOs, number_points_trajectories,N, M);
        k=1;
    else
        indice_shad_UPO_previous_step = indice_shad_UPO; % this
        [shadowing_UPO(j,:), dist_shadowing_UPO(j,:), coordinate_shadowing(j,:,:), indice_shad_UPO, indice_shad(j,:)] = shadowing_UPO_reduced(x_chaotic(j,:), trajectories_UPOs, indice_shad_UPO_previous_step, tau, number_points_trajectories,N, M);
        k=k+1;
    end

     
end


