function [Texp,Lexp]=lyapunov(n,rhs_ext_fcn,fcn_integrator,tstart,stept,tend,ystart,ioutp)

% n=3;
% rhs_ext_fcn = @lorenz_ext;
% ystart = [0,1,0];

% n=40;
% rhs_ext_fcn=@lorenz96_ext;
% ystart = ones(40,1);
% ystart(4:10) = 0;
% 
% 
% fcn_integrator=@ode45;
% 
% tstart = 0;
% stept=0.5;
% tend = 100;
% ioutp = 0;

%    Lyapunov exponent calculation for ODE-system.
%
%    The alogrithm employed in this m-file for determining Lyapunov
%    exponents was proposed in
%
%         A. Wolf, J. B. Swift, H. L. Swinney, and J. A. Vastano,
%        "Determining Lyapunov Exponents from a Time Series," Physica D,
%        Vol. 16, pp. 285-317, 1985.
%
%    For integrating ODE system can be used any MATLAB ODE-suite methods. 
% This function is a part of MATDS program - toolbox for dynamical system investigation
%    See:    http://www.math.rsu.ru/mexmat/kvm/matds/
%
%    Input parameters:
%      n - number of equation
%      rhs_ext_fcn - handle of function with right hand side of extended ODE-system.
%              This function must include RHS of ODE-system coupled with 
%              variational equation (n items of linearized systems, see Example).                   
%      fcn_integrator - handle of ODE integrator function, for example: @ode45                  
%      tstart - start values of independent value (time t)
%      stept - step on t-variable for Gram-Schmidt renormalization procedure.
%      tend - finish value of time
%      ystart - start point of trajectory of ODE system.
%      ioutp - step of print to MATLAB main window. ioutp==0 - no print, 
%              if ioutp>0 then each ioutp-th point will be print.
%
%    Output parameters:
%      Texp - time values
%      Lexp - Lyapunov exponents to each time value.
%
%    Users have to write their own ODE functions for their specified
%    systems and use handle of this function as rhs_ext_fcn - parameter.      
%
%    Example. Lorenz system:
%               dx/dt = sigma*(y - x)     = f1
%               dy/dt = r*x - y - x*z = f2
%               dz/dt = x*y - b*z     = f3
%
%    The Jacobian of system: 
%        | -sigma  sigma  0 |
%    J = |   r-z    -1   -x |
%        |    y      x   -b |
%
%    Then, the variational equation has a form:
% 
%    F = J*Y
%    where Y is a square matrix with the same dimension as J.
 
n1=n; % n=number of nonlinear odes
n2=n1*(n1+1); % total number of odes

%  Number of steps
nit = round((tend-tstart)/stept);

% Memory allocation 
y=zeros(n2,1); 
cum=zeros(n1,1); 
y0=y;
gsc=cum; 
znorm=cum; % contains the norm of the normalised based at each increment
t=tstart;

% Initial values
y(1:n)=ystart(:); % initial condition of the ODE

for i=1:n1 
    y((n1+1)*i)=1.0; % initial condition of the tangent linear
end



%%
% Main loop

for ITERLYAP=1:nit

% Solutuion of extended ODE system in the interval [t, tstep]


  [~,Y] = feval(fcn_integrator,rhs_ext_fcn,[t t+stept],y);  % solve the variational equation with initial condition y in the interval [t, t+step] 
  
  t=t+stept; % update to the new section 
  y=Y(size(Y,1),:); % last point of the solution of the variational equation

  % this loop transposes the tangent linear matrix solution
  for i=1:n1 
      for j=1:n1 
          y0(n1*i+j)=y(n1*j+i); 
      end
  end

%       construct new orthonormal basis by gram-schmidt

% the voume spanned by the old basis is given by prod(znorm) 
% I consider the evoluted frame (now almost surely not anymore orthogonal)
% at time t+step and I produce an orthogonal frame out of it 

  znorm(1)=0.0;
  for j=1:n1 
      znorm(1)=znorm(1)+y0(n1*j+1)^2; 
  end

  znorm(1)=sqrt(znorm(1)); % Euclidian norm (sqrt of the summed squared components)

  for j=1:n1 
      y0(n1*j+1)=y0(n1*j+1)/znorm(1); 
  end

  for j=2:n1
      
      for k=1:(j-1)
          gsc(k)=0.0;
          for l=1:n1 
              gsc(k)=gsc(k)+y0(n1*l+j)*y0(n1*l+k); 
          end
      end
 
      for k=1:n1
          for l=1:(j-1)
              y0(n1*k+j)=y0(n1*k+j)-gsc(l)*y0(n1*k+l);
          end
      end

      znorm(j)=0.0;
      
      for k=1:n1 
          znorm(j)=znorm(j)+y0(n1*k+j)^2; 
      end
      znorm(j)=sqrt(znorm(j));

      for k=1:n1 
          y0(n1*k+j)=y0(n1*k+j)/znorm(j); 
      end
  end

%
%       update running vector magnitudes
%

  for k=1:n1 
      cum(k)=cum(k)+log(znorm(k));
  end

%
%       normalize exponent
%

  for k=1:n1 
      lp(k)=cum(k)/(t-tstart); 
  end

% Output modification

  if ITERLYAP==1
     Lexp=lp;
     Texp=t;
  else
     Lexp=[Lexp; lp];
     Texp=[Texp; t];
  end

  if (mod(ITERLYAP,ioutp)==0)
     fprintf('t=%6.4f',t);
     for k=1:n1 fprintf(' %10.6f',lp(k)); end;
     fprintf('\n');
  end

  for i=1:n1 
      for j=1:n1
          y(n1*j+i)=y0(n1*i+j);
      end
  end

end