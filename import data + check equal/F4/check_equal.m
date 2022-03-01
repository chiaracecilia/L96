%% this script examines all the orbit and calculates whether there are repeated orbits

load('ic.mat')
% parameters
dt=0.01;
M=40;
F=4;


[trajectories_UPOs, number_points_trajectories, tau, dist] = create_matrix_trajectory_UPOs(Xp,Tp,dt,M, F);
[primo,secondo, terzo, quarto, quinto] = moments_UPOs(trajectories_UPOs, number_points_trajectories);
%%
S = distance_quantity(primo);
err = 0.5;
suspicion = S<err;
suspicion = suspicion.*~eye(size(suspicion));

%%
tol = 10^(-15);

%%
same_or_symmetric = zeros(length(Tp), length(Tp));

%%

for i=1:length(Tp)
    for j = i:length(Tp)
        if(suspicion(i,j))
            Xi = Xp(:,i);
            Ti=Tp(i);
            Xj = Xp(:,j);
            Tj=Tp(j);
            [same, min_inter_orbits_distance] = is_the_same(Xi, Xj, Ti, Tj, dt, F, M, tol);
            if (same)
                same_or_symmetric(i,j)=1;
                break
            else
                [flag] = is_symmetric(Xi, Xj, Ti, Tj, dt, F, M, tol);
                if (sum(flag))
                    same_or_symmetric(i,j) = find(flag~=0);
                end
            end
        end
    end
end
           
            
            