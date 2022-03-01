% this function creates the chaotic trajectory for which I will calculate
% the shadowing


function x_chaotic = create_chaotic_trajectory(dt, T_chaotic, M, F)
x = midpoint(0,dt, 100, rand(1,M),M, F); % find an initial condition in the attractor of the system
x_chaotic = midpoint(0,dt, T_chaotic, x(end,:), M, F); 
end