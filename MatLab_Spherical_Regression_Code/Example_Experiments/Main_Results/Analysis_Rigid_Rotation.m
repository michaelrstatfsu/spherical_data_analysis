% Fit Model
if ~exist('index','var')
    index=1
end
model='Rigid Rotation';
[A]=RRR(X,Y); % find optimal rigid rotation matrixs for data
%% Verify Matrix is in S)(d)
% This will warn the user if the determinant is not equal to 1
if (det(A)-1>10^(-10))
    display('WARNING: det(A)~=1')
end
%% Verify Matrix is in not singular
% This will warn the user if the transformation matrix is nearly singular
if (sum(eig(A)>10^(-10))~=3)
    display('WARNING: A may be singular!')
end
%% Verify Matrix is orthogonal
% This will warn the user if the transformation matrix is not orthogonal
if (sum(sum((A'*A-eye(M))>10^(-10))))
    display('WARNING: A is may not be orthogonal')
end
%% Predicted Values
Yhat=A*X; % Predicted values of Trianing Data
Yhat2=A*X2; % Predicted values of Testing Data
Mu= A*[X,X2]; % Predicted values of All Data
gam= A*gam_id; % Predicted values of $\gamma_id$
GAM=reshape(gam',NN,NN,3); % Deformed Mesh Grid
%% Make Diagnostic Plots
diagnostics_plots