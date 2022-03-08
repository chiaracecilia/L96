% VIDEOINO CARINO CARINO
clear all
close all
axis tight manual 


%% import and creata data for video
load('upo_data.mat')
load('x_chaotic.mat')
load('indice_shad_UPO_reduced.mat')
load('shadowing_stats.mat')          
load('shadowing_UPO_reduced.mat')
load('dist_shadowing_UPO_reduced.mat')

% parameters
dt =0.01;
M = 40;
F = 5;

% calculate the trajectories of the shadowing UPOs only
quelle_che_approssimano = UPOs_approx_index(1:number_orbits_for_approximation(1),1);
X_sh = X(:,quelle_che_approssimano); 
T_sh = T(quelle_che_approssimano);
[trajectories_UPOs, number_points_trajectories, tau, dist] = create_matrix_trajectory_UPOs(X_sh,T_sh,dt,M, F);

% MOMENTS
% for each trajectory calculate its projection on the first three moments
traj_moments = traj_moments(trajectories_UPOs, number_points_trajectories);
% projection of the coordinates of the shadowing point on its first three moments 
[first_moment_upo, second_moment_upo, third_moment_upo] = projection_moments(coordinate_shadowing_reduced(:,:,1));
% projection on the moments of the chaotic trajectory
[first_moment_traj, second_moment_traj, third_moment_traj] = projection_moments(x_chaotic);

%%
v = VideoWriter('primo.avi');
open(v);

secondo_ergodico = 8.1;


first_moment_traj = first_moment_traj./ sqrt(secondo_ergodico);
first_moment_upo = first_moment_upo./ sqrt(secondo_ergodico);
second_moment_traj = second_moment_traj./secondo_ergodico;
third_moment_traj = third_moment_traj./(secondo_ergodico)^(3/2);
second_moment_upo = second_moment_upo./secondo_ergodico;
third_moment_upo = third_moment_upo./(secondo_ergodico)^(3/2);


for k=11:450  % for each point of the chaotic orbit, find and plot the closest UPO
    plot3(first_moment_traj(k-10:k+10),second_moment_traj(k-10:k+10),third_moment_traj(k-10:k+10), 'k','LineWidth',2)
    hold on
    plot3(first_moment_traj(k),second_moment_traj(k),third_moment_traj(k),'Color','k','Marker','*','LineWidth',10)
    hold on
    plot3(first_moment_upo(k),second_moment_upo(k),third_moment_upo(k), 'Color','r','Marker','*','LineWidth',10);
    hold on
    shad_orbit = shadowing_UPO_reduced(:,1);
    i = find(UPOs_approx_index(:,1)==shad_orbit(k));
    p = traj_moments(1:number_points_trajectories(i),1,i)./sqrt(secondo_ergodico);
    s = traj_moments(1:number_points_trajectories(i),2,i)./secondo_ergodico;
    t = traj_moments(1:number_points_trajectories(i),3,i)./(secondo_ergodico)^(3/2);
    plot3(p,s, t, 'r','LineWidth',1 );
% 
    xlim([0.4,0.9]);
     ylim([0.9,1.35]);
     zlim([1,2.9]);
%     colormap(gca, c);
%     l = colorbar;
%     title(l,'T')
% %     caxis([min(T) max(T)])
  set(0,'defaulttextinterpreter','latex')
    ylabel('$first moment$')
    xlabel('$second moment$')
    zlabel('$third moment$')
     set(gca,'FontSize', 15)
     hold off
    frame=getframe(gcf);
    writeVideo(v,frame);
end



close(v);