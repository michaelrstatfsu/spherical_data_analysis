close all;clear all;%clc;
% M=3; % Dimension of vector space
% N=100; % Number of observations
% 
% A0=A0_generator;%rotMat(mu./norm(mu),[1,1,1]'/sqrt(3),pi/50);%eye(3);%
% % A0 =eye(M)+...
% % [
% % 1 0 0 
% % 1 1 0
% % 1 1 1
% % ];
% k=3;%10000%.5
% X=randvonMisesFisherm(M, N, k,mu);
% 
% % Noise-Free Data
% MUi=A0*X; MUi=MUi./(ones(M,1)*sqrt(sum(MUi.^2,1)));
% S=RRR(MUi,X);
% MUi=S*MUi;

% save example1.mat
clear
load example1.mat


mu=[-1,-1,1]'/sqrt(M);
MUi=A0*X; MUi=MUi./(ones(M,1)*sqrt(sum(MUi.^2,1)));
size=100;
MUi=rotMat(mu,[0,0,-1]',.4)*MUi;

%% Noiseless Data
Y=MUi;
[A1,e,~,path]= PLT_NR(X,MUi);
figure(1);plot(e/N,'linewidth',2)
hold on
fnA0=trace(Y'*MUi)/N;
plot(repmat(fnA0,1,length(e)))
set(gca,'Linewidth',2,'fontsize',30);
xlim([0,length(e)]);ylim([.7,1.1])
print -dpng noiseless01.png

figure(3);close;figure(3);
center=mean(Y,2);
Display_Path(X,Y,path)
zoom(1.5)
print -dpng noiseless02.png

%% Noise Data
kappa=10;
for n=1:N
Y(:,n)=randvonMisesFisherm(M, 1, kappa,MUi(:,n));
end
kappahat.Mui=kappa_tilde(MUi,Y);
[A2,e,Xtilde,path]= PLT_NR(X,Y);
kappahat.noise=kappa_tilde(Xtilde,Y);

figure(2);plot(e/N,'linewidth',2)
hold on
fnA0=trace(Y'*MUi)/N;
% plot(repmat(resultant_length(M,kappa),1,length(e)))
plot(repmat(fnA0,1,length(e)))
set(gca,'Linewidth',2,'fontsize',30);
xlim([0,length(e)]);ylim([.7,1.1])
print -dpng noise01.png

figure(4);close;figure(4);
Display_Path(X,Y,path)
zoom(1.5)
print -dpng noise02.png
%% Compare true and estimated tranformation matricies
A0 % true tranformation matrix
A1 % estimated tranformation matrix under noiseless data
A2 % estimated tranformation matrix under noisy data
%%
kappa % true concentration
kappahat.Mui % estimated concentration under noiseless data
kappahat.noise % estimated concentration under noisey data
