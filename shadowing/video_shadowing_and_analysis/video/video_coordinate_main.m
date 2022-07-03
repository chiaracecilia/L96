% VIDEOINO CARINO CARINO
clear all

%% import and creata data for video
load('upo_data.mat')
load('x_chaotic.mat')
load('indice_shad_UPO_reduced.mat')
load('shadowing_stats.mat')          
load('shadowing_UPO_reduced.mat')
load('dist_shadowing_UPO_reduced.mat')

% parameters
dt =0.01;
M = 20;
F = 5;
%%
% calculate the trajectories of the shadowing UPOs only
quelle_che_approssimano = UPOs_approx_index(1:number_orbits_for_approximation(1),1);
X_sh = X(:,quelle_che_approssimano); 
T_sh = T(quelle_che_approssimano);

[trajectories_UPOs, number_points_trajectories, tau, dist] = create_matrix_trajectory_UPOs(X_sh,T_sh,dt,M, F);



% persistence
[times, persistence, space] = pers(length(T), shadowing_UPO_reduced, x_chaotic);
per = persistence(quelle_che_approssimano);
tim = times(quelle_che_approssimano);
persistenza = per./tim;
%%
close all
axis tight manual 
v = VideoWriter('primo.avi');
open(v);

closest_UPOs = shadowing_UPO_reduced(:,1);

c = flip(hot(length(T_sh)));

[points_sorted, idx] = sort(T_sh);
[~,j] =sort(idx);
shad_orbit = shadowing_UPO_reduced(:,1);

x= 1;
y=7;
z=17;


for k=11:450  % for each point of the chaotic orbit, find and plot the closest UPO
    
    plot3(x_chaotic(k-10:k+10,x),x_chaotic(k-10:k+10,y),x_chaotic(k-10:k+10,z), 'k','LineWidth',2) % chaotic traj
    hold on
    plot3(x_chaotic(k,x),x_chaotic(k,y),x_chaotic(k,z),'Color','k','Marker','*','LineWidth',10) % point where it shadows
    hold on
    
    i = find(UPOs_approx_index(:,1)==shad_orbit(k));
    plot3(trajectories_UPOs(indice_shad_UPO_reduced(k,1), x, i),trajectories_UPOs(indice_shad_UPO_reduced(k,1), y, i),trajectories_UPOs(indice_shad_UPO_reduced(k,1), z, i), 'Color','r','Marker','*','LineWidth',10);
    hold on
    
  
    plot3(trajectories_UPOs(1:number_points_trajectories(i), x, i),trajectories_UPOs(1:number_points_trajectories(i), y, i), trajectories_UPOs(1:number_points_trajectories(i), z, i), 'Color',c(j(i),:) );
    
    
    %title( "UPO number: "+ i + ",\quad persistence:" + persistenza(i))

%     xlim([0.4,0.9]);
%      ylim([0.9,1.35]);
%      zlim([1,2.8]);
    colormap(gca, c);
    l = colorbar;
    title(l,'T')
    caxis([min(T) max(T)])
  set(0,'defaulttextinterpreter','latex')
    ylabel('$x_7$')
    xlabel('$x_1$')
    zlabel('$x_{17}$')
     set(gca,'FontSize', 15)
     hold off
    frame=getframe(gcf);
    writeVideo(v,frame);
end



close(v);