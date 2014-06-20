% Design a tuning algorithm for the weather balloon data.
clear;close all;load midatlantic.mat;
[M,N]=size(X);load GRID_15_60;l=5;
clear B b btan
%% K-fold Modified to only do one
K=2;
IND=randsample(1:N,N);
ind=zeros(N-floor(N/K),K);
% for k=1:K
j=1;
k=1
ind(:,k)=randsample(IND,floor(N/K));
x=X(:,ind(:,k));y=Y(:,ind(:,k));
indtest(:,k)=setdiff(IND,ind(:,k));
x2=X(:,indtest(:,k));y2=Y(:,indtest(:,k));
save data_cv
%%
clear;load data_cv
lambda=(linspace(0,.1,10)).^2
for j=1:10
    filename=['midatlantic_cv_' num2str(lambda(j)) '_' num2str(NN) '_' num2str(l) '.mat'];
    [Grid2] = NPSR(x,y,lambda(j),l,NN);
    grid2=reshape(Grid2(:,:,:,end),NN*NN,3)';
    yhat=interpsurf(grid,grid2,x2);
    rho(j)=trace(yhat'*y2);
    save(filename,'grid','grid2','x','y','x2','y2','rho');
end



