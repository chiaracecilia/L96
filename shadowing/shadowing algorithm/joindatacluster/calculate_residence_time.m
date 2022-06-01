load('upo_data.mat')
load('shadowing_UPO.mat')
N=1000;
dt = 0.01;

[number_orbits_for_approximation, UPOs_approx_index, time_approx, period_approx] = residence_time_tiers(shadowing_UPO, dt, T,  N);