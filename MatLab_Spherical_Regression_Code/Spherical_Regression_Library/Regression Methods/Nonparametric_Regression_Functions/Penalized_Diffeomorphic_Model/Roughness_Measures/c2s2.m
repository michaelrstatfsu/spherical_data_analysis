function [theta,phi]=c2s2(X,Y,Z)
%%
% phi=atan(Y./X);
% theta=acos(Z);
phi=real(atan(Y./X));
theta=real(acos(Z));


end