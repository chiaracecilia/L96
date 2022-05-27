

KS=zeros(max(size(Lp)),1);

for j=1:max(size(Lp));
    np=sum((Lp(:,j)>0));
    KS(j)=sum(Lp(1:np,j));
end



