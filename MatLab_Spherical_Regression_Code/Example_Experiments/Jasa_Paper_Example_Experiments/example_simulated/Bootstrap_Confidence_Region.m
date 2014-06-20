%% Bootstrap Experiment
% this module randomly generates data on $S^1$ and and constructs
% confidence intervals for the tangent space at $\hat{A}$.
clear;close all;
%% Randomly Generate Data
M=2;
A0=A0_generator(M)
mu=ones(M,1)/sqrt(M);
N=500; % sample size
X=randvonMisesFisherm(M,N,0,mu); % uniformly distributed on the sphere
MUi=A0*X; MUi=MUi./(ones(M,1)*sqrt(sum(MUi.^2,1)));
Y=MUi;
for n=1:N
    Y(:,n)=randvonMisesFisherm(M, 1,10,MUi(:,n));
end

%% boot-strap
n_boot=100
J=100;
for j=1:J
    ind=randsample(N,n_boot);
    [A(:,:,j)]=PLT_GA(X(:,ind),Y(:,ind));
end

%% Compute MLE for focus point
A1=PLT_GA(X,Y);
%% Constuct orthonormal basis for $T_{A_1}(SL(3))$
E_A1=Basis_T_SL(A1);
%% Map to Tangent Space at $A_1$
for j=1:J
    for i=1:(M^2-1)
        Vj=A1*logm(inv(A1)*A(:,:,j));
        a(i,j)=trace(Vj'*E_A1(:,:,i));
    end
end
%%
mu=zeros(M^2-1,1);
%c=sqrt(n_boot)*a; % noncentered coefficients
c=sqrt(n_boot)*(a-mean(a,2)*ones(1,n_boot)); % centered coefficients
K_n=cov(c');
%% 
% plot 3D ellipsoid
% developed from the original demo by Rajiv Singh
% http://www.mathworks.com/matlabcentral/newsreader/view_thread/42966
% 5 Dec, 2002 13:44:34
% Example data (Cov=covariance,mu=mean) is included.
% http://kittipatkampa.wordpress.com/2011/08/04/plot-3d-ellipsoid/

[U,L] = eig(K_n);
% L: eigenvalue diagonal matrix
% U: eigen vector matrix, each column is an eigenvector

% For N standard deviations spread of data, the radii of the eliipsoid will
% be given by N*SQRT(eigenvalues).
close all
N =sqrt(chi2inv(.95,2)); % choose your own N
radii = N*sqrt(diag(L));

% generate data for "unrotated" ellipsoid
[xc,yc,zc] = ellipsoid(0,0,0,radii(1),radii(2),radii(3));

% rotate data with orientation matrix U and center mu
a1 = kron(U(:,1),xc); 
b1 = kron(U(:,2),yc); 
c1 = kron(U(:,3),zc);

data = a1+b1+c1; n = size(data,2);

x = data(1:n,:)+mu(1); 
y = data(n+1:2*n,:)+mu(2); 
z = data(2*n+1:end,:)+mu(3);

% now plot the rotated ellipse
% sc = surf(x,y,z); shading interp; colormap copper
h = surfl(x, y, z);colormap('gray')
axis equal
alpha(0.7)
%
hold on
scatter3(c(1,:),c(2,:),c(3,:))