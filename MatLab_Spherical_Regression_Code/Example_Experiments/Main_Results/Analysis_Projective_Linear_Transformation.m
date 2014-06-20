% Fit Model
if ~exist('index','var')
    index=1
end
model='Projective Linear Transformation';
[A]=RRR(X,Y); % find optimal rigid rotation matrixs for data
%% Verify Matrix is in S)(d)
% This will warn the user if the determinant is not equal to 1
if (det(A)-1>10^(-10))
    display('WARNING: det(A)~=1')
end
%% Verify Matrix is in not singular
% This will warn the user if the transformation matrix is nearly singular
if (sum(eig(A)>10^(-10))~=3)
    display('WARNING: A may b1e singular!')
end
%% Predicted Values
Yhat=A*X;Yhat=Yhat./(ones(3,1)*sqrt(sum(Yhat.^2))); % Predicted values of Training Data
Yhat2=A*X2;Yhat2=Yhat2./(ones(3,1)*sqrt(sum(Yhat2.^2))); % Predicted values of Testing Data
gam= A*gam_id;gam=gam./(ones(3,1)*sqrt(sum(gam.^2))); % Predicted values of $\gamma_id$
GAM=reshape(gam',NN,NN,3); % Deformed Mesh Grid
%% Make Diagnostic Plots
diagnostics_plots