function [X2,neighbors]=interpsurf(grid,grid2,X)
%% Interpolation of Tangent Vector Feild on the sphere
% grid should be 3xNNNN (unit vectors)
% btan should be 3xNNNN (tangent vectors at specified grid points)
% X should be 3xN where N is the number of new point on the sphere we wish
% to interpolate the tangent vector field at.
[M,NNNN]=size(grid);NN=sqrt(NNNN);[M,N]=size(X);
%%
%% Find Neighbors
[thetaX,phiX]=c2s(X(1,:),X(2,:),X(3,:));
r=thetaX*((NN-1)/pi);
c=phiX*((NN-1)/(2*pi));
rows=floor(r)+1;    cols=floor(c)+1;
% keyboard
%%
neighbors(1,:)=cols+(rows-1)*NN;
neighbors(2,:)=mod(cols+1+(rows-1)*NN,NNNN+1);
% neighbors(2,logical(neighbors(2,:)==0))=1;
neighbors(3,:)=mod(cols+(rows)*(NN),NNNN); %%
neighbors(4,:)=mod(cols+1+(rows)*NN,NNNN+1);
% neighbors(4,logical(neighbors(4,:)==0))=1;

neighbors(5,:)=mod(cols+2+(rows)*NN,NNNN+1);
neighbors(6,:)=mod(cols+2+(rows-1)*NN,NNNN+1);
neighbors(7,:)=mod(cols-1+(rows)*NN,NNNN+1);
neighbors(8,:)=mod(cols-1+(rows-1)*NN,NNNN+1);
neighbors(9,:)=mod(cols+(rows-2)*NN,NNNN+1);
neighbors(10,:)=mod(cols+1+(rows-2)*NN,NNNN+1);
neighbors(11,:)=mod(cols+(rows+1)*NN,NNNN+1);
neighbors(12,:)=mod(cols+1+(rows+1)*NN,NNNN+1);
neighbors(13,:)=mod(cols-1+(rows-2)*NN,NNNN+1);
neighbors(14,:)=mod(cols-1+(rows+1)*NN,NNNN+1);
neighbors(15,:)=mod(cols+2+(rows-2)*NN,NNNN+1);
neighbors(16,:)=mod(cols+2+(rows+1)*NN,NNNN+1);
% set zeros to 1
neighbors(logical(neighbors(1:end)==0))=1;
%% 
% ind=10000;%randsample(N,1);
% close all;
% PLOT(X(:,ind));hold on;PLOT(grid(:,neighbors(:,ind)))
%%
for n=1:N
%     keyboard
    psi=grid2(:,neighbors(:,n));
    %% Compute Weighted Average
    D=acos(max(min(grid(:,neighbors(:,n))'*X(:,n),1),-1)); % Distance Matrix of Neighbors
    sigma=3*pi/NNNN;
    k=exp(-(D.^2-min(D).^2)/sigma);
    W=k/sum(k); % Weights
    X2(:,n)=psi*W; % Weighted Average   
end
X2= X2./(ones(3,1)*sqrt(sum(X2.^2)));

% close all
% MESH(reshape(grid',NN,NN,3))
% hold on;
% PLOT(grid(:,neighbors));view(X);zoom(10)
% PLOT(X)
% PLOT(X2)
%%
end