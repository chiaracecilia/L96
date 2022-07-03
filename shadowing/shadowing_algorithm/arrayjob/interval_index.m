% this function calculates the interval of indexes centered in "indice"
% with radius tau, given the UPO

% INPUT 
% indice: center of the interval
% tau: radius of the interval 
% number_points_UPO: number of points of the UPO. 

% OUTPUT
% interval_index: vector of size 2*tau + 1 containg the indexes that individuate
% the interval

function interval_indice = interval_index(indice, tau, number_points_UPO)

if(2*tau+1>number_points_UPO)
    interval_indice=1:number_points_UPO;
else
    pivot = indice-tau-1;
interval_indice = zeros(2*tau+1, 1);

for k=1:length(interval_indice)
    if(pivot+k<1)
        interval_indice(k)=number_points_UPO+pivot+k;
    elseif(pivot+k>number_points_UPO)
        interval_indice(k)=mod(pivot+k,number_points_UPO);
    else
        interval_indice(k)=pivot+k;
    end
end
end

