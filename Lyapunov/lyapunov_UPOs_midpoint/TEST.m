%% this function calculates the lyapunov exponents for the UPOs of the system
%%
clear all

load('F8_raw.mat')
Integrator = @lorenz96_ext;
M=40;
F=8;
dt=0.01;

j=3;
ic = Xp(:,j);
T = Tp(j);
[x, dist] = calculate_UPO(ic, T, dt/10,M, F);
Initial_time=0;          %Initial time: 0

%%
Iteration = 0.10; % this is measured in time (and not time-steps)

n=1000;
Final_time=Tp(j)*n;         %Final Time: 1000 sec 


Discard_time = Tp(j)*500 ; 
period_UPO=Tp(j);

%%
[Lexp, Texp, Lambda, giro] = lyapunov(Integrator, M,F, Tp(j),Initial_time, Final_time, dt, Iteration , Discard_time, ic);
%%
% 
% h = [Tp(j)*2, Tp(j)*3, Tp(j)*4, Tp(j)*5, Tp(j)*6, Tp(j)*7, Tp(j)*9, Tp(j)*10, Tp(j)*11, Tp(j)*12, Tp(j)*13, Tp(j)*14, Tp(j)*15, Tp(j)*16, Tp(j)*17, Tp(j)*18, Tp(j)*19, Tp(j)*20, Tp(j)*30, Tp(j)*40, Tp(j)*50, Tp(j)*100];
% Lambda = zeros(40, length(h));
% for i=1:length(h)
%     [Lexp, Texp, Lambda(:,i), giro] = lyapunov(Integrator, M,F, period_UPO,Initial_time, h(i), dt, 0.35 , Discard_time, ic);
% end

%%

h = [0.5:0.01:1.3];
Lambda = zeros(40, length(h));
for i=1:length(h)
    [Lexp, Texp, Lambda(:,i), ~] = lyapunov(Integrator, M,F,Tp(j), Initial_time,Final_time, dt, h(i) , Discard_time, ic);
end

save('expo_UPO.mat')
%%
k=15;
plot(h,Lambda(k,:))
xlabel('tau')
ylabel('Lyapunov Exponent Dynamics')
title('35th exponent')