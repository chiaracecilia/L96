%% this function calculates the stochastic matrix

% INPUT
% x_chaotic (T_max/dt, 3) chaotic trajectory 
% shadowing_UPOs (T_max/dt,1) UPO that shadows the trajectory at each time
% step
% T(number_UPOs,1): period of the periodic orbit

% OUTPUT
% TRANSITION(number_UPOs,number_UPOs): transition matrix

function [TRANSITION] = matrix(shadowing_UPO, T)

number_UPOs = length(T);
TRANSITION = zeros(number_UPOs,number_UPOs);

% fill the transition matrix with the data from the UPOs 
for t = 1:length(shadowing_UPO)-1
    TRANSITION(shadowing_UPO(t+1), shadowing_UPO(t)) = TRANSITION(shadowing_UPO(t+1), shadowing_UPO(t))+1;
end

% transform the counts in probability
for i =1:number_UPOs
    if(sum(TRANSITION(:,i)))
        TRANSITION(:,i) = TRANSITION(:,i)./sum(TRANSITION(:,i));
    end
end
