%% this function calculates the lyapunov exponents for the UPOs of the system
%%
clear all

load('F4_ic_raw.mat')
Integrator = @lorenz96_ext;
M=40;
F=4;
dt=0.01;
j=3;
ic = Xp(:,j);
T = Tp(j);
[x, dist] = calculate_UPO(ic, T, dt,M, F);
Initial_time=0;          %Initial time: 0



Iteration = 0.15; % this is measured in time (and not time-steps)

n=20;
Final_time=Tp(j)*n;         %Final Time: 1000 sec 
Discard_time = Tp(j) ; 
period_UPO=Tp(j);

%%
%[Lexp, Texp, Lambda, giro] = lyapunov(Integrator, M,F, Tp(j),Initial_time, Final_time, dt, Iteration , Discard_time, ic);
%%

h = [Tp(j)*2, Tp(j)*3, Tp(j)*4, Tp(j)*5, Tp(j)*6, Tp(j)*7, Tp(j)*9, Tp(j)*10, Tp(j)*11, Tp(j)*12, Tp(j)*13, Tp(j)*14, Tp(j)*15, Tp(j)*16, Tp(j)*17, Tp(j)*18, Tp(j)*19, Tp(j)*20, Tp(j)*30, Tp(j)*40, Tp(j)*50, Tp(j)*100];
Lambda = zeros(40, length(h));
for i=1:length(h)
    [Lexp, Texp, Lambda(:,i), giro] = lyapunov(Integrator, M,F, period_UPO,Initial_time, h(i), dt, 0.35 , Discard_time, ic);
end

%%
n=8;
Final_time=Tp(j)*40; 
h = [0.01,0.02, 0.04, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.45, 0.5, 0.55, 0.6, 0.7, 1.2, 1.3];
Lambda = zeros(40, length(h));
for i=1:length(h)
    [Lexp, Texp, Lambda(:,i), ~] = lyapunov(Integrator, M,F,Tp(j), Initial_time,Final_time, dt, h(i) , Discard_time, ic);
end

%%
k=35;
plot(h,Lambda(k,:),'*')
xlabel('tau')
ylabel('Lyapunov Exponent Dynamics')
title('35th exponent')