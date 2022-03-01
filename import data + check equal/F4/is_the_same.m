%% this function tests whether two orbits are the same 

% the two orbits have very similar period, thus I have to see whether they
% co-evolve for a full period 

% flag: 0 if no UPOs as mininterorbitdistance is too big, 1 if they don't
% co-evolve, 2 if they are the same. 

function [flag, min_inter_orbits_distance] = is_the_same(Xi, Xj, Ti, Tj, dt, F, M, tol)

% first I calculate the two trajectories 


[xi, ~] = calculate_UPO(Xi, Ti, dt,M,F);
[xj, ~] = calculate_UPO(Xj, Tj, dt,M,F);

%%
% find the closest point between the two orbits

% calculate all the distances of the possible couple of points
% i runs over y1, j runs over y2
dist_orbits = zeros(length(xi(:,1)),length(xj(:,1)));

for i=1:length(xi(:,1))
    for j=1:length(xj(:,1))   
        dist_orbits(i,j)=norm(xi(i,:)-xj(j,:));
    end
end

%%
% find the minimum distance
min_inter_orbits_distance = min(dist_orbits(:));
[mini,minj] = find(dist_orbits==min_inter_orbits_distance); %NB. this might be an array 

%%
if(min_inter_orbits_distance>tol)
    flag = 0;
    
else % check whether the two orbits are the same
    
    %now solve again Lorenz for the points that realise the minimum
    [xi2, ~] = calculate_UPO(xi(mini(1),:), Ti, dt,M, F);
    [xj2, ~] = calculate_UPO(xj(minj(1),:), Tj, dt,M, F);
    
    mint = min(length(xi2(:,1)),length(xj2(:,1)));

    % now calculate the distance of the corresponding points. 
    ndist=zeros(1,mint);
    
    for i=1:mint
        ndist(i)=norm(xi2(i,:)-xj2(i,:));
        % now analyse the distance, if it is bigger than the tolerance,
        % then exit. the two orbits are different
        if(ndist(i)>tol)
            flag=0;
            break;
        end
    end
    % If I got to this point, then the two orbits are the same.
    flag=1;
end
end

    





