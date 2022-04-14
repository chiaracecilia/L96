
clear all
clc

load('F5_raw.mat')
F=5;
M=40;

j=3;
T = Tp(j);
X = Xp(:,j);
nit = 1000;
tend = T*nit;

stept = [T, T/2, T/3, T/4, T/5, T/6, T/7];

Lambda = zeros(40, length(stept));
Lexp_ist = zeros(nit,40, length(stept));
Lexp_cum = zeros( nit, 40,length(stept));
turn = zeros(1, length(stept));

for i = 1 : length(stept)
    [Lambda(:,i)] = lyapunov_UPOs_midpoint(stept(i),  X, T, tend, F, M);
end
%%
j=8;
plot(Lexp_ist(:,j));
%%
k=2;
plot(stept(:),Lambda(k,:), 'o','Color','r','MarkerSize',10,'MarkerFaceColor','r', 'DisplayName','second exponent')
xlabel('iteration step duration')
ylabel('Value of the Lyapunov exponent')
hold on
k=1;
plot(stept(:),Lambda(k,:), 'o','Color','b','MarkerSize',10,'MarkerFaceColor','b', 'DisplayName','first exponent')
hold on
k=3;
plot(stept(:),Lambda(k,:), 'o','Color','g','MarkerSize',10,'MarkerFaceColor','g', 'DisplayName','third exponent')
k=4;
plot(stept(:),Lambda(k,:), '*','Color','r','MarkerSize',10,'MarkerFaceColor','r', 'DisplayName','fourth exponent')
legend

%%
%% plot Lyapunov spectra
i=11;
plot(Lambda_average_second_half, '-o')
hold on 
plot(i,Lambda_average_second_half(i),  '-o','Color','r','MarkerSize',10,'MarkerFaceColor','r', 'DisplayName','Condizione Iniziale')
xlabel('number of the Lyapunov exponent')
ylabel('value of the Lyapunov exponent')
title('UPO of period 1.70')
set(gca,'fontsize',14)
%%
%% plot Lyapunov spectra
i=10000-500;
j = 10000;
k = 3;

iterations = i:j;
plot(iterations, ist_T1(iterations,k), '-o','Color','r','DisplayName','step = T')
hold on 
plot(iterations, ist_T2(iterations,k), '-o','Color','b','DisplayName','step = T/2')
hold on 
plot(iterations, ist_T3(iterations,k), '-o','Color','k','DisplayName','step = T/3')
xlabel('iterations')
ylabel('value of the third FTLE')

legend
set(gca,'fontsize',14)

%% 
i=1000-200;
j = 1000;

iterations = i:j;
plot(iterations, ist_T1(iterations,3),'Color','r','DisplayName','third FTLE')
hold on 
plot(iterations, ist_T1(iterations,4),'Color','b','DisplayName','fourth FTLE')
hold on 
yline(cum_T1(end,3), 'Color','r','LineWidth', 1.5,'DisplayName','average value third exponent')
hold on 
yline(cum_T1(end,3), '-.','Color','b','LineWidth', 1.5,'DisplayName','average value fourth exponent')
legend
xlabel('iterations')
ylabel('value of the FTLE (iterate every T)')