%% Generate Simulated Data using von Mises-Fisher noise
% This generates paired data related via a projective linear transformation
%% The randvonMisesFisherm.m function
% This function was written by Sungkyu Jung.
% The code can be found at:
% http://www.unc.edu/~sungkyu/manifolds/randvonMisesFisherm.m
% 
% For more information see: http://www.unc.edu/~sungkyu/index.html
%% Set Parameters
close all;clear all;%clc;
M=3; % Dimension of vector space ex S^2 in R^3
N=25; % Number of observations
kappax=6;% concentration parameter for x
kappa=10;% concentration parameter for x
A0=A0_generator(3); % randomly generates transformation matrix in SL(M)
%% Generate x
X=randvonMisesFisherm(M, N, kappax,[0,0,1]);
%% Apply PLT

MUi=A0*X; MUi=MUi./(ones(M,1)*sqrt(sum(MUi.^2,1)));
%% Add Noise to Mean directions to generate y
mu=[-1,-1,1]'/sqrt(M);
Y=MUi;
for n=1:N
Y(:,n)=randvonMisesFisherm(M, 1, kappa,MUi(:,n));
end
%% save
%  save estimation_example_PLT_NR.mat X Y MUi kappa A0 M N