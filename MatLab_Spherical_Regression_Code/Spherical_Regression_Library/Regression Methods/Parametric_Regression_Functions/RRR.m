%% Rigid Rotation and Reflection
% This function applies a Newton-Raphson algorithm based on derivations
% used in "Spherical Regression Models Using Projective Linear Transformations".
%
% X and Y respectively denote dXn dimensional predictor and response matricies where the
% columns denote individual observations on the sphere.
%
% noreflect is a logical which indicates whether we should prevent
% procrustes reflections. By default it is set to 1 which means that only
% rotations are allowed.
%
% Ahat is the estimated rotation/reflection matrix.
%
% e is the objective function
%
% Yhat is the predicted value of Y given X
function [Ahat,e,Yhat]=RRR(X,Y,noreflect)
if ~exist('reflect','var')
    noreflect=1; %1 implies we do allow procrustes reflection
end
[U1 , trash, U2]=svd(Y*X');
Ahat=U1*U2';
if (det(Ahat)<0)*noreflect
    [M,N]=size(X);
    I=eye(M);I(end)=-1;
    Ahat=U1*I*U2';
end
Yhat=Ahat(:,:,1)*X;
e=trace(Y'*Yhat);
end

