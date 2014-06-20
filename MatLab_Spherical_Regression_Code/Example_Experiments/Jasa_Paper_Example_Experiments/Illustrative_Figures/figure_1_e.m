%% Figure 1e
%% Midatlantic ridge
% This is a toy data set which compares hand selected landmarks of
% contentents and the midatlantic ridge.
clear;load midatlantic.mat
%% make earth texturemap sphere of earth
close all;figure(1);
image_file='earth_1600.jpg';radius=.99;
cdata = imread(image_file);
[x, y, z] = ellipsoid(0, 0, 0, radius, radius,radius, 32);
g=mesh(x, y, -z,'FaceColor', 'texturemap',...
    'CData', cdata, 'EdgeColor','none');
axis equal;set(gca,'fontsize',20,'linewidth',2)
%
figure(1);
hold on;
% plot predictor (Landmarks on Somalian Plate)
scatter3(X(1,:),X(2,:),X(3,:),100,'y','fill','markeredgecolor','black')
% plot response (Landmarks on Arabian Plate)
scatter3(Y(1,:),Y(2,:),Y(3,:),100,'r','fill','markeredgecolor','black')
view(mean([X,Y],2));zoom(1.7)
