function [ R0 ] = R_0(Grid, Grid2)
% measures the first order roughness of a diffeomorphism on the sphere.
% [Theta,Phi]=c2s2(Grid(:,:,1),Grid(:,:,2),Grid(:,:,3));
% [Theta2,Phi2]=c2s2(Grid2(:,:,1),Grid2(:,:,2),Grid2(:,:,3));
[NN,NN,M]=size(Grid2);NNNN=NN*NN;
n=NN-1;
theta = pi*[.01:n+1-.01]/(n+.02);
phi = 2*pi*[0:n]/n;
CURVE=sum((Grid-Grid2).^2,3);
R0=sqrt(trapz(phi(2:(end-1)),trapz(theta(2:(end-1)),CURVE(2:(end-1),(2:(end-1))),2),1));
end