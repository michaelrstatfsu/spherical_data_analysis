function [df_dphi,df_dtheta] = Df_S2_R(Grid,f)
[NN,NN,M]=size(f);
[NN0,NN0,M0]=size(Grid);
n=NN0-1;
% theta = pi*[.01:n+1-.01]/(n+.02);
% phi = 2*pi*[0:n]/n;

theta = pi*[.01:n+1-.01]/(n+.02);
phi = 2*pi*[0:n]/n;
Theta = repmat(theta,n+1,1);
Phi = repmat(phi',1,n+1);

% eps=pi/10^(10);
% theta =linspace(eps,pi-eps,NN);
% phi =linspace(0,2*pi,NN);

Theta = repmat(theta,n+1,1);
Phi = repmat(phi',1,n+1);

dphi=mean(diff(phi));
dtheta=mean(diff(theta));
% keyboard


[df_dtheta,df_dphi] = gradient(f,dtheta,dphi);
% df_dphi= df_dphi./sin(Theta);
% 
% [NN,NN,M]=size(f);
% [NN0,NN0,M0]=size(Grid);
% n=NN0-1;
% theta = pi*[.01:n+1-.01]/(n+.02);
% % phi = 2*pi*[0:n]/n;
% 
% for m=1:M
%     for x=1:(NN-1)
%         for y=1:(NN-1)
%             z0=squeeze(Grid(x,y,:));
%             zx=squeeze(Grid(x+1,y,:));
%             zy=squeeze(Grid(x,y+1,:));
%             dx=sin(theta(y))*2*pi/(NN0);%acos(zx'*z0);% 
%             dy=pi/NN0;%acos(zy'*z0);%
%             
%             f0=f(x,y,m);fx=f(x+1,y,m);fy=f(x,y+1,m);
%             Df_dx(x,y,m)=(fx-f0)/dx;
%             Df_dy(x,y,m)=(fy-f0)/(dy);
%             
%             %         u=[cos(Theta(x,y)).*cos(Phi(x,y)),cos(Theta(x,y)).*sin(Phi(x,y)),-sin(Theta(x,y))]';
%             %         v=[-sin(Theta(x,y)).*sin(Phi(x,y)),sin(Theta(x,y)).*cos(Phi(x,y)),0]';
%             %         Grad_f(x,y,:)=Df_dx(x,y)*u+Df_dy(x,y)*v;
%         end
%     end
% end
% %%
% Df_dx(NN,:,:)=Df_dx(NN-1,:,:);
% Df_dy(NN,:,:)=Df_dy(NN-1,:,:);
% Df_dx(:,NN,:)=Df_dx(:,1,:);
% Df_dy(:,NN,:)=Df_dy(:,1,:);

end

