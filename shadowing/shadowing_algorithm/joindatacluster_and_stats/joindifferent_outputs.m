i=1;
number_inputs = 20;

filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/' num2str(i,'%2.0f') '/shadowing_UPO_reduced.mat'];
str=whos('-file',filename);
str={str.name};
load(filename,str{:});
shadowing_UPO  = shadowing_UPO_reduced;
coordinate_shadowing = coordinate_shadowing_reduced;

filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/' num2str(i,'%2.0f') '/dist_shadowing_UPO_reduced.mat'];
str=whos('-file',filename);
str={str.name};
load(filename,str{:});
dist_shadowing = dist_shadowing_UPO_reduced;

filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/' num2str(i,'%2.0f') '/x_chaotic.mat'];
str=whos('-file',filename);
str={str.name};
load(filename,str{:});
x_ch = x_chaotic;

filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/' num2str(i,'%2.0f') '/indice_shad_UPO_reduced.mat'];
str=whos('-file',filename);
str={str.name};
load(filename,str{:});
index_shadowing=indice_shad_UPO_reduced;


for i= 2:number_inputs
    
    i
    filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/' num2str(i,'%2.0f') '/shadowing_UPO_reduced.mat'];
    str=whos('-file',filename);
    str={str.name};
    load(filename,str{:});
    
    shadowing_UPO = [shadowing_UPO;shadowing_UPO_reduced];
    coordinate_shadowing = [coordinate_shadowing;coordinate_shadowing_reduced];
    
    filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/' num2str(i,'%2.0f') '/dist_shadowing_UPO_reduced.mat'];
    str=whos('-file',filename);
    str={str.name};
    load(filename,str{:});
    
    dist_shadowing = [dist_shadowing;dist_shadowing_UPO_reduced];
    
    filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/' num2str(i,'%2.0f') '/indice_shad_UPO_reduced.mat'];
    str=whos('-file',filename);
    str={str.name};
    load(filename,str{:});
    
    index_shadowing = [index_shadowing;indice_shad_UPO_reduced];
    
    filename=['/home/ma/c/ccm4518/NEW/L96_F5_N20/10000/' num2str(i,'%2.0f') '/x_chaotic.mat'];
    str=whos('-file',filename);
    str={str.name};
    load(filename,str{:});
    x_ch = [x_ch;x_chaotic];
    
    
end


save('shadowing_UPO.mat', '-v7.3','shadowing_UPO', 'coordinate_shadowing')
save('dist.mat', '-v7.3','dist_shadowing')
save('index_shadowing.mat', '-v7.3','index_shadowing')
save('x_chaotic', '-v7.3','x_ch')