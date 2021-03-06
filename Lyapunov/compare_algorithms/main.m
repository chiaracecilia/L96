clear all
clc

%load('F5_raw.mat')
load('raw_F5_M20.mat')

N = 20;
F = 5;
M = N;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
j=2; % choose the UPO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T = Tp(j); % period UPO
X = Xp(:, j);
L= Lp(:,j);

dt = 0.01;
T_timeunits = T/dt;
tau = dt * T_timeunits/fix(T_timeunits);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dtL=T/3; % each step of the Lyapunov simulation is dtL long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Tfin=400*T; % Final time. How many times do I turn around the period?


%% ALGO

[Lambda_GS, Lexp_istGS] = lyapunov_UPOs_midpoint(dtL, X,T,Tfin, F, M);
[Lambda_byhand, Lexp_ist_byhand] = LE_byhand(N, F, dtL,Tfin, T, X, tau);


%% Plot the stuff

plot(Lambda_GS, 'o', 'DisplayName','Integrate tangent linear, GS algorithm')
hold on 
plot(Lambda_byhand, '*', 'DisplayName','measure evolution displacement, QR matlab func')
hold on 
plot(L, 'o','Color','g','MarkerSize',2,'MarkerFaceColor','g',  'DisplayName','Andreys LE')
title("T =" + T)
legend