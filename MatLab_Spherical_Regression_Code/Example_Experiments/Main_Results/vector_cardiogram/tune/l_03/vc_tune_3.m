% Design a tuning algorithm for the weather balloon data.
clear;close all;load Vector_Cardiogram_All_cv.mat;
[M,N]=size(X);load GRID_10_60;l=3;
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
    filename=['vector_cardiogram_all_cv_' num2str(lambda(j)) '_' num2str(NN) '_' num2str(l) '.mat'];
    [Grid2] = NPSR(x,y,lambda(j),l,NN);
    grid2=reshape(Grid2(:,:,:,end),NN*NN,3)';
    yhat=interpsurf(grid,grid2,x2);
    rho(j)=trace(yhat'*y2);
    save(filename,'grid','grid2','x','y','x2','y2','rho');
end




%%

%%
close all;clear all
filename='vector_cardiogram_all_cv_';
argX='500, ''y'',''fill'',''markeredgecolor'',''black'' ';
argY='500,''s'', ''r'',''fill'',''markeredgecolor'',''black'' ';
argV=' 0,''color'',[0.9 0 0],''linewidth'',1 ';
argVhat=' 0,''y'',''linewidth'',1 ';
% figtype='-depsc';figext='.eps';
figtype='-dpng';figext='.png';
%%
lambda=(linspace(0,.1,10).^2);

for j=1:10
filename2= [filename num2str(lambda(j)) '_60_' num2str(l) '.mat'];
load(filename2)
r(j)=rho(j)/length(x);
yhat(:,:,j)=interpsurf(grid,grid2,x2);Grid2(:,:,:,j)=reshape(grid2',60,60,3);
end
%%
figure
h=plot(lambda(1:end),2-2*r,'linewidth',2);
set(gca,'linewidth',2,'fontsize',22);
set(h,'LineWidth',2);
xlim([min(lambda),max(lambda)])
print(figtype,[  filename figext]);
%%
[~,j]=min(2-2*r)
lambda(j)
%%
MSE=2-2*r;
[~,j]=min(MSE)
lambda(j)
%%
