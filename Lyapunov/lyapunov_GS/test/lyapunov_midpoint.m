function [Texp,Lexp, Lambda]=lyapunov_midpoint(n,F, tau, tstart,stept,tend,ystart,ioutp)

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

%       n=number of nonlinear odes
%       n2=n*(n+1)=total number of odes
%

n1=n; % number of nonlinear ODEs
n2=n1*(n1+1); % total number of equation

%  Number of steps

nit = round((tend-tstart)/stept);
M=n;

% Memory allocation 

y=zeros(n2,1); 
cum=zeros(n1,1);
y0=y;
gsc=cum; 
znorm=cum; % contains the norm of the normalised base at each increment

% Initial values

y(1:n)=ystart(:); % initial condition of the ODE

for i=1:n1 
    y((n1+1)*i)=1.0; % initial condition of the tangent linear
end

t=tstart; % initial time

% Main loop

for ITERLYAP=1:nit

% Solution of extended ODE system in the interval [t, tstep]

  Y = midpoint(@lorenz96_ext_midpoint, t,tau, t+stept, y, M, F); % solve the variational equation in the interval [t, tstep]
  
  t=t+stept;    % update to the new section 
  y=Y(size(Y,1),:); % last point of the solution of the variational equation 

  % this loop transposes the tangent linear matrix solution 
  for i=1:n1 
      for j=1:n1 y0(n1*i+j)=y(n1*j+i); end
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

  for j=1:n1 y0(n1*j+1)=y0(n1*j+1)/znorm(1); end;

  for j=2:n1
      for k=1:(j-1)
          gsc(k)=0.0;
          for l=1:n1 gsc(k)=gsc(k)+y0(n1*l+j)*y0(n1*l+k); end;
      end;
 
      for k=1:n1
          for l=1:(j-1)
              y0(n1*k+j)=y0(n1*k+j)-gsc(l)*y0(n1*k+l);
          end;
      end;

      znorm(j)=0.0;
      for k=1:n1 znorm(j)=znorm(j)+y0(n1*k+j)^2; end;
      znorm(j)=sqrt(znorm(j));

      for k=1:n1 y0(n1*k+j)=y0(n1*k+j)/znorm(j); end;
  end;

%
%       update running vector magnitudes
%

  for k=1:n1 cum(k)=cum(k)+log(znorm(k)); end;

%
%       normalize exponent
%

  for k=1:n1 
      lp(k)=cum(k)/(t-tstart); 
  end;

% Output modification

  if ITERLYAP==1
     Lexp=lp;
     Texp=t;
  else
     Lexp=[Lexp; lp];
     Texp=[Texp; t];
  end;

  if (mod(ITERLYAP,ioutp)==0)
     fprintf('t=%6.4f',t);
     for k=1:n1 fprintf(' %10.6f',lp(k)); end;
     fprintf('\n');
  end;

  for i=1:n1 
      for j=1:n1
          y(n1*j+i)=y0(n1*i+j);
      end;
  end;

end;
Lambda = Lexp(end,:);