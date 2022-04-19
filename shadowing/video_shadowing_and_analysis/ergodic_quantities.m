%% calculate ergodic quantities

dt =0.01;
M = 40;
F = 5;
T_chaotic = 10^4;


x_chaotic = create_chaotic_trajectory(dt, T_chaotic, M, F);

[first_moment, second_moment, third_moment] = projection_moments(x_chaotic);

se = mean(sum(x_chaotic.^2));
% %%
% m = 0;
% for i = 1:length(x_chaotic(:,1))
%     m = m + (x_chaotic(i,:).^2);
% end
% mean(m)



% ergodic value of the second moment: 8.1267e+06     