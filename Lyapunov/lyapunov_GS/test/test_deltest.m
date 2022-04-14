
clear all
clc

load('F8_raw.mat')

j=3;
T = Tp(j);
X = Xp(:,j);
tend = T*1000;

stept = [T, T/2, T/3, T/4, T/5, T/6, T/7, T/8];
div=[1:10];
Lambda = zeros(40, length(stept));
turn = zeros(1, length(stept));

for i = 1 : length(stept)

    [Lambda(:,i)] = lyapunov_UPOs_midpoint_test(stept(i),  X, T, tend);
end

%%
k=1;
plot(stept(:),Lambda(k,:), '*')
xlabel('tau')
ylabel('Lyapunov Exponent Dynamics')
