%% this script calculates the average speed over the Lorenz attractor 

%% import and creata data for video
load('upo_data.mat')
load('x_chaotic.mat')
load('indice_shad_UPO_reduced.mat')
load('shadowing_stats.mat')          
load('shadowing_UPO_reduced.mat')
load('dist_shadowing_UPO_reduced.mat')
%%
dt = 0.01;
number_UPO=length(T);

F = 5;
M=20;

             

% evaluate the vector field on the chaotic trajectory 
%% mean speed
v = zeros(1,length(x_chaotic));

for i = 1:length(x_chaotic)
    v(i) = norm(lorenz96(x_chaotic(i,:),M,F));
end

%% evaluate the speed over the shadowing orbits

v_shad_UPO = zeros(M,length(x_chaotic));
s_shad_UPO = zeros(1,length(x_chaotic));
v_x_chaotic = zeros(M,length(x_chaotic));
s_x_chaotic = zeros(1,length(x_chaotic));


for i = 1:length(x_chaotic)
    v_shad_UPO(:,i) = lorenz96(x_chaotic(i,:),M,F);
    s_shad_UPO(i) = norm(v_shad_UPO(i));
    v_x_chaotic(:,i) = lorenz96(coordinate_shadowing_reduced(i,:,1),M,F);
    s_x_chaotic(i) = norm(v_x_chaotic(i));
end
%%
diff = zeros(1,length(x_chaotic));
h = zeros(1,length(x_chaotic));

for i = 1:length(x_chaotic)
    h(i) = norm(v_shad_UPO(:,i)-v_x_chaotic(:,i));
    diff(i) = h(i)/(norm(v_shad_UPO(:,i)) + norm(v_x_chaotic(:,i)));
end


%% plot these

hist(diff) 
set(0,'defaulttextinterpreter','latex')
ylabel('count')
xlabel('$\frac{|v(chaotic \quad trajectory \quad  step \quad i)-v(shadowing \quad UPO \ step \quad i)|}{|v(chaotic \quad trajectory \quad step \quad i)| +|v(shadowing \quad UPO \ step \quad i)|}$')
set(gca,'FontSize', 15)

%% plot these

hist(h) 
set(0,'defaulttextinterpreter','latex')
ylabel('count')
xlabel('$\frac{|v(chaotic \quad trajectory \quad  step \quad i)-v(shadowing \quad UPO \ step \quad i)|}{|v(chaotic \quad trajectory \quad step \quad i)| +|v(shadowing \quad UPO \ step \quad i)|}$')
set(gca,'FontSize', 15)

%%
hist(d2) 
set(0,'defaulttextinterpreter','latex')
ylabel('count')
xlabel('distance between shadowing UPO and chaotic trajectory')
set(gca,'FontSize', 15)