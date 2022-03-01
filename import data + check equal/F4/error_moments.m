%% this function calculates the typical error for the different moments

function [error_first, error_second, error_third, error_fourth, error_fifth] = error_moments(trajectories_UPOs, number_points_trajectories,trajectories_UPOs_shifted, number_points_UPOs_shifted)

[primo,secondo, terzo, quarto, quinto] = moments_UPOs(trajectories_UPOs, number_points_trajectories);
[primo_shifted,secondo_shifted, terzo_shifted, quarto_shifted, quinto_shifted] = moments_UPOs(trajectories_UPOs_shifted, number_points_UPOs_shifted);

error_first = abs(primo-primo_shifted);%./(abs(primo) + abs(primo_shifted));
error_second = abs(secondo-secondo_shifted);%./(abs(secondo)+ abs(secondo_shifted));
error_third = abs(terzo-terzo_shifted);%./(abs(terzo)+ abs(terzo_shifted));
error_fourth = abs(quarto-quarto_shifted);%./(abs(quarto)+ abs(quarto_shifted) );
error_fifth = abs(quinto-quinto_shifted);%./(abs(quinto)+ abs(quinto_shifted));