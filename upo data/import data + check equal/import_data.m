% % import initial conditions
N = 15019; % number of orbits
dt = 0.01;
F=5;
M = 20;

fileID_UPO = fopen('perpt.dt');
fileID_LE = fopen('lexpt.dt');
A = fread(fileID_UPO,'real*8');
B = fread(fileID_LE,'real*8');
fclose(fileID_UPO);
fclose(fileID_LE);
orbits = importdata('perp.dt');

%%
ic = reshape(A,[M+1,N]);

Xp = ic(1:M,:);
Tp = ic(M+1,:);

Tp = Tp*dt;

%%
Lp = reshape(B,[M,N]);


%%
j=6;
X = Xp(:,j);
T = Tp(j);
[x, dist] = calculate_UPO(X, T, dt,M, F);
