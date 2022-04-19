% this algorithm calculates the shadowing orbits according to the new
% definition

M = 30; % persistence parameter

persistence_shadowing_orbits_30 = zeros(1,length(shadowing_UPO_reduced(:,1)));

persistence_shadowing_orbits_30(1) = shadowing_UPO_reduced(1,1);

for i =2:length(shadowing_UPO_reduced(:,1))
    for j=1:M
        if ( shadowing_UPO_reduced(i,j) == persistence_shadowing_orbits_30(i-1)) 
            persistence_shadowing_orbits_30(i) = shadowing_UPO_reduced(i,j);
            break
        end
    end
    if ( persistence_shadowing_orbits_30(i) == 0)
        persistence_shadowing_orbits_30(i) = shadowing_UPO_reduced(i,1);
    end
end
   

M = 10; % persistence parameter

persistence_shadowing_orbits_10 = zeros(1,length(shadowing_UPO_reduced(:,1)));

persistence_shadowing_orbits_10(1) = shadowing_UPO_reduced(1,1);

for i =2:length(shadowing_UPO_reduced(:,1))
    for j=1:M
        if ( shadowing_UPO_reduced(i,j) == persistence_shadowing_orbits_10(i-1)) 
            persistence_shadowing_orbits_10(i) = shadowing_UPO_reduced(i,j);
            break
        end
    end
    if ( persistence_shadowing_orbits_10(i) == 0)
        persistence_shadowing_orbits_10(i) = shadowing_UPO_reduced(i,1);
    end
end
          
      
                
        