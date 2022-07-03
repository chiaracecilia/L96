%% calculate new shadowing orbits considering different persistence levels and work out the average persistence for each of them

try
    load('shadowing_UPO.mat')
    load('upo_data.mat')
    
    
    M1 = 10;
    M2 = 100;
    %M3 = 1000;
    
    number_UPO = length(T);
    
    [persistent_shadowing_UPO_10] = persistent_shadowing(shadowing_UPO, M1);
    [persistent_shadowing_UPO_100] = persistent_shadowing(shadowing_UPO, M2);
    %[persistent_shadowing_UPO_1000] = persistent_shadowing(shadowing_UPO, M3);
    
    %% calculate average persistence
    
    [times1, count1, average_persistence1] = average_persistence_UPOs(number_UPO, shadowing_UPO(:,1));
    [times10, count10, average_persistence10] = average_persistence_UPOs(number_UPO, persistent_shadowing_UPO_10);
    [times100, count100, average_persistence100] = average_persistence_UPOs(number_UPO, persistent_shadowing_UPO_100);
    %[times1000, count1000, average_persistence1000] = average_persistence_UPOs(number_UPO, persistent_shadowing_UPO_1000);
    
    %save('persistent_shadowing.mat', '-v7.3','persistent_shadowing_UPO_10', 'persistent_shadowing_UPO_100', 'persistent_shadowing_UPO_1000')
    save('average_persistence.mat', '-v7.3', 'average_persistence1', 'average_persistence10', 'average_persistence100')
    
    
    %%%%%%%%%% calculate the average persistence over each tiers
    load('shadowing_UPO.mat')
    N=100; %consider the first N tiers
    
    average_persistence = zeros(1, N);
    
    for i = 1:N
        [~, ~, average_persistence_full] = average_persistence_UPOs(number_UPO, shadowing_UPO(:,i));
        idx = average_persistence_full~=0;
        persistenza = average_persistence_full(idx);
        average_persistence(i) = mean(persistenza);
    end
    
    save('average_persistencetiers.mat', 'average_persistence')
    
    
catch err
    fid = fopen('errorFile','a+');
    fprintf(fid, '%s', err.getReport('extended', 'hyperlinks','off'));
    fclose(fid);
    
end



