% This script calculates the Lyapunov spectra by hand
clear all
clc 


N=40;
F=8;
dt = 0.01;

T = 2; % period UPO
yo = rand(1, N);

Tspin=10*T; % discard the first part
Tfin=100*T; % Final time. How many times do I turn around the period?

dtL=0.6; % each step of the Lyapunov simulation is dtL long 

Nstep= round(Tfin/dtL);  % number of steps of the Lyap algorithm
time=dtL*[0:Nstep]; % total time of the simulation. I will have Nstep each one of duration dtL


options=odeset('AbsTol',1e-8,'RelTol',1e-8);


tic
[Tirr,Yirr]=ode45(@lorenz96irr,[0:dt:Tspin-dt],yo,options); % THIS TIMESTEP MIGHT BE AN ISSUE
toc


eps=1e-7; % displacement

yo=Yirr(end,:); % last point of the integration
yin=yo;

%N=max(size(yo));
% %if size(yo,2)>size(yo,1);
% %   yo=yo';
% %end


trajh1irr=zeros(Nstep,N);
ytpert=zeros(N,N);  % contains the perturbation for each direction

Texp=zeros(Nstep,1);    % contains the time at which I calculate the Lyap expo
Lexph1irrnum=zeros(Nstep,N);   % contains the Lyap exponents approximation at each time step 

%stima degli esponenti di Lyapunov
Mpert=eps*eye(max(size(yin)));

ci=yo;  % set the initial condition
timecount=0;
%%
for j=1:Nstep % N steps in this procedure
  tic
  j
  [T,Y] = ode45(@lorenz96irr,[time(j):dtL/10:time(j+1)],ci,options); % reference trajectory PROBLEM HERE, need to have dt = 0.01;
  
  yt=Y(end,1:N); 
  trajh1irr(j,:)=Y(end,1:N);
  
  % perturbation along each direction
  for p=1:N
    [T,Yp] = ode45(@lorenz96irr,[time(j):dtL/10:time(j+1)],ci+Mpert(p,:),options);
    ytpert(p,:)=Yp(end,1:N)-Y(end,1:N); % this is how much the pert along direction p grew in one iteration
  end
  

  % decompose the perturbed matrix 
  Mtan=ytpert';
 [Q1,R1] = qr(Mtan);
  
   
  Mpert=eps*Q1; 
  
  %ecco i nuovi vettori di perturbazione
  ci=yt; % last point on the reference trajectory
  Texp(j)=time(j+1); % continue the integration 
  dia=diag(log(abs(R1/eps))); 
  Lexph1irrnum(j,:)=dia/dtL; % this contains the value of the LE
  
  %stime degli esponenti di Lyapunov

  sumlyapunov=sum(sum(Lexph1irrnum(1:j,:)))/j 
  firstlyapunov=mean(Lexph1irrnum(1:j,1))

  
  %qualche cosa stampata come controllo

  timeint=toc;
  timecount=timecount+timeint
  mtime=timecount/j;
  timetocompletion=mtime*(Nstep-j)
  %quanto ci vuole per finire?

end