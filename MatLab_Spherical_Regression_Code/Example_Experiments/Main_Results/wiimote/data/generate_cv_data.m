clear; 
% filename='counterclockwise'
filename='left45';
% filename='right45';
load([filename '.mat'])
[M,N]=size(X);
IND=randsample(1:N,N);
ind=randsample(IND,floor(N*.75));
indtest=setdiff(IND,ind);
x=X(:,ind);y=Y(:,ind);
x2=X(:,indtest);y2=Y(:,indtest);
X=x;Y=y;X2=x2;Y2=y2;
save([filename '_cv.mat'], 'X', 'Y', 'X2', 'Y2')
%%
close all
globe([],'');hold on
load right45_cv.mat
PLOT(X);PLOT(Y);PAIR(X,Y)
figure
globe([],'');hold on
load left45_cv.mat
PLOT(X);PLOT(Y);PAIR(X,Y)