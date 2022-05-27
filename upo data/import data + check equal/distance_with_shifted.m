%% this function calculates the minimum inter orbit distance between an orbit and its shifted one

function min_inter_orb = distance_with_shifted(trajectories_UPOs, trajectories_UPOs_shifted, number_points_trajectories, number_points_UPOs_shifted)

M = length(trajectories_UPOs(1,1,:));

min_inter_orb = zeros(1,M);

for i=1:M
    traj_i = trajectories_UPOs(2:number_points_trajectories(i)-1, :,i);
    traj_j = trajectories_UPOs_shifted(2:number_points_UPOs_shifted(i)-1,:,i);
    [min_inter_orb(i), ~, ~]  = inter_orbit_distance(traj_i, traj_j);
end
