%%% this function calculates the distance in a quantity of respective
%%% orbits

function S = distance_quantity(quantity)

S = zeros(length(quantity), length(quantity));

for i = 1: length(quantity)
    for j = 1:length(quantity)
        S(i,j)=abs(quantity(i)-quantity(j));
    end
end