% make sure that length each piece divide T_chaotic and that in the
% parameters.txt I have exactly  T_chaotic/length_each_piece number of
% parameters indicating each piece

function []=prova(j)

try tStart = tic;
    
    % load data
    load('upo_data.mat')
    
    %%%%%%%%%%%%%% modify accordingly %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    T_chaotic = 10^4;
    length_each_piece = 100;
    N=1000; % number of tiers
    M=20;
    F=5;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    seed = 2002;
    
    dt = 0.01;
    
    tau=5;
    K = 10; % every K time step execute the full algorithm
    
    
    % create the chaotic trajectory
    x_chaotic = create_chaotic_trajectory_j(j, length_each_piece, dt, T_chaotic,M, F, seed);
    
    % create trajectories UPOs
    [trajectories_UPOs, number_points_trajectories, ~, dist] = create_matrix_trajectory_UPOs(X,T,dt,M, F);
    
    % reduced algorithm
    [shadowing_UPO_reduced,dist_shadowing_UPO_reduced,coordinate_shadowing_reduced,indice_shad_UPO_reduced] = shadowing_UPOs_every_K_steps(x_chaotic, trajectories_UPOs, number_points_trajectories, tau, K, N,M);
    
    % save data
    tEnd = toc(tStart) ;
    save('tempo.mat', 'tEnd')
    save('shadowing_UPO_reduced.mat','shadowing_UPO_reduced', 'coordinate_shadowing_reduced')
    save('dist_shadowing_UPO_reduced.mat', 'dist_shadowing_UPO_reduced', 'dist')
    save('x_chaotic.mat', 'x_chaotic')
    save('indice_shad_UPO_reduced.mat','indice_shad_UPO_reduced')
    
catch err
    fid = fopen('errorFile','a+');
    fprintf(fid, '%s', err.getReport('extended', 'hyperlinks','off'));
    fclose(fid);
end