%% this script given the chaotic trajectory and relative shadowing UPO calculates the respective first three moments of both

load('upo_data.mat')
%load('coordinate_shadowing_reduced.mat')
load('x_chaotic.mat')
load('indice_shad_UPO_reduced.mat')
load('shadowing_stats.mat')          
load('shadowing_UPO_reduced.mat')
load('dist_shadowing_UPO_reduced.mat')
%%
[first_moment_upo, second_moment_upo, third_moment_upo] = projection_moments(coordinate_shadowing_reduced(:,:,1));
[first_moment_traj, second_moment_traj, third_moment_traj] = projection_moments(x_chaotic);

%% plot trajectories and point that minimises it
% 
% for k = 1:length(coordinate_shadowing_reduced(:,1,1))
%     plot3(first_moment_traj(k),second_moment_traj(k),third_moment_traj(k),'Marker', '*' ,'Color', 'red')
%     hold on
%     plot3(first_moment_upo(k),second_moment_upo(k),third_moment_upo(k), 'Marker', '*' ,'Color', 'blue');
%     hold on
% end



%% calculate the trajectories of the shadowing UPOs only
quelle_che_approssimano = UPOs_approx_index(1:number_orbits_for_approximation(1),1);
X_sh = X(:,quelle_che_approssimano); 
T_sh = T(quelle_che_approssimano);

%%
dt =0.01;
M = 40;
F = 5;


%%

%[trajectories_UPOs, number_points_trajectories, tau, dist] = create_matrix_trajectory_UPOs(X(:,1:100),T(1:100),dt,M, F);
%%
[trajectories_UPOs, number_points_trajectories, tau, dist] = create_matrix_trajectory_UPOs(X_sh,T_sh,dt,M, F);
%%
traj_moments = traj_moments(trajectories_UPOs, number_points_trajectories);

%% plot trajectories

% for i=1:22 % for each point of the chaotic orbit, find and plot the closest UPO
%  
% plot3(traj_moments(1:number_points_trajectories(i),1,i),traj_moments(1:number_points_trajectories(i),2,i), traj_moments(1:number_points_trajectories(i),3,i) );
% hold on
% 
% end
