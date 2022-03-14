%%% calculate the persistence of each orbit here 

% for each orbit calculate how many times it is chosen consecutively on
% average


function [times, persistence, space] = pers(number_UPO, shadowing_UPO, x_chaotic)

persistence = zeros(1, number_UPO);
times = zeros (1, number_UPO);
space = zeros (1, number_UPO);

persistence(shadowing_UPO(1))=1;
times(shadowing_UPO(1)) = 1;
space(shadowing_UPO(1)) = norm(x_chaotic(2,:)-x_chaotic(1,:));

for i = 2:length(shadowing_UPO)
    persistence(shadowing_UPO(i)) = persistence(shadowing_UPO(i))+1; % how many times it shadows
    times(shadowing_UPO(i)) = times(shadowing_UPO(i))+1;  % I assume that every time it is shadowing for a single time
    
    space(shadowing_UPO(i)) = space(shadowing_UPO(i)) + norm(x_chaotic(i,:)-x_chaotic(i-1,:));
    
    if(shadowing_UPO(i-1)==shadowing_UPO(i)) % if it instead was persisting, consider it as one.s
        times(shadowing_UPO(i)) = times(shadowing_UPO(i))-1;
  
        
    end
    
end
     
end
            
        

