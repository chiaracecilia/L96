%% with this script I plot things

%% plot Lyapunov spectra
i=11;
plot(Lambda_average_second_half, '-o')
hold on 
plot(i,Lambda_average_second_half(i),  '-o','Color','r','MarkerSize',10,'MarkerFaceColor','r', 'DisplayName','Condizione Iniziale')
xlabel('number of the Lyapunov exponent')
ylabel('value of the Lyapunov exponent')
set(gca,'fontsize',14)
%% Periodicity ftle
% ist_T10 = Lexp_ist; 
% cum_T10 = Lexp_cum;
% save('dieciperiodo.mat', 'ist_T10', 'cum_T10')
%%
plot