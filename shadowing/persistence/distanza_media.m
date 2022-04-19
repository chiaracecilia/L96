%% this script calculates the average distances in the phase space 

% parameters
M = 40;
F = 5;
T_chaotic = 100;
dt = 0.01;

%%

x_chaotic = create_chaotic_trajectory(dt, T_chaotic, M, F);

%%
N = length(x_chaotic(:,1)); % dimension of the matrix that will contain the distances

D = (N*(N-1))/2;
distances = zeros(1,D);

%%
count=0;
for i =1:N
    for j = i+1:N
        count = count+1;
        distances(count) = norm(x_chaotic(i,:)-x_chaotic(j,:));
    end
end
        
%% AVERAGE SIZE OF A TIME-STEP

dist = zeros(N-1,1);

for i=1:N-1
    dist(i) = norm(x_chaotic(i,:)-x_chaotic(i+1,:));
end


        
%%
[f,xi] = ksdensity(distances,'Support','positive');

a = plot(xi,f, 'k', 'LineWidth',2)
a.Color = [0.6350 0.0780 0.1840];
xlabel('typical distances distribution')
