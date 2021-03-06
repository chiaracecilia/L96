%% This function calculates the Lyapunov exponents of the Lorenz-96 model
% L96 parameters
% 
% Integrator = @lorenz96_ext;
% M=40;
% F=8;
% 
% % initial condition for the ODE system
% ic = zeros(1,M);
% ic(2)=1;
% 
% 
% Initial_time=0;          %Initial time: 0
% Final_time=2500;         %Final Time: 1000 sec 
% dt=0.001;          %Time step: 0.01 sec
% 
% RelTol=1e-5;            %Relative tolerance
% AbsTol=1e-6;            %Absolute tolerance
% 
% linODEnum=M*M;              %No. of linearized ODEs
% %M=sqrt(linODEnum); %Dimension of the tangent linear system (total: M x M ODEs)
% 
% Iteration = 0.1; % this is measured in time (and not time-steps)
% Discard_time = 2000; %NB: this seems enough to avoid the 
% %    Number_Iteration_Discard=10;            %Transient iterations to be discarded: 
% %    Update_LE=10;         %Update the LEs every 10 time steps
% %    Iteration = Update_LE*dt;	% this is measured in time (and not time-steps)
% %    Discard_time = Number_Iteration_Discard*Iteration+Initial_time; % Time at which I will start iterating the algorithm


function [Lexp, Texp, Lambda] = lyapunov(Integrator, M,Initial_time, Final_time, dt, AbsTol, RelTol, Iteration , Discard_time, ic)


%%
%Initial conditions for the tangent linear

Q0 = eye(M);      % initialise on an identity matrix
IC = [ic(:);Q0(:)];   % extended initial condition (ODE + TANGENT LINEAR - this is a column vector-)

M_ext = length(IC);		%Total no. of initial coniditions for the extended system (It will be (N+1)*N)

%%

% Iteration Variables
T1=Initial_time;
T2=T1+Iteration;
TSpan=[T1:dt:T2];

%Absolute tolerance of each components is set to the same value
options=odeset('RelTol',RelTol,'AbsTol',ones(1,M_ext)*AbsTol);

%%
%Initialize variables
n=0;			%Iteration counter (fake one, it considers ALL the iterations, comprising of the ones that do not contribute to the Lyap mean)
k=0;			%Effective iteration counter (discarded iterations are not counted)
				
           
cumulative_sum_LE=zeros(1,M);  % this will contain the cumulative sum for the calculation of the LE


%%
A=zeros(M,M);       

while (T2<Final_time)       % Iterate till the given Final Time
    
    n=n+1;  % count total integrations

    [t, X] = ode45(Integrator, TSpan, IC, options); % solve the extended system in an Iteration time-span

    [rX,cX]=size(X);
                        
     % tangent linear solution at final time evolution point TRANSPOSED                       
       for i=1:M
          m1=M+1+(i-1)*M;
          m2=m1+M-1;
          A(:,i)=(X(rX,m1:m2))';
       end
   
      %QR decomposition
      [Q,R]=qr(A);
      
      if T2>Discard_time
         Q0=Q;
      else
         Q0=eye(M); % always start from identity
      end
      
   permission=1;
   for i=1:M
      if R(i,i)==0
         permission=0;
         break;
      end
   end
   
   
   if (T2>Discard_time && permission) % if I have passed the transient time
       
      k=k+1;
      % internal iteration step
      T=k*Iteration;
      TT=n*Iteration+Initial_time;
      
      %There are d Lyapunov exponents
      cumulative_sum_LE=cumulative_sum_LE+log(abs(diag(R))');
      lambda=cumulative_sum_LE/T;
      
      %Sort the Lyapunov exponents in descenting order
      Lambda=fliplr(sort(lambda));
      
      % save the variables CANE
      
      if k==1
         Lexp=Lambda;
         Texp=TT;
      else
         Lexp=[Lexp; Lambda];
         Texp=[Texp; TT];
      end
      
   end
   
   
      %Update the initial conditions and time span for the next iteration
      ic=X(rX,1:M); % initial condition of the ODE system
      % translate the time span of a window of size Iteration
      T1=T1+Iteration;  
      T2=T2+Iteration;
      TSpan=[T1:dt:T2]; 
      % initial condition of the extended system: ic evolved ODE +
      % orthoghonalised matrix
      IC=[ic(:);Q0(:)];
      
end

