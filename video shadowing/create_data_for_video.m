%% this script given the chaotic trajectory and relative shadowing UPO calculates the respective first three moments of both

load('upo_data.mat')
load('coordinate_shadowing_reduced.mat')
load('x_chaotic.mat')
load('indice_shad_UPO_reduced.mat')
load('shadowing_stats.mat')          
load('shadowing_UPO_reduced.mat')

[first_moment_upo, second_moment_upo, third_moment_upo] = projection_moments(coordinate_shadowing_reduced);
[first_moment_traj, second_moment_traj, third_moment_traj] = projection_moments(x_chaotic);


%% calculate the trajectories for the shadowing UPOs
X_sh = X(:,UPOs_approx_index(1:number_orbits_for_approximation(1),1));
T_sh = T(UPOs_approx_index(1:number_orbits_for_approximation(1),1));

%%
dt =0.01;
M = 40;
F = 5;

[trajectories_UPOs, number_points_trajectories, tau, dist] = create_matrix_trajectory_UPOs(X_sh,T_sh,dt,M, F);
%%
traj_moments = traj_moments(trajectories_UPOs, number_points_trajectories);