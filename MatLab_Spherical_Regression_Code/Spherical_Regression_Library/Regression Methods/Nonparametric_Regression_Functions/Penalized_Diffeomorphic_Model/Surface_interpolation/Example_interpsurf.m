clear;close all
l=1;L=2*(l+1)^2-2;
NN=400;NNNN=NN*NN;
[Theta,Phi,Psi,B] = spherharmbasis1(l,NN);
% construct Grid in Cartesian Coordinates
[Grid(:,:,1),Grid(:,:,2),Grid(:,:,3)]=s2c(Theta,Phi);
% vectorize grid inputs
theta=reshape(Theta,NNNN,1);phi=reshape(Phi,NNNN,1);b=reshape(B,NNNN,2,L);
grid=reshape(Grid,NNNN,3)';
 A0=A0_generator(3);
 grid2=A0*grid; grid2= grid2./(ones(3,1)*sqrt(sum(grid2.^2)));
% grid2=grid;
Grid2=reshape(grid2',NN,NN, 3);
%
 X=randvonMisesFisherm(3, 1, 0, [0,0,1]);

[Theta,Phi,Psi,B] = spherharmbasis1(l,NN);
% construct Grid in Cartesian Coordinates
[Grid(:,:,1),Grid(:,:,2),Grid(:,:,3)]=s2c(Theta,Phi);
% vectorize grid inputs
theta=reshape(Theta,NNNN,1);phi=reshape(Phi,NNNN,1);b=reshape(B,NNNN,2,L);
grid=reshape(Grid,NNNN,3)';
 A0=A0_generator(3);
 grid2=A0*grid; grid2= grid2./(ones(3,1)*sqrt(sum(grid2.^2)));
Grid2=reshape(grid2',NN,NN, 3);
%
X=randvonMisesFisherm(3, 1, 0, [0,0,1]);
% X=grid(:,10000)

[X2,neighbors]=interpsurf(grid,grid2,X);
close all
MESH(Grid);hold on
PLOT(X); 
PLOT(grid(:,neighbors));view(X);zoom(20)
%

%
x2=A0*X;x2= x2./(ones(3,1)*sqrt(sum(x2.^2)));
% x2=X;

figure
MESH(Grid2);hold on

PLOT(X2);PLOT(x2)

view(X2); zoom(15)

norm(X2-x2)