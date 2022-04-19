%% calculate first moments of the variable along the orbit

function [primo, secondo, terzo, quarto, quinto] = calculate_moments(trajectories_UPOs)

primo = mean(sum(trajectories_UPOs(:,:)'));
secondo = mean(sum((trajectories_UPOs(:,:).^2)'));
terzo = mean(sum((trajectories_UPOs(:,:).^3)'));
quarto = mean(sum((trajectories_UPOs(:,:).^4)'));
quinto = mean(sum((trajectories_UPOs(:,:).^5)'));


