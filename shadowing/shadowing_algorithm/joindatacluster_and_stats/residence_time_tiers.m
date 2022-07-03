%% For each tier calculate the number of shadowing UPOs and their features

% INPUT
% N number of tiers
% x_chaotic (T_max, 3): trajectory of the chaotic orbit
% indice_shad_UPO_reduced(T_max, N): for each point i on the chaotic trajectory, index that
% identifies the N closest UPOs
% lambda(1,number_UPOs): maximal Lyap expo of the UPOs in the db


% OUTPUT: total time(number_UPOs, N): for each UPO in each tier, its total shadowing
% time
 % number_orbits_for_approximation(1,N): number of orbits used in the
% shadowing for each tier
% since the number of shadowing UPOs can vary from tier to tier, then
% initialise these values with the maximum number of UPOs, and then fill it
% only where required
% UPOs_approx_index(number_UPOs, N): index of the UPOs. 
% considered in the shadowing in each tier
% time_approx(number_UPOs, N): for each UPO in each tier, time considered for the approximation
% period_approx(number_UPOs, N): period of the UPOs considered in the shadowing
% lambda_approx(number_UPOs, N): lyap expo of the
% shadowiing UPO in each tier


function [number_orbits_for_approximation, UPOs_approx_index, time_approx, period_approx] = residence_time_tiers(shadowing_UPO_reduced, dt, T,  N)

% initialise the variables 

number_UPOs = length(T);
UPOs_approx_index = zeros(number_UPOs,N);
time_approx = zeros(number_UPOs,N);
period_approx = zeros(number_UPOs, N);
number_orbits_for_approximation = zeros(1,N);


for i = 1:N
    [number_orbits_for_approximation(i), indice, tempo, periodo ] = residence_time(shadowing_UPO_reduced(:,i), dt, T);
    UPOs_approx_index(1:number_orbits_for_approximation(i),i)=indice;
    time_approx(1:number_orbits_for_approximation(i),i)=tempo;
    period_approx(1:number_orbits_for_approximation(i),i)=periodo;


end


    
    