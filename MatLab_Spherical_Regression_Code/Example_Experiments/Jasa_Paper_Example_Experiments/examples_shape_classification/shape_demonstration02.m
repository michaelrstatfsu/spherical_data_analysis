clear all; close all;
load Full20objDatanobadshapes;
kappa=100;
J=1300;
N=100;
for j=1:J
    C(:,:,j)=C(:,:,j)-mean(C(:,:,j),2)*ones(1,N);
    C(:,:,j)=5*C(:,:,j)/norm(C(:,:,j));
end
i=1;
% Randomly select a class
%c0(i)=randsample(1:65,1);
% Randomly select an image in that class
%j0(i)= (c0(i)-1)*20 + randsample(1:20,1);
j0=901%901;%700%463
%% Plot original shape in S2

figure
plot(C(1,:,j0),C(2,:,j0),'linewidth',3);%title('Original Response')
axis equal
%% Map Shape to the sphere
x=C(:,:,j0);
X=Upsphere(x);
figure
scatter3(X(1,:),X(2,:),X(3,:),'linewidth',3);hold on
% title('Original Response on Sphere')
center=[0,0,1];
[sphereX,sphereY,sphereZ] =sphere;
mesh(sphereX*.99,sphereY*.99,sphereZ*.99)
axis equal;colormap(gray(100)*.8);view(center);zoom(1)

%% Calculate mean directions (the PLT distorted shape).
M=3;
% A0=A0_generator

% A0 =[
%     1.2607   -0.0493    0.6312
%    -0.4000    0.2157   -0.9994
%    -1.3386    0.8648    0.0496];
% A0 =[0.5231   -0.7465    0.9881
%    -0.7647    0.6921   -0.0037
%    -1.8385    0.6348   -1.0829];

% A0 =[    0.5493   -1.0897   -0.1060
%     1.0170    0.1051   -0.1467
%     0.7533   -0.3705    0.7386];
% A0=[1 0 0
%     1 1 0
%     1 1 1];
%A0=eye(M);
% A0=mvnrnd(10*A0,eye(M));
% A0=A0/norm(A0);
A0=A0_generator()
mu=A0*X; mu=mu./(ones(M,1)*sqrt(sum(mu.^2,1)));
figure
plot3(mu(1,:),mu(2,:),mu(3,:),'linewidth',3); hold on
% title('Noiseless Distorted Response Shape')
center=mean(mu,2);
[sphereX,sphereY,sphereZ] =sphere;
mesh(sphereX*.99,sphereY*.99,sphereZ*.99)
axis equal;colormap(gray(100)*.8);view(center);zoom(1)
%%
Y=zeros(M,N);
for n=1:N
    Y(:,n)=randvonMisesFisherm(M, 1, kappa,mu(:,n));
end

% subplot(2,2,4)
scatter3(Y(1,:),Y(2,:),Y(3,:),'linewidth',3); hold on
% title('Noisy Distorted Response Shape')
center=mean(mu,2);
[sphereX,sphereY,sphereZ] =sphere;
mesh(sphereX*.99,sphereY*.99,sphereZ*.99)
axis equal;colormap(gray(100)*.8);view(center);zoom(1)

%%
% Randomly select a class
% c(i)=randsample(1:65,1);
% c(i)=randsample([c(i),c0(i)],1)
% Randomly select an image in that class
% j(i)= (c(i)-1)*20 + randsample(1:20,1);
j=683%470;%j+10;
figure(1)
plot(C(1,:,j(i)),C(2,:,j(i)),'linewidth',3);%title('Original Explanatory')
axis equal
%% Map Shape to the sphere
x=C(:,:,j(i));
X=Upsphere(x);
figure
scatter3(X(1,:),X(2,:),X(3,:),'linewidth',3);hold on
% title('Original Explanatory on Sphere')
center=[0,0,1];
[sphereX,sphereY,sphereZ] =sphere;
mesh(sphereX*.99,sphereY*.99,sphereZ*.99)
axis equal;colormap(gray(100)*.8);view(center);zoom(1)

%% PLT
[Ahat.PLT,e,Yhat.PLT]= PLT_GA(X,Y);
rho.PLT=e(end)/N;
L.PLT=vMFL(X,Yhat.PLT)
% subplot(2,4,6)
figure
plot3(Yhat.PLT(1,:),Yhat.PLT(2,:),Yhat.PLT(3,:),'linewidth',3); hold on
scatter3(Y(1,:),Y(2,:),Y(3,:)); hold on
% title('PLT')
center=mean(mu,2);
[sphereX,sphereY,sphereZ] =sphere;
mesh(sphereX*.99,sphereY*.99,sphereZ*.99)
axis equal;colormap(gray(100)*.8);view(center);zoom(1)
%% PLT plot in 2D
% y=Downsphere(Y);
% yhat.PLT=Downsphere(Yhat.PLT);
% figure
% scatter(y(1,:),y(2,:));hold on;
% % title('PLT')
% plot(yhat.PLT(1,:),yhat.PLT(2,:),'g','linewidth',3)

%% LLR
[~,e,Yhat.LLR]=LLR(X,Y);
rho.LLR=e/N;
L.LLR=vMFL(X,Yhat.LLR);
figure
plot3(Yhat.LLR(1,:),Yhat.LLR(2,:),Yhat.LLR(3,:),'linewidth',3); hold on
% title('LLR')
scatter3(Y(1,:),Y(2,:),Y(3,:)); hold on
center=mean(mu,2);
[sphereX,sphereY,sphereZ] =sphere;
mesh(sphereX*.99,sphereY*.99,sphereZ*.99)
axis equal;colormap(gray(100)*.8);view(center);zoom(1)
%% LLR plot in 2D
% y=Downsphere(Y);
% yhat.LLR=Downsphere(Yhat.LLR);
% % subplot(2,4,3)
% figure
% scatter(y(1,:),y(2,:));hold on;
% % title('LLR')
% plot(yhat.LLR(1,:),yhat.LLR(2,:),'g','linewidth',3)

%% RRR
[~,e,Yhat.RRR]=RRR(X,Y);
rho.RRR=e/N;
L.RRR=vMFL(X,Yhat.RRR);
% subplot(2,4,8)
figure
plot3(Yhat.RRR(1,:),Yhat.RRR(2,:),Yhat.RRR(3,:),'linewidth',3); hold on
% title('RRR')
scatter3(Y(1,:),Y(2,:),Y(3,:)); hold on
center=mean(mu,2);
[sphereX,sphereY,sphereZ] =sphere;
mesh(sphereX*.99,sphereY*.99,sphereZ*.99)
axis equal;colormap(gray(100)*.8);view(center);zoom(1)
%% RRR plot in 2D
% y=Downsphere(Y);
% yhat.RRR=Downsphere(Yhat.RRR);
% % subplot(2,4,4)
% figure
% scatter(y(1,:),y(2,:));hold on;
% % title('RRR')
% plot(yhat.RRR(1,:),yhat.RRR(2,:),'g','linewidth',3)

%%
[PO]=performance_evaluation(X,Y)
%%
LaTex_Table(PO)
