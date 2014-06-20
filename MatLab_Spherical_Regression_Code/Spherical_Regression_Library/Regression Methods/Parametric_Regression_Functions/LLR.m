function [Ahat,e,Yhat,Ynew]=LLR(X,Y,Xnew)
% Exponential Ridge Regression
[M,N]=size(X);
mu=mean(Y,2);
mu=mu/norm(mu);
%% map to the vectorspace
x=INVEXP(X,mu);
y=INVEXP(Y,mu);
%% Construct Orthnormal Basis
e=eye(M);
E=rotMat(e(:,M),mu)*e(:,1:(M-1));
%%
vx=E'*x;
vy=E'*y;
%%
Ahat= vy*vx'*inv(vx*vx'); % );%
vyhat=Ahat*vx;
yhat=zeros(M,N);
for i=1:(M-1)
    yhat=yhat+E(:,i)*vyhat(i,:);
end
%% map to the sphere
Yhat=EXP(yhat,mu);
% for n=1:N
%     x=vyhat(:,n);
%     theta=norm(x);
%     Yhat(:,n)=cos(theta)*mu+...
%         sin(theta).*x/(theta);
% end

%% Make sure on the sphere
%     Yhat=Yhat./(ones(M,1)*sqrt(sum(Yhat.^2)));

e=trace(Yhat'*Y);
    
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
    %% Make sure on the sphere
%     Ynew=Ynew./(ones(M,1)*sqrt(sum(Ynew.^2)));
end
end