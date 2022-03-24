%% Lorenz-96 model + tangent linear

% this function evaluates the RHS of the Lorenz equation + its tangent
% linear dynamics
% M: number of modes
% F: forcing parameter
% y: point where I evaluate 

function f = lorenz96(t,X)
M=40;
F=4;
% Lorenz equations
f=zeros(M,1);

f(1)=(X(2)-X(M-1))*X(M)-X(1)+F;
f(2)=(X(3)-X(M))*X(1)-X(2)+F;
f(M)=(X(1)-X(M-2))*X(M-1)-X(M)+F;

for j=3:M-1
    f(j)=(X(j+1)-X(j-2))*X(j-1)-X(j)+F;
end


end