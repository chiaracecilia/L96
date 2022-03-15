[T,Res]=lyapunov(3,@lorenz_ext,@ode45,0,0.5,200,[0 1 0],10);
plot(T,Res);
title('Dynamics of Lyapunov exponents');
xlabel('Time'); ylabel('Lyapunov exponents');
%%
ic = zeros(1,40);
ic(2)=1;
M=40;

[T,Res]=lyapunov(40,@lorenz96_ext,@ode45,0,0.5,200,ic,0);
plot(T,Res);
title('Dynamics of Lyapunov exponents');
xlabel('Time'); ylabel('Lyapunov exponents');

%%
Ly = Res(end,:);
k = 1:40;

assey = Ly./40;
assex = k./20;
plot(assex,assey)
