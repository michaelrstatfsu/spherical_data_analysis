%% Cloud Formation Example 03
% This example was not included in the paper. It has 26 data points from
% two consecutive days.
clear; close all;load Cloud_Example03.mat

%%
name1='clouds_8_30_12.jpg'; % August 30, 2012 cloudmap
name2='clouds_8_31_12.jpg'; % August 31, 2012 cloudmap
%% Plot clouds_8_30_12 data

%plot globe 
figure(3);close;figure(3);
cdata = imread('earth_1600.jpg');
radius=.98
[x, y, z] = ellipsoid(0, 0, 0, radius, radius,radius, 32);
g=mesh(x, y, -z,'FaceColor', 'texturemap',...
    'CData', cdata, 'EdgeColor','none');

hold on
% add cloud layer
cdata = imread(name1);
radius=1
alpha_data=sqrt(sum(double(cdata).^2,3));
[x, y, z] = ellipsoid(0, 0, 0, radius, radius,radius, 72);
g= mesh(x, y, -z,'FaceColor', 'texturemap',...
    'CData', cdata, 'FaceAlpha','texture', 'EdgeColor',...
    'none','AlphaDataMapping','scaled','alphadata',alpha_data);
globe_layer([name1],.99);
center=mean(X,2); center= center/norm(center);
view(center);zoom(3);

hold on;

scatter3(X(1,:),X(2,:),X(3,:),'y','fill')
%%
figure(3);close;figure(3);
cdata = imread('earth_1600.jpg');
radius=.98
[x, y, z] = ellipsoid(0, 0, 0, radius, radius,radius, 32);
g=mesh(x, y, -z,'FaceColor', 'texturemap',...
    'CData', cdata, 'EdgeColor','none');

hold on
cdata = imread(name2);
radius=1
alpha_data=sqrt(sum(double(cdata).^2,3));
[x, y, z] = ellipsoid(0, 0, 0, radius, radius,radius, 72);
g= mesh(x, y, -z,'FaceColor', 'texturemap',...
    'CData', cdata, 'FaceAlpha','texture', 'EdgeColor',...
    'none','AlphaDataMapping','scaled','alphadata',alpha_data);
globe_layer([name1],.99);
center=mean(X,2); center= center/norm(center);
view(center);zoom(3);

hold on;
%plot data points
scatter3(Y(1,:),Y(2,:),Y(3,:),'r','fill')
%% Performance Evaluation
[PO]=performance_evaluation(X,Y)
%%
LaTex_Table(PO)