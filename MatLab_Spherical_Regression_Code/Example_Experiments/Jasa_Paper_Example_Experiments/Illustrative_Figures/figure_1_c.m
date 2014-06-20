%% Figure 1c
% This figure illustrates the distortions which occur when flattening a
% non-linear manifold to a tangnet space. These approaches are reasonable
% only locally.
%% Data points on the sphere
[X(1,:),X(2,:),X(3,:)]=sph2cart(0,(2*pi/3):(pi/3):(4*pi/3),1);
[Y(1,:),Y(2,:),Y(3,:)]=sph2cart(pi,(2*pi/3):(pi/3):(4*pi/3),1);
[M,N]=size(X);
%% Map to Tangent Space at North Pole
mu=[0,0,1]'; % Focal Point
for n=1:N
    x=X(:,n);
    theta(n)=acos(x'*mu);
    vx(:,n)= (theta(n)/sin(theta(n)))*(X(:,n)-cos(theta(n))*mu);
    vy(:,n)= (theta(n)/sin(theta(n)))*(Y(:,n)-cos(theta(n))*mu);
end
vx=vx+mu*ones(1,N);
vy=vy+mu*ones(1,N);
%% Construct Plot
close all;
for n=1:N
plot3([vx(1,n),X(1,n)],[vx(2,n),X(2,n)],[vx(3,n),X(3,n)],'bla','linewidth',2);hold on
plot3([vy(1,n),Y(1,n)],[vy(2,n),Y(2,n)],[vy(3,n),Y(3,n)],'bla','linewidth',2);
end
sphere;colormap(gray);hold on;axis equal
scatter3(vx(1,:),vx(2,:),vx(3,:),150,'fill',...
    'red','MarkerEdgeColor','black','linewidth',2)
scatter3(vy(1,:),vy(2,:),vy(3,:),150,'s','fill',...
    'yellow','MarkerEdgeColor','black','linewidth',2)
scatter3(X(1,:),X(2,:),X(3,:),150,'fill',...
    'red','MarkerEdgeColor','black','linewidth',2)
scatter3(Y(1,:),Y(2,:),Y(3,:),150,'s','fill',...
    'yellow','MarkerEdgeColor','black','linewidth',2)
view([0,1,0]);
set(gca,'FontSize',20,'LineWidth',2,'XTick',[0])