%% Shape Classification Experiment
% This script performs the shape classification experiment described in the
% paper for a fixed concentration $\kappa$.
%% Load data
clear all; close all;
J=1300; % # of shapes
N=100; % # of data points in shapes
M=3;C=zeros(M-1,N,J);load Full20objDatanobadshapes;
%% Set Parameters
kappa=50; % concentration level
itr=1;%500; % # of trials
%% Initialize Parameters
c0=zeros(itr,1);c1=zeros(itr,1);c2=zeros(itr,1);c3=zeros(itr,1);
j0=zeros(itr,1);j1=zeros(itr,1);j2=zeros(itr,1);j3=zeros(itr,1);
L.BAR=zeros(itr,1300);L.PLT=zeros(itr,1300);L.LLR=zeros(itr,1300);L.RRR=zeros(itr,1300);
itrindex=1:itr;
%% Center and scale 2D shapes
% Example seen in figure 4a
% All the 2D shapes are centered and scaled in this step.
for j=1:1300
    C(:,:,j)=C(:,:,j)-mean(C(:,:,j),2)*ones(1,N);
    C(:,:,j)=5*C(:,:,j)/norm(C(:,:,j));
end
%% Plot an example of the center and scaled 2D shape
close all;j=randsample(J,1);plot(C(1,:,j),C(2,:,j))
%% Run itr=500 trials
for i=itrindex
    %% Generate observed noisy distorted data 
    % Example seen in figure 4
    %% Randomly select a class
    c0(i)=randsample(1:65,1);% The true class of the noisy data
    %% Randomly select an image in that class
    j0(i)= (c0(i)-1)*20 + randsample(1:20,1);
    %% Project 2D  shape the selected image to the sphere
    % Example seen in figure 4b
    x=C(:,:,j0(i));
    X=Upsphere(x);
    %% Apply a random projective linear transformation to generating image
    % Example seen in figure 4c
    %
    % (1) randomly generate $A_0 \in SL(3)$
    %
    % (2) apply the PLT to selected shape
    A0=A0_generator(M);
    mu=A0*X; mu=mu./(ones(M,1)*sqrt(sum(mu.^2,1)));
    %% Generate noise to the transformed data
    % Example seen in figure 4d
    Y=zeros(M,N);
    for n=1:N
        Y(:,n)=randvonMisesFisherm(M, 1, kappa,mu(:,n));
    end
    %%
    for j=setdiff(1:J, j0(i))
        %% select 2D candidate shape j
        % Example seen in figure 5a
        x=C(:,:,j);
        %% Project candidate shape j to the sphere
        X=Upsphere(x);
        %% Compute Predicted values under each candidate model
        %% Compute predicted value for PLT 
        % Example seen in figure 5 b
        [~,e,Yhat.PLT]= PLT_GA(X,Y);
        %% Compute predicted value for RRR 
        % Example seen in figure 5 c        
        [~,~,Yhat.RRR]=RRR(X,Y);
        %% Compute predicted value for LLR
        % Example seen in figure 5 c
        [~,~,Yhat.LLR]=LLR(X,Y);
        %% Compute log-likelihoods under von-Mises Fisher distribution
        [~,l.PLT(i,j)]=vMFL(Y,Yhat.PLT);
        [~,l.RRR(i,j)]=vMFL(Y,Yhat.RRR);
        [~,l.LLR(i,j)]=vMFL(Y,Yhat.LLR);
    end
    %% For each model select the shape which yeilds the largest log-likelihood
    [~,j1(i)]=max(l.PLT(i,:));
    [~,j2(i)]=max(l.LLR(i,:));
    [~,j3(i)]=max(l.RRR(i,:));
    %% Classify the noisy data with the selected candidate shape
    c1(i)=floor((j1(i)-1)/20)+1; % The selected class for PLT
    c2(i)=floor((j2(i)-1)/20)+1; % The selected class for LLR
    c3(i)=floor((j3(i)-1)/20)+1; % The selected class for RRR
    %% Optional Output
%     save(['Shape_Recognition_' num2str(kappa)])
%     display(['kappa:' num2str(kappa)])
%     display(['n:' num2str(i)])
%     display(['PLT:' num2str(mean(c1(1:i)==c0(1:i)))])
%     display(['LLR:' num2str(mean(c2(1:i)==c0(1:i)))])
%     display(['RRR:' num2str(mean(c3(1:i)==c0(1:i)))])
end
%% Plot the output and make Latex Tables to present results
Shape_Classification_Performance_Plot