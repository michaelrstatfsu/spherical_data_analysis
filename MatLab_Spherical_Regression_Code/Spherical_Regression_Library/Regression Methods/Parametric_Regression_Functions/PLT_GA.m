%% Projective Linear Transformation Estimation
% This function applies a gradient ascent algorithm based on derivations
% used in "Spherical Regression Models Using Projective Linear Transformations".
%
% X and Y respectively denote dXn dimensional predictor and response matricies where the
% columns denote individual observations on the sphere.
%
% Ahat is the estimated transformation matrix.
%
% e is the iterativly updated objective function
%
% Xtilde is the predicted value of Y given X
%
% path shows the iterative updates of Xtilde and can be plotted using the Display_Path.m function.
function [Ahat,e,Xtilde,path]= PLT_GA(X,Y)
path_index=1;
[M,N]=size(Y);
% Initialize using rigid rotation
[U1 , trash, U2]=svd(Y*X');
Ahat=U1*U2';
% Initialize using Identity
% Ahat(:,:)=eye(M); 
Xtilde=Ahat(:,:,1)*X;
path(:,(N*(path_index-1)+1):(N*(path_index)))=Xtilde;
path_index=path_index+1;
%% Initailize Iteration
i=1;
maxitr=2000; % Maximum number of iterations
e(1:maxitr)=trace(Y'*Xtilde);
minitr=10; % Minimum number of iterations
epsilon=10^(-2);% Step size
GO=1;
CloseEnough=10^-4; % Stopping parameter
while (i<=maxitr)&&(GO==1)||(i<minitr)
    %% Iteration
    i=i+1;
    % Gradient at Ahat
    B= (Y*Xtilde'- Xtilde.*(ones(M,1)*sum(Xtilde.*Y,1))*Xtilde' )/(Ahat');   
    Ahat=Ahat+epsilon*B;
    Xtilde=Ahat*X;    
    Xtilde=Xtilde./(ones(M,1)*sqrt(sum(Xtilde.^2,1)));
path(:,(N*(path_index-1)+1):(N*(path_index)))=Xtilde;
path_index=path_index+1;
e(i)=trace(Y'*Xtilde);
GO= (abs(e(i)-e(i-1))>CloseEnough)*(e(i)>e(i-1));

end
e=e(1:(i-1));
%% Return
Ahat=Ahat(:,:,end)/norm(Ahat(:,:,end));
end
