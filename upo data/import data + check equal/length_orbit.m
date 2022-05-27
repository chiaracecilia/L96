% this function calculates the length of the UPO

% INPUT
% number_points_trajectories (1,1) 
% trajectories_UPOs (number_points_trajectories,3): trajectory of the UPO 

% OUTPUT
% length_UPO (1,1) length of the trajectory. 

function length_UPO = length_orbit(number_points_trajectories, trajectories_UPOs)

length_UPO = 0;

for i=1:number_points_trajectories -1
    length_UPO = length_UPO + norm(trajectories_UPOs(i+1,:)-trajectories_UPOs(i,:));
end




