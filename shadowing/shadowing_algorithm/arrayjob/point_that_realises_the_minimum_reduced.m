% this function finds the point that minimise the distance between punto
% and the given UPO

% INPUT
% punto: point that I with which I want to minimise the distance 
%`traj_UPO: trajectory of the UPO that I am considering
% indice_shad_UPO_previous_step: index that at the previous time step along
% the chaotic trajectory realises the minimum with punto
% tau: I look for the minimum in the interval centered in punto with radius

% OUTPUT
% coord: coord of the point that realises the minimum 
% dist: distance of the point that realises the minimum
% indice_shad_UPO: index along the UPO of thepoint that realises the
% minimum 

function [coord, dist, indice_shad_UPO] = point_that_realises_the_minimum_reduced(punto, traj_UPO, indice_shad_UPO_previous_step, tau)

% select the indexes that individuate the window
number_points_UPO = length(traj_UPO(:,1));

interval_indice = interval_index(indice_shad_UPO_previous_step, tau, number_points_UPO);

% now calculate the distances for each point individuato da interval_indice
% with punto
dist = distanza_punto_traiettoria(punto,traj_UPO, interval_indice(1));
coord = traj_UPO(interval_indice(1),:);
indice_shad_UPO = interval_indice(1);

for i=2:length(interval_indice)
     dist_new = distanza_punto_traiettoria(punto,traj_UPO, interval_indice(i));
    if (dist_new<dist)
        dist = dist_new;
        coord = traj_UPO(interval_indice(i),:);
        indice_shad_UPO = interval_indice(i);
    end
end
    
    
 
