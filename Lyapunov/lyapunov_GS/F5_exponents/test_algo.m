%function [Lambda_average_second_half, Lexp_ist] = lyapunov_UPOs_midpoint_test(stept, X,T, tend, F, M)
clear all
clc

load('F5_raw.mat')

j=3;
T = Tp(j);
X = Xp(:,j);
tend = T*10000;
F = 5;
M=40;
stept = T;

% parameters
n = M; % dimension of the L-96 system

% UPO data
% j=2;
dt = 0.01;
% T = Tp(j); % period UPO
% X = Xp(:, j);
ystart = X'; % starting condition

% calculate integration time-step specific to the UPO
T_timeunits = T/dt;
tau = dt * T_timeunits/fix(T_timeunits);


% Lyapunov algorithm spcification
tstart = 0;
nit = round((tend-tstart)/stept); %  Number of iterations of the exponent algorithm
time=stept*[0:nit];

n1=n; % number of nonlinear ODEs
n2=n1*(n1+1); % total number of equation

%
% Memory allocation
%

% GS algorithm
y=zeros(n2,1);
cum=zeros(n1,1);
y0=y;
gsc=cum;
znorm=cum; % contains the norm of the normalised base at each increment (diagonal elements of R - upper triangular matrix)
% values of the exponents
Rjj = zeros(M, nit);
l_cum = zeros(M,1);
l_ist = zeros(M,1);
Lexp_cum = zeros(nit, M); % cumulative mean of the exponents
Lexp_ist = zeros(nit, M); % finite time Lyapunov exponents
Texp = zeros(nit, 1);   % time of the simulation 


Q = zeros(n1,n1, nit); % contains the matrix Q of the decomposition
R = zeros(n1,n1, nit);% contains the matrix R of the decomposition
A = zeros(n1,n1, nit);% contains the matrix A of the decomposition

% Initial values
y(1:n)=ystart(:); % initial condition of the ODE

for i=1:n1
    y((n1+1)*i)=1.0; % initial condition of the tangent linear (Identity matrix) - access to the 
end


%%
% Main loop
turns = 0;   % counts how many times I turn around the UPO

for ITERLYAP=1:nit

    if ((time(ITERLYAP+1) - turns*T) > 10^(-4) ) 
        turns = turns+1;
        y(1:n)=ystart(:); % reset initial condition
%         figure(1)
%         plot3(x(:,1), x(:,2),x(:,3), 'k') % original orbit
%         hold on 
%         plot3(y(1), y(2),y(3), '-o','Color','b','MarkerSize',10,'MarkerFaceColor','b')

    end
    
    Y = midpoint(@lorenz96_ext_midpoint, time(ITERLYAP),tau, time(ITERLYAP+1), y, M, F); % solve the variational equation in the interval [t, tstep]
%     figure(2)
%     plot3(x(:,1), x(:,2),x(:,3), 'k') % original orbit
%     hold on
%     plot3(Y(:,1), Y(:,2),Y(:,3), '-o','Color','r','MarkerSize',5,'MarkerFaceColor','g')
%     hold on
    y=Y(end,:); % last point of the solution of the variational equation
%     
%     figure(2)
%     plot3(y(1), y(2),y(3), '*','Color','k','MarkerSize',10,'MarkerFaceColor','k')
    
    % transpose and save 
    for i=1:n1
        for j=1:n1
            y0(n1*i+j)=y(n1*j+i);
            A(i,j, ITERLYAP) = y0(n1*i+j);
        end
    end
    
    % initial condition, column 1 of the Q matrix, R11 of the R matrix
    znorm(1)=0.0;
    
    for j=1:n1
        znorm(1)=znorm(1)+y0(n1*j+1)^2;
    end
    
    znorm(1)=sqrt(znorm(1)); % Euclidian norm (sqrt of the summed squared components)
    Rjj(1, ITERLYAP) = znorm(1);
    
    for j=1:n1 
        y0(n1*j+1)=y0(n1*j+1)/znorm(1); 
        Q(j,1, ITERLYAP) =  y0(n1*j+1); % first column contains the first orthogonal vector
    end
    
    
    for j=2:n1   % at each iteration I find the orthogonal vector stored in column j of the Q matrix
        
        for k=1:(j-1) % subtract at the vector j the other j-1 projection of the components
            
            gsc(k)=0.0;
            
            for l=1:n1 
                gsc(k)=gsc(k)+y0(n1*l+j)*y0(n1*l+k); % + j is column j, + k is column k of the A matrix
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
        Rjj(j, ITERLYAP) = znorm(j);
        
        for k=1:n1 
            y0(n1*k+j)=y0(n1*k+j)/znorm(j); 
            Q(k,j, ITERLYAP) =  y0(n1*k+j); % first column contains the first orthogonal vector
        end
        
        
    end
    
    R(:,:, ITERLYAP) = transpose(Q(:,:, ITERLYAP))* A(:,:, ITERLYAP);
    
    %  Calculate and save exponents
    
    %  update running vector magnitudes
    for k=1:n1 
        cum(k)=cum(k)+log(znorm(k)); % diagonal elements of R
    end
    
    
    for k=1:n1
        l_cum(k)=cum(k)/(time(ITERLYAP)-tstart); % cumulative exp
        l_ist(k) = log(znorm(k))/stept;
    end
    
    Texp(ITERLYAP)=time(ITERLYAP+1);
    
   
    Lexp_cum(ITERLYAP,:) = l_cum; % cumulative mean of the exponents
    Lexp_ist(ITERLYAP,:) = l_ist;   % finite time Lyapunov exponents
    
    
    % update initial condition for next iteration
    for i=1:n1
        for j=1:n1
            y(n1*j+i)=y0(n1*i+j);
        end
    end
    
    
end

Lambda = Lexp_cum(end, :); 
l = length(Lambda(:,1));

Lambda_average_second_half = mean(Lexp_ist(round(l/2):end,:));
% %%
% j=2;
% A1 = A(:,:,j);
% Q1 = Q(:,:,j);
% R1 = R(:,:,j);
% 
% %%
% j=2;
% k=5;
% R(j,j,k)
% Rjj(j, k)
%%
MAT = R(1:10,1:10, end-10:end);
for i = 1:10
    MAT(:,:,i)
end

