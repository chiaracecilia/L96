% this function associates the FTLE of the chaotic trajectory to the
% shadowing orbit

% load data
clear all
clc

filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/test_res_time/upo_data.mat'];
str=whos('-file',filename);
str={str.name};
load(filename,str{:});

filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/test_res_time/shadowing_UPO.mat'];
str=whos('-file',filename);
str={str.name};
load(filename,str{:});

filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/test_res_time/x_chaotic.mat'];
str=whos('-file',filename);
str={str.name};
load(filename,str{:});

dt_renormalisation = 2;
F = 5;
N = 20;
dt = 0.01;

count = 1;

block_number = 0;

for i = 1:length(shadowing_UPO)-1
    i
    if((shadowing_UPO(i+1)~=shadowing_UPO(i)) || i==(length(shadowing_UPO)-1))
        
        block_number = block_number + 1;
        
        FTLE_time = dt * count;
       
        Lambda_step = FTLE_QR(x_ch(i+1-count,:), FTLE_time, F, N);
        
        if (block_number==1)
            Lambda_step =  FTLE_QR(x_ch(i+1-count,:), FTLE_time, F, N);
            pers = FTLE_time;
            L_chaotic_traj = sort(Lambda_step, 'desc');
            UPO = shadowing_UPO(i);
            L_UPO = L(:,i)';
        else
            
            Lambda_step = sort(Lambda_step, 'desc');
            L_chaotic_traj = [L_chaotic_traj;Lambda_step];
            UPO = [UPO;shadowing_UPO(i)];
            L_UPO = [L_UPO; L(:,i)'];
            pers = [pers;FTLE_time];
            
        end
        
        count=1;
        
    else
        count = count+1;
    end
end
    
save('Lambda_shadowing.mat', 'UPO', 'L_chaotic_traj', 'L_UPO', 'pers')