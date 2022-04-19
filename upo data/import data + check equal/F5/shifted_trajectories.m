%% this function calculates the shifted trajectory for all the UPOs

function [trajectories_UPOs_shifted, tnew, number_points_UPOs_shifted] = shifted_trajectories(trajectories_UPOs, T, dt, M, number_points_trajectories, tau)

number_UPO=length(T);
trajectories_UPOs_shifted=zeros(length(0:dt:max(T)),M, number_UPO);
number_points_UPOs_shifted = zeros(1, length(T));

for i=1:length(T)
    [o,tnew, number_points] = shifted_upo(trajectories_UPOs(1:number_points_trajectories(i), :,i), T(i), dt, M, tau(i));
    trajectories_UPOs_shifted(1:number_points,:,i)=o;
    number_points_UPOs_shifted(i)=number_points;
end
    
