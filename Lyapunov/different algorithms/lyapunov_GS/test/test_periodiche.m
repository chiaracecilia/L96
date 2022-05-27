
clear all
clc

load('F8_raw.mat')

j=4;
T = Tp(j);
X = Xp(:,j);
stept = [ 2*T, T, T/2, T/3, T/4, T/5, T/6,  T/8 ,T/10, T/11,  T/13,  T/15,  T/20, T/30];
Lambda = zeros(40, length(stept));
turn = zeros(1, length(stept));

for i = 1 : length(stept)
    [Lambda(:,i), turn(i)] = lyapunov_UPOs_midpoint(stept(i), j);
end

%%
k=1;
plot(stept,Lambda(k,:), '*')
xlabel('tau')
ylabel('Lyapunov Exponent Dynamics')
title('35th exponent')