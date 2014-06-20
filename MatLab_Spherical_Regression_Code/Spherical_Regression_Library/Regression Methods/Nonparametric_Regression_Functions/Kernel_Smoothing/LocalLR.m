function [ m] = local_linear( X,Y,Xnew,kappa)
if ~exist('kappa','var')
    kappa=40;
end

[M,N2]=size(Xnew);
[M,N]=size(X);

for n=1:N2
x=Xnew(:,n);
d=M;q=M;
K=exp(kappa*X'*x);W=diag(K/sum(K));
%Wtilde=kron(eye(q),W);
e1=[1, zeros(1,d)]';
Q2=[x,eye(d)-x*x']';
xi= INVEXP(X,x);
Xmat=[ones(N,1), xi'];
m(:,n)=[e1'*Q2*inv(Q2'*Xmat'*W*Xmat*Q2)*Q2'*Xmat'*W*Y']';
end
m=m./(ones(3,1)*sqrt(sum(m.^2)));


end

