%% Figure 1b
% This figure illustrates an example which cannnot be characterized using a
% rigid rotation.
%% Data points on the sphere
load BadForRotation.mat
sphere;colormap(gray);hold on
scatter3(X(1,:),X(2,:),X(3,:),150,'fill',...
    'red','MarkerEdgeColor','black','linewidth',2)
scatter3(Y(1,:),Y(2,:),Y(3,:),150,'s','fill',...
    'yellow','MarkerEdgeColor','black','linewidth',2)
view(mean([X,Y],2));
set(gca,'FontSize',20,'LineWidth',2,'XTick',[0]);axis equal