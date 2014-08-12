%% Log Linear Regression
% This function perform a parametric log linear regression analysis for spherical data. 
%
% X and Y respectively denote dXn dimensional predictor and response matricies where the
% columns denote individual observations on the sphere.
% 
% Xnew is an optional dXm matrix. Again, each column denotes a point on the sphere.
% This should be used when one wishes to compute the predicted values Ynew given Xnew.
%
% Ahat is a (d-1)X(d-1) matrix for describing the linear relationship in the tangent space
%
% e is the objective function
%
% Yhat is the predicted value of Y given X
%
% Ynew is a dXm matrix whos columns denote the predicted values of Xnew. This is only
% computedwhich is only computed when the optional Xnew argument is present.
function [Ahat,e,Yhat,Ynew]=LLR(X,Y,Xnew)
% Exponential Ridge Regression
[M,N]=size(X);
mu=mean(Y,2);
mu=mu/norm(mu);
%% map to the tangent space at mu
x=INVEXP(X,mu);
y=INVEXP(Y,mu);
%% Construct Orthnormal Basis in the tangent space at mu
e=eye(M);
E=rotMat(e(:,M),mu)*e(:,1:(M-1));
%% Compute coeficients in the tangent space at mu
vx=E'*x;
vy=E'*y;
%% Perform Multi-Linear Regression in the tangent space at mu
Ahat= vy*vx'*inv(vx*vx'); % );%
vyhat=Ahat*vx;
%% Compute predicted values of training data
yhat=zeros(M,N);
for i=1:(M-1)
    yhat=yhat+E(:,i)*vyhat(i,:);
end
%% map back to the sphere using the exponetial map
Yhat=EXP(yhat,mu);
% for n=1:N
%     x=vyhat(:,n);
%     theta=norm(x);
%     Yhat(:,n)=cos(theta)*mu+...
%         sin(theta).*x/(theta);
% end


e=trace(Yhat'*Y);

%% Compute predicted values of testing data (if Xnew is given)
if exist('Xnew','var')
    [M,Nnew]=size(Xnew);
%      keyboard
     x=INVEXP(Xnew,mu);
     thetanew=acos(x'*mu);
     vxnew=E'*x;
     vyhatnew=Ahat*vxnew;
     yhat=zeros(M,Nnew);
     for i=1:(M-1)
         yhat=yhat+E(:,i)*vyhatnew(i,:);
     end
     Ynew=EXP(yhat,mu);
end
end
