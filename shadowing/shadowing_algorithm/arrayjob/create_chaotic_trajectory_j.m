
function x_chaotic = create_chaotic_trajectory_j(j, length_each_piece, dt, T_chaotic,M, F, seed)

%
points_each_piece = length_each_piece/dt;
index_start = (j-1)*points_each_piece +1;

x_chaotic_total = create_chaotic_trajectory(dt, T_chaotic, M, F, seed);   
%%
x_chaotic = midpoint(0,dt, length_each_piece-dt, x_chaotic_total(index_start,:), M, F); 


end