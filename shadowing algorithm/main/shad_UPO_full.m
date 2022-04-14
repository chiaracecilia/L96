% this function finds the shadowing UPO performing ALL the possible
% confronts

% INPUT 
% punto: point on the chaotic trajectory
% trajectories_UPOs: traj of all the UPOs
% number_points_trajectories: number of point on each UPO traj
% N: number of UPOs that shadows the traj at each timestep

% OUTPUT
% shadowing_UPO(N,1): index of the shadowing UPO
% dist_shadowing_UPO(N,1): distance of the shad UPO
% coordinate_shadowing(N,3): coordinate of the shadowing UPO 
% indice_shad(N,1): index that identifies the shadowing UPO in the UPO
% array
% indice_shad_UPO(number_UPOs, 1): for each UPO it contains the index that realises the
% minimum with punto, not just the shadowing ones! (VARIABLE NEEDED FOR THE REDUCED ALGORITHM!)



function [shadowing_UPO, dist_shadowing_UPO, coordinate_shadowing, indice_shad_UPO, indice_shad] = shad_UPO_full(punto, trajectories_UPOs, number_points_trajectories, N, M)

number_UPOs = length(trajectories_UPOs(1,1,:));
indice_shad_UPO = zeros(number_UPOs, 1);
dist = zeros(number_UPOs, 1);
coord = zeros(number_UPOs, M);

for j=1:number_UPOs % j indicates the UPOs that I am considering
    % for each UPO, caculate all the distances with punto and select the
    % minimum  
    UPO_traj = traj_single_UPO(trajectories_UPOs, number_points_trajectories(j),j);
    [coord(j,:), dist(j), indice_shad_UPO(j)] = point_that_realises_minimum(UPO_traj, punto);
end

% sort the vector of the distances in ascending order
[dist_sorted, idx] = sort(dist);
% consider only the first N shadowing UPOs
dist_shadowing_UPO = dist_sorted(1:N);
shadowing_UPO  = idx(1:N);
coordinate_shadowing = coord(shadowing_UPO,:)';
indice_shad = indice_shad_UPO(shadowing_UPO);

end