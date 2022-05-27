%%% this script originates for each initial condition the corresponind 39
%%% symmetric 

load('raw_F5_M20_final.mat')

M = 20;
number_UPOs = length(Tp);

% matrix of initial conditions
X = zeros(M, number_UPOs*M);
T = zeros(1,number_UPOs*M);
L = zeros(M,number_UPOs*M);
%%
for i =1:number_UPOs %examine all UPOs
    X(:,M*(i-1)+1:M*i)=circulate(Xp(:,i), M)';
    T(M*(i-1)+1:M*i)=Tp(i);
    L(1:end,M*(i-1)+1:M*i)=repmat(Lp(1:end,i),  1, M);
end
     