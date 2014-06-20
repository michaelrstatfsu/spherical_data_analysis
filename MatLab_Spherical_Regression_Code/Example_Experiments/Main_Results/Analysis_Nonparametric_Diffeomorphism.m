% Fit Model
if ~exist('index','var')
    index=1
end
model='Nonparametric Diffeomorphism';
%% Load Model
load(file_diffeo)
%% Predicted Values
Yhat= interpsurf(grid,grid2,[X]); % Predicted values of Trianing Data
Yhat2= interpsurf(grid,grid2,[X2]); % Predicted values of Testing Data
Mu= interpsurf(grid,grid2,[X, X2]);; % Predicted values of All Data
gam= interpsurf(grid,grid2,gam_id);; % Predicted values of $\gamma_id$
GAM=reshape(gam',NN,NN,3); % Deformed Mesh Grid
%% Make Diagnostic Plots
diagnostics_plots