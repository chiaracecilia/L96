%% plots
set(0,'defaulttextinterpreter','latex')

%% distances
primo = dist_shadowing(:,1);
dieci = dist_shadowing(:,10);   
trenta = dist_shadowing(:,100);
%cento = dist_shadowing_UPO_reduced(:,100);



[f,xi] = ksdensity(log10(primo));
plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 1')

hold on 
[f,xi] = ksdensity(log10(dieci));
a = plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 10')
a.LineStyle='--';
a.Color = [0.6350 0.0780 0.1840];

hold on 
[f,xi] = ksdensity(log10(trenta));
b= plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 30')
b.LineStyle='-.';
b.Color = [0.8500 0.3250 0.0980];

% hold on 
% [f,xi] = ksdensity(log10(cento));
% c = plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 100')
% c.LineStyle=':';
% c.Color = [0.9290 0.6940 0.1250];
% xticklabels({'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}','0', '10' })
xlabel('$log_{10}$(distance)');
ylabel('pdf');
set(gca,'FontSize', 20)
legend


%%
%% histogram of the persistence 

[f,xi] = ksdensity(persistenza,'Support','positive');
plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 1')



hold on 

[f,xi] = ksdensity(persistenza_10,'Support','positive');

a = plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 10')
a.LineStyle='--';
a.Color = [0.6350 0.0780 0.1840];

hold on 

[f,xi] = ksdensity(persistenza_30,'Support','positive');

b= plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 30')
b.LineStyle='-.';
b.Color = [0.8500 0.3250 0.0980];

% hold on 
% id3 = (times100~=0);
% [f,xi] = ksdensity(log10(dt*persistence100(id3)./times100(id3)));
% p100=(dt*persistence100(id3)./times100(id3));
% var(log10(dt*persistence100(id3)./times100(id3)))
% c = plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 100')
% c.LineStyle=':';
% c.Color = [0.9290 0.6940 0.1250];

xlabel('persistence');
ylabel('pdf');
%xticklabels({'0', '10', '10^{2}','10^{3}' })
% xlim([0 680])
set(gca,'FontSize', 20)
xlim([0 max(persistenza_30)])
legend


%%

%% histogram of the persistence 

[f,xi] = ksdensity(spazio,'Support','positive');
plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 1')



hold on 

[f,xi] = ksdensity(spazio_10,'Support','positive');

a = plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 10')
a.LineStyle='--';
a.Color = [0.6350 0.0780 0.1840];

hold on 

[f,xi] = ksdensity(spazio_30,'Support','positive');

b= plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 30')
b.LineStyle='-.';
b.Color = [0.8500 0.3250 0.0980];

% hold on 
% id3 = (times100~=0);
% [f,xi] = ksdensity(log10(dt*persistence100(id3)./times100(id3)));
% p100=(dt*persistence100(id3)./times100(id3));
% var(log10(dt*persistence100(id3)./times100(id3)))
% c = plot(xi,f, 'k', 'LineWidth',2, 'DisplayName','tier 100')
% c.LineStyle=':';
% c.Color = [0.9290 0.6940 0.1250];

xlabel('average persistence of the orbits measured in space');
ylabel('pdf');
%xticklabels({'0', '10', '10^{2}','10^{3}' })
% xlim([0 680])
set(gca,'FontSize', 20)
xlim([0 max(persistenza_30)])
legend