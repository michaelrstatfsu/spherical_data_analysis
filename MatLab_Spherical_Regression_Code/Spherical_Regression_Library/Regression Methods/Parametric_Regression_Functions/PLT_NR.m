%% Projective Linear Transformation Estimation
% This function applies a Newton-Raphson algorithm based on derivations
% used in "Spherical Regression Models Using Projective Linear Transformations".
%
% X and Y respectively denote dXn dimensional predictor and response matricies where the
% columns denote individual observations on the sphere.
%
% Ahat is the estimated transformation matrix.
%
% e is the iterativly updated objective function
%
% Xtilde is the predicted value of Y given X
%
% path shows the iterative updates of Xtilde and can be plotted using the Display_Path.m function.
function [A,e,Xtilde,path,A_store]= PLT_NR(X,Y)
path_index=1;
ind=1;
[M,N]=size(Y);
%% Initialize using rigid rotation
[A,~,~]=RRR(X,Y);
% A=eye(M);
%% Update Path
Xtilde=A*X./(ones(3,1)*sqrt(sum((A*X).^2)));
path(:,(N*(path_index-1)+1):(N*(path_index)))=Xtilde;
path_index=path_index+1;
%% Update e
e(ind)=trace(Y'*Xtilde)/N;
%% Initialize index parameters
maxitr=500; % Maximum number of iterations
e(1:maxitr)=trace(Y'*Xtilde);
GO=1;
CloseEnough=10^(-4); % Stopping parameter
while (ind<=maxitr)&&(GO==1)
    %% Compute the Normal
    N_A_tilde= inv(A');
    N_A=N_A_tilde/trace(N_A_tilde*N_A_tilde')^(1/2);
    %Ntilde=inv(A)';N_A= Ntilde*(Ntilde(1:end)*Ntilde(1:end)')^(-1/2);
    %% Construct an Orthonomral Basis $\{ E_{A,1},\ldots, E_{A,d^2-1}\} \subset T_A(SL(d))$
    E_A=Basis_T_SL(A);
    %% Derive/Compute the extrinsic gradient of F at A
    Xtilde=A*X;Xtilde=Xtilde./(ones(M,1)*sqrt(sum(Xtilde.^2)));
    gradF=(Y*Xtilde'- Xtilde.*(ones(M,1)*sum(Xtilde.*Y,1))*Xtilde' )/(A');
    %% Compute intrinsic gradient
    Vf=gradF - trace(gradF'*N_A)*N_A;
    %% Compute Inverse Hessian in the direction of the intrinsic gradient $V$
    vf=zeros(M^2-1,1);
    for j=1:(M^2-1)
        vf(j,1)=trace(Vf'*E_A(:,:,j));
    end
%     norm(vf)
    if sum((vf'*vf).^2)<10^(-3)
        break
    end
    %%
    %H_AE=zeros(M,M);
    W=zeros(M^2-1);
    for i=1:(M^2-1)
        %%
        V=E_A(:,:,i);
        %% Compute the Directional derivative of the normal for each $E_{A,i}$
        %Analytic
        % D_EN_A=-inv(A')*V'*inv(A')*(trace(inv(A)*inv(A'))^(-1/2))...
        %    +inv(A')*(trace(inv(A)*inv(A'))^(-3/2))*trace(inv(A')*inv(A)*V*inv(A));
        %Numeric
        % epsilon=10^(-6);
        % D_EN_A=(inv((A+epsilon*V)')*trace(inv((A+epsilon*V))*inv((A+epsilon*V))')^(-1/2)-N_A)/epsilon
        %% Compute the directional derivative of the extrinsic gradient
        % in the direction of $E_{A,i}$
        %Analytic
        %         D_EAF=zeros(M);
        %         for n=1:N
        %             x=X(:,n); y=Y(:,n);
        %             D_EAF=D_EAF+((-y*x')*(x'*A'*V*x) +V*x*x'*A'*y*x'+A*x*x'*V'*y*x'...
        %                 +3*(A*x*x'*A')*y*x'*(x'*A'*V*x)/((x'*A'*A*x)))/((x'*A'*A*x)^(-3/2));
        %         end
        % %
        %         D_EAF=zeros(M);
        %         for n=1:N
        %             x=X(:,n); y=Y(:,n);
        %             D_EAF=D_EAF+((-y*x')*(x'*A'*V*x) +V*x*x'*A'*y*x'+A*x*x'*V'*y*x'...
        %                 +3*(A*x*x'*A')*y*x'*(x'*A'*V*x)*((x'*A'*A*x))^(-1))*((x'*A'*A*x)^(-3/2));
        %         end
        AX=A*X;
        dXAVX=diag((X'*A'*V*X));
        dAXXA3_2=diag((X'*(A'*A)*X).^(-3/2));
        dAXY=diag(AX'*Y);
        D_EAF=(-Y*diag(dXAVX.*dAXXA3_2)+V*X*diag(dAXY.*dAXXA3_2)+AX*diag(diag(X'*V'*Y).*dAXXA3_2)+3*AX*diag(dAXY.*dXAVX.*diag((AX'*AX).^(-5/2))))*X';
        
        %Numeric
        %         epsilon=10^(-4);
        %         Xtilde=(A+epsilon*V)*X;Xtilde=Xtilde./(ones(M,1)*sqrt(sum(Xtilde.^2)));
        %         grad_AVF=(Y*Xtilde'- Xtilde.*(ones(M,1)*sum(Xtilde.*Y,1))*Xtilde' )/((A+epsilon*V)');
        %         D_EAF=(grad_AVF-gradF)/epsilon
        %% Compute $H_A(E_{A,i})$
        H_AE=D_EAF - trace(D_EAF'*N_A)'*N_A-trace(gradF'*N_A)*D_EAF;
        %% Compute $W$
        for j=1:(M^2-1)
            W(i,j)=trace(H_AE'*E_A(:,:,j));
        end
    end
%     c=vf'*pinv(W);
    c=vf'/W;
    invH_A=zeros(M);
    for j=1:(M^2-1)
        invH_A=invH_A+ c(j)*E_A(:,:,j);
    end
    %% Update
    %     Ahat=A*expm(N_A_tilde'*invH_A);
    Ahat=A+invH_A;
    Ahat= Ahat/abs(det(Ahat)).^(1/3);   
    Xtilde=Ahat*X./(ones(3,1)*sqrt(sum((Ahat*X).^2)));
    %% Check for convergence
    ind=ind+1;
    e(ind)=trace(Y'*Xtilde);
    GO= (e(ind)-e(ind-1)>CloseEnough);
    if GO==1
        A=Ahat;
        A_store(:,:,ind)=A;
        path(:,(N*(path_index-1)+1):(N*(path_index)))=Xtilde;
        path_index=path_index+1;
    end
        
end
[~,ind]=max(e);
e=e(1:ind);
Xtilde=A*X./(ones(3,1)*sqrt(sum((A*X).^2)));
end