%% Lorenz-96 model + tangent linear

% this function evaluates the RHS of the Lorenz equation + its tangent
% linear dynamics
% M: number of modes
% F: forcing parameter
% y: point where I evaluate 

function f = lorenz96_ext_ode45(t,X)
M=40;
F=8;
% Lorenz equations
f=zeros(M^2,1);

% Y contains the initial conditions for the tangent linear
Y = zeros(M,M);

for i = 1:M
    Y(:,i) = X(i*M+1:(i+1)*M);
end
  
f(1)=(X(2)-X(M-1))*X(M)-X(1)+F;
f(2)=(X(3)-X(M))*X(1)-X(2)+F;
f(M)=(X(1)-X(M-2))*X(M-1)-X(M)+F;

for j=3:M-1
    f(j)=(X(j+1)-X(j-2))*X(j-1)-X(j)+F;
end

% Linearised system

% column i contains the derivatives with respect to the variable i

D = eye(M,M);
Jac = zeros(M,M);
    
for i = 1:M
    
    Jac(1,i) = X(M)*D(2,i) + (X(2)-X(M-1))*D(M,i) - X(M)*D(M-1,i) - D(1,i);
    Jac(2,i) = X(1)*D(3,i) + (X(3)-X(M))*D(1,i) - X(1)*D(M,i) - D(2,i);
    Jac(M,i) = X(M-1)*D(1,i) + (X(1)-X(M-2))*D(M-1,i) - X(M-1)*D(M-2,i) - D(M,i);

    for j=3:M-1
        Jac(j,i)= X(j-1)*D(j+1,i) + (X(j+1)-X(j-2))*D(j-1,i) - X(j-1)*D(j-2,i)-D(j,i);
    end
    
end

f(M+1: M*(M+1)) = Jac*Y;