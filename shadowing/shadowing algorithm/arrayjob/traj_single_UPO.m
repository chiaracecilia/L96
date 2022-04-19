% creates a vector containing all the points of the UPO that we are taking
% into account 

function UPO_traj = traj_single_UPO(trajectories_UPOs, number_point_traj,index_UPO)
        


UPO_traj = trajectories_UPOs(1:number_point_traj, :, index_UPO);