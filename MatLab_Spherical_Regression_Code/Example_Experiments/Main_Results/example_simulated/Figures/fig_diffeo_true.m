%% Set plotting parameters
close all;
argX='500, ''y'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
argYhat='500, ''g'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
argY='500,''s'', ''r'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
% argV=' 0,''color'',[0.9 0 0],''linewidth'',1 ';
% argVhat=' 0,''y'',''linewidth'',1 ';
if ~exist('figtype','var')
    figtype='-depsc';figext='.eps';
end
filename='fig_diffeo_true';
lw=2;
lw2=1.5;
ZOOM=2.5;
Rad=.97;
%% load data
load rand_diffeo_EX_02
x=X;y=Y
center=[1,1,1];
%% Load true diffeomorphic map and downsample
load diffeo01.mat
l=10;NN=60
grid=reshape(Grid,300*300,3)';grid2=reshape(Grid2,300*300,3)';
yhat=interpsurf(grid,grid2,x);
[ Grid2,Grid ] = lower_res( grid,grid2,NN);
Grid2=Rad*Grid2;
grid=Rad*reshape(Grid,NN*NN,3)';grid2=Rad*reshape(Grid2,NN*NN,3)';

close all;
surf(Grid2(:,:,1)',Grid2(:,:,2)',Grid2(:,:,3)','edgecolor','black','linewidth',lw);
colormap(.7*gray)
zoom(ZOOM);
print(figtype, [filename figext])


close all
surf(Grid2(:,:,1)',Grid2(:,:,2)',Grid2(:,:,3)','edgecolor','black','linewidth',lw);
colormap(.7*gray)
hold on
PLOT(yhat,argYhat)
PLOT(y,argY)
zoom(ZOOM);
set(gca,'FontSize',20,'LineWidth',2,'XTick',[0])
print(figtype, [filename '_withpoints' figext])
