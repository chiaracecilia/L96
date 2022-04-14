% test algorithm for UPOs

Tspin=50; % transient time
Tfin=100;
dtL=0.5;

Nstep=Tfin/dtL;
time=dtL*[0:Nstep];

N=40;
F=8;
eps=1e-8;

yo=rand(N,1);

Yirr=midpoint(@lorenz96,0,0.01,Tspin-0.001,yo,N,F);
yo=Yirr(end,:);

trajh1irr=zeros([Nstep,N]);
ytpert=zeros(N,N);

Texp=zeros(Nstep,1);
Lexph1irrnum=zeros(Nstep,N);
%stima degli esponenti di Lyapunov

Mpert=eps*eye(N);

ci=yo;


for j=1:Nstep
    Y = midpoint(@lorenz96,time(j),0.01,time(j+1),ci,N,F);
    yt=Y(end,1:N);
    trajh1irr(j,:)=Y(end,:);
    
    for p=1:N
        Yp = midpoint(@lorenz96,time(j),0.01,time(j+1),ci+Mpert(p,:),N,F);
        ytpert(p,:)=Yp(end,1:N)-Y(end,1:N);
    end
    
    %questo costruisce l?evoluto del cubetto intorno alla traiettoria di riferimento
    Mtan=ytpert';
    [Q1,R1] = qr(Mtan);
    %ecco la QR
    Mpert=eps*Q1;
    %ecco i nuovi vettori di perturbazione
    ci=yt;
    
    Texp(j)=time(j+1);
    dia=diag(log(abs(R1/eps)));
    Lexph1irrnum(j,:)=dia/dtL;
    
    
end
