%% This function calculates the Lyapunov exponents of the Lorenz-96 model


function [Lexp, Texp, Lambda, giro] = lyapunov(Integrator, M,F, period_UPO,Initial_time, Final_time, dt, Iteration , Discard_time, ic)
%
T_timeunits = period_UPO/dt;
tau = dt * T_timeunits/fix(T_timeunits);
X0 = ic;
%%
%Initial conditions for the tangent linear

Q0 = eye(M);      % initialise on an identity matrix
IC = [ic(:);Q0(:)];   % extended initial condition (ODE + TANGENT LINER - this is a column vector-)



% Iteration Variables
T1=Initial_time;
T2=T1+Iteration;

%%
%Initialize variables
n=0;			%Iteration counter (fake one, it considers ALL the iterations, comprising of the ones that do not contribute to the Lyap mean)
k=0;			%Effective iteration counter (discarded iterations are not counted)
giro = 0;    % counts how many times I run around the UPO				
           
cumulative_sum_LE=zeros(1,M);  % this will contain the cumulative sum for the calculation of the LE


%%
A=zeros(M,M);       

while (T2<Final_time)       % Iterate till the given Final Time
    
    n=n+1;  % count total integrations

    X = midpoint(Integrator, T1,tau, T2, IC, M, F); % solve the extended system in an Iteration time-span

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
      if (T2< giro*period_UPO)
         ic=X(rX,1:M); % initial condition of the ODE system
      else
          giro = giro+1;
          ic = X0;
      end
         
    
      % translate the time span of a window of size Iteration
      T1=T1+Iteration;  
      T2=T2+Iteration;
      % initial condition of the extended system: ic evolved ODE +
      % orthoghonalised matrix
      IC=[ic(:);Q0(:)];
      
end

