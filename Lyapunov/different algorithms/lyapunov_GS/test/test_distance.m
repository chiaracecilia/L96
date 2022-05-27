%%% I want to check how far the UPO solved with ode45 or midpoint scheme
%%% gets when evolving for tau

clear all

M=40;
F=8;

tau = 0.1;
dt = 0.01;

rng(1);
ic = rand(1,M);

tmin = 0;
tmax = 0.1;

dt = 0.01;


x_mi = midpoint(@lorenz96, tmin,dt, tmax, ic, M, F);

[t, x_ode] = ode45(@lorenz96ode, [tmin dt tmax], ic);

d = zeros(1, length(x_mi(:,1)));
for i = 1:length(x_mi(:,1))
    d(i) = norm(x_mi(i,:)- x_ode(i,:));
end
    
%%
clear all
load('expo.mat');
Lexp = Lexp(end/2:end, :);
Res = Res(end/2:end, :);

Lode = mean(Lexp);
Lmid = mean(Res);

diff = mean(Lode - Lmid);

