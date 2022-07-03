%%% calculate the average persistence of each shadowing UPO

% for each orbit calculate how many times it is chosen consecutively on
% average average


function [times, count, average_persistence] = average_persistence_UPOs(number_UPO, shadowing_UPO)

count = zeros(1, number_UPO);
average_persistence = zeros(1, number_UPO);
times = zeros (1, number_UPO);


count(shadowing_UPO(1))=1;
times(shadowing_UPO(1)) = 1;


for i = 2:length(shadowing_UPO)

    count(shadowing_UPO(i)) = count(shadowing_UPO(i))+1;
    times(shadowing_UPO(i)) = times(shadowing_UPO(i))+1;
    
    if(shadowing_UPO(i-1)==shadowing_UPO(i))
        times(shadowing_UPO(i)) = times(shadowing_UPO(i))-1;        
    end
    
end

idx = (count ~= 0);
average_persistence(idx) = count(idx)./times(idx);




