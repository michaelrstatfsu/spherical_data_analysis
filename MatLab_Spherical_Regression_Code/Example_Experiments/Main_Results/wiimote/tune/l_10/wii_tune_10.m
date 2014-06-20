% Design a tuning algorithm for the weather balloon data.
clear;close all;
% filename='counterclockwise_cv';
filename='right45_cv'
load(filename)
[M,N]=size(X);
NN=60; NNNN=NN*NN;
Grid=mkgrid(0,NN);grid=reshape(Grid,NNNN,3)';
l=10;
%% K-fold Modified to only do one
IND=randsample(1:N,N);
k=floor(.75*N);
x=X(:,IND(1:k));y=Y(:,IND(1:k));
x2=X(:,IND(k:end));y2=Y(:,IND(k:end));
save data_cv
%%
clear;load data_cv
lambda=(linspace(0,.1,10)).^2
for j=1:10
    filename2=[filename '_' num2str(lambda(j)) '_' num2str(NN) '_' num2str(l) '.mat'];
    [Grid2] = NPSR(x,y,lambda(j),l,NN);
    grid2=reshape(Grid2(:,:,:,end),NN*NN,3)';
    yhat=interpsurf(grid,grid2,x2);
    rho(j)=trace(yhat'*y2);
    save(filename2,'grid','grid2','x','y','x2','y2','rho');
end

%%
clear;
l=10;NN=60;
filename='right45_cv';
% figtype='-depsc';figext='.eps';
figtype='-dpng';figext='.png';
%%
lambda=(linspace(0,.1,10).^2);
for j=1:8
filename2= [filename '_' num2str(lambda(j)) '_' num2str(NN) '_' num2str(l) '.mat'];
load(filename2)
r(j)=rho(j)/length(x);
yhat(:,:,j)=interpsurf(grid,grid2,x2);Grid2(:,:,:,j)=reshape(grid2',NN,NN,3);
end
%%
figure
h=plot(lambda(1:length(r)),2-2*r,'linewidth',2);
set(gca,'linewidth',2,'fontsize',22);
set(h,'LineWidth',2);
xlim([min(lambda),max(lambda)])
print(figtype,[  filename '_tuning_MSE' '_' num2str(NN) '_' num2str(l) figext]);
%%
[~,j]=max(r);num2str(lambda(j))