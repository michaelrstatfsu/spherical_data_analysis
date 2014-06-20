%% Applying Inverse Mollweide to current SSEC images
% This module demonstrates how one can obtain Data in Cartesian
% corrdinates from composite Mollweide maps which are posted from the Space Science and
% Engineering Center at University of Wisconsin-Madison.
%
% http://www.ssec.wisc.edu/
%% Download and Display the Current Composite image
clear
URL='http://www.ssec.wisc.edu/data/comp/latest_moll.jpg';
image_raw=imread(URL);
imshow(image_raw)
%% Preprocess raw image to remove margins
% Trime the margins so that the ellipse matches the image.
[h0,w0,~]=size(image_raw);
lm=8;  % left Margin
rm=8;  % right Margin
tm=22; % top Margin
bm=22; % bottom Margin
image=image_raw(tm:(h0-bm),lm:(w0-rm),:);
[h,w,~]=size(image);
close all
imshow(image)
imellipse(gca, [0,0,w,h])
%% Perform Inverse Mollweide Projection at selected Pixels
pixels=[179 92
    253 168
    293 92
]';
[ p ] = inverse_mollweide(pixels(1,:),pixels(2,:),image)
%% Plote the selected Pixle on the Mollweide map
close all;
figure(1);
imshow(image)
hold on;
scatter(pixels(1,:),pixels(2,:),'y','fill')
%% Plote the selected point on the earth
figure(2)
radius=.99;
cdata = imread('earth_1600.jpg');
[x, y, z] = ellipsoid(0, 0, 0, radius, radius,radius, 32);
g=mesh(x, y, -z,'FaceColor', 'texturemap',...
    'CData', cdata, 'EdgeColor','none');
axis equal
set(gca,'fontsize',20,'linewidth',2)
hold on
scatter3(p(1,:),p(2,:),p(3,:),'y','fill')
view(mean(p,2))
%% Creat grid mapping for plotting the image mesh
NN=100;
[PX,PY]=meshgrid(linspace(1,w,NN),linspace(1,h,NN));
[grid] = inverse_mollweide(PX(1:end),PY(1:end),image);
Grid=reshape(grid',NN,NN,3);
%% Plot mollweide image on earth
figure(3)

%plot the earth
radius_earth=6371; % select radius of the earth globe
cdata = imread('earth_1600.jpg');
[x, y, z] = ellipsoid(0, 0, 0, radius_earth, radius_earth,radius_earth, 32);
g=mesh(x, y, -z,'FaceColor', 'texturemap',...
    'CData', cdata, 'EdgeColor','none');

hold on

%plot the translucent cloud map on top
cdata=image;[r,c,m]=size(cdata);
alpha_data=sqrt(sum(double(cdata).^2,3))/500;
h=mesh(1.01*radius_earth*Grid(:,:,1),1.01*radius_earth*Grid(:,:,2),1.01*radius_earth*Grid(:,:,3),'FaceColor', 'texturemap',...
    'CData', cdata, 'FaceAlpha','texture', 'EdgeColor',...
    'none','AlphaDataMapping','scaled','alphadata',alpha_data);

hold on

%plot the selected points on the earth
scatter3(1.01*radius_earth*p(1,:),1.01*radius_earth*p(2,:),1.01*radius_earth*p(3,:),'y','fill')
view(mean(p,2))

axis equal
set(gca,'fontsize',20,'linewidth',2)