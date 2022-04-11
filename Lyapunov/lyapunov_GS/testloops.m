%%% test the loops
 
clear all
clc

load('F8_raw.mat')
% UPO data
j=5;
dt = 0.01;
T = Tp(j); % period UPO
X = Xp(:, j);
ystart = X'; % starting condition
stept = T/3;
% calculate integration time-step specific to the UPO
T_timeunits = T/dt;
tau = dt * T_timeunits/fix(T_timeunits);

tstart = 0;
n = 1000;
tend = T*N;
nit = int64((tend-tstart)/stept); %  Number of iterations of the exponent algorithm
time=stept*[0:nit];
%%
base = [0:stept:T];
for i = 1: N 
    
    


%time(ITERLYAP+1) > turns*T