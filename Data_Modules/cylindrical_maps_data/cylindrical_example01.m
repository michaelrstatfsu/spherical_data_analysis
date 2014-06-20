%% cylindrical data map example
% This module illustrates how hand selected pixels from a cylindrical map
% can be mapped to cartesian coordinates.

clear;close all;
%% EXAMPLE Plots
[image,cmap2]=imread('earth_400.jpg');
x=[105 65
   182 84
   162 106
    ]'
figure(1);
imshow(image)
hold on;scatter(x(1,:),x(2,:),100,'fill',...
    'bl','MarkerEdgeColor','y')
%%
X=pix2geo(image,x(1,:),x(2,:));
size(X)
%
figure(2);
[gx, gy, gz] = ellipsoid(0, 0, 0, .97, .97,.97, 32);
g=mesh(gx, gy, -gz,'FaceColor', 'texturemap',...
    'CData', image, 'EdgeColor','none'); axis equal
hold on 
scatter3(X(1,:),X(2,:),X(3,:),100,'fill',...
    'bl','MarkerEdgeColor','y')
view(mean(X,2))