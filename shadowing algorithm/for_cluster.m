%TRANSITION
%now1 = tic();
% load data
load('upo_data.mat')
%%
F=5;
%%

% load('lambda.mat')
% parameters


T_chaotic = 5;
N=10; % number of tiers

M=40;
dt = 0.01;
number_UPO=length(T);

tau=5;
K = 10; % every K time step execute the full algorithm 


%%
% create the chaotic trajectory
x_chaotic = create_chaotic_trajectory(dt, T_chaotic,M, F);                     

%%
% create trajectories UPOs

[trajectories_UPOs, number_points_trajectories, ~, dist] = create_matrix_trajectory_UPOs(X,T,dt,M, F);

%% reduced algorithm
[shadowing_UPO_reduced,dist_shadowing_UPO_reduced,coordinate_shadowing_reduced,indice_shad_UPO_reduced] = shadowing_UPOs_every_K_steps(x_chaotic, trajectories_UPOs, number_points_trajectories, tau, K, N,M);

% 
[number_orbits_for_approximation, UPOs_approx_index, time_approx, period_approx] = residence_time_tiers(shadowing_UPO_reduced, dt, T,  N);
%tempo_esecuzione = toc(now1);
save('shadowing_UPO_reduced.mat','shadowing_UPO_reduced')
save('dist_shadowing_UPO_reduced.mat', 'dist_shadowing_UPO_reduced', 'dist')
save('shadowing_stats.mat', 'number_orbits_for_approximation', 'UPOs_approx_index', 'time_approx', 'period_approx')
save('x_chaotic.mat', 'x_chaotic')
save('indice_shad_UPO_reduced.mat','indice_shad_UPO_reduced')
%save('shadowing.mat')
