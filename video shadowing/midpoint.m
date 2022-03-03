%% this script implements the midpoint integration scheme 

% INPUT
% f equation
% tmin, tmax, time interval where I want the solution of the equation (1,1)
% dt space step (1,1)
% init_cond initial (N,1)
% M number of modes (1,1)
% F forcing parameter (1,1)

function x = midpoint(tmin,dt, tmax, init_con, M, F)

t = tmin:dt:tmax;
x = zeros(length(t),M);

x(1,:)=init_con;

for i=2:length(t)
    k = x(i-1,:)' + dt * lorenz96(x(i-1,:),M,F)/2;
    x(i,:) = x(i-1,:)' + dt * lorenz96(k, M,F);
end
    

