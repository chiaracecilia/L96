% import initial conditions

orbits = importdata('perp10.dat');
N = 10; % number of orbits

%%
ic = reshape(orbits,[41,10]);

X = ic(1:40,:);
T = ic(41,:);

%% import equilibria

orbits = importdata('stat08.dat');
N = 8; % number of orbits

ic = reshape(orbits,[41,N]);

eq = ic(1:40,:);


    
