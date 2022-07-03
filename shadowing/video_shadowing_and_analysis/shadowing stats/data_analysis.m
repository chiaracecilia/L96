%load the data

load('average_persistence.mat')
load('number_orbit_approx.mat')
load('period_approx.mat')
load('time_approx.mat')
load('upo_data.mat')
load('UPOs_approx_index.mat')
load('Lyap_stats.mat')
load('Lambda.mat')
load('res_time.mat')
load('dist1_10_100.mat')

set(0,'defaulttextinterpreter','latex')

%% define shadowing time and occupancy ratio quantities (TIER j)
j=1;

shadowing_time = time_approx(1:number_orbits_for_approximation(j), j);
shad_UPO_1 = UPOs_approx_index(1:number_orbits_for_approximation(j), j);
period_shad_UPO_1 = period_approx(1:number_orbits_for_approximation(j), j);
lambda_shad_UPO_1 = zeros(number_orbits_for_approximation(j), 20);

for i=1:number_orbits_for_approximation(j)
    lambda_shad_UPO_1(i,:) = L(:, shad_UPO_1(i));
end

ocupancy_shad_UPO_1 = shadowing_time./period_shad_UPO_1;

number_positive_LE_shad_UPO_1 = zeros(1,number_orbits_for_approximation(j));
KS_shad_UPO_1 = zeros(1,number_orbits_for_approximation(j));


for i = 1:number_orbits_for_approximation(j) 
    [number_positive_LE_shad_UPO_1(i), ~, ~,~, ~, ~ , KS_shad_UPO_1(i)] = sign_LE(lambda_shad_UPO_1(i,:));
end
    

%% KS entropy vs 1st LE

scatter(first_LE,KS, 'k', 'LineWidth',2, 'DisplayName','UPOs')
yline(mean(first_LE), 'b','LineWidth',2, 'DisplayName','Mean over the full set of UPOs')
yline(Lambda(1), 'r','LineWidth',2, 'DisplayName','Global')
xlabel('KS entropy')
ylabel('$\lambda_1$')
set(gca,'FontSize', 20)
legend

%% histogram of number of unstable dimensions for the UPOs

h = histogram(number_positive_LE);
edges = 1:10;
h.FaceColor = 'none';
h.LineWidth = 1.5;
h.BinEdges = edges;
xlabel('Number of Positive Lyapunov Exponents for each UPO');
ylabel('Count');
set(gca,'FontSize', 20)

%% histogram KS entropy 

h = histogram(KS,25,  'DisplayName','UPOs');
h.FaceColor = 'none';
h.LineWidth = 1.5;
xlabel('KS entropy');
xline(sum(Lambda(1:4)),  'r','LineWidth',2,  'DisplayName','global')
ylabel('Count');
set(gca,'FontSize', 20)
legend

%% plot Lyapunov spectra
i=5;
plot(Lambda, '-o')
hold on 
plot(i,Lambda(i),  '-o','Color','r','MarkerSize',10,'MarkerFaceColor','r', 'DisplayName','Condizione Iniziale')
xlabel('number of the Lyapunov exponent')
ylabel('value of the Lyapunov exponent')
set(gca,'fontsize',14)
%% number orbits for approximation in the different tiers

scatter(1:100, number_orbits_for_approximation/length(L(1,:)), 'k', 'LineWidth',2)
xlabel('tier');
ylabel('percentage of the database');
set(gca,'FontSize', 20)

%% persistency of the shadowing in the first, first ten, first hundred tiers 

scatter([1:100],average_persistence, 'k', 'LineWidth',2)
xlabel('tier');
ylabel('average persistence n  ');
set(gca,'FontSize', 20)

%% density lambda_1 over the orbits

[f,xi] = ksdensity(Lp(1,:),'Support','positive');
plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','UPOs')
xline(Lambda(1), 'r','LineWidth',2,  'DisplayName','global')
xlabel('$\lambda_1$');
ylabel('pdf');
set(gca,'FontSize', 20)
legend

%% histogram of the persistent shadowing (looser definition of shadowing) 

idx = average_persistence1~=0;
persistenza = average_persistence1(idx);
[f,xi] = ksdensity(persistenza,'Support','positive');
plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 1')

hold on 
idx = average_persistence10~=0;
persistenza_10 = average_persistence10(idx);
[f,xi] = ksdensity(persistenza_10,'Support','positive');

a = plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 10')
a.LineStyle='--';
a.Color = [0.6350 0.0780 0.1840];

hold on 
idx = average_persistence100~=0;
persistenza_100 = average_persistence100(idx);
[f,xi] = ksdensity(persistenza_100,'Support','positive');

b= plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 100')
b.LineStyle='-.';
b.Color = [0.8500 0.3250 0.0980];

xlabel('persistence');
ylabel('pdf');
%xticklabels({'0', '10', '10^{2}','10^{3}' })
% xlim([0 680])
set(gca,'FontSize', 20)
xlim([0 max(persistenza_100)])
legend


%% histogram of the distance from the chaotic trajectory in different tiers 

[f,xi] = ksdensity(dist_1,'Support','positive');
plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 1')

hold on 

[f,xi] = ksdensity(dist_10,'Support','positive');

a = plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 10')
a.LineStyle='--';
a.Color = [0.6350 0.0780 0.1840];

hold on 
[f,xi] = ksdensity(dist_100,'Support','positive');

b = plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 100')
b.LineStyle='-.';
b.Color = [0.8500 0.3250 0.0980];

xlabel('distance');
ylabel('pdf');
%xticklabels({'0', '10', '10^{2}','10^{3}' })
% xlim([0 680])
set(gca,'FontSize', 20)
xlim([0 max(dist_100)])
legend




%% histogram shadowing time
[~,edges] = histcounts(log10(shadowing_time));
h=histogram(shadowing_time,10.^edges);
h.FaceColor = 'none';
h.LineWidth = 1.5;
xlabel('Shadowing time');
ylabel('count');
set(gca,'FontSize', 20)
set(gca, 'xscale','log')

%% histogram occupancy ratio
[~,edges] = histcounts(log10(ocupancy_shad_UPO_1));
h=histogram(ocupancy_shad_UPO_1,10.^edges);
h.FaceColor = 'none';         
h.LineWidth = 1.5;
xlabel('Occupancy ratio');
ylabel('count');
set(gca,'FontSize', 15)
set(gca, 'xscale','log')

%% scatter shadowing time and period 
%scatter(period_shad_UPO_1, ocupancy_shad_UPO_1)
%scatter(period_shad_UPO_1, shadowing_time)

scatter(lambda_shad_UPO_1(:,1), shadowing_time)
%%

%% occupancy ratio 

bin = min(period_shad_UPO_1):max(period_shad_UPO_1);

[aver, deviaz, aver_per, neg, pos] = data_for_error_bar(bin, ocupancy_shad_UPO_1, lambda_shad_UPO_1(:,1));
figure(1)
e = errorbar(aver_per, aver, neg, pos, 'k', 'LineWidth',2);
e.LineStyle='--';
xlabel('T')
ylabel('occupancy ratio')
set(gca,'FontSize', 20)

