clear;close all;
%% Load true diffeomorphic map used to simulate data.
load diffeo01.mat
l=10;NN=100
grid=reshape(Grid,300*300,3)';grid2=reshape(Grid2,300*300,3)';
[ Grid2,Grid ] = lower_res( grid,grid2,NN);
grid=reshape(Grid,NN*NN,3)';grid2=reshape(Grid2,NN*NN,3)';
%% Randomly generate N predictor observations.
N=75;
X=randvonMisesFisherm(3, N, 0,[0,0,1]);
%% Compute $\gamma(x)$
[MUi,neighbors]=interpsurf(grid,grid2,X);
%% Apply vMF noise to $\gamma(x)$
kappa=100;
Y=MUi;
for n=1:N
    Y(:,n)=randvonMisesFisherm(3, 1, kappa,MUi(:,n));
end
%% Plot final results
% blue X
% green Y
close all;
MESH(Grid2);hold on
PLOT(X);
yhat=interpsurf(grid,grid2,X);
% PLOT(yhat)
PLOT(Y);

%% Save Simulated observations
save rand_diffeo_EX_02 X Y