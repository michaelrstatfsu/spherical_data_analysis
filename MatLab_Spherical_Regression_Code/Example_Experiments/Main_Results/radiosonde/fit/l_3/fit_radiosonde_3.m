%%
clear; close all
lambda=0.00049383;
filename='weatherballoon';
l=3;NN=60;
%% load data
load([filename '.mat'])
[M,N]=size(X);
%%
[Grid2,E,Xtilde,path] = NPSR(X,Y,lambda,l,NN);
%%
load GRID_10_60.mat
grid2=reshape(Grid2(:,:,:,end),NNNN,3)';
[Xtilde,neighbors]=interpsurf(grid,grid2,X,l);
%%
save([filename '_fitted.mat'])

save([filename '_fitted_light.mat'],'grid','grid2')
