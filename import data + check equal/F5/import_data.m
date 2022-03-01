% import initial conditions

orbits = importdata('lor5.dat');
N = 1252; % number of orbits
dt = 0.01;
F=5;
%%
ic = reshape(orbits,[41,N]);

Xp = ic(1:40,:);
Tp = ic(41,:);

Tp = Tp*dt;


    
