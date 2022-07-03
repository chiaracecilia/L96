% This function calculates the resident times of the chaotic orbit on each
% UPO

% INPUT: x_chaotic: trajectory of the chaotic orbit
%       closest_UPOs: for each point on the chaotic trajectory, index that identify the closest UPO

% OUTPUT: total time: for each UPO, how long it has been used in the
% shadowinig. as loong as the number of UPOs of the database
% number_orbits_for_approximation: number of orbits used in the shadowing
% UPOs_approx_index: index of the UPOs considered in the shadowing
% time_approx: for each UPO, time considered for the approximation
% period approx: period of the UPOs considered in the shadowing
% lambda_approx: lyap expo of the shadowing UPO

function [number_orbits_for_approximation, UPOs_approx_index, time_approx , period_approx] = residence_time(shadowing_UPO, dt, T)

number_UPOs = length(T); 
total_time = zeros(number_UPOs,1); % records the total time spent on the UPO10

for j=1:number_UPOs % consider the UPO at position j
    count=0; % how many times have I considered the UPO j?
    for i=1:length(shadowing_UPO) % consider point i along the chaotic trajectory
        if(shadowing_UPO(i)==j)
            count=count+1;
        end
    end
    total_time(j)=count;
end


% now just record the orbits considered in the approximation and the
% average time of stay. EXCLUDE THE ONES THAT ARE NOT USED

number_orbits_for_approximation=nnz(total_time);

UPOs_approx_index=zeros(number_orbits_for_approximation,1); % index corresponding to the upo
time_approx=zeros(number_orbits_for_approximation,1);   % residence time
period_approx = zeros(number_orbits_for_approximation,1); 
j=0;

for i=1:number_UPOs
    if (total_time(i))
    j=j+1;
    time_approx(j)= total_time(i)*dt; 
    UPOs_approx_index(j)=i;
    period_approx(j)=T(i);
    end
end
    

end       
            


