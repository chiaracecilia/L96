%% Lorenz-96 model
% M: number of modes
% F: forcing parameter
% y: point where I evaluate 

function dy = lorenz96irr(t,y)
M = 40;
F=8;
dy=zeros(M,1);

dy(1)=(y(2)-y(M-1))*y(M)-y(1)+F;
dy(2)=(y(3)-y(M))*y(1)-y(2)+F;
dy(M)=(y(1)-y(M-2))*y(M-1)-y(M)+F;

for j=3:M-1
dy(j)=(y(j+1)-y(j-2))*y(j-1)-y(j)+F;
end