%% this script calculates how many positive, null and negative LE of a UPO

function [number_positive, number_negative, mean_pve, mean_ne, z, zero, KS_entropy] = sign_LE(LE)


% find zero value
z = min(abs(LE));
idx = find(abs(LE)==z);
zero = length(idx);

if(length(idx)>1)
    % find positive exponents
number_positive = sum(LE>LE(idx(1)));
number_negative = sum(LE<LE(idx(end)));

% calculate mean values exponents
mean_pve = mean(LE(1:idx(1)-1));
mean_ne = mean(LE(idx(end)+1:end));

% calculate sum of the positive exponents
KS_entropy = sum(LE(1:idx-1));

else
    

% find positive exponents
number_positive = sum(LE>LE(idx));
number_negative = sum(LE<LE(idx));

% calculate mean values exponents
mean_pve = mean(LE(1:idx-1));
mean_ne = mean(LE(idx+1:end));

% calculate sum of the positive exponents
KS_entropy = sum(LE(1:idx-1));

end