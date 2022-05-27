%function [Lambda, turns] = lyapunov_UPOs_midpoint(stept)
clear all
clc

%%%% input 
number_of_blocks_UPOs = 8; % number of blo


load('F8_raw.mat')

% parameters
n = 40; % n number of equation
F = 8;
M = n; % dimension of the L-96 system

% UPO data
j=5; % UPO 3
dt = 0.01; 
T = Tp(j); % period UPO
X = Xp(:, j);

% calculate integration time-step specific to the UPO
T_timeunits = T/dt;
tau = dt * T_timeunits/fix(T_timeunits);

[x, dist] = calculate_UPO(X, T, dt,M, F);

number_points_UPOs = length(x(:,2));
number_points_each_block = number_points_UPOs/number_of_blocks_UPOs;

blocks_UPOs = zeros(number_points_each_block,number_of_blocks_UPOs, M );

% fill the matrix with the UPOs data
for i = 1:number_of_blocks_UPOs
    blocks_UPOs(:,i,:) = x((i-1)*number_points_each_block+1:i*number_points_each_block, :);
end
%%
%ystart = X; % starting condition


% stept = T/10; % choose the number of Lyapunov steps as sottomultiplo del
% periodo

%tend = 100*T; % Final time. How many times do I turn around the period?
loops = 100; 

%  Number of iterations of the exponent algorithm
%nit = round((tend-tstart)/stept);
number_iteration_algorithm = loops* number_of_blocks_UPOs;

% simulation time one loop
simulation_time_one_loop = [0:tau:T];
block_time = tau * number_points_each_block;

n1=n; % number of nonlinear ODEs
n2=n1*(n1+1); % total number of equation

% Memory allocation
y=zeros(n2,1);
cum=zeros(n1,1);
y0=y;
gsc=cum;
znorm=cum; % contains the norm of the normalised base at each increment

% Initial values

y(1:n)=blocks_UPOs(1,1,:); % initial condition of the ODE

for i=1:n1
    y((n1+1)*i)=1.0; % initial condition of the tangent linear (Identity matrix)
end

t=simulation_time_one_loop(1); % initial time

%t_total_simulation = [0:tau:loops*T];
%%
% Main loop
turns = 1;   % counts how many times I turn around the UPO

for ITERLYAP=1:number_iteration_algorithm

    %%%%%%% DO THIS PART BELOW %%%%%%%
    if ((t+stept) > turns*T)
        turns = turns+1;
        y(1:n)=ystart(:); % reset initial condition
    end
    
    Y = midpoint(@lorenz96_ext_midpoint, t,tau, t+block_time, y, M, F); % solve the variational equation in the interval [t, tstep]
   
    t=t+block_time;    % update to the new section
    y=Y(end,:); % last point of the solution of the variational equation
    
    % this loop transposes the tangent linear matrix solution
    for i=1:n1
        for j=1:n1
            y0(n1*i+j)=y(n1*j+i);
        end
    end
    %%%%%%% DO THIS PART ABOVE %%%%%%%
   
    %  construct new orthonormal basis using gram-schmidt
    
    % the volume spanned by the old basis is given by prod(znorm)
    % I consider the evoluted frame (now almost surely not anymore orthogonal)
    % at time t+step and I produce an orthogonal frame out of it
    
    znorm(1)=0.0;
    
    for j=1:n1
        znorm(1)=znorm(1)+y0(n1*j+1)^2;
    end
    
    znorm(1)=sqrt(znorm(1)); % Euclidian norm (sqrt of the summed squared components)
    
    for j=1:n1 
        y0(n1*j+1)=y0(n1*j+1)/znorm(1); 
    end
    
    for j=2:n1
        for k=1:(j-1)
            gsc(k)=0.0;
            for l=1:n1 
                gsc(k)=gsc(k)+y0(n1*l+j)*y0(n1*l+k); 
            end
        end
        
        for k=1:n1
            for l=1:(j-1)
                y0(n1*k+j)=y0(n1*k+j)-gsc(l)*y0(n1*k+l);
            end
        end
        
        znorm(j)=0.0;
        for k=1:n1 
            znorm(j)=znorm(j)+y0(n1*k+j)^2; 
        end
        znorm(j)=sqrt(znorm(j));
        
        for k=1:n1 
            y0(n1*k+j)=y0(n1*k+j)/znorm(j); 
        end
    end
    
    
    %  update running vector magnitudes
    
    for k=1:n1 
        cum(k)=cum(k)+log(znorm(k)); 
    end
    
    %  normalize exponent
    
    for k=1:n1
        lp(k)=cum(k)/(t-tstart);
    end
    
    % Output modification
    
    if ITERLYAP==1
        Lexp=lp;
        Texp=t;
    else
        Lexp=[Lexp; lp];
        Texp=[Texp; t];
    end
    
    
    for i=1:n1
        for j=1:n1
            y(n1*j+i)=y0(n1*i+j);
        end
    end
    
    
    
end

Lambda = Lexp(end, :);