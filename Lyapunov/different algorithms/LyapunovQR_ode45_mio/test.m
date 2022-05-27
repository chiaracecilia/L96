%% this script calculates the Lyapunov Exponents of the UPOs

Integrator = @lorenz96_ext;


% initial condition for the ODE system
M=40;
F=8;
ic = rand(1,M);
Integrator = @lorenz96_ext;


% % initial condition for the ODE system
% ic = zeros(1,M);
% ic(2)=1;

Initial_time=0;          %Initial time: 0        %Final Time: 1000 sec 
dt=0.01;          %Time step: 0.01 sec

RelTol=1e-5;            %Relative tolerance
AbsTol=1e-6;            %Absolute tolerance

linODEnum=M*M;              %No. of linearized ODEs
%M=sqrt(linODEnum); %Dimension of the tangent linear system (total: M x M ODEs)



Initial_time=0;          %Initial time: 0
        %Final Time: 1000 sec 
          %Time step: 0.01 sec

RelTol=1e-5;            %Relative tolerance
AbsTol=1e-6;            %Absolute tolerance

linODEnum=M*M;              %No. of linearized ODEs
%M=sqrt(linODEnum); %Dimension of the tangent linear system (total: M x M ODEs)

Iteration = 0.1; % this is measured in time (and not time-steps)
Discard_time = 1000; %NB: this seems enough to avoid the 
Final_time = 1200;

[Lepx, Texp, Lambda] = lyapunov(Integrator, M,Initial_time, Final_time, dt, AbsTol, RelTol,Iteration, Discard_time, ic);
%

% %% study dependence on Iteration frequency 
% dt=0.001;
% h = [ 0.01, 0.05, 0.1,  0.5];
% Lambda = zeros(40, length(h));
% 
% for i = 1:length(h)
%     [Lepx, Texp, Lambda(:,i)] = lyapunov(Integrator, M,Initial_time, Final_time, dt, AbsTol, RelTol, h(i) , Discard_time, ic);
% end
%%
plot(Texp, Lepx)
xlabel('time')
ylabel('Dynamics Lyapunov exponents')
title('Lorenz-96, F=8, M=40')
