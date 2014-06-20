%%
clear; close all
lambda=0.0044444;l=10
filename='cloud_083012_083112_allover_cv'
%% load data
load([filename '.mat'])
[M,N]=size(X);
%%
[Grid2,E,Xtilde,path] = NPSR(X,Y,lambda,l);
%%
load GRID_10_60.mat
grid2=reshape(Grid2(:,:,:,end),NNNN,3)';
[Xtilde,neighbors]=interpsurf(grid,grid2,X);
%%
save([filename '_fitted.mat'])

save([filename '_fitted_light.mat'],'grid','grid2')
