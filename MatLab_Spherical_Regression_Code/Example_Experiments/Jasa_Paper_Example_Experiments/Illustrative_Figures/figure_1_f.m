%% Figure 1f
%% Shape Example
% This is a toy data set which compares a shape on a sphere with a
% projective linear transformation of that shape.
clear;load Shape_01.mat
%% make earth texturemap sphere of earth
close all;figure(1);
sphere;colormap(gray)
axis equal;set(gca,'fontsize',20,'linewidth',2)
%
figure(1);
hold on;
% plot predictor (Landmarks on Somalian Plate)
plot3(X(1,:),X(2,:),X(3,:),'y','linewidth',3)
% plot response (Landmarks on Arabian Plate)
plot3(Y(1,:),Y(2,:),Y(3,:),'r','linewidth',3)
view(mean([X,Y],2));zoom(1.7)
