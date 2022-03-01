%% create a vector containing all initial conditions and the repeated ones


M = 40;
F = 8;
dt=0.01;

orbits = importdata('perp10.dat');
N = 10; % number of orbits

%%
ic = reshape(orbits,[41,10]);

Xp = ic(1:40,:);
Tp = ic(41,:)*dt;

%%

X = zeros(N*M, M);
T = zeros(N*M, 1);

for i=1:N
    a = (i-1)*M+1;
    b=i*M;
    X(a:b,:)=circulate(Xp(:,i), M);
    T(a:b)=Tp(i);
end

