function [ Z ] = Downsphere( Z )
%DOWNSPHERE takes arbitrary (P)xN matrix of points on the sphere and maps
%them to the next lower vectorspace.

[P,N]=size(Z);
%keyboard
%Z./(ones(P,1)*sqrt(sum(Z(1:(P-1),:).^2)));
Z=Z(1:(P-1),:)./(ones(P-1,1)*Z(P,:));


end

