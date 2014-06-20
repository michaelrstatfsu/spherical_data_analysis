function [theta,phi]=c2s(X,Y,Z)
%%
% phi=atan(Y./X);
% theta=acos(Z);
phi=real(atan(Y./X));
theta=real(acos(Z));
%% Correct the Branchcut

Xp=(X>0);
Xn=(X<0);
Xnn=(X>=0);
Xnp=(X<=0);
Yp=(Y>0);
Yn=(Y<0);
Ynn=(Y>=0);
Ynp=(Y<=0);


phi=phi+Xp.*Ynn*(-2)*(pi/2)+Xnn.*Yn*(2)*(pi/2)+pi;

phi(isnan(phi))=0;
%%
% data=[X(1:end);Y(1:end);Z(1:end)];
% pluspi=abs(sum(data-[sin(theta(1:end)).*cos(phi(1:end)+pi);sin(theta(1:end)).*sin(phi(1:end)+pi);cos(theta(1:end))]))<.00001;
% phi(1:end)=phi(1:end)+pi*pluspi+ 2*pi*(phi(1:end)<0).*(pluspi==0);
% %% Correct North Pole
% phi(isnan(phi))=pi;

end