%%% this script originates for each initial condition the corresponind 39
%%% symmetric 

%load('ic.mat')

M = 40;
number_UPOs = length(Tp);

% matrix of initial conditions
X = zeros(M, number_UPOs*M);
T = zeros(1,number_UPOs*M);
%%
for i =1:number_UPOs %examine all UPOs
    X(:,M*(i-1)+1:M*i)=circulate(Xp(:,i), M)';
    T(M*(i-1)+1:M*i)=Tp(i);
end
        