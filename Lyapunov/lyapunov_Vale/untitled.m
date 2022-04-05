load('F8_raw.mat')

n = 40; % n - number of equation
F = 8;
M = n; % dimension of the L-96 system

% UPO data
j=5; % UPO 3
dt = 0.01;
T = Tp(j); % period UPO
X = Xp(:, j);
ystart = X'; % starting condition

% calculate integration time-step specific to the UPO
T_timeunits = T/dt;
tau = dt * T_timeunits/fix(T_timeunits);
%%
[x, dist] = calculate_UPO(X, T, dt,M, F);






for i = 1:50
    stept = T/i;
    g = 0:tau:0+stept;
    length(g)
    if ( length(g) == 40 )
        i
        break
    end
    
end
