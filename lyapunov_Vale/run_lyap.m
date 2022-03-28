[T,Res]=lyapunov(40,@lorenz96_ext,@ode45,0,0.1,500,rand(1,40),0);
plot(T,Res);
title('Dynamics of Lyapunov exponents');
xlabel('Time'); ylabel('Lyapunov exponents');

