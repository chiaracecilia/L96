% this function calculates the mean and stdev in each bin 

%% INPUT
% bin(1, number_bins)
% occupancy_ratio
% period_approx

%% OUTPUT
% it finds the mean of "quantity" for those points for each bin
% it finds corresponding percentiles as well
function [aver, deviaz,  aver_per, neg, pos] = data_for_error_bar(bin, quantity, xaxis)


aver = zeros(1, length(bin)-1);
deviaz = zeros(1, length(bin)-1);
aver_per = zeros(1, length(bin)-1);
neg = zeros(1, length(bin)-1);
pos = zeros(1, length(bin)-1);

for i=1:length(bin)-1
    d = (xaxis>bin(i));
    e =(xaxis<bin(i+1));
    idx = find(d+e ==2) ;
    aver(i) = mean(quantity(idx));
    deviaz(i) = std(quantity(idx));
    l = prctile(quantity(idx),2.5);
    u = prctile(quantity(idx),97.5);
    neg(i) = aver(i)- l;
    pos(i) = u-aver(i);
    aver_per(i) = mean(xaxis(idx));
end