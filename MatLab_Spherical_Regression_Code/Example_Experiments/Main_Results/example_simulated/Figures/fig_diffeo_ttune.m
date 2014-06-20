close all;%clear all
argX='500, ''y'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
argYhat='500, ''g'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
argY='500,''s'', ''r'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
% argV=' 0,''color'',[0.9 0 0],''linewidth'',1 ';
% argVhat=' 0,''y'',''linewidth'',1 ';
if ~exist('figtype','var')
    figtype='-depsc';figext='.eps';
end
filename='fig_diffeo_true';
linethick=2.5
ZOOM=2.5;
Rad=.97;
%%
lambda=(linspace(0,.1,10).^2);
clear r
for j=1:10
    filename= ['rand_diffeo_EX_02_cv_' num2str(lambda(j)) '_60_5.mat']
    IND(j)=exist(filename, 'file')~=0;
    if IND(j)
        load(filename)
        r(j)=rho(j)/length(x);        
    end
end
%%
% Grid=reshape(grid',60,60,3);
Grid=lower_res(grid,grid,30);
%%
figure
MSE=2-2*r(IND)
h=plot(lambda(IND),MSE,'linewidth',2);
set(gca,'linewidth',2,'fontsize',23);
set(h,'LineWidth',2);
xlim([min(lambda(IND)),max(lambda(IND))])
ylim([min(MSE),max(MSE)])
print(figtype,[  'rand_diffeo_EX_02_cv_MSE' figext]);
%% load data
load rand_diffeo_EX_02_cv_new.mat x y x2 y2
lw=2;
lw2=1.5;
%%
close all
surf(Rad*Grid(:,:,1)',Rad*Grid(:,:,2)',Rad*Grid(:,:,3)','edgecolor','black','linewidth',lw);
colormap(.7*gray)
hold on
PLOT(x,argX);PLOT(y,argY)
zoom(ZOOM);
print(figtype,[  'rand_diffeo_EX_02_cv_train' figext]);
%%
close all
surf(Rad*Grid(:,:,1)',Rad*Grid(:,:,2)',Rad*Grid(:,:,3)','edgecolor','black','linewidth',lw);
colormap(.7*gray)
hold on
PLOT(x2,argX);PLOT(y2,argY)
zoom(ZOOM);
print(figtype,[  'rand_diffeo_EX_02_cv_test' figext]);

%% Load true diffeomorphic map and downsample
load diffeo01.mat
l=10;NN=30
grid=reshape(Grid,300*300,3)';grid2=reshape(Grid2,300*300,3)';
[ Grid2,Grid ] = lower_res( grid,grid2,NN);
grid=reshape(Grid,NN*NN,3)';grid2=reshape(Grid2,NN*NN,3)';
yhat=interpsurf(grid,grid2,x2);

close all;
surf(Rad*Grid2(:,:,1)',Rad*Grid2(:,:,2)',Rad*Grid2(:,:,3)','edgecolor','black','linewidth',lw);
colormap(.7*gray)
zoom(ZOOM);


hold on
PLOT(1.03*yhat,argYhat)
PLOT(1.03*y2,argY)
set(gca,'FontSize',20,'LineWidth',2,'XTick',[0])
% view([1,1,1])

print(figtype,[  'rand_diffeo_EX_02_cv_True' figext]);
%%
load rand_diffeo_EX_02_cv_0_60_5.mat
X=x;Y=y;X2=x2;Y2=y2;
% Grid2=reshape(grid2',60,60,3);
[ Grid2,Grid ] = lower_res( grid,grid2,NN);
yhat=interpsurf(grid,grid2,x2);
figure
surf(Rad*Grid2(:,:,1)',Rad*Grid2(:,:,2)',Rad*Grid2(:,:,3)','edgecolor','black','linewidth',lw);
colormap(.7*gray)
hold on
PLOT(1.03*yhat,argYhat);
PLOT(1.03*y2,argY);
zoom(ZOOM);
% view([1,1,1])
print(figtype,[  'rand_diffeo_EX_02_cv_rough' figext]);
%%
load rand_diffeo_EX_02_cv_0.0011111_60_5.mat
% Grid2=reshape(grid2',60,60,3);
[ Grid2,Grid ] = lower_res( grid,grid2,NN);
X=x;Y=y;X2=x2;Y2=y2;
yhat=interpsurf(grid,grid2,x2);
figure
surf(Rad*Grid2(:,:,1)',Rad*Grid2(:,:,2)',Rad*Grid2(:,:,3)','edgecolor','black','linewidth',lw);
colormap(.7*gray)
hold on
PLOT(1.03*yhat,argYhat);
PLOT(1.03*y2,argY);
zoom(ZOOM);
print(figtype,[  'rand_diffeo_EX_02_cv_med' figext]);
%%
load rand_diffeo_EX_02_cv_0.01_60_5.mat
% Grid2=reshape(grid2',60,60,3);
[ Grid2,Grid ] = lower_res( grid,grid2,NN);
X=x;Y=y;X2=x2;Y2=y2;
yhat=interpsurf(grid,grid2,x2);
figure
surf(Rad*Grid2(:,:,1)',Rad*Grid2(:,:,2)',Rad*Grid2(:,:,3)','edgecolor','black','linewidth',lw);
colormap(.7*gray)
hold on
PLOT(1.03*yhat,argYhat);
PLOT(1.03*y2,argY);
zoom(ZOOM);

print(figtype,['rand_diffeo_EX_02_cv_smooth' figext]);

%%
close all;
load rand_diffeo_EX_02_path_light

Display_Path(X,Y,path,0)
zoom(ZOOM);
print(figtype,[  'rand_diffeo_EX_02_cv_PATH' figext]);
%%
close all;
plot(E)

h=plot(E,'linewidth',2);
set(gca,'linewidth',2,'fontsize',23);
set(h,'LineWidth',2);
ylim([min(E),max(E)])
print(figtype,[  'rand_diffeo_EX_02_cv_E' figext]);