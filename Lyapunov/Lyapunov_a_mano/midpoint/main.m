
clear all
clc

%load('F5_raw.mat')
load('raw_F5_M20.mat')

N = 20;
F = 5;
M = N;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
j=1; % choose the UPO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dt = 0.01;

T = Tp(j); % period UPO
X = Xp(:, j);
L= Lp(:,j);

T_timeunits = T/dt;
tau = dt * T_timeunits/fix(T_timeunits);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dtL=T; % each step of the Lyapunov simulation is dtL long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tfin=100*T; % Final time. How many times do I turn around the period?


%% GS ALGO

Lambda_GS = lyapunov_UPOs_midpoint(dtL, X,T,Tfin, F, M);
Lambda_byhand = LE_byhand(N, F, dtL,Tfin, T, X, tau);


%% Plot the stuff

plot(Lambda_GS, 'o', 'DisplayName','QR decomposition')
hold on 
plot(Lambda_byhand, 'd', 'DisplayName','QR decomposition')
hold on 
plot(L, '*', 'DisplayName','Andreys LE')