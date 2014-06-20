clear;close all
lambda=0;delta=10^(-3);% step size
load GRID_3_60.mat;l=5
clear B b btan
%% Load Data
filename= 'rand_diffeo_EX_02'
figtype='-depsc';figext='.eps';
% figtype='-dpng';figext='.png';
name1='clouds_8_30_12.jpg';
name2='clouds_8_31_12.jpg';
[cloudx]=imread([name1]);
[cloudy]=imread([name2]);
load([filename '.mat'])
[M,N]=size(X);
argX='200, ''y'',''fill'',''markeredgecolor'',''black'' ';
argY='200,''s'', ''r'',''fill'',''markeredgecolor'',''black'' ';

%% Split Data into training and testing
IND=randsample(1:N,N);
K=floor(.9*N)
ind=randsample(IND,K);
x=X(:,ind);y=Y(:,ind);
indtest=setdiff(IND,ind);
x2=X(:,indtest);y2=Y(:,indtest);
% save data_cv % don't save over data used in the paper.
save rand_diffeo_EX_02_cv_new
%% Tune lambda Parameter
% clear;load data_cv_new % to repeat experiment with ne data 
clear;load rand_diffeo_EX_02_cv_new
lambda=(linspace(0,.1,10)).^2
for j=1:10
    filename2=[filename '_cv_' num2str(lambda(j)) '_' num2str(NN) '_' num2str(l) '.mat'];
    [Grid2] = NPSR(x,y,lambda(j),l,NN);
    grid2=reshape(Grid2(:,:,:,end),NN*NN,3)';
    yhat=interpsurf(grid,grid2,x2);
    rho(j)=trace(yhat'*y2);
    save(filename2,'grid','grid2','x','y','x2','y2','rho');
end
%%
close all;clear all
argX='500, ''y'',''fill'',''markeredgecolor'',''black'' ';
argY='500,''s'', ''r'',''fill'',''markeredgecolor'',''black'' ';
argV=' 0,''color'',[0.9 0 0],''linewidth'',1 ';
argVhat=' 0,''y'',''linewidth'',1 ';
figtype='-depsc';figext='.eps';
% figtype='-dpng';figext='.png';
%%
lambda=(linspace(0,.1,10).^2);

for j=1:10

filename= ['rand_diffeo_EX_02_cv_' num2str(lambda(j)) '_60_5.mat']
load(filename)
r(j)=rho(j)/length(x);
yhat(:,:,j)=interpsurf(grid,grid2,x2);Grid2(:,:,:,j)=reshape(grid2',60,60,3);
end
%%
figure
h=plot(lambda(1:end),2-2*r,'linewidth',2);
set(gca,'linewidth',2,'fontsize',22);
set(h,'LineWidth',2);
xlim([min(lambda),max(lambda)])
print(figtype,[  'rand_diffeo_EX_02_cv_MSE' figext]);
%%
% lambda=0.00049383
[~,j]=min(2-2*r)
num2str(lambda(j))
%%
load rand_diffeo_EX_02_cv_0.00049383_60_5.mat
X=x;Y=y;X2=x2;Y2=y2;
Yhat=interpsurf(grid,grid2,X)
[ GAM,Grid] = lower_res( grid,grid2,60 );
close all;
h=mesh(GAM(:,:,1)',GAM(:,:,2)',GAM(:,:,3)','FaceColor', 'white','edgecolor','black');
hold on
set(h,'LineWidth',1);
PLOT(1.02*Yhat,argX);PLOT(1.02*Y,argY);
%%
load rand_diffeo_EX_02_cv_0_60_5.mat
load rand_diffeo_EX_02_cv_new.mat
X=x;Y=y;X2=x2;Y2=y2;
Yhat=interpsurf(grid,grid2,X)
[ GAM,Grid] = lower_res( grid,grid2,60 );
close all;
h=mesh(GAM(:,:,1)',GAM(:,:,2)',GAM(:,:,3)','FaceColor', 'white','edgecolor','black');
hold on
set(h,'LineWidth',1);
PLOT(1.02*Yhat,argX);PLOT(1.02*Y,argY);
%%

