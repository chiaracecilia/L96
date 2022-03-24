%% this script calculates the Lyapunov Exponents of the UPOs

Integrator = @lorenz96_ext;
M=40;
F=4;

% initial condition for the ODE system
ic = rand(1,M);
Integrator = @lorenz96_ext;
M=40;
F=8;

% % initial condition for the ODE system
% ic = zeros(1,M);
% ic(2)=1;

Initial_time=0;          %Initial time: 0        %Final Time: 1000 sec 
dt=0.001;          %Time step: 0.01 sec

RelTol=1e-5;            %Relative tolerance
AbsTol=1e-6;            %Absolute tolerance

linODEnum=M*M;              %No. of linearized ODEs
%M=sqrt(linODEnum); %Dimension of the tangent linear system (total: M x M ODEs)

Iteration = 0.1; % this is measured in time (and not time-steps)

Initial_time=0;          %Initial time: 0
        %Final Time: 1000 sec 
dt=0.001;          %Time step: 0.01 sec

RelTol=1e-5;            %Relative tolerance
AbsTol=1e-6;            %Absolute tolerance

linODEnum=M*M;              %No. of linearized ODEs
%M=sqrt(linODEnum); %Dimension of the tangent linear system (total: M x M ODEs)

Iteration = 0.01; % this is measured in time (and not time-steps)
Discard_time = 0.005; %NB: this seems enough to avoid the 

i=2;
ic = Xp(:,i);
Final_time = Tp(i);


%%
i=3;
dt = 0.00001;
[t, X] = ode45(@lorenz96, 0:dt:Tp(i), Xp(:,i));

norm(X(1,:)-X(end,:))
