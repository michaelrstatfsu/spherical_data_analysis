close all
lambda=0;delta=10^(-3);% step size
load GRID_10_60.mat;l=10
%%
filename= 'cloud_083012_083112_allover_cv'
diffeo3='cloud_083012_083112_allover_cv_3_fitted_light'
diffeo10='cloud_083012_083112_allover_cv_0.62027_10_60_0.0044_light'
kappa=6.4444;
%% load data
load([filename '.mat'])
[M,N]=size(X);[M,N2]=size(X2);
argX='400, ''y'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
argY='400,''s'', ''r'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
argYhat='400, ''g'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
lw=2;
lw2=1;
if ~exist('figtype','var')
    %     figtype='-depsc';figext='.eps';
    figtype='-dpng';figext='.png';
end
%%
% x=X;y=Y; % training data
% x=X2;y=Y2; % testing data
x=[X,X2];y=[Y,Y2]; % all data
%%
[A_RRR,e_RRR]=RRR(X,Y);
MU=A_RRR*x;
[Z] = center(MU,y);

close all
sphere;colormap(.7*gray);hold on
PLOT(Z)
view([0,0,1]')
print('-dpng',[filename '_RR_res' figext])

ins=1;[T(ins),p_value(ins)]=vMF_gof(Z); kappahat(ins)=kappa_tilde(Z);
print('-dpng',[filename '_RR_chi' figext])

%%
[A_PLT,e_PLT]=PLT_NR(X,Y);
MU= A_PLT*x;MU=MU./(ones(3,1)*sqrt(sum(MU.^2)));
[Z] = center(MU,y);

close all
sphere;colormap(.7*gray);hold on
PLOT(Z)
view([0,0,1]')
print('-dpng',[filename '_PLT_res' figext])

ins=ins+1;[T(ins),p_value(ins)]=vMF_gof(Z); kappahat(ins)=kappa_tilde(Z);
print('-dpng',[filename '_PLT_chi' figext])
%%
[~,~,~,MU]=LLR(X,Y,x);
[Z] = center(MU,y);

close all
sphere;colormap(.7*gray);hold on
PLOT(Z)
view([0,0,1]')
print('-dpng',[filename '_LLR_res' figext])

ins=ins+1;[T(ins),p_value(ins)]=vMF_gof(Z); kappahat(ins)=kappa_tilde(Z);
print('-dpng',[filename '_LLR_chi' figext])

%%

[ MU] = LocalLR(X,Y,x,kappa);
[Z] = center(MU,y);
close all
sphere;colormap(.7*gray);hold on
PLOT(Z)
view([0,0,1]')
print('-dpng',[filename '_NLL_res' figext])

ins=ins+1;[T(ins),p_value(ins)]=vMF_gof(Z); kappahat(ins)=kappa_tilde(Z);
print('-dpng',[filename '_NLL_chi' figext])


%%
load([diffeo3, '.mat'])

MU=interpsurf(grid,grid2,x);
[Z] = center(MU,y);

close all
sphere;colormap(.7*gray);hold on
PLOT(Z)
view([0,0,1]')
print('-dpng',[filename '_ours_3_res' figext])

ins=ins+1;[T(ins),p_value(ins)]=vMF_gof(Z); kappahat(ins)=kappa_tilde(Z);
print('-dpng',[filename '_ours_3_chi' figext])

%%
load([diffeo10, '.mat'])

MU=interpsurf(grid,grid2,x);
[Z] = center(MU,y);

close all
sphere;colormap(.7*gray);hold on
PLOT(Z)
view([0,0,1]')
print('-dpng',[filename '_ours_10_res' figext])

ins=ins+1;[T(ins),p_value(ins)]=vMF_gof(Z); kappahat(ins)=kappa_tilde(Z);
print('-dpng',[filename '_ours_10_chi' figext])

%%
T
p_value
kappahat
