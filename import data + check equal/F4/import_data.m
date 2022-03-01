% import initial conditions

orbits = importdata('lor4.dat');
N = 32; % number of orbits
dt = 0.01;
F=4;
%%
ic = reshape(orbits,[41,N]);

Xp = ic(1:40,:);
Tp = ic(41,:);

Tp = Tp*dt;


    
