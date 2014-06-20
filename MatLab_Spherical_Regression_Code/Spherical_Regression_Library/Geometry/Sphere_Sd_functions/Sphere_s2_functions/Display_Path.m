function Display_Path(X,Y,path,center_graph)
[M,N]=size(X);
[sphereX,sphereY,sphereZ] =sphere;
r=.96;
r2=.99;
surf(sphereX*r,sphereY*r,sphereZ*r)
axis equal;colormap(gray(100)*.7); hold on;
scatter3(r2*X(1,:),r2*X(2,:),r2*X(3,:),100,'w','fill',...
'MarkerEdgeColor','black')
for n=1:N
pathlength=length(path)/N;
indn=(1:N:length(path))+n-1;
% scatter3(path(1,indn(1)),path(2,indn(1)),path(3,indn(1)),size,'y')
plot3(path(1,indn)*r,path(2,indn)*r,path(3,indn)*r,'y','linewidth',2)
scatter3(path(1,indn(1))*r2,path(2,indn(1))*r2,path(3,indn(1))*r2,30,'y')
% scatter3(path(1,indn(end))*r2,path(2,indn(end))*r2,path(3,indn(end))*r2,50,'s','black','linewidth',1)
scatter3(path(1,indn(end))*r2,path(2,indn(end))*r2,path(3,indn(end))*r2,500,'s','black','linewidth',1)
scatter3(path(1,indn(end))*r2,path(2,indn(end))*r2,path(3,indn(end))*r2,400,'s','y','linewidth',2)
end
r3=r2;
scatter3(r3*Y(1,:),r3*Y(2,:),r3*Y(3,:),100,'s','r','fill',...
    'MarkerEdgeColor','black')
if ~exist('center_graph','var')
    center_graph=1
end
if center_graph~=0
    center= mean([X,Y],2);
    view(center);
end

zoom(1);
grid off
set(gca,'Linewidth',2,'fontsize',20)
end