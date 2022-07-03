% this function given a point calculates the first three moments

function [first, second, third] = moments(point)

N = length(point);
first = sum(point)/N;
second = sum(point.^2)/N;
third = sum(point.^3)/N;

