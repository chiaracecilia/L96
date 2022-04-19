%% this script calculates the persistence of the orbits

number_UPO = length(T);
[times, persistence, space] = pers(number_UPO, shadowing_UPO_reduced(:,1), x_chaotic);

idx = (persistence~=0);
per = persistence(idx);
spa = space(idx);
tim = times(idx);

persistenza = per./tim;
spazio = spa./tim;

%%
number_UPO = length(T);
[times, persistence, space] = pers(number_UPO, persistence_shadowing_orbits_10, x_chaotic);

idx = (persistence~=0);
per = persistence(idx);
spa = space(idx);
tim = times(idx);

persistenza_10 = per./tim;
spazio_10 = spa./tim;
%%
number_UPO = length(T);
[times, persistence, space] = pers(number_UPO, persistence_shadowing_orbits_30, x_chaotic);

idx = (persistence~=0);
per = persistence(idx);
tim = times(idx);
spa = space(idx);

persistenza_30 = per./tim;
spazio_30 = spa./tim;