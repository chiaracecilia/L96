%% calculate the size of the attractor

M = 40;
F = 8;

start = 3*ones(40,1);

f = midpoint(0,0.01, 10000, start, M, F);
x = midpoint(0,0.01, 10000, f(end,:), M, F);


% calculate all the distances 
dmax = 0;

for i = 1:length(x(:,1))
    d = norm(x(1,:)-x(i,:));
    if (d>dmax)
        dmax=d;
    end
end
        