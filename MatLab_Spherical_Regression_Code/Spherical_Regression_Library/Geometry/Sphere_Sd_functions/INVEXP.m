%% Inverse Exponential Mapping from $S^(d-1)\in R^d$ to $T_p(S^(d-1))$
function [u] = INVEXP(X,p)
[M,N]=size(X);
%% map to the vectorspace
u=zeros(size(X));
Index=1:N;
[M,Np]=size(p);
if Np==1
    p=p*ones(1,N);
end
% keyboard
for n=Index(sum((X-p).^2)>10^(-20))
    x=X(:,n);
    theta(n)=acos(x'*p(:,n));
        u(:,n)= (theta(n)/sin(theta(n)))*(X(:,n)-cos(theta(n))*p(:,n));
end
end

