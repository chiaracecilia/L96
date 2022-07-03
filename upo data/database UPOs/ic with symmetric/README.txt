SHADOWING LORENZ-96 MODEL N= 20, F = 5

The data refer to the shadowing of a chaotic trajectory of length Tmax = 100, discretised in 10^4 points of size dt = 0.01 each. (Happy to provide a longer one if needed!). 

At each time-step we select the 100 closest orbits to the chaotic trajectory. (Again, I also have more tiers in the selection in case you'd need them)

************************************************************************************
NUMERICAL SCHEME 

Since the UPOs are extremely sensitive to the numerical scheme used to reproduce them it is essential that you implement the same schemed used to find them. 

midpoint scheme 
X(^)=X(i)+tau*F(X(i))/2
X(i+1)=X(i)+tau*F(X(^))

for the UPOs we use: 
T_timeunits = T/dt;
tau = dt * T_timeunits/integerpart(T_timeunits);

All the orbits close with a precision of around 10^(-11) (please check that to make sure that you reproduced the data correctly) 
************************************************************************************
DATA AVAILABLE 

- chaotic_traj.mat
chaotic_traj size: (10^4, 20)
contains the chaotic trajectory considered in the shadowing. It is a trajectory contained in the attractor of the system 

- shad_UPO.mat 
shad_UPO size: (10^4,100)
the element (i,j) contains the UPO that shadows the trajectory at time-step i and it is the jth closest
eg. if shadowing_UPO(3,8) = 34 means that the UPO identified by position 34 in the array X,T,L of the file "upo_data.mat' is the 8th closest to the chaotic trajectory at step 3. 

- upo_data.mat
contains the data relative to N = 300380 UPOs. 

X size (20, N) contains the initial condition of the UPOs
T size (1, N) contains the period of the UPOs
L size (20,N) contains the Lyapunov exponents of each UPO

