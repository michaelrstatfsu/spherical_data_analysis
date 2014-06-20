clear; close all
filename= 'Vector_Cardiogram_All_cv';kappa=20;
% filename= 'cloud_083012_083112_allover_cv';kappa=6.4444;
% filename= 'midatlantic_cv';kappa=50;
% filename='weatherballoon';kappa=23;
% filename= 'right45_cv';kappa=10;
%% load data
load([filename '.mat'])
[M,N]=size(X);[M,N2]=size(X2);
%% Figure Arguments
argX='400, ''y'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
argY='400,''s'', ''r'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
argYhat='400, ''g'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
lw=2;
lw2=1;

figtype='-dpng';figext='.png';
%figtype='-depsc';figext='.eps';
%% Load Sphere Meshgrid
NN=60;% make a 60x60 meshgrid of a sphere
[GAM_id ] = mkgrid(0,NN);
gam_id=reshape(GAM_id,60*60,3)';
north=zeros(M,1);north(M)=1; % the north pole

%% Nonparametric Diffeomorphism L=30,l=3
index=1;
l=3;
file_diffeo=[filename '_' num2str(l) '_fitted_light.mat'];% Load a saved model
Analysis_Nonparametric_Diffeomorphism
names{index}=[model 'l=3'];
%% Nonparametric Diffeomorphism L=240,l=10
index=2;
l=10;
file_diffeo=[filename '_' num2str(l) '_fitted_light.mat'];% Load a saved model
Analysis_Nonparametric_Diffeomorphism
names{index}=[model 'l=10'];index=index+1;
%% Nonparametric Local Linear Regression
index=3;
Analysis_Nonparametric_Local_Linear
names{index}=model;index=index+1;
%% Perform Rigid Rotation Analysis
index=4;
Analysis_Projective_Linear_Transformation
names{index}=model;index=index+1;
%% Perform Projective Linear Transformation Analysis
index=5;
Analysis_Rigid_Rotation
names{index}=model;index=index+1;
%% Parametric Log-Linear Regression
index=6;
Analysis_Parametric_Log_Linear
names{index}=model;index=index+1;
%% Summary
close all
variables={'W' 'PValue' 'kappa' 'TrainingMSE' 'TestingMSE' 'Roughness'};
table(W',pvalue',kappahat',MSE_train',MSE_test',roughness','RowNames',names','VariableNames',variables)