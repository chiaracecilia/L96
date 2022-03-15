%% Lorenz-96 model
% M: number of modes
% F: forcing parameter
% y: point where I evaluate 

function f = lorenz96(t,X)

M=40;
F=5;
% Lorenz equations
f=zeros(M,1);

Y = zeros(M,M);

for i = 1:M-1 
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
    
    Jac(1,i) = X(M)*Jac(2,i) + (X(2)-X(M-1))*Jac(M,i) - X(M)*Jac(M-1,i) - Jac(1,i);
    Jac(2,i) = X(1)*Jac(3,i) + (X(3)-X(M))*Jac(1,i) - X(1)*Jac(M,i) - Jac(2,i);
    Jac(M,i) = X(M-1)*Jac(1,i) + (X(1)-X(M-2))*Jac(M-1,i) - X(M-1)*Jac(M-2,i) - Jac(M,i);

    for j=3:M-1
        Jac(j,i)= X(j-1)*Jac(j+1,i) + (X(j+1)-X(j-2))*Jac(j-1,i) - X(j-1)*Jac(j-2,i)-Jac(j,i);
    end
    
    f(M+1: M*(M+1)) = Jac*Y;
end
