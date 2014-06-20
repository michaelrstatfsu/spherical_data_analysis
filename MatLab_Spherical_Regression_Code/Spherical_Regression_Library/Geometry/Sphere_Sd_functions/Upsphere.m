function [ Z ] = Upsphere(Z)
% maps an PxN matrix into the sphere embedded in the next higher dimension
% (P+1)xN
[P,N]=size(Z);
%keyboard
Z(P+1,:)=1;
Z=Z./(ones(P+1,1)*sqrt(sum(Z.^2)));


end

