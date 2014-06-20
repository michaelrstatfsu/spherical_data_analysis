
function [ e ] = Basis_T_SL(A)
if ~exist('A','var')
    A=eye(3);
end
[d,t]=size(A);clear t
%%  Construct orthonormal basis for $T_I(SL(d))$
n=1;
E= zeros(d,d,d^2-1);
for i=1:d
    for j = setdiff((1:d),i)
        E(i,j,n)= 1;
        n=n+1;
    end
    if n<=(d^2-1)
        E(i,i,n)= 1;
        E(d,d,n)= -1;
        n=n+1;
    end
end
clear i j n1
%% Construct Basis for $T_A(SL(d))$
EA=zeros(d,d,d^2-1);
for j=1:(d^2-1)
    EA(:,:,j)=A*E(:,:,j);
end
clear j
%% Orthonomralize using Gram Schmidt
u=EA;
v(:,:,1)=u(:,:,1);
e(:,:,1)=v(:,:,1)/sqrt(trace(v(:,:,1)*v(:,:,1)'));
for i=2:(d^2-1);
    v(:,:,i)=u(:,:,i);
    for j=1:(i-1)
        v(:,:,i)=v(:,:,i)- v(:,:,j)*trace(u(:,:,i)*v(:,:,j)')/trace(v(:,:,j)*v(:,:,j)');
    end
    e(:,:,i)=v(:,:,i)/sqrt(trace(v(:,:,i)*v(:,:,i)'));
end


end

