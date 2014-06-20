%% Set plotting parameters
close all;clear all
argX='200, ''y'',''fill'',''markeredgecolor'',''black'' ';
argY='200,''s'', ''r'',''fill'',''markeredgecolor'',''black'' ';
argV=' 0,''color'',[0.9 0 0],''linewidth'',1 ';
argVhat=' 0,''y'',''linewidth'',1 ';
linewidth=1.2;
ZOOM=1.5;
if ~exist('figtype','var')
    figtype='-depsc';figext='.eps';
end
filename='fig_diffeo_lambda_00012346';
%% Data points on the sphere
load rand_diffeo_EX_02_cv_0_60_3.mat
center=[1,1,1];
Grid2=reshape(grid2',60,60,3);
yhat=interpsurf(grid,grid2,x);
%%
close all
MESH(Grid2,'',linewidth)
hold on
PLOT(yhat,argX)
PLOT(y,argY)
view(center)
zoom(ZOOM)
set(gca,'FontSize',20,'LineWidth',2,'XTick',[0])
print(figtype, [filename figext])