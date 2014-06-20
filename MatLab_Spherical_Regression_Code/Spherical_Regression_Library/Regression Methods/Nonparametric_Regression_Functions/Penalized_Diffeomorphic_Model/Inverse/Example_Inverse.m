clear
load diffeo01.mat
grid=reshape(Grid,300*300,3)';grid2=reshape(Grid2,300*300,3)';
NN=30;
[ Grid2,Grid ] = lower_res( grid,grid2,NN );
grid=reshape(Grid,NN*NN,3)';grid2=reshape(Grid2,NN*NN,3)';;
%%
grid=0;
if ~exist('l','var')
    l=15;
end
if ~exist('NN','var')
    NN=60;
end
mkgrid(l,NN);
load(['GRID_' num2str(l) '_' num2str(NN) '.mat']);
    display('file loaded')
%% Algorithm Parameters
delta=10^(-2);% step size
epsilon=10^(-10); % derivative estimate
minitr=10;maxitr=5000;
%% Initialize
R_old=repmat(R_0(Grid,Grid2),maxitr+1,1);
gridinvhat=grid;
grid2_tilde=grid2;
c=zeros(1,L);
a=zeros(1,L);
%%
for ind=2:maxitr
    bnew=reshape(epsilon*interptan_fast(grid,btan,grid2_tilde),3,NNNN*L);
    grid2_tilde_tmp=EXP(bnew,repmat(grid2_tilde,1,L));
    Grid2_tilde_tmp=reshape(grid2_tilde_tmp,3,NN,NN,L);
    Grid2_tilde(:,:,1,:)=squeeze(Grid2_tilde_tmp(1,:,:,:));
    Grid2_tilde(:,:,2,:)=squeeze(Grid2_tilde_tmp(2,:,:,:));
    Grid2_tilde(:,:,3,:)=squeeze(Grid2_tilde_tmp(3,:,:,:));
    nabla=zeros(size(btan(:,:,1)));
    for j=1:L
        R_tilde=R_0(Grid,Grid2_tilde(:,:,:,j));
        c(j,ind)=(R_tilde-R_old(ind))/epsilon;
        nabla=nabla-c(j,ind)*btan(:,:,j);
    end    
%     nabla2=interptan_fast(grid,delta*nabla,grid2_tilde);
%     grid2_tilde=EXP(nabla2,grid2_tilde);
    nablainvhat=interptan_fast(grid,delta*nabla,gridinvhat);
    gridinvhat=EXP(nablainvhat,gridinvhat);
    grid2_tilde=interpsurf(grid,gridinvhat,grid2);
    Grid2(:,:,:,ind+1)=reshape(grid2_tilde',NN,NN,3);
    R_old(ind+1)=R_0(Grid,Grid2(:,:,:,ind+1));
    if (abs(abs(R_old(ind-1))-abs(R_old(ind+1)))<10^(-5))&&(ind>minitr)        
        break
    end
end
ind
R0=R_old(1:ind); Grid2=Grid2(:,:,:,1:ind);
% keyboard
% grid2=reshape(Grid2(:,:,:,ind),NNNN,3)';
%%
gridgrid=interpsurf(grid,gridinvhat,grid2);
Gridinvhat=reshape(gridinvhat',NN,NN,3);
Gridgrid=reshape(gridgrid',NN,NN,3);
%%
close all
plot(R0)
%%
figure   
MESH(Grid2(:,:,:,3));
figure
MESH(Grid2(:,:,:,end));
figure
MESH(Gridinvhat);
%% Method two using taylor's model
gridinvhat2=taylor(grid2,grid,grid);
Gridinvhat2=reshape(gridinvhat2',NN,NN,3);
gridgrid2=interpsurf(grid,gridinvhat2,grid2);
Gridgrid2=reshape(gridgrid2',NN,NN,3);
figure
MESH(Gridinvhat2);
figure
MESH(Gridgrid2);
%%
