function [ R1 ] = R_1(Grid, Grid2)
% measures the first order roughness of a diffeomorphism on the sphere.
[Theta,Phi]=c2s2(Grid(:,:,1),Grid(:,:,2),Grid(:,:,3));
[Theta2,Phi2]=c2s2(Grid2(:,:,1),Grid2(:,:,2),Grid2(:,:,3));
[NN,NN,M]=size(Grid2);NNNN=NN*NN;
n=NN-1;
theta = pi*[.01:n+1-.01]/(n+.02);
phi = 2*pi*[0:n]/n;
%%

%% Take the derivatives of the Theta2
[dTheta2_dphi,dTheta2_dtheta] = Df_S2_R(Grid,Theta2);
%% Smooth Phi2 in direction theta
% theta=acos(Grid2(:,:,3));
Phi3=Phi2;%atan(Grid2(:,:,2)./Grid2(:,:,1));
for i=1:NN
    for j=1:NN
        n1=max(j-1,1);
        n2=min(j+1,NN);
        if abs(Phi3(i,j)-Phi3(i,n1))>=pi/4
            diff=Phi3(i,j)-Phi3(i,n1);
            Phi3(i,j)=Phi3(i,j)-round(diff/pi)*pi;
        end
        
    end
end
%%
[~,dPhi2_dtheta] = Df_S2_R(Grid,Phi3);
%% Smooth Phi2 in direction phi
% theta=acos(Grid2(:,:,3));
Phi4=Phi2;
for i=1:NN
    for j=1:NN
        n1=max(i-1,1);
        n2=min(i+1,NN);
        if abs(Phi4(i,j)-Phi4(n1,j))>=pi/10
                diff=Phi4(i,j)-Phi4(n1,j);
            Phi4(i,j)=Phi4(i,j)-round(diff/pi)*pi;
        end        
    end
%     close all;mesh(Phi4);pause(.1)
end
%%
[dPhi2_dphi] = Df_S2_R(Grid,Phi4);
% %%
% figure
% subplot(2,2,1)
% mesh(dTheta2_dtheta)
% subplot(2,2,2)
% mesh(dTheta2_dphi)
% subplot(2,2,3)
% mesh(dPhi2_dtheta)
% subplot(2,2,4)
% mesh(dPhi2_dphi)

%%
% i=randsample(NN,1);j=randsample(NN,1);
% C=[dTheta2_dtheta(i,j),dPhi2_dtheta(i,j);dTheta2_dphi(i,j),dPhi2_dphi(i,j)];
% % det(C)
% M=[1,0;0,1/sin(Theta(i,j))]*C*[1,0;0,sin(Theta2(i,j))];
% det(M)
% M'*M
% M*M'
%%
south=[0,0,-1]';%Grid(end,end,:);
north=[0,0,1]';%Grid(1,1,:);
eps2=pi/50;
grid2=reshape(Grid2,NNNN,3)';grid=reshape(Grid,NNNN,3)';
poles=(reshape(acos(grid2'*south),NN,NN)>eps2).*(reshape(acos(grid2'*north),NN,NN)>eps2);
poles2=(reshape(acos(grid'*south),NN,NN)>eps2).*(reshape(acos(grid'*north),NN,NN)>eps2);
A11=(dTheta2_dtheta.^2) + (sin(Theta2).^2).*(dPhi2_dtheta.^2)-1;
A12=(dTheta2_dtheta.*dTheta2_dphi + (sin(Theta2).^2).*dPhi2_dtheta.*dPhi2_dphi)./sin(Theta);
A21=(dTheta2_dphi.*dTheta2_dtheta + (sin(Theta2).^2).*dPhi2_dtheta.*dPhi2_dphi)./sin(Theta);
A22=(dTheta2_dphi.^2 + (sin(Theta2).^2).*(dPhi2_dphi.^2))./(sin(Theta).^2)-1;

% keyboard
CURVE=(A11.^2+A12.^2+A21.^2+A22.^2).*sin(Theta).*poles.*poles2;
% mesh(CURVE)
%%

% keyboard
R1=sqrt(trapz(phi(2:(end-1)),trapz(theta(2:(end-1)),CURVE(2:(end-1),(2:(end-1))),2),1));
if R1>1000
    close all;mesh(CURVE)
    figure; MESH(Grid2)
    R1
    keyboard
end
end