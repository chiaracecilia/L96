% UPO j shadows with persistence M if it is a shadowing orbit within the
% first M tiers

% INPUT
% shadowing_UPO (length_chaotic_trajectory, number_of_tiers) this are the
% shad UPOs for all tiers
% M (1,1) I want to consider persistence up to tier M

% OUTPUT
% persistent_shadowing_UPO (length_chaotic_trajectory,1) these are the new
% shadowing orbits according to the new persistence definition 

function [persistent_shadowing_UPO] = persistent_shadowing(shadowing_UPO, M)

persistent_shadowing_UPO= zeros(1,length(shadowing_UPO(:,1)));

persistent_shadowing_UPO(1) = shadowing_UPO(1,1);

for i =2:length(shadowing_UPO(:,1))
    for j=1:M
        if ( shadowing_UPO(i,j) == persistent_shadowing_UPO(i-1)) 
            persistent_shadowing_UPO(i) = shadowing_UPO(i,j);
            break
        end
    end
    if ( persistent_shadowing_UPO(i) == 0)
        persistent_shadowing_UPO(i) = shadowing_UPO(i,1);
    end
end
        
          
      
                
        