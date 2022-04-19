% test function 

i = 2;

    traj_i = trajectories_UPOs(2:number_points_trajectories(i)-1, :,i);
    traj_j = trajectories_UPOs_shifted(2:number_points_UPOs_shifted(i)-1,:,i);
    [min_inter_orb, ~, ~]  = inter_orbit_distance(traj_i, traj_j);