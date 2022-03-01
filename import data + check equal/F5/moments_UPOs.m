%% this function calculates the moments for all the orbits

function [primo,secondo, terzo, quarto, quinto] = moments_UPOs(trajectories_UPOs, number_points_trajectories)

number_UPOs = length(number_points_trajectories);
primo = zeros(1, number_UPOs);
secondo = zeros(1, number_UPOs);
terzo = zeros(1, number_UPOs);
quarto = zeros(1, number_UPOs);
quinto = zeros(1, number_UPOs);

% for each orbit calculates its length
for i=1:number_UPOs
    [primo(i), secondo(i), terzo(i), quarto(i), quinto(i)] = calculate_moments( trajectories_UPOs(1:number_points_trajectories(i),:,i));

end
