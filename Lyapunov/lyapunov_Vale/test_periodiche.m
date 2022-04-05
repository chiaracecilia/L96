
clear all
clc

load('F8_raw.mat')

j=4;
T = Tp(j);
stept = [T/5, T/6, T/7, T/8, T/9 ,T/10, T/11, T/12, T/13, T/14, T/15, T/16, T/17, T/18, T/19, T/20, T/21, T/22, T/23, T/24, T/25, T/26, T/27, T/28, T/29, T/30];
Lambda = zeros(40, length(stept));
turn = zeros(1, length(stept));
for i = 1 : length(stept)
    [Lambda(:,i), turn(i)] = lyapunov_UPOs_midpoint(stept(i));
end

%%
k=29;
plot(stept,Lambda(k,:))
xlabel('tau')
ylabel('Lyapunov Exponent Dynamics')
title('35th exponent')