%% this function returns the first three moments for each point along the given trajectory

function [first_moment, second_moment, third_moment] = projection_moments(trajectory)

first_moment = zeros(1, length(trajectory(:,1)));
second_moment = zeros(1, length(trajectory(:,1)));
third_moment = zeros(1, length(trajectory(:,1)));

for i=1:length(trajectory(:,1))
     [first_moment(i), second_moment(i), third_moment(i)] = moments(trajectory(i,:));
end