%% %%
ic = zeros(1,40);
ic(2)=1;
M=40;

[T,Res]=lyapunov(40,@lorenz96_ext,@ode45,0,0.5,10^4,ic,0);
 

lyap = Res(end, :);
save('lyap.mat', 'lyap');

