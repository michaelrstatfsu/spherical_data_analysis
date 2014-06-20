%%
clear; close all
lambda=10^(-10);
filename='midatlantic_cv'
l=3;
NN=60;
%% load data
load([filename '.mat'])
[M,N]=size(X);
%%
[Grid2,E,Xtilde,path] = NPSR(X,Y,lambda,l,NN);
%%
load GRID_10_60.mat
grid2=reshape(Grid2(:,:,:,end),NNNN,3)';
[Xtilde,neighbors]=interpsurf(grid,grid2,X);
%%
save([filename '_fitted_' num2str(l) '.mat'])

save([filename '_fitted_' num2str(l) '_light.mat'],'grid','grid2')