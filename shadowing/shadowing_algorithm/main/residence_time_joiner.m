% this function calculates the residence time and occupancy ratio of the shadowing UPOs

% load data
clear all
clc


filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/test_res_time/upo_data.mat'];
str=whos('-file',filename);
str={str.name};
load(filename,str{:});

filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/test_res_time/shadowing_UPO.mat'];
str=whos('-file',filename);
str={str.name};
load(filename,str{:});

filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/test_res_time/x_chaotic.mat'];
str=whos('-file',filename);
str={str.name};
load(filename,str{:});

dt=0.01;
N=100;

try
    [number_orbits_for_approximation, UPOs_approx_index, time_approx, period_approx] = residence_time_tiers(shadowing_UPO, dt, T,  N);
    
    save('res_time.mat', '-v7.3', 'number_orbits_for_approximation', 'UPOs_approx_index', 'time_approx', 'period_approx')
catch err
    fid = fopen('errorFile','a+');
    fprintf(fid, '%s', err.getReport('extended', 'hyperlinks','off'));
    fclose(fid);
end