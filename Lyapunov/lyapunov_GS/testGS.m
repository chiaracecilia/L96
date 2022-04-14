%% test GS decomposition
clear all
clc


M=40;
F=8;
n1=M;

y = zeros(1,n1*(n1+1));
y0 = zeros(1,n1*(n1+1));

y(1:n1) = rand(1,40);

for i=1:n1
    y((n1+1)*i)=1.0; % initial condition of the tangent linear (Identity matrix) - access to the 
end

y0=y;

Y = midpoint(@lorenz96_ext_midpoint, 0,0.01, 100, y0, M, F); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NB: This is the transpose of the matrix we want to QR decompose (A)
y=Y(end,:); % last point of the solution of the variational equation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Q = zeros(n1,n1); % contains the matrix Q of the decomposition
R = zeros(n1,n1);% contains the matrix R of the decomposition
A = zeros(n1,n1);% contains the matrix A of the decomposition

% (n*i)+j colonna i, riga j
%%
% this loop transposes the tangent linear matrix solution to obtain A
    for i=1:n1
        for j=1:n1
            y0(n1*i+j)=y(n1*j+i);
        end
    end
        
    % initial condition, u1 vector, first column of A (corresponds to first column),
    znorm(1)=0.0;
    
    for j=1:n1
        znorm(1)=znorm(1)+y0(n1*j+1)^2;
        A(j,1) = y0(n1*j+1); 
    end
    
    znorm(1)=sqrt(znorm(1)); % ||u1|| = (R11)
    
    % u1/||u1||
    for j=1:n1 
        y0(n1*j+1)=y0(n1*j+1)/znorm(1); 
        Q(j,1) =  y0(n1*j+1); % first column contains the first orthogonal vector
    end
    
    R(1,1) = sqrt(znorm(1));
    
    % each j will return Rjj and column j of both A and R
    for j=2:n1   
        
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
            A(k,j) = y0(n1*k+j); % jth column of the original matrix A (+j)
        end
        
        znorm(j)=sqrt(znorm(j));
        
        for k=1:n1 
            y0(n1*k+j)=y0(n1*k+j)/znorm(j); 
            Q(k,j) =  y0(n1*k+j); % first column contains the first orthogonal vector
        end
        
    end
    
    
    % update initial condition for next iteration (re-transpose)
    for i=1:n1
        for j=1:n1
            y(n1*j+i)=y0(n1*i+j);
        end
    end