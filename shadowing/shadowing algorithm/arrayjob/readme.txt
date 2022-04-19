
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% x_chaotic: chaotic trajectory
% trajectories_UPOs: traj of the UPOs
% number_points_trajectories: length of each UPO traj
% N: number of tiers

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% SHADOWING STATISTICS WITH POINT-WISE INFORMATION ALONG THE TRAJECTORY

% shadowing_UPO (length(x_chaotic),N): index that identifies the shadowing UPO
% dist_shadowing_UPO (length(x_chaotic),N): distance of the shadowing UPO with the chaotic trajectory
% coordinate_shadowing (length(x_chaotic),3, N) : coordinate of the point of the UPO that shadows the trajectory
% indice_shad_UPO (length(x_chaotic),N): along the UPO that shadows the traj, index that realises
% the minimum. It identifies the position along the trajectory of the UPO that shadows the chaotic trajectory

%% GLOBAL SHADOWING STATISTICS

% total time(number_UPOs, N): for each UPO in each tier, its total shadowing
% time
% number_orbits_for_approximation(1,N): number of orbits used in the
% shadowing for each tier

% since the number of shadowing UPOs can vary from tier to tier, then
% initialise these values with the maximum number of UPOs, and fill it
% only where required

% UPOs_approx_index(number_UPOs, N): index that identifies in the total vector of UPOs the position of the UPOs considered in the shadowing in each tier. Which ones are the selected orbits for the shadowing?
% time_approx(number_UPOs, N): for each UPO in each tier, time considered for the approximation
% period_approx(number_UPOs, N): period of the UPOs considered in the shadowing
