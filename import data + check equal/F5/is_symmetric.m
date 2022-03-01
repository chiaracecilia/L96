%% this function takes two inial conditions and check whether an orbit could be the symmetric of the other

% OUTPUT
% flag(M,1): 1 if orbit at position i is the same, 0 otherwise 
% if flag(j)==1 => Xj= circshift(Xi, j)



function [flag] = is_symmetric(Xi, Xj, Ti, Tj, dt, F, M, tol)

% circulate over the M-1 possible symmetric orbits and test whether I find
% the same orbit. 


flag = zeros(M,1);
% Xi stays fixed

% circulate Xj
for i=1:M-1
    Xjc=circshift(Xj, i);
    [f, ~] = is_the_same(Xi, Xjc, Ti, Tj, dt, F, M, tol);
    if (f)
        flag(M-i)=1;
    end
end


