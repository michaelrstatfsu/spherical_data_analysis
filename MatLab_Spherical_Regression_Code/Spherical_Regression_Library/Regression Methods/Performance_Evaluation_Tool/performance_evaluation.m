function [Performance_Output,L,E]=performance_evaluation(X,Y)
[M,N]=size(X);
%% MSE
[Ahat.PLT,E.PLT,Yhat.PLT]= PLT_NR(X,Y);
[Ahat.RRR,E.RRR,Yhat.RRR]=RRR(X,Y);
[Ahat.LLR,E.LLR,Yhat.LLR]=LLR(X,Y);
Ybar=mean(Y,2);Ybar=Ybar/norm(Ybar);
rho.BAR(N+1)=mean(Y'*Ybar);
rho.PLT(N+1)=E.PLT(end)/N;
rho.RRR(N+1)=E.RRR/N;
rho.LLR(N+1)=E.LLR/N;
MSE.BAR= 2-2*rho.BAR(N+1);
MSE.PLT= 2-2*rho.PLT(N+1);
MSE.RRR= 2-2*rho.RRR(N+1);
MSE.LLR= 2-2*rho.LLR(N+1)
% COD.PLT=1-MSE.PLT/MSE.BAR;
% COD.RRR=1-MSE.RRR/MSE.BAR;
% COD.LLR=1-MSE.LLR/MSE.BAR;
%% kappa
kappa.BAR=kappa_tilde(Ybar*ones(1,N),Y);
kappa.PLT=kappa_tilde(Yhat.PLT,Y);
kappa.RRR=kappa_tilde(Yhat.RRR,Y);
kappa.LLR=kappa_tilde(Yhat.LLR,Y)
%% likelihood
[L.BAR,l.BAR]=vMFL(Y,Ybar*ones(1,N),kappa.BAR);
[L.PLT,l.PLT]=vMFL(Y,Yhat.PLT,kappa.PLT);
[L.RRR,l.RRR]=vMFL(Y,Yhat.RRR,kappa.RRR);
[L.LLR,l.LLR]=vMFL(Y,Yhat.LLR,kappa.LLR)
%% cvMSE
for I=1:(N)
    %%
    j=I;
    n=length(j);
    index=setdiff(1:N,j);
    x=X(:,index);y=Y(:,index);
    Yhat.BAR=mean(y,2);Yhat.BAR=Yhat.BAR/norm(Yhat.BAR); rho.BAR(I)= trace(Y(:,j)'*(Yhat.BAR*ones(1,n)))/n;
    cvkappa.BAR(I)=kappa_tilde(Yhat.BAR*ones(1,N-n),y);
    [Ahat.PLT,e,est]= PLT_NR(x,y);
    cvkappa.PLT(I)=kappa_tilde(est,y);
    Yhat.PLT= Ahat.PLT*X(:,j); Yhat.PLT= Yhat.PLT./(ones(M,1)*sqrt(sum( Yhat.PLT.^2)));
    rho.PLT(I)= trace(Y(:,j)'*Yhat.PLT)/n;
    %%
    [Ahat.RRR,e,est]=RRR(x,y);
    cvkappa.RRR(I)=kappa_tilde(est,y);
    Yhat.RRR=Ahat.RRR*X(:,j);%Yhat.RRR= Yhat.RRR./(ones(M,1)*sqrt(sum( Yhat.RRR.^2)));
    rho.RRR(I)= trace(Y(:,j)'*Yhat.RRR)/n;
    [~,~,est,Yhat.LLR]=LLR(x,y,X(:,j));rho.LLR(I)= trace(Y(:,j)'*Yhat.LLR)/n;
    cvkappa.LLR(I)=kappa_tilde(est,y);
end
meanrho.BAR=mean(rho.BAR(1:N));
meanrho.PLT=mean(rho.PLT(1:N));
meanrho.RRR=mean(rho.RRR(1:N));
meanrho.LLR=mean(rho.LLR(1:N));

cvMSE.BAR= 2-2*meanrho.BAR;
cvMSE.PLT= 2-2*meanrho.PLT;
cvMSE.RRR= 2-2*meanrho.RRR;
cvMSE.LLR= 2-2*meanrho.LLR

cvCOD.PLT=1-cvMSE.PLT/cvMSE.BAR;
cvCOD.RRR=1-cvMSE.RRR/cvMSE.BAR;
cvCOD.LLR=1-cvMSE.LLR/cvMSE.BAR;

cvkappa.BAR=mean(cvkappa.BAR);
cvkappa.PLT=mean(cvkappa.PLT);
cvkappa.RRR=mean(cvkappa.RRR);
cvkappa.LLR=mean(cvkappa.LLR)

%%
test.MSE=MSE;
test.kappa=kappa;
cv.MSE=cvMSE;
cv.kappa=cvkappa;
Performance_Output.test=test;
Performance_Output.cv=cv;
Performance_Output.N=N;
Performance_Output.L=L;
Performance_Output.l=l;
end

