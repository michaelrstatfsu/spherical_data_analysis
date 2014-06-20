% Fit Model
if ~exist('index','var')
    index=1
end
model='Parametric Log-Linear Analysis';
[A]=LLR(X,Y);%% Fit data
%% Verify Matrix is in not singular
% This will warn the user if the transformation matrix is nearly singular
if (sum(eig(A)>10^(-10))~=M-1)
    display('WARNING: A may be singular!')
end
%% Predicted Values
[~,~,~,Xtilde]=LLR(X,Y,X2);% Predicted values of Test Data
[~,~,~,gam]=LLR(X,Y,gam_id);% Deformed Mesh Grid in long form
GAM=reshape(gam',NN,NN,3); % Deformed Mesh Grid
[~,~,~,MU]=LLR(X,Y,[X,X2]);% Compute  Predicted Values of full data
%% Make Diagnostic Plots
diagnostics_plots