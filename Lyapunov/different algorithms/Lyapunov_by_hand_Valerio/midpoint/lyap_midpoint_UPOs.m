% This script calculates the Lyapunov spectrum by hand for the UPOs

clear all
clc

%load('F5_raw.mat')
load('raw_F5_M20.mat')

N = 20;
F = 5;
M = N;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
j=1; % UPO 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dt = 0.01;

T = Tp(j); % period UPO
X = Xp(:, j);
L= Lp(:,j);

T_timeunits = T/dt;
tau = dt * T_timeunits/fix(T_timeunits);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dtL=T; % each step of the Lyapunov simulation is dtL long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Tfin=100*T; % Final time. How many times do I turn around the period?

Nstep= round(Tfin/dtL);  % number of steps of the Lyap algorithm
time=dtL*[0:Nstep]; % total time of the simulation. I will have Nstep each one of duration dtL

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eps=1e-8; % displacement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

traj_irr=zeros(Nstep,N); % contains the final point of the reference traj at each iteration
ytpert=zeros(N,N);  % contains the perturbation for each direction

Texp=zeros(Nstep,1);    % contains the time at which I calculate the Lyap expo
Lexp_ist_V=zeros(Nstep,N);   % contains the istantaneous Lyap exponents approximation at each time step
Lexp_cum=zeros(Nstep,N);    % contains the cumulative Lyap expo
cum=zeros(N,1);

Mpert=eps*eye(N); % this matrix contains the pert along each direction

ci=X';  % set the initial condition

timecount=0;
turns = 0;    % counts how many times I run around the UPO

Q = zeros(N,N, Nstep); % contains the matrix Q of the decomposition
R = zeros(N,N, Nstep);% contains the matrix R of the decomposition
A = zeros(N,N, Nstep);% contains the matrix A of the decomposition


for j=1:Nstep % N steps in this procedure
    
    % if I have looped around the orbit start again from the IC
    if (time(j+1) - turns*T >10^(-4) )
        turns = turns+1;
        ci = X';
    end

    Y = midpoint(@lorenz96, time(j),tau, time(j+1), ci, N, F); % reference trajectory 
    
    yt=Y(end,1:N);
    traj_irr(j,:)=Y(end,1:N);
    
    % perturbation along each direction
    for p=1:N
        Yp = midpoint(@lorenz96, time(j),tau, time(j+1), ci+Mpert(p,:), N, F);
        ytpert(p,:)=Yp(end,:)-Y(end,:); % this is how much the pert along direction p grew in one iteration
    end
    
    % decompose the perturbed matrix
    Mtan=ytpert';
    [Q1,R1] = qr(Mtan);
    R(:,:, j) = R1;
    Q(:,:, j) = Q1;
    A(:,:, j) = Mtan;
    
    %ecco i nuovi vettori di perturbazione
    Mpert=eps*Q1';    
    
    ci=yt; 
    Texp(j)=time(j+1); % continue the integration
    dia=diag(log(abs(R1/eps)));
    cum = cum + dia;
    Lexp_cum(j,:) = cum/time(j); 
    Lexp_ist_V(j,:)=dia/dtL; % this contains the value of the LE
            
end


Lambda = Lexp_cum(end, :); 
l = length(Lambda(:,1));
Lambda_average_second_half = mean(Lexp_ist_V(round(l/2):end,:));



%% look at the matrix
%%

plot(Lambda_average_second_half, 'o', 'DisplayName','QR decomposition')
hold on 
plot(L, '*', 'DisplayName','Andreys LE')
