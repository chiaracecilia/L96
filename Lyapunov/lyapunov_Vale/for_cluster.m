
M=40;
F=8;

[T,Res]=lyapunov_midpoint(M, F,0.01,0, 0.1,100,rand(1,M),0);
%%
[Texp,Lexp]=lyapunov(M,@lorenz96_ext_ode45,@ode45,0,0.1,10^4,rand(1,M),0);

save('expo.mat')

