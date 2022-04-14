%% global expoonents
clear all
clc

F = 8;
N= 40;
dt = 0.01;
dtL = 0.5;
Tfin = 100;
Tspin = 50;

yo = rand(1,N);

stept = [1.9:0.1:2];
Lambda = zeros(length(stept), N);

for i = 1 : length(stept)
    [Lambda(i,:) ]=lyap_midpoint(N,F, dt, stept(i),Tfin,Tspin, yo);
end

%%
k=1;
plot(stept,Lambda(:,k), '*')
xlabel('tau')
ylabel('Lyapunov Exponent Dynamics')
title('35th exponent')

