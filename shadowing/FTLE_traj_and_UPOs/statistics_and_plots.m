%% this script analyses the statistics of the tangent space and shadowing UPOs

j = 1;

scatter(L_UPO(:,j), L_chaotic_traj(:,j))
R = corrcoef(L_UPO(:,j), L_chaotic_traj(:,j));

%%
number_positive_LE_UPO = zeros(1,length(UPO));
KS_UPO = zeros(1,length(UPO));

for i = 1:length(UPO) 
    [number_positive_LE_UPO(i), ~, ~,~,~, ~ , KS_UPO(i)] = sign_LE(L_UPO(i,:));
end

number_positive_LE_traj = zeros(1,length(UPO));
KS_traj = zeros(1,length(UPO));

for i = 1:length(UPO) 
    [number_positive_LE_traj(i), ~, ~,~,~, ~ , KS_traj(i)] = sign_LE(L_chaotic_traj(i,:));
end

%%

scatter(number_positive_LE_traj, number_positive_LE_UPO)
R = corrcoef(number_positive_LE_traj, number_positive_LE_UPO);

%%

scatter(KS_traj, KS_UPO)
R = corrcoef(KS_traj, KS_UPO);