% Given a dataset of UPOs this function creates a square matrix that stores
% for each column all the points belonging to that orbit, up to its period
% T. 
% The longer orbit will contain more points and it will decide the
% dimension of the matrix. In the matrix, all the missing spaces will be
% filled with 0s.

% INPUT: X: initial conditions of the UPOs
%        T: period of the UPOs
%        dt: time step
% OUTPUT: trajectories_UPOs
%         number_points_trajectories, number of point in each numerical
%         trajectory

function [trajectories_UPOs, number_points_trajectories, tau, dist] = create_matrix_trajectory_UPOs(X,T,dt,M, F)


number_UPO=length(T);
trajectories_UPOs=zeros(length(0:dt:max(T)),M, number_UPO); %create the matrix that will store the trajectory of the UPOs
tau = zeros(1, length(T));
number_points_trajectories = zeros(number_UPO,1);
dist = zeros(1, number_UPO);
T_timeunits = T/dt;
% now fill the matrix
for i=1:number_UPO % calculate all the points for each orbit
    tau(i) = dt * T_timeunits(i)/fix(T_timeunits(i));
    number_points_trajectories(i) = number_points_UPO(T(i), tau(i));
    x = midpoint(0,tau(i), T(i), X(:,i), M, F); % x contains the trajectory
    % now fill the matrix up to the point 
    dist(i)=norm(x(1,:)-x(end,:));
    trajectories_UPOs(1:length(x),:,i)=x;
    
end
end
