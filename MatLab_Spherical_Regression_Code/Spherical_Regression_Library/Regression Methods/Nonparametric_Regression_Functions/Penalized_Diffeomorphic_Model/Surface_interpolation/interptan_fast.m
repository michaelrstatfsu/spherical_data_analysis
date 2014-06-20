function [btanX,neighbors]=interptan_fast(grid,btan,X)
%% Interpolation of Tangent Vector Feild on the sphere
% grid should be 3xNNNN (unit vectors)
% btan should be 3xNNNN (tangent vectors at specified grid points)
% X should be 3xN where N is the number of new point on the sphere we wish
% to interpolate the tangent vector field at.
[~,NNNN,L]=size(btan);NN=sqrt(NNNN);[~,N]=size(X);
%%
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

%% Calculate Weighted Average
% keyboard
% h=3*pi/(NNNN); % set bandwidth
h=3*pi/(NN); % set bandwidth
btanX=zeros(3,L*N);
k=zeros(4,N);
% keyboard
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
    psi(:,sum(isnan(psi))>0)=btan(:,sum(isnan(psi))>0);
    D=acos(dot(grid(:,neighbors(i,:)),x)); % Distance Matrix of Neighbors
%     k(i,:)=1./(D+10^(-10));    
    k(i,:)=exp(-(D.^2-min(D).^2)/h);
    %k(i,:)=exp(-((D/h).^2)/2)/(sqrt(2*pi))+10^(-10); % DGaussian Kernel
    btanX=btanX+repmat(k(i,:),3,L).*psi;    
end

btanX=btanX./repmat(sum(k),3,L);
btanX=reshape(btanX,3,N,L);
end