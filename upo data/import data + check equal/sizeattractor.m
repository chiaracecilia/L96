%% calculate the size of the attractor

M = 20;
F = 5;

start = 3*rand(M,1);

f = midpoint(0,0.01, 10000, start, M, F);
x = midpoint(0,0.1, 1000, f(end,:), M, F);


% calculate all the distances 
dmax = 0;

for i = 1:length(x(:,1))
    d = norm(x(1,:)-x(i,:));
    if (d>dmax)
        dmax=d;
    end
end
        

%% typical distance

%% calculate the size of the attractor

% calculate all the distances
h = length(x(:,1));
distances = zeros(h*(h-1)/2,1);
count = 0;

for i = 1:length(x(:,1))
    for j = i+1:length(x(:,1))
        count = count+1;
        distances(count) = norm(x(i,:)-x(j,:));
    end
end

%%

[f,xi] = ksdensity(distances)
plot(xi, f)
xlabel('distance')
        