function [ X,Y,t ] = magload( filename ,n)
%MAGLOAD converts magsat data into directional data as described in
dataframe= importfile(filename);
% keyboard
theta=-pi*(-(dataframe(:,2)')+90)/180;
phi=pi*((dataframe(:,3)')+180)/180;

index=randsample(length(theta),n);
t=dataframe(index,1)'/86400000;
% index=1:length(theta);
theta=theta(index);phi=phi(index);

[x,y,z]=s2c(theta,phi);X=[x;y;z];
N=length(x);
North=[cos(theta).*cos(phi);cos(theta).*sin(phi);-sin(theta)];
East=[sin(phi);-cos(phi);zeros(1,N)];
Vertical=-X;

Y=(ones(3,1)*(dataframe(index,5)')).*North+(ones(3,1)*dataframe(index,6)').*East+...
    (ones(3,1)*dataframe(index,7)').*Vertical;
Y=Y./(ones(3,1)*sqrt(sum(Y.^2)));

end

