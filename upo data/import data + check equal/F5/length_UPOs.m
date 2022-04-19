%% given a DB of UPOs, calculate the lenght of each orbit.

% INPUT
% number_points_trajectories(number_UPO, 1)
% trajectories_UPOs(nunmber_points_traj, 3, number_UPOs)

% OUTPUT
% length_orbits(number_UPOs, 1) 

function length_orbits = length_UPOs(number_points_trajectories, trajectories_UPOs)

number_UPOs = length(number_points_trajectories);
length_orbits = zeros(1, number_UPOs);

% for each orbit calculates its length
for i=1:number_UPOs
    length_orbits(i)=length_orbit(number_points_trajectories(i), trajectories_UPOs(:,:,i));
end
