clear all
clc

try
    load('upo_data.mat')
    load('shadowing_UPO.mat')
    %%
    N=10;
    dt = 0.01;
    
    [number_orbits_for_approximation, UPOs_approx_index, time_approx, period_approx] = residence_time_tiers(shadowing_UPO, dt, T,  N);
    
    save('number_orbit_approx.mat', 'number_orbits_for_approximation')
    save('UPOs_approx_index.mat','UPOs_approx_index.mat')
    save('time_approx.mat','time_approx')
    save('period_approx.mat','period_approx')
    
catch err
    fid = fopen('errorFile','a+');
    fprintf(fid, '%s', err.getReport('extended', 'hyperlinks','off'));
    fclose(fid);
    
end
