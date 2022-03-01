
k = zeros(1,length(x_chaotic)-1);

for i =1:length(x_chaotic)-1
    k(i) = norm(x_chaotic(i,:) - x_chaotic(i+1,:));
end
   