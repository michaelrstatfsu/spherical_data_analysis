clear;close all
l=5;L=2*(l+1)^2-2;
NN=200;NNNN=NN*NN;
[Theta,Phi,Psi,B] = spherharmbasis1(l,NN);
% construct Grid in Cartesian Coordinates
[Grid(:,:,1),Grid(:,:,2),Grid(:,:,3)]=s2c(Theta,Phi);
grid=reshape(Grid,NNNN,3)';
X=randvonMisesFisherm(3, 10,0, [0,0,-1]');
[M,NNNN]=size(grid);NN=sqrt(NNNN);[M,N]=size(X);
%% Construct Basis of Tangenet Vectors
theta=reshape(Theta,NNNN,1);phi=reshape(Phi,NNNN,1);b=reshape(B,NNNN,2,L);
v1=h1(theta,phi);
v2=h2(theta,phi);
btan=zeros(3,NNNN,L);
for j=1:L
    btan(:,:,j)=v1.*(ones(3,1)*b(:,1,j)')+v2.*(ones(3,1)*b(:,2,j)');
    Btan(:,:,:,j)=reshape(btan(:,:,j)',NN,NN,3 );
end

%% Find Neighbors
[thetaX,phiX]=c2s(X(1,:),X(2,:),X(3,:));

% keyboard
rows=floor(thetaX*((NN-1)/pi))+1;    cols=floor(phiX*((NN-1)/(2*pi)))+1;
neighbors(1,:)=cols+(rows-1)*NN;
neighbors(2,:)=mod(cols+1+(rows-1)*NN,NNNN+1);
neighbors(2,logical(neighbors(2,:)==0))=1;
neighbors(3,:)=cols+(rows)*NN;
neighbors(4,:)=mod(cols+1+(rows)*NN,NNNN+1);
neighbors(4,logical(neighbors(4,:)==0))=1;
%%
i=1

ax=reshape(btan(:,neighbors(i,:),:),3,L*N);
x=grid(:,neighbors(i,:));y=X;
fxy=cross(x,y);fxy=fxy./(ones(3,1)*sqrt(sum(fxy.^2)));
exy=cross(fxy,x);
fyx=cross(y,x);fyx=fyx./(ones(3,1)*sqrt(sum(fyx.^2)));
eyx=cross(fyx,y);
af= dot(repmat(-fxy,1,L),ax);
ae= dot(repmat(-exy,1,L),ax);
psi=repmat(fyx,1,L).*(ones(3,1)*af)+repmat(eyx,1,L).*(ones(3,1)*ae);
%%
n=4;
close all
MESH(Grid);hold on;
PLOT(grid(:,neighbors(4,n)));
PLOT(y(:,n));view(y(:,n))
% QUIVER3(grid(:,neighbors(4,n)),ax(:,n));zoom(2)
QUIVER3(grid(:,neighbors(4,n)),fxy(:,n));
QUIVER3(grid(:,neighbors(4,n)),exy(:,n));
% QUIVER3(y(:,n),psi(:,n));
QUIVER3(y(:,n),-fyx(:,n));
QUIVER3(y(:,n),-eyx(:,n));
%%
x=repmat(x,1,L);view(x(:,n));
QUIVER3(x(:,n),psi(:,n));
%%
h=2*pi/(NN); % set bandwidth
btanX=zeros(3,L*N);
for i=1:4
    ax=reshape(btan(:,neighbors(i,:),:),3,L*N);
    x=grid(:,neighbors(i,:));y=X;
    fxy=cross(x,y);fxy=fxy./(ones(3,1)*sqrt(sum(fxy.^2)));
    exy=cross(fxy,x);
    fyx=cross(y,x);fyx=fyx./(ones(3,1)*sqrt(sum(fyx.^2)));
    eyx=cross(fyx,y);
    af= dot(repmat(-fxy,1,L),ax);
    ae= dot(repmat(-exy,1,L),ax);
    psi=repmat(fyx,1,L).*(ones(3,1)*af)+repmat(eyx,1,L).*(ones(3,1)*ae);
    D=diag(acos(grid(:,neighbors(i,:))'*x)); % Distance Matrix of Neighbors
    k(i,:)=exp(-((D/h).^2)/2)/(sqrt(2*pi))+10^(-10); % DGaussian Kernel
    btanX=btanX+repmat(k(i,:),3,L).*psi;
end

%%


btanX=btanX./repmat(sum(k),3,L);
%%
btanX=reshape(btanX,3,N,L);
%%
j=70;
i=4;
tic
for j=1:L
[btanX_old(:,:,j),neighbors_old]=interptan(grid,btan(:,:,j),X);
end
toc
tic
[btanX,neighbors]=interptan_fast(grid,btan,X);
toc