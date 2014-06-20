% Fit Model
if ~exist('index','var')
    index=1
end
model='Nonparametric Local Linear';
%% User must Specify kappa
if ~exist('kappa','var')
    display('User must Specify kappa for Nonparametric Local Linear model!')
end
%% Predicted Values
Yhat= LocalLR(X,Y,X,kappa); % Predicted values of Trianing Data
Yhat2= LocalLR( X,Y,X2,kappa);; % Predicted values of Testing Data
Mu= LocalLR( X,Y,[X, X2],kappa);; % Predicted values of All Data
gam= LocalLR( X,Y,gam_id,kappa);; % Predicted values of $\gamma_id$
GAM=reshape(gam',NN,NN,3); % Deformed Mesh Grid
%% Make Diagnostic Plots
diagnostics_plots