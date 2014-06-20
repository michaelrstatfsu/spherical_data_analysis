%% Figure 1d
%% Gulf of Aden Example
% This data comes from Chang (1986). It contains 11 paired data points on
% $S^2$ which correspond to geographical coordinates located in the Gulf of
% Aden. At one point in time, it is thought that the corresponding data
% points were in the same location. In this data example, the points which
% are on the Somalian Plate are treated as the predictor (x) and the
% corresponding point on the Arabian Plate is treated as the response (y).
clear;load GULF_OF_ADEN.mat
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
view(mean([X,Y],2));zoom(5)
