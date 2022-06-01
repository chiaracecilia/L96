%% this script calculates for each UPO its 

clear all
clc

load('upo_data')
load('Lambda.mat')

%%
positive_LE = zeros(1,length(Tp));
mean_pos = zeros(1,length(Tp));
sum_pos = zeros(1,length(Tp));
z = zeros(1,length(Tp));

for i = 1:length(Tp) 
    [positive_LE(i), ~, mean_pos(i),~, z(i), ~ , sum_pos(i)] = sign_LE(Lp(:,i));
end
    
mean_first_LE = mean(Lp(1,:));
min_first_LE = min(Lp(1,:));
max_first_LE = max(Lp(1,:));
first_LE = Lp(1,:);


%% plot and analyse the statistics

% plot Lyapunov spectra
i=5;
plot(Lambda, '-o')
hold on 
plot(i,Lambda(i),  '-o','Color','r','MarkerSize',10,'MarkerFaceColor','r', 'DisplayName','Condizione Iniziale')
xlabel('number of the Lyapunov exponent')
ylabel('value of the Lyapunov exponent')
set(gca,'fontsize',14)


%% histogram of number of unstable dimensions for the UPOs

h = histogram(positive_LE,10);
h.FaceColor = 'none';
h.LineWidth = 1.5;
xlabel('Number of Positive Lyapunov Exponents for each UPO');
ylabel('Count');
set(gca,'FontSize', 20)


%% histogram period UPOs
edge = [1:23];
h = histogram(Tp,edge);
h.FaceColor = 'none';
h.LineWidth = 1.5;
xlabel('Period');
ylabel('Count');
set(gca,'FontSize', 20)

%% histogram of mean value of the number of LE

h = histogram(sum_pos,10,  'DisplayName','UPOs');
h.FaceColor = 'none';
h.LineWidth = 1.5;
xlabel('KS entropy');
xline(sum(Lambda(1:4)),  'r','LineWidth',2,  'DisplayName','global')
ylabel('Count');
set(gca,'FontSize', 20)
legend
%% Empirical Copula

% figure;
% scatterhist(positive_LE,mean_pos)

u = ksdensity(positive_LE,positive_LE,'function','cdf');
v = ksdensity(mean_pos,mean_pos,'function','cdf');

figure;
scatterhist(u,v)
xlabel('number of positive LE')
ylabel('mean value for each UPO of the positive LE')

%%  primo LE, number positive LE

% figure;
scatterhist(positive_LE,first_LE)
xlabel('number of positive LE')
ylabel('mean value for each UPO of the positive LE')
%%

bin = 0.5:max(sum_pos);


[aver, deviaz, aver_per, neg, pos] = data_for_error_bar(bin, first_LE, sum_pos);
figure(1)
e = errorbar(aver_per, aver, neg, pos, 'k', 'LineWidth',2, 'DisplayName','first LE of the UPOs');
e.LineStyle='--';
yline(mean(first_LE), 'b','LineWidth',2, 'DisplayName','Mean first LE of the UPOs')
yline(Lambda(1), 'r','LineWidth',2, 'DisplayName','Global LE')
xlabel('KS entropy')
ylabel('First Lyapunov Exponent')
set(gca,'FontSize', 20)
legend
%%

bin = 0.5:max(Tp);


[aver, deviaz, aver_per, neg, pos] = data_for_error_bar(bin, positive_LE, Tp);
figure(1)
e = errorbar(aver_per, aver, neg, pos, 'k', 'LineWidth',2, 'DisplayName','first LE of the UPOs');
e.LineStyle='--';
%yline(Lambda(1), 'r','LineWidth',2, 'DisplayName','Global LE')
xlabel('Period')
ylabel('number of unstable directions')
set(gca,'FontSize', 20)
legend

%%

bin = 1:max(Tp);
mid = zeros(1, length(bin)-1);
for i = 1: length(bin)-1
    mid(i) = bin(i)+0.5;
end
[aver, deviaz, aver_per, neg, pos] = data_for_error_bar(bin, positive_LE, Tp);
figure(1)
e = errorbar(mid, aver, neg, pos, 'k', 'LineWidth',2);
e.LineStyle='--';
xlabel('Period')
ylabel('first Lyapunov exponent')
set(gca,'FontSize', 20)



%%

% figure;
% scatterhist(positive_LE,mean_pos)

u = ksdensity(positive_LE,positive_LE,'function','cdf');
v = ksdensity(first_LE,first_LE,'function','cdf');

figure;
scatterhist(u,v)
xlabel('number of unstable directions')
ylabel('value of the first LE')
