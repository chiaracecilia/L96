%% this function calculates the periodic orbit

% NB the period should be actual period 

function [x, dist] = calculate_UPO(X, T, dt,M, F)

T_timeunits = T/dt;
tau = dt * T_timeunits/fix(T_timeunits);
x = midpoint(0,tau, T, X, M, F);

dist=norm(x(1,:)-x(end,:));

end
