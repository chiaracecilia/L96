%% this scrip takes an initial condition and generates the other M-1 initial conditions associated to that UPO

function X = circulate(x, M)

X = zeros(M,M); % this will contain the M initial conditions associated to x
X(1,:)=x;

for i=1:M-1
    X(i+1,:)=circshift(x, i);
end
end