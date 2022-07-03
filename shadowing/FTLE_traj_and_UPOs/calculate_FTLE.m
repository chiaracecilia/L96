%% this script calculates the FTLE along a chaotic trajectory with two different methods

% parameters
M = 20;
F=5;
dt=0.01;

% create chaotic trajectory
T_chaotic = 10^2;
seed = 2022;
rng(seed)
x = midpoint(@lorenz96,0,dt, 10000, rand(1,M),M, F); % find an initial condition in the attractor of the system
x_chaotic = midpoint(@lorenz96,0,dt, T_chaotic, x(end,:), M, F); 


%% SOME TESTS
clc
seed = 2022;
rng(seed)
X = rand(1,20);
FTLE_time = 1;

[Lambda] = FTLE_QR( X, FTLE_time, F, M);
[Lambda1,Lexph1irrnum1] = FTLE_vale(X, FTLE_time, M,F, dt, 0.5);

Lambda(1)
Lambda1(1)

%% calculate the first exponent along a chaotic trajectory 

FTLE_time = 2;
number_segments = 1000;
time=FTLE_time*[0:number_segments];

lambda1 = zeros(1, number_segments);
ic =  x(end,:);

for i = 1: number_segments
    x_chaotic = midpoint(@lorenz96,time(i),dt, time(i+1), ic, M, F); 
    ic = x_chaotic(end,:);
    lambda = FTLE_QR(ic, FTLE_time, F, M);
    lambda1(i) = lambda(1);
end
   
%%
c = plot(lambda1, 'o', 'LineWidth',2, 'DisplayName','UPOs')
c.Color = 'k';
xlabel('t_0');
ylabel('\Lambda_1(t_0)');
set(gca,'FontSize', 20)
yline(0)