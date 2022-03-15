%% Lorenz-96 model + tangent linear

% this function evaluates the RHS of the Lorenz equation + its tangent
% linear dynamics
% M: number of modes
% F: forcing parameter
% y: point where I evaluate 

function f = lorenz96(t,X)

M=40;
F=8;
% n=40;
% % Memory allocation 
% ystart = ones(40,1);
% ystart(4:10) = 0;
% n1=M;
% n2=n1*(n1+1);
% y=zeros(n2,1); 
% y0=y;
% 
% y(1:n)=ystart(:); % initial condition of the ODE
% 
% for i=1:n1 
%     y((n1+1)*i)=1.0; % initial condition of the tangent linear
% end
% X = y;


% Lorenz equations
f=zeros(M,1);

% Y contains the initial conditions for the tangent linear
Y = zeros(M,M);

for i = 1:M
    Y(i,:) = X(i*M+1:(i+1)*M);
end
  
f(1)=(X(2)-X(M-1))*X(M)-X(1)+F;
f(2)=(X(3)-X(M))*X(1)-X(2)+F;
f(M)=(X(1)-X(M-2))*X(M-1)-X(M)+F;


for j=3:M-1
f(j)=(X(j+1)-X(j-2))*X(j-1)-X(j)+F;
end

% Linearised system

% column i contains the derivatives with respect to the variable i

Jac = zeros(M,M);
    
for i = 1:M
    
    Jac(1,i) = X(M)*Y(2,i) + (X(2)-X(M-1))*Y(M,i) - X(M)*Y(M-1,i) - Y(1,i);
    Jac(2,i) = X(1)*Y(3,i) + (X(3)-X(M))*Y(1,i) - X(1)*Y(M,i) - Y(2,i);
    Jac(M,i) = X(M-1)*Y(1,i) + (X(1)-X(M-2))*Y(M-1,i) - X(M-1)*Y(M-2,i) - Y(M,i);

    for j=3:M-1
        Jac(j,i)= X(j-1)*Y(j+1,i) + (X(j+1)-X(j-2))*Y(j-1,i) - X(j-1)*Y(j-2,i)-Y(j,i);
    end
    
end

f(M+1: M*(M+1)) = Jac*Y;