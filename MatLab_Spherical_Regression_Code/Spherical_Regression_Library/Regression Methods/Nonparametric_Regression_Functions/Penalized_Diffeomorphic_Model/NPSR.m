function [Grid2,E,Xtilde,path] = NPSR(X,Y,lambda,l,NN)
%%
% clear
% l=10;L=2*(l+1)^2-2;
% NN=60;NNNN=NN*NN;
% [Theta,Phi,~,B] = spherharmbasis1(l,NN);
% % construct Grid in Cartesian Coordinates
% [Grid(:,:,1),Grid(:,:,2),Grid(:,:,3)]=s2c(Theta,Phi);
% % vectorize grid inputs
% theta=reshape(Theta,NNNN,1);phi=reshape(Phi,NNNN,1);b=reshape(B,NNNN,2,L);
% grid=reshape(Grid,NNNN,3)';
% % Construct Basis of Tangenet Vectors
% v1=h1(theta,phi);
% v2=h2(theta,phi);
% btan=zeros(3,NNNN,L);
% for j=1:L
%     btan(:,:,j)=v1.*(ones(3,1)*b(:,1,j)')+v2.*(ones(3,1)*b(:,2,j)');
% %     Btan(:,:,:,j)=reshape(btan(:,:,j)',NN,NN,3 );
% end
% save(['GRID_' num2str(l) '_' num2str(NN)])
grid=0;
if ~exist('l','var')
    l=10;
end
if ~exist('NN','var')
    NN=60;
end
mkgrid(l,NN);
load(['GRID_' num2str(l) '_' num2str(NN) '.mat']);
    display('file loaded')

%%
[~,N]=size(X);
delta=10^(-4);% step size
minitr=100;maxitr=5000;
A=eye(3);% [A]=RRR(X,Y);
Xtilde=A*X;
e=trace(Y'*X)*ones(maxitr+1,1);
% keyboard
grid2=grid;
R_old=repmat(R_1(Grid,reshape(grid2',NN,NN,3)),maxitr+1,1);

grid2=A*grid2;
Grid2(:,:,:,2)=reshape(grid2',NN,NN,3);
e(2)=trace(Y'*Xtilde);
R_old=repmat(R_1(Grid,Grid2(:,:,:,2)),maxitr+1,1);
E=e/N - lambda*R_old;

c=zeros(1,L);
a=zeros(1,L);
epsilon=10^(-10);

path_index=1;
path=repmat(Xtilde,1,maxitr);
path_index=path_index+1;
close all
for ind=2:maxitr
    bnew=reshape(epsilon*interptan_fast(grid,btan,grid2),3,NNNN*L);
    grid2_tilde=EXP(bnew,repmat(grid2,1,L));
    Grid2_tilde_tmp=reshape(grid2_tilde,3,NN,NN,L);
    Grid2_tilde(:,:,1,:)=squeeze(Grid2_tilde_tmp(1,:,:,:));
    Grid2_tilde(:,:,2,:)=squeeze(Grid2_tilde_tmp(2,:,:,:));
    Grid2_tilde(:,:,3,:)=squeeze(Grid2_tilde_tmp(3,:,:,:));
    
    btanX=interptan_fast(grid,btan,Xtilde);
    
    nabla=zeros(size(btan(:,:,1)));
    for j=1:L
        R_tilde=R_1(Grid,Grid2_tilde(:,:,:,j));
        a(j,ind)=trace(Y'*btanX(:,:,j));
        c(j,ind)=(R_tilde-R_old(ind))/epsilon;
        nabla=nabla+(a(j,ind)-N*lambda*c(j,ind))*btan(:,:,j);
    end
    
    nabla2=interptan_fast(grid,delta*nabla,grid2);
    grid2=EXP(nabla2,grid2);
    Grid2(:,:,:,ind+1)=reshape(grid2',NN,NN,3);
    
    nablaX=interptan_fast(grid,delta*nabla,Xtilde);
    Xtilde=EXP(nablaX,Xtilde);
    
    path(:,(N*(path_index-1)+1):(N*(path_index)))=Xtilde;
    path_index=path_index+1;
    
    %     close all
    %     MESH_lowres(grid,grid2);
    %     hold on;PLOT(Xtilde);PLOT(Y); pause(.1);
    
    R_old(ind+1)=R_1(Grid,Grid2(:,:,:,ind+1));
    e(ind+1)=trace(Y'*Xtilde);
    E(ind+1)=e(ind+1)/N-lambda*R_old(ind+1);
    if abs((abs(E(ind+1))-abs(E(ind-1)))<10^(-7))&&(ind>minitr)
        break
    end
end

E=E(1:ind); Grid2=Grid2(:,:,:,1:ind);
% keyboard
grid2=reshape(Grid2(:,:,:,ind),NNNN,3)';
Xtilde=interpsurf(grid,grid2,X);

end