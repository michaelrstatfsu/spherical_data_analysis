function [L,l]=vMFL(Y,mui,kappa)
%%
if ~exist('kappa','var')
    kappa= kappa_tilde(mui,Y);
end
[d,N]=size(Y);
[d2,N2]=size(mui);
if N2~= N
   mui= mui*ones(N2,N);
end

I=besseli(d/2-1,kappa,1);
C=max((kappa^(d/2-1))/(2*pi^(d/2)*I),10^(-1000));
%L=C*exp(kappa*trace(Y'*mui)-kappa);
% keyboard
l=log(C) +kappa*trace(Y'*mui)-kappa;
L=exp(l);
% L=exp(l);
% I=besseli(d/2-1,kappa);
% C=max((kappa^(d/2-1))/(2*pi^(d/2)*I),10^(-1000));
% L=C*exp(kappa*trace(Y'*mui));
% keyboard
% if  isinf(L)&(C==0)
%     L=inf
% else
%     l=N*log(C) +kappa*trace(Y'*mui);
%     L=exp(l);
% end

% l=kappa*trace(Y'*(mui))+ ((d/2-1)*log(kappa)-log(I))*N- (d/2)*log(2*pi)
end