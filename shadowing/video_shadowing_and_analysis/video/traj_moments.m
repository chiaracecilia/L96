%% this function takes the trajectories of some UPOs and returns their first three moments

function traj_moments = traj_moments(trajectories_UPOs, number_points_trajectories)

number_UPOs = length(trajectories_UPOs(1,1,:));
lmax = length(trajectories_UPOs(:,1,1));

traj_moments = zeros(lmax,3, number_UPOs);

for i=1:number_UPOs
    traj = trajectories_UPOs(1:number_points_trajectories(i),:,i);
    [first_moment_upo, second_moment_upo, third_moment_upo] = projection_moments(traj);
    traj_moments(1:number_points_trajectories(i),1,i) = first_moment_upo;
    traj_moments(1:number_points_trajectories(i),2,i) = second_moment_upo;
    traj_moments(1:number_points_trajectories(i),3,i) = third_moment_upo;
end
    
    
