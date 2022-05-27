%% global expoonents
clear all
clc

F = 5;
n= 20;
tau = 0.01;
tstart = 0;
tend = 1000;


ystart = rand(1,n);
ioutp = 0;
%%
% stept = [0.1:0.1:1.1];
% 
% 
% for i = 1 : length(stept)
%     [~,~, Lambda(:,i) ]=lyapunov_midpoint(n,F, tau, tstart,stept(i),tend,ystart,ioutp);
% end
% 
% %%
% k=1;
% plot(stept,Lambda(k,:), '*')
% xlabel('tau')
% ylabel('Lyapunov Exponent Dynamics')
% title('35th exponent')

%%
[~,~, Lambda]=lyapunov_midpoint(n,F, tau, tstart,0.1,10000,ystart,ioutp);