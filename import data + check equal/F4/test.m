%% with this script I want to get an idea of the relative error on each quantity 
load('ic.mat')
% parameters
dt=0.01;
M=40;
F=4;

[trajectories_UPOs, number_points_trajectories, tau, dist] = create_matrix_trajectory_UPOs(Xp,Tp,dt,M, F);

%% STUDY THE AVERAGE QUANTITIES INVOLVING THE SHIFTED TRAJECTORIES

%create a shifted trajectory
[trajectories_UPOs_shifted, tnew, number_points_UPOs_shifted] = shifted_trajectories(trajectories_UPOs, Tp, dt, M,number_points_trajectories, tau);

% error momenta of each orbit
[error_first, error_second, error_third, error_fourth, error_fifth] = error_moments(trajectories_UPOs, number_points_trajectories,trajectories_UPOs_shifted, number_points_UPOs_shifted);

% inter_orbit distance
min_inter_orb = distance_with_shifted(trajectories_UPOs, trajectories_UPOs_shifted, number_points_trajectories, number_points_UPOs_shifted);


%% STUDY THE AVERAGE QUANTITIES WITH AN ORBIT AND ITS SYMMETRIC 

k = 5; % shift that I am interested in

Xc = zeros(M, length(Tp));
for i=1:length(Tp)
    Xc(:,i)=circshift(Xp(:,i), k);
end

% trajectory of the symmetric orbit
[trajectories_UPOs_c, number_points_trajectories_c, tauc, distc] = create_matrix_trajectory_UPOs(Xc,Tp,dt,M, F);

% distance between an orbit and its symmetric
min_inter_orb_c = distance_with_shifted(trajectories_UPOs, trajectories_UPOs_c, number_points_trajectories, number_points_trajectories_c);
stat_general(min_inter_orb_c)
%% check length of the orbits

length_orbits = length_UPOs(number_points_trajectories, trajectories_UPOs);
length_orbits_shifted = length_UPOs(number_points_UPOs_shifted, trajectories_UPOs_shifted);

%%
[primo,secondo, terzo, quarto, quinto] = moments_UPOs(trajectories_UPOs, number_points_trajectories);

%%
% 
% the suspicious orbits are the ones obtained for j=3,4,7 check if they are
% the same or they are shifted
i=3;
j=7;
tol = 10^(-15);

Xi = Xp(:,i);
Ti=Tp(i);
Xj = Xp(:,j);
Tj=Tp(j);
[flag] = is_the_same(Xi, Xj, Ti, Tj, dt, F, M, tol);
%%
[flag] = is_symmetric(Xi, Xj, Ti, Tj, dt, F, M, tol);
sum(flag)

%%

i=1;
j=1;
Xi = Xp(:,i);
Ti=Tp(i);
Xj = Xc(:,j);
Tj=Tp(i);
tol = 10^(-16);

[flag] = is_symmetric(Xi, Xj, Ti, Tj, dt, F, M, tol)

