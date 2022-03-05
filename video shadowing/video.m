% VIDEOINO CARINO CARINO
close all
axis tight manual 

v = VideoWriter('primo.avi');
open(v);

% closest_UPOs = shadowing_UPO_reduced(:,1);
% 
% [x,y]=meshgrid(-20:5:20,-28:5:28 ); % fix axes length
% loc_bar=[18,18,0];
% c = flip(hot(length(T)));
% 
% [points_sorted, idx] = sort(T);
% [~,j] =sort(idx);

for k=1:450  % for each point of the chaotic orbit, find and plot the closest UPO
    plot3(first_moment_traj(k:k+10),second_moment_traj(k:k+10),third_moment_traj(k:k+10), 'k','LineWidth',2)
    hold on
    plot3(first_moment_traj(k),second_moment_traj(k),third_moment_traj(k),'Color','k','Marker','*','LineWidth',10)
    hold on
    plot3(first_moment_upo(k),second_moment_upo(k),third_moment_upo(k), 'Color','r','Marker','*','LineWidth',10);
    hold on
    shad_orbit = shadowing_UPO_reduced(:,1);
    i = find(UPOs_approx_index(:,1)==shad_orbit(k));
    plot3(traj_moments(1:number_points_trajectories(i),1,i),traj_moments(1:number_points_trajectories(i),2,i), traj_moments(1:number_points_trajectories(i),3,i), 'r','LineWidth',1 );
% 
%     xlim([1.4,2.5]);
%      ylim([7.5,11]);
%      zlim([25,50]);
%     colormap(gca, c);
%     l = colorbar;
%     title(l,'T')
% %     caxis([min(T) max(T)])
%     set(0,'defaulttextinterpreter','latex')
%     ylabel('$first moment$')
%     xlabel('$second moment$')
%     zlabel('$third moment$')
%     set(gca,'FontSize', 15)
     hold off
    frame=getframe(gcf);
    writeVideo(v,frame);
end



close(v);