%% this function calculates the inter-orbit distance

% given two trajectories it calculates the minimum distance between
% the two orbits

function [min_inter_orbits_distance, mini, minj]  = inter_orbit_distance(traj_i, traj_j)

% find the closest point between the two orbits

% calculate all the distances of the possible couple of points
% i runs over y1, j runs over y2
dist_orbits = zeros(length(traj_i(:,1)),length(traj_j(:,1)));

for i=1:length(traj_i(:,1))
    for j=1:length(traj_j(:,1))   
        dist_orbits(i,j)=norm(traj_i(i,:)-traj_j(j,:));
    end
end

%%
% find the minimum distance
min_inter_orbits_distance = min(dist_orbits(:));
[mini,minj] = find(dist_orbits==min_inter_orbits_distance); %NB. this might be an array 