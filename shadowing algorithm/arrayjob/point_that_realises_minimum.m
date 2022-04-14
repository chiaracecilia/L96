% this function given a UPO and a point x, find the point on the UPO that
% minimise the distance with the point x

% INPUT 
% UPO traj: trajectory of the UPO I am considering
% punto: point for which I am minimising the distance

% OUTPUT
% coord: coord of the point that realises the minimum
% dist: dist of the point that realises the minimum 
% index: index of the point that realises the minimum along the UPO

function [coord, dist, index] = point_that_realises_minimum(UPO_traj, punto)

number_points_traj = length(UPO_traj(:,1));
% consider each point of the UPO and calculate the distance with punto. 
dist = distanza_punto_traiettoria(punto,UPO_traj, 1);
coord = UPO_traj(1,:);
index = 1;

for i=2:number_points_traj
    dist_new = distanza_punto_traiettoria(punto,UPO_traj, i);
    if (dist_new<dist)
        dist = dist_new;
        coord = UPO_traj(i,:);
        index = i;
    end
end

