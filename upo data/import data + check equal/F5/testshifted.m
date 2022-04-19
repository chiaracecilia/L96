%% test distance shifted UPOs
i = 1;
j =8;

Xi = Xp(:,i);
Ti=Tp(i);
% Xj = trajectories_UPOs_shifted(1,:,i);
% Tj=Tp(i);
Xj = Xp(:,j);
Tj=Tp(j);

tra_j = trajectories_UPOs(1:number_points_trajectories(j), :,j);
tra_i = trajectories_UPOs(1:number_points_trajectories(i), :,i);

tra_j_shifted = trajectories_UPOs_shifted(1:number_points_UPOs_shifted(j), :,j);
tra_i_shifted = trajectories_UPOs_shifted(1:number_points_UPOs_shifted(i), :,i);

di= norm(tra_i_shifted(1,:)- tra_i_shifted(end,:));
dj= norm(tra_j_shifted(1,:)- tra_j_shifted(end,:));